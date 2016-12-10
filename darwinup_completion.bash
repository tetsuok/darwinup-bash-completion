_darwinup() {
  local cur prev line archives

  if _get_comp_words_by_ref cur prev &>/dev/null ; then
    case $prev in
      -p)
        _filedir -d
        return 0
        ;;
    esac
  else
    cur="${COMP_WORDS[COMP_CWORD]}"
  fi

  case "$COMP_CWORD" in
    1)
      COMPREPLY=($(compgen -W "files install list rename uninstall forget upgrade verify" -- $cur))
      ;;
  esac

  line=$(echo ${COMP_LINE} | cut -d " " -f 2-)
  case $line in
    install)
      _filedir
      return 0
      ;;
    uninstall)
      # TODO: get the list of archives
      # TODO: complete the list of possible archives by TAB
      #archives="eval darwinup list | tail -n +3"
      archives="newest oldest superseded all"
      COMPREPLY=($(compgen -W "$archives" -- $cur))
      ;;
  esac
  return
}

complete -F _darwinup darwinup
