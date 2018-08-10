# ~/.bash_profile

#  _________                    .__       _________                      _____  .__  .__            
#  \_____   \ _____      ______ |  |___   \_____   \ _______    ____   _/ ____\ |__| |  |     ____  
#   |   |  _/ \__  \    /  ___/ |  |_  \   |    ___/ \_  __ \  /  _ \  \   __\  |  | |  |   _/ __ \ 
#   |   |   \  / __ \_  \___ \  |  | | |   |   |      |  | \/ (  (_) )  |  |    |  | |  |__ \  ___/ 
#   |_______/ (______/ /______> |__| |_|   |___|      |__|     \____/   |__|    |__| |____/  \___   

# ===================================================================================================
# RESOURCES
# ===================================================================================================
# http://cli.learncodethehardway.org/bash_cheat_sheet.pdf
# http://ss64.com/bash/syntax-prompt.html
# https://dougbarton.us/Bash/Bash-prompts.html
# http://sage.ucsc.edu/xtal/iterm_tab_customization.html

# ===================================================================================================
# TABLE OF CONTENTS
# ===================================================================================================
# --------------------
# System Settings
# --------------------
#  Path
#  Settings
#  History
#  Aliases
#  Change System Settings
# --------------------
# Application Settings
# --------------------
#  Application Aliases
#  rbenv
#  nvm
# --------------------
# Other Settings
# --------------------
#  Functions
#  Sourced Files
#  Environmental Variables and API Keys

# ===================================================================================================
# PATH
# ===================================================================================================

# A list of all directories in which to look for commands, scripts and programs
PATH="$HOME/.rbenv/bin:$PATH"                      # RBENV
PATH="/usr/local/share/npm/bin:$PATH"              # NPM
PATH="/usr/local/bin:/usr/local/sbin:$PATH"        # Homebrew
PATH="/usr/local/heroku/bin:$PATH"                 # Heroku Toolbelt

# Uncomment to use GNU versions of core utils by default.
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"          # Coreutils
# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"    # Manual pages

# See scripts/mac/homebrew_install_core_utils.sh in the Installfest. In essence, Mac OS X is in BSD userland, while Linux et al are in GNU. GNU utils tend towards current POSIX compliance and are more feature-rich; thus they are aliased below to add color, clean output etc. BSD tools are more stable. Mac has also added some Mac-specific abilities to its set of BSD-like coreutils, however: check `man chmod`, eg.

# ===================================================================================================
# SETTINGS
# ===================================================================================================

# Prefer US English
export LC_ALL="en_US.UTF-8"
# use UTF-8
export LANG="en_US"

# ===================================================================================================
# HISTORY
# ===================================================================================================

# http://jorge.fbarr.net/2011/03/24/making-your-bash-history-more-efficient/
# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Make some commands not show up in history
export HISTIGNORE="h"

# ===================================================================================================
# ALIASES
# ===================================================================================================

alias ls='gls -F'                                           # By default, show slashes for directories.
alias lf='gls --color -h --group-directories-first -F'      # Enhanced ls, grouping directories and using colors.
alias la='gls -a --color -h --group-directories-first -F'   # Enhanced ls, grouping directories and using colors.
alias ll='gls --color -h --group-directories-first -Fla'    # Long list format including hidden files and file information.
alias lacl='/bin/ls -GFlae'                                 # List ACLs (finer-grained permissions that can be inherited).

# Go back one directorys
cd() { builtin cd "$@"; lf; }                               # Always list directory contents upon 'cd'
alias cd..='cd ../'                                         # Go back 1 directory level (for fast typers)
alias b='cd ../'                                            # Go back 1 directory level
alias b2='cd ../../'                                        # Go back 2 directory levels
alias b3='cd ../../../'                                     # Go back 3 directory levels
alias b4='cd ../../../../'                                  # Go back 4 directory levels
alias b5='cd ../../../../../'                               # Go back 5 directory levels
alias b6='cd ../../../../../../'                            # Go back 6 directory levels
alias h='history'                                           # History lists your previously entered commands
alias reload="clear; source ~/.bash_profile"                # If we make a change to our bash profile we need to reload it
alias add="git add -A"                                      # Git Push and Pull
alias pull="git pull origin master"                         # Git Pull from Origin
alias push="git push origin master"                         # Git Push to Origin

# Execute verbosely
alias cp='gcp -v'
alias mv='gmv -v'
alias rm='grm -v'
alias mkdir='gmkdir -pv'

# Hide/show all desktop icons (useful when presenting)
alias hide_desktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias show_desktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Hide/show hidden files in Finder
alias hide_files="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias show_files="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias chrome='open -a "Google Chrome"'
alias macdown="open -a MacDown"
alias code="open -a 'Visual Studio Code'"

# ===================================================================================================
# rbenv
# ===================================================================================================

# start rbenv (our Ruby environment and version manager) on open
if which rbenv > /dev/null; then 
  eval "$(rbenv init -)"; 
fi

# ===================================================================================================
# nvm
# ===================================================================================================

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# ===================================================================================================
# FUNCTIONS
# ===================================================================================================

# List any open internet sockets on several popular ports. Useful if a rogue server is running.
# - http://www.akadia.com/services/lsof_intro.html
# - http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers

rogue() {
  # add or remove ports to check here!
  local PORTS="3000 4567 6379 8000 8888 27017"
  local MESSAGE="> Checking for processes on ports"
  local COMMAND="lsof"
  for PORT in $PORTS; do
    MESSAGE="${MESSAGE} ${PORT},"
    COMMAND="${COMMAND} -i TCP:${PORT}"
  done
  echo "${MESSAGE%?}..."
  local OUTPUT="$(${COMMAND})"
  if [ -z "$OUTPUT" ]; then
    echo "> Nothing running!"
  else
    echo "> Processes found:"
    printf "\n$OUTPUT\n\n"
    echo "> Use the 'kill' command with the 'PID' of any process you want to quit."
    echo
  fi
}

# ===================================================================================================
# TAB IMPROVEMENTS
# ===================================================================================================

# make completions appear immediately after pressing TAB once
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB: menu-complete'

# ===================================================================================================
# SOURCED SCRIPTS
# ===================================================================================================

# Builds the prompt with git branch notifications.
if [ -f ~/.bash_prompt.sh ]; then
  source ~/.bash_prompt.sh
fi

# A welcome prompt with stats for sanity checks
if [ -f ~/.welcome_prompt.sh ]; then
  source ~/.welcome_prompt.sh
fi

# bash/zsh completion support for core Git.
if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# ===================================================================================================
# ENVIORNMENTAL VARIABLES AND API KEYS
# ===================================================================================================

# Below here is an area for other commands added by outside programs or commands. Attempt to reserve this area for their use!
export HOMEBREW_EDITOR=nano
export NODE_REPL_HISTORY_FILE=~/.node_repl_history

# Setting PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH