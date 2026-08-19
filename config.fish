# ~/.config/fish/config.fish
# -------------------------
# Starship
# -------------------------
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml
set -gx STARSHIP_CACHE ~/.starship/cache
if status is-interactive
    starship init fish | source
end

# -------------------------
# Environment
# -------------------------
set -gx ASDF_DATA_DIR ~/.asdf
fish_add_path ~/bin
fish_add_path ~/.asdf/shims
fish_add_path ~/.spicetify
fish_add_path ~/.cargo/bin
if status is-interactive
    if status is-interactive
        set -gx GPG_TTY (tty)
    end
end

# -------------------------
# Aliases
# -------------------------
alias ..="cd .."
alias nv="nvim"
alias lg="lazygit"
alias fd="fdfind"
alias sqlite="sqlite3"
alias prettify="node ~/dev/prettier-script.js"
alias present="clear && fastfetch"
alias rstart="clear && source ~/.config/fish/config.fish"

# -------------------------
# lsd
# -------------------------
if command -q eza
    alias ls='eza --icons --group-directories-first --git'
    alias ll='eza -l --icons --git --header --group-directories-first'
    alias la='eza -a --icons --git'
    alias lt='eza -T --level=2 -I "node_modules" --icons --git'
else
    echo "eza is not installed. Install it with: sudo apt install lsd"
end

# -------------------------
# fastfetch on startup
# -------------------------
if status is-interactive; and command -q fastfetch
    fastfetch
end



# -------------------------
# asdf
# -------------------------
if test -f ~/.asdf/plugins/golang/set-env.fish
    source ~/.asdf/plugins/golang/set-env.fish
end

# -------------------------
# FZF
# -------------------------
set -gx FZF_DEFAULT_OPTS "
--style=full
--layout=reverse
--border=rounded
--info=inline-right
--prompt=' '
--preview-window=right:60%
--preview '[ -d {} ] && tree -C {} | head -200 || batcat --style=numbers --color=always {}'
--bind 'ctrl-u:preview-half-page-up'
--bind 'ctrl-d:preview-half-page-down'
--color='hl:#00afff,hl+:#00afff,pointer:#00afff,marker:#00afff,info:#5fd7ff,prompt:#5fd7ff,border:#B1AED5'
"

# -------------------------
# FZF dev navigation
# -------------------------
function fzf_dev
    set dir (fd --type d --exclude '.git' --exclude 'node_modules' . ~/dev | fzf)
    if test -n "$dir"
        cd $dir
        pwd
        nvim
    end
end
alias fdv="fzf_dev"

function fzf_dev_dir
    set dir (fd --type d --exclude '.git' --exclude 'node_modules' . ~/dev | fzf)
    if test -n "$dir"
        cd $dir
        pwd
    end
end
alias fdc="fzf_dev_dir"

function fzf_home_config
    set dir (
        fd --type d \
        --exclude '.git' \
        --exclude 'node_modules' \
        --exclude '.venv' \
        . ~ ~/.config | fzf
    )
    if test -n "$dir"
        cd $dir
        pwd
    end
end
alias fhf="fzf_home_config"

# -------------------------
# yazi
# -------------------------
if status is-interactive
    bind \cy yazi
end

# Keybinds
function fish_user_key_bindings
    # Your existing bindings...
    bind \cf "commandline -r fdv; commandline -f execute"
end


fish_add_path /home/jd/.spicetify
