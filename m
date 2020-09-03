Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487CAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F977206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRN1mR9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F977206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDk1H-0002CW-7X
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjue-0000dB-Rp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:04 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuY-0003uG-1h
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:04 -0400
Received: by mail-pj1-x1043.google.com with SMTP id q1so1065184pjd.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/GaUltnz0Pg3c4Cd+mTYTkHsnyZ4IcQD2a8N3N67cLI=;
 b=WRN1mR9UF1ZOZZtgmHtz4tVK6IUF61JxzDNJTBM8syZ4YHS6A1+UQdyhiqaf1qnEMI
 t+YPK1mXGMW5wo5ovsbaWF5rmtjUzXGkHrpCOkT1ATYyFqlg81gny0jSsR+aeJUfMML1
 mizKY8He5AzA40vB/x8s77dLLWRQLeya01dWdtgaeEDhIxkcwuFR6hu0L2+X929Ru2OK
 Bsphayi3F1o46NQ/Ghy7USA0oN8VPY6anIfR+Op2LnCsIvwsev7WPq1k5FeBVlnKxce+
 ge/TXqE1219Hp/ML6KYQTp6QSOA2DO2P40gVDZLeAtASVTxapcMJJnD5grxfGTzMUYY+
 D+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/GaUltnz0Pg3c4Cd+mTYTkHsnyZ4IcQD2a8N3N67cLI=;
 b=OG3hWCjFj3MKvmypYnyC9YtgNL7wyUqFnq81pufdQY5DOlT5cQlMx7JHZhyop9BlFS
 72lkGmKo/pbqJCFMy4w2P0iFSxcPiz/Msd2bXhiSDBmiVaxQb2GRw3UG7hpMmbTvV+dV
 CwVntRk09XPcMOzWdriELBPyaVKlnf6L9BuqgcBQtVLIs3ro3/LKs7DeTxfavx5osYg/
 g6FSIsIWrFuvo6525ye80h+gqOk/4S5eJn3ZDoFSrmsIGID1uRORdcAfHOkd80GX5QyR
 AKyMFs3Th11n6FTrq4ZOxC6weFxdKmFXg88qTPy+zEHl2TMNYPJjjq5ud1GkNgs2BW6C
 So0g==
X-Gm-Message-State: AOAM531YU7IYnJwpYTtR5qDXTffOI/tngx9IeTRWuIKmitqFoIp72GwF
 5qnJnNMGyyVhHyErAigSzJ99/SGcx+kTXIyg
X-Google-Smtp-Source: ABdhPJyjVWKavDCA3el1bB6qn8u27nFycdfHunj+A2OV58RMRUrnhSXudkbYqC07ailnIrcJf5VqJQ==
X-Received: by 2002:a17:90a:4046:: with SMTP id
 k6mr2069873pjg.11.1599119033186; 
 Thu, 03 Sep 2020 00:43:53 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/12] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Thu,  3 Sep 2020 15:43:09 +0800
Message-Id: <20200903074313.1498-9-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 capstone  |     2 +-
 configure | 16574 ++++++++++++++++++++++++++--------------------------
 2 files changed, 8288 insertions(+), 8288 deletions(-)

diff --git a/capstone b/capstone
index 22ead3e0bf..1d23053284 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
diff --git a/configure b/configure
index 5f2bcc4b57..e42d210e5f 100755
--- a/configure
+++ b/configure
@@ -1,8287 +1,8287 @@
-#!/bin/sh
-#
-# qemu configure script (c) 2003 Fabrice Bellard
-#
-
-# Unset some variables known to interfere with behavior of common tools,
-# just as autoconf does.
-CLICOLOR_FORCE=3D GREP_OPTIONS=3D
-unset CLICOLOR_FORCE GREP_OPTIONS
-
-# Don't allow CCACHE, if present, to use cached results of compile tests!
-export CCACHE_RECACHE=3Dyes
-
-# make source path absolute
-source_path=3D$(cd "$(dirname -- "$0")"; pwd)
-build_path=3D$PWD
-if [ "$MSYSTEM" =3D "MINGW64" -o  "$MSYSTEM" =3D "MINGW32" ]; then
-source_path=3D$(cd "$(dirname -- "$0")"; pwd -W)
-build_path=3D`pwd -W`
-fi
-
-if test "$build_path" =3D "$source_path"
-then
-    echo "Using './build' as the directory for build output"
-
-    MARKER=3Dbuild/auto-created-by-configure
-
-    if test -e build
-    then
-        if test -f $MARKER
-        then
-           rm -rf build
-        else
-            echo "ERROR: ./build dir already exists and was not previously=
 created by configure"
-            exit 1
-        fi
-    fi
-
-    mkdir build
-    touch $MARKER
-
-    cat > GNUmakefile <<'EOF'
-# This file is auto-generated by configure to support in-source tree
-# 'make' command invocation
-
-ifeq ($(MAKECMDGOALS),)
-recurse: all
-endif
-
-.NOTPARALLEL: %
-%: force
-	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'
-	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
-	@if test "$(MAKECMDGOALS)" =3D "distclean" && \
-	    test -e build/auto-created-by-configure ; \
-	then \
-	    rm -rf build GNUmakefile ; \
-	fi
-force: ;
-.PHONY: force
-GNUmakefile: ;
-
-EOF
-    cd build
-    exec $source_path/configure "$@"
-fi
-
-# Temporary directory used for files created while
-# configure runs. Since it is in the build directory
-# we can safely blow away any previous version of it
-# (and we need not jump through hoops to try to delete
-# it when configure exits.)
-TMPDIR1=3D"config-temp"
-rm -rf "${TMPDIR1}"
-mkdir -p "${TMPDIR1}"
-if [ $? -ne 0 ]; then
-    echo "ERROR: failed to create temporary directory"
-    exit 1
-fi
-
-TMPB=3D"qemu-conf"
-TMPC=3D"${TMPDIR1}/${TMPB}.c"
-TMPO=3D"${TMPDIR1}/${TMPB}.o"
-TMPCXX=3D"${TMPDIR1}/${TMPB}.cxx"
-TMPE=3D"${TMPDIR1}/${TMPB}.exe"
-TMPTXT=3D"${TMPDIR1}/${TMPB}.txt"
-
-rm -f config.log
-
-# Print a helpful header at the top of config.log
-echo "# QEMU configure log $(date)" >> config.log
-printf "# Configured with:" >> config.log
-printf " '%s'" "$0" "$@" >> config.log
-echo >> config.log
-echo "#" >> config.log
-
-print_error() {
-    (echo
-    echo "ERROR: $1"
-    while test -n "$2"; do
-        echo "       $2"
-        shift
-    done
-    echo) >&2
-}
-
-error_exit() {
-    print_error "$@"
-    exit 1
-}
-
-do_compiler() {
-    # Run the compiler, capturing its output to the log. First argument
-    # is compiler binary to execute.
-    local compiler=3D"$1"
-    shift
-    if test -n "$BASH_VERSION"; then eval '
-        echo >>config.log "
-funcs: ${FUNCNAME[*]}
-lines: ${BASH_LINENO[*]}"
-    '; fi
-    echo $compiler "$@" >> config.log
-    $compiler "$@" >> config.log 2>&1 || return $?
-    # Test passed. If this is an --enable-werror build, rerun
-    # the test with -Werror and bail out if it fails. This
-    # makes warning-generating-errors in configure test code
-    # obvious to developers.
-    if test "$werror" !=3D "yes"; then
-        return 0
-    fi
-    # Don't bother rerunning the compile if we were already using -Werror
-    case "$*" in
-        *-Werror*)
-           return 0
-        ;;
-    esac
-    echo $compiler -Werror "$@" >> config.log
-    $compiler -Werror "$@" >> config.log 2>&1 && return $?
-    error_exit "configure test passed without -Werror but failed with -Wer=
ror." \
-        "This is probably a bug in the configure script. The failing comma=
nd" \
-        "will be at the bottom of config.log." \
-        "You can run configure with --disable-werror to bypass this check."
-}
-
-do_cc() {
-    do_compiler "$cc" "$@"
-}
-
-do_cxx() {
-    do_compiler "$cxx" "$@"
-}
-
-# Append $2 to the variable named $1, with space separation
-add_to() {
-    eval $1=3D\${$1:+\"\$$1 \"}\$2
-}
-
-update_cxxflags() {
-    # Set QEMU_CXXFLAGS from QEMU_CFLAGS by filtering out those
-    # options which some versions of GCC's C++ compiler complain about
-    # because they only make sense for C programs.
-    QEMU_CXXFLAGS=3D"$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTAN=
T_MACROS -D__STDC_FORMAT_MACROS"
-    CXXFLAGS=3D$(echo "$CFLAGS" | sed s/-std=3Dgnu99/-std=3Dgnu++11/)
-    for arg in $QEMU_CFLAGS; do
-        case $arg in
-            -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
-            -Wold-style-declaration|-Wold-style-definition|-Wredundant-dec=
ls)
-                ;;
-            *)
-                QEMU_CXXFLAGS=3D${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
-                ;;
-        esac
-    done
-}
-
-compile_object() {
-  local_cflags=3D"$1"
-  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
-}
-
-compile_prog() {
-  local_cflags=3D"$1"
-  local_ldflags=3D"$2"
-  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $QEMU_L=
DFLAGS $local_ldflags
-}
-
-# symbolically link $1 to $2.  Portable version of "ln -sf".
-symlink() {
-  rm -rf "$2"
-  mkdir -p "$(dirname "$2")"
-  ln -s "$1" "$2"
-}
-
-# check whether a command is available to this shell (may be either an
-# executable or a builtin)
-has() {
-    type "$1" >/dev/null 2>&1
-}
-
-# search for an executable in PATH
-path_of() {
-    local_command=3D"$1"
-    local_ifs=3D"$IFS"
-    local_dir=3D""
-
-    # pathname has a dir component?
-    if [ "${local_command#*/}" !=3D "$local_command" ]; then
-        if [ -x "$local_command" ] && [ ! -d "$local_command" ]; then
-            echo "$local_command"
-            return 0
-        fi
-    fi
-    if [ -z "$local_command" ]; then
-        return 1
-    fi
-
-    IFS=3D:
-    for local_dir in $PATH; do
-        if [ -x "$local_dir/$local_command" ] && [ ! -d "$local_dir/$local=
_command" ]; then
-            echo "$local_dir/$local_command"
-            IFS=3D"${local_ifs:-$(printf ' \t\n')}"
-            return 0
-        fi
-    done
-    # not found
-    IFS=3D"${local_ifs:-$(printf ' \t\n')}"
-    return 1
-}
-
-version_ge () {
-    local_ver1=3D`echo $1 | tr . ' '`
-    local_ver2=3D`echo $2 | tr . ' '`
-    while true; do
-        set x $local_ver1
-        local_first=3D${2-0}
-        # 'shift 2' if $2 is set, or 'shift' if $2 is not set
-        shift ${2:+2}
-        local_ver1=3D$*
-        set x $local_ver2
-        # the second argument finished, the first must be greater or equal
-        test $# =3D 1 && return 0
-        test $local_first -lt $2 && return 1
-        test $local_first -gt $2 && return 0
-        shift ${2:+2}
-        local_ver2=3D$*
-    done
-}
-
-have_backend () {
-    echo "$trace_backends" | grep "$1" >/dev/null
-}
-
-glob() {
-    eval test -z '"${1#'"$2"'}"'
-}
-
-supported_hax_target() {
-    test "$hax" =3D "yes" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}" in
-        i386|x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_kvm_target() {
-    test "$kvm" =3D "yes" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}:$cpu" in
-        arm:arm | aarch64:aarch64 | \
-        i386:i386 | i386:x86_64 | i386:x32 | \
-        x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
-        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
-        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
-        s390x:s390x)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_xen_target() {
-    test "$xen" =3D "yes" || return 1
-    glob "$1" "*-softmmu" || return 1
-    # Only i386 and x86_64 provide the xenpv machine.
-    case "${1%-softmmu}" in
-        i386|x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_hvf_target() {
-    test "$hvf" =3D "yes" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}" in
-        x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_whpx_target() {
-    test "$whpx" =3D "yes" || return 1
-    glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}" in
-        i386|x86_64)
-            return 0
-        ;;
-    esac
-    return 1
-}
-
-supported_target() {
-    case "$1" in
-        *-softmmu)
-            ;;
-        *-linux-user)
-            if test "$linux" !=3D "yes"; then
-                print_error "Target '$target' is only available on a Linux=
 host"
-                return 1
-            fi
-            ;;
-        *-bsd-user)
-            if test "$bsd" !=3D "yes"; then
-                print_error "Target '$target' is only available on a BSD h=
ost"
-                return 1
-            fi
-            ;;
-        *)
-            print_error "Invalid target name '$target'"
-            return 1
-            ;;
-    esac
-    test "$tcg" =3D "yes" && return 0
-    supported_kvm_target "$1" && return 0
-    supported_xen_target "$1" && return 0
-    supported_hax_target "$1" && return 0
-    supported_hvf_target "$1" && return 0
-    supported_whpx_target "$1" && return 0
-    print_error "TCG disabled, but hardware accelerator not available for =
'$target'"
-    return 1
-}
-
-
-ld_has() {
-    $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
-}
-
-check_valid_build_path=3D"[[:space:]:]"
-if [ "$MSYSTEM" =3D "MINGW64" -o  "$MSYSTEM" =3D "MINGW32" ]; then
-check_valid_build_path=3D"[[:space:]]"
-fi
-
-if printf %s\\n "$source_path" "$build_path" | grep -q "$check_valid_build=
_path";
-then
-  error_exit "main directory cannot contain spaces nor colons"
-fi
-
-# default parameters
-cpu=3D""
-iasl=3D"iasl"
-interp_prefix=3D"/usr/gnemul/qemu-%M"
-static=3D"no"
-cross_prefix=3D""
-audio_drv_list=3D""
-block_drv_rw_whitelist=3D""
-block_drv_ro_whitelist=3D""
-host_cc=3D"cc"
-libs_tools=3D""
-audio_win_int=3D""
-libs_qga=3D""
-debug_info=3D"yes"
-stack_protector=3D""
-safe_stack=3D""
-use_containers=3D"yes"
-gdb_bin=3D$(command -v "gdb-multiarch" || command -v "gdb")
-
-if test -e "$source_path/.git"
-then
-    git_update=3Dyes
-    git_submodules=3D"ui/keycodemapdb"
-    git_submodules=3D"$git_submodules tests/fp/berkeley-testfloat-3"
-    git_submodules=3D"$git_submodules tests/fp/berkeley-softfloat-3"
-else
-    git_update=3Dno
-    git_submodules=3D""
-
-    if ! test -f "$source_path/ui/keycodemapdb/README"
-    then
-        echo
-        echo "ERROR: missing file $source_path/ui/keycodemapdb/README"
-        echo
-        echo "This is not a GIT checkout but module content appears to"
-        echo "be missing. Do not use 'git archive' or GitHub download link=
s"
-        echo "to acquire QEMU source archives. Non-GIT builds are only"
-        echo "supported with source archives linked from:"
-        echo
-        echo "  https://www.qemu.org/download/#source"
-        echo
-        echo "Developers working with GIT can use scripts/archive-source.s=
h"
-        echo "if they need to create valid source archives."
-        echo
-        exit 1
-    fi
-fi
-git=3D"git"
-
-# Don't accept a target_list environment variable.
-unset target_list
-unset target_list_exclude
-
-# Default value for a variable defining feature "foo".
-#  * foo=3D"no"  feature will only be used if --enable-foo arg is given
-#  * foo=3D""    feature will be searched for, and if found, will be used
-#              unless --disable-foo is given
-#  * foo=3D"yes" this value will only be set by --enable-foo flag.
-#              feature will searched for,
-#              if not found, configure exits with error
-#
-# Always add --enable-foo and --disable-foo command line args.
-# Distributions want to ensure that several features are compiled in, and =
it
-# is impossible without a --enable-foo that exits if a feature is not foun=
d.
-
-brlapi=3D""
-curl=3D""
-curses=3D""
-docs=3D""
-fdt=3D""
-netmap=3D"no"
-sdl=3D"auto"
-sdl_image=3D"auto"
-virtfs=3D""
-mpath=3D""
-vnc=3D"enabled"
-sparse=3D"no"
-vde=3D""
-vnc_sasl=3D"auto"
-vnc_jpeg=3D"auto"
-vnc_png=3D"auto"
-xkbcommon=3D"auto"
-xen=3D""
-xen_ctrl_version=3D""
-xen_pci_passthrough=3D""
-linux_aio=3D""
-linux_io_uring=3D""
-cap_ng=3D""
-attr=3D""
-libattr=3D""
-xfs=3D""
-tcg=3D"yes"
-membarrier=3D""
-vhost_net=3D""
-vhost_crypto=3D""
-vhost_scsi=3D""
-vhost_vsock=3D""
-vhost_user=3D""
-vhost_user_fs=3D""
-kvm=3D"no"
-hax=3D"no"
-hvf=3D"no"
-whpx=3D"no"
-rdma=3D""
-pvrdma=3D""
-gprof=3D"no"
-debug_tcg=3D"no"
-debug=3D"no"
-sanitizers=3D"no"
-tsan=3D"no"
-fortify_source=3D""
-strip_opt=3D"yes"
-tcg_interpreter=3D"no"
-bigendian=3D"no"
-mingw32=3D"no"
-gcov=3D"no"
-EXESUF=3D""
-HOST_DSOSUF=3D".so"
-LDFLAGS_SHARED=3D"-shared"
-modules=3D"no"
-module_upgrades=3D"no"
-prefix=3D"/usr/local"
-qemu_suffix=3D"qemu"
-slirp=3D""
-oss_lib=3D""
-bsd=3D"no"
-linux=3D"no"
-solaris=3D"no"
-profiler=3D"no"
-cocoa=3D"no"
-softmmu=3D"yes"
-linux_user=3D"no"
-bsd_user=3D"no"
-blobs=3D"yes"
-edk2_blobs=3D"no"
-pkgversion=3D""
-pie=3D""
-qom_cast_debug=3D"yes"
-trace_backends=3D"log"
-trace_file=3D"trace"
-spice=3D""
-rbd=3D""
-smartcard=3D""
-u2f=3D"auto"
-libusb=3D""
-usb_redir=3D""
-opengl=3D""
-opengl_dmabuf=3D"no"
-cpuid_h=3D"no"
-avx2_opt=3D""
-capstone=3D""
-lzo=3D""
-snappy=3D""
-bzip2=3D""
-lzfse=3D""
-zstd=3D""
-guest_agent=3D""
-guest_agent_with_vss=3D"no"
-guest_agent_ntddscsi=3D"no"
-guest_agent_msi=3D""
-vss_win32_sdk=3D""
-win_sdk=3D"no"
-want_tools=3D""
-libiscsi=3D""
-libnfs=3D""
-coroutine=3D""
-coroutine_pool=3D""
-debug_stack_usage=3D"no"
-crypto_afalg=3D"no"
-seccomp=3D""
-glusterfs=3D""
-glusterfs_xlator_opt=3D"no"
-glusterfs_discard=3D"no"
-glusterfs_fallocate=3D"no"
-glusterfs_zerofill=3D"no"
-glusterfs_ftruncate_has_stat=3D"no"
-glusterfs_iocb_has_stat=3D"no"
-gtk=3D""
-gtk_gl=3D"no"
-tls_priority=3D"NORMAL"
-gnutls=3D""
-nettle=3D""
-nettle_xts=3D"no"
-gcrypt=3D""
-gcrypt_hmac=3D"no"
-gcrypt_xts=3D"no"
-qemu_private_xts=3D"yes"
-auth_pam=3D""
-vte=3D""
-virglrenderer=3D""
-tpm=3D""
-libssh=3D""
-live_block_migration=3D"yes"
-numa=3D""
-tcmalloc=3D"no"
-jemalloc=3D"no"
-replication=3D"yes"
-bochs=3D"yes"
-cloop=3D"yes"
-dmg=3D"yes"
-qcow1=3D"yes"
-vdi=3D"yes"
-vvfat=3D"yes"
-qed=3D"yes"
-parallels=3D"yes"
-sheepdog=3D"yes"
-libxml2=3D""
-debug_mutex=3D"no"
-libpmem=3D""
-default_devices=3D"yes"
-plugins=3D"no"
-fuzzing=3D"no"
-rng_none=3D"no"
-secret_keyring=3D""
-libdaxctl=3D""
-meson=3D""
-ninja=3D""
-skip_meson=3Dno
-gettext=3D""
-
-bogus_os=3D"no"
-malloc_trim=3D""
-
-# parse CC options first
-for opt do
-  optarg=3D$(expr "x$opt" : 'x[^=3D]*=3D\(.*\)')
-  case "$opt" in
-  --cross-prefix=3D*) cross_prefix=3D"$optarg"
-  ;;
-  --cc=3D*) CC=3D"$optarg"
-  ;;
-  --cxx=3D*) CXX=3D"$optarg"
-  ;;
-  --cpu=3D*) cpu=3D"$optarg"
-  ;;
-  --extra-cflags=3D*) QEMU_CFLAGS=3D"$QEMU_CFLAGS $optarg"
-                    QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $optarg"
-  ;;
-  --extra-cxxflags=3D*) QEMU_CXXFLAGS=3D"$QEMU_CXXFLAGS $optarg"
-  ;;
-  --extra-ldflags=3D*) QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $optarg"
-                     EXTRA_LDFLAGS=3D"$optarg"
-  ;;
-  --enable-debug-info) debug_info=3D"yes"
-  ;;
-  --disable-debug-info) debug_info=3D"no"
-  ;;
-  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FOO o=
ption"
-  ;;
-  --cross-cc-cflags-*) cc_arch=3D${opt#--cross-cc-flags-}; cc_arch=3D${cc_=
arch%%=3D*}
-                      eval "cross_cc_cflags_${cc_arch}=3D\$optarg"
-                      cross_cc_vars=3D"$cross_cc_vars cross_cc_cflags_${cc=
_arch}"
-  ;;
-  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}
-                cc_archs=3D"$cc_archs $cc_arch"
-                eval "cross_cc_${cc_arch}=3D\$optarg"
-                cross_cc_vars=3D"$cross_cc_vars cross_cc_${cc_arch}"
-  ;;
-  esac
-done
-# OS specific
-# Using uname is really, really broken.  Once we have the right set of che=
cks
-# we can eliminate its usage altogether.
-
-# Preferred compiler:
-#  ${CC} (if set)
-#  ${cross_prefix}gcc (if cross-prefix specified)
-#  system compiler
-if test -z "${CC}${cross_prefix}"; then
-  cc=3D"$host_cc"
-else
-  cc=3D"${CC-${cross_prefix}gcc}"
-fi
-
-if test -z "${CXX}${cross_prefix}"; then
-  cxx=3D"c++"
-else
-  cxx=3D"${CXX-${cross_prefix}g++}"
-fi
-
-ar=3D"${AR-${cross_prefix}ar}"
-as=3D"${AS-${cross_prefix}as}"
-ccas=3D"${CCAS-$cc}"
-cpp=3D"${CPP-$cc -E}"
-objcopy=3D"${OBJCOPY-${cross_prefix}objcopy}"
-ld=3D"${LD-${cross_prefix}ld}"
-ranlib=3D"${RANLIB-${cross_prefix}ranlib}"
-nm=3D"${NM-${cross_prefix}nm}"
-strip=3D"${STRIP-${cross_prefix}strip}"
-windres=3D"${WINDRES-${cross_prefix}windres}"
-pkg_config_exe=3D"${PKG_CONFIG-${cross_prefix}pkg-config}"
-query_pkg_config() {
-    "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"
-}
-pkg_config=3Dquery_pkg_config
-sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
-
-# If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
-ARFLAGS=3D"${ARFLAGS-rv}"
-
-# default flags for all hosts
-# We use -fwrapv to tell the compiler that we require a C dialect where
-# left shift of signed integers is well defined and has the expected
-# 2s-complement style results. (Both clang and gcc agree that it
-# provides these semantics.)
-QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
-QEMU_CFLAGS=3D"-Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
-QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
-QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE =
$QEMU_CFLAGS"
-QEMU_INCLUDES=3D"-iquote . -iquote ${source_path} -iquote ${source_path}/a=
ccel/tcg -iquote ${source_path}/include"
-QEMU_INCLUDES=3D"$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"
-CFLAGS=3D"-std=3Dgnu99 -Wall"
-
-
-# running configure in the source tree?
-# we know that's the case if configure is there.
-if test -f "./configure"; then
-    pwd_is_source_path=3D"y"
-else
-    pwd_is_source_path=3D"n"
-fi
-
-check_define() {
-cat > $TMPC <<EOF
-#if !defined($1)
-#error $1 not defined
-#endif
-int main(void) { return 0; }
-EOF
-  compile_object
-}
-
-check_include() {
-cat > $TMPC <<EOF
-#include <$1>
-int main(void) { return 0; }
-EOF
-  compile_object
-}
-
-write_c_skeleton() {
-    cat > $TMPC <<EOF
-int main(void) { return 0; }
-EOF
-}
-
-write_c_fuzzer_skeleton() {
-    cat > $TMPC <<EOF
-#include <stdint.h>
-#include <sys/types.h>
-int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);
-int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }
-EOF
-}
-
-if check_define __linux__ ; then
-  targetos=3D"Linux"
-elif check_define _WIN32 ; then
-  targetos=3D'MINGW32'
-elif check_define __OpenBSD__ ; then
-  targetos=3D'OpenBSD'
-elif check_define __sun__ ; then
-  targetos=3D'SunOS'
-elif check_define __HAIKU__ ; then
-  targetos=3D'Haiku'
-elif check_define __FreeBSD__ ; then
-  targetos=3D'FreeBSD'
-elif check_define __FreeBSD_kernel__ && check_define __GLIBC__; then
-  targetos=3D'GNU/kFreeBSD'
-elif check_define __DragonFly__ ; then
-  targetos=3D'DragonFly'
-elif check_define __NetBSD__; then
-  targetos=3D'NetBSD'
-elif check_define __APPLE__; then
-  targetos=3D'Darwin'
-else
-  # This is a fatal error, but don't report it yet, because we
-  # might be going to just print the --help text, or it might
-  # be the result of a missing compiler.
-  targetos=3D'bogus'
-  bogus_os=3D'yes'
-fi
-
-# Some host OSes need non-standard checks for which CPU to use.
-# Note that these checks are broken for cross-compilation: if you're
-# cross-compiling to one of these OSes then you'll need to specify
-# the correct CPU with the --cpu option.
-case $targetos in
-Darwin)
-  # on Leopard most of the system is 32-bit, so we have to ask the kernel =
if we can
-  # run 64-bit userspace code.
-  # If the user didn't specify a CPU explicitly and the kernel says this is
-  # 64 bit hw, then assume x86_64. Otherwise fall through to the usual det=
ection code.
-  if test -z "$cpu" && test "$(sysctl -n hw.optional.x86_64)" =3D "1"; then
-    cpu=3D"x86_64"
-  fi
-  ;;
-SunOS)
-  # $(uname -m) returns i86pc even on an x86_64 box, so default based on i=
sainfo
-  if test -z "$cpu" && test "$(isainfo -k)" =3D "amd64"; then
-    cpu=3D"x86_64"
-  fi
-esac
-
-if test ! -z "$cpu" ; then
-  # command line argument
-  :
-elif check_define __i386__ ; then
-  cpu=3D"i386"
-elif check_define __x86_64__ ; then
-  if check_define __ILP32__ ; then
-    cpu=3D"x32"
-  else
-    cpu=3D"x86_64"
-  fi
-elif check_define __sparc__ ; then
-  if check_define __arch64__ ; then
-    cpu=3D"sparc64"
-  else
-    cpu=3D"sparc"
-  fi
-elif check_define _ARCH_PPC ; then
-  if check_define _ARCH_PPC64 ; then
-    if check_define _LITTLE_ENDIAN ; then
-      cpu=3D"ppc64le"
-    else
-      cpu=3D"ppc64"
-    fi
-  else
-    cpu=3D"ppc"
-  fi
-elif check_define __mips__ ; then
-  cpu=3D"mips"
-elif check_define __s390__ ; then
-  if check_define __s390x__ ; then
-    cpu=3D"s390x"
-  else
-    cpu=3D"s390"
-  fi
-elif check_define __riscv ; then
-  if check_define _LP64 ; then
-    cpu=3D"riscv64"
-  else
-    cpu=3D"riscv32"
-  fi
-elif check_define __arm__ ; then
-  cpu=3D"arm"
-elif check_define __aarch64__ ; then
-  cpu=3D"aarch64"
-else
-  cpu=3D$(uname -m)
-fi
-
-ARCH=3D
-# Normalise host CPU name and set ARCH.
-# Note that this case should only have supported host CPUs, not guests.
-case "$cpu" in
-  ppc|ppc64|s390x|sparc64|x32|riscv32|riscv64)
-  ;;
-  ppc64le)
-    ARCH=3D"ppc64"
-  ;;
-  i386|i486|i586|i686|i86pc|BePC)
-    cpu=3D"i386"
-  ;;
-  x86_64|amd64)
-    cpu=3D"x86_64"
-  ;;
-  armv*b|armv*l|arm)
-    cpu=3D"arm"
-  ;;
-  aarch64)
-    cpu=3D"aarch64"
-  ;;
-  mips*)
-    cpu=3D"mips"
-  ;;
-  sparc|sun4[cdmuv])
-    cpu=3D"sparc"
-  ;;
-  *)
-    # This will result in either an error or falling back to TCI later
-    ARCH=3Dunknown
-  ;;
-esac
-if test -z "$ARCH"; then
-  ARCH=3D"$cpu"
-fi
-
-# OS specific
-
-# host *BSD for user mode
-HOST_VARIANT_DIR=3D""
-
-case $targetos in
-MINGW32*)
-  mingw32=3D"yes"
-  hax=3D"yes"
-  vhost_user=3D"no"
-  audio_possible_drivers=3D"dsound sdl"
-  if check_include dsound.h; then
-    audio_drv_list=3D"dsound"
-  else
-    audio_drv_list=3D""
-  fi
-  supported_os=3D"yes"
-  pie=3D"no"
-;;
-GNU/kFreeBSD)
-  bsd=3D"yes"
-  audio_drv_list=3D"oss try-sdl"
-  audio_possible_drivers=3D"oss sdl pa"
-;;
-FreeBSD)
-  bsd=3D"yes"
-  make=3D"${MAKE-gmake}"
-  audio_drv_list=3D"oss try-sdl"
-  audio_possible_drivers=3D"oss sdl pa"
-  # needed for kinfo_getvmmap(3) in libutil.h
-  LIBS=3D"-lutil $LIBS"
-  netmap=3D""  # enable netmap autodetect
-  HOST_VARIANT_DIR=3D"freebsd"
-;;
-DragonFly)
-  bsd=3D"yes"
-  make=3D"${MAKE-gmake}"
-  audio_drv_list=3D"oss try-sdl"
-  audio_possible_drivers=3D"oss sdl pa"
-  HOST_VARIANT_DIR=3D"dragonfly"
-;;
-NetBSD)
-  bsd=3D"yes"
-  hax=3D"yes"
-  make=3D"${MAKE-gmake}"
-  audio_drv_list=3D"oss try-sdl"
-  audio_possible_drivers=3D"oss sdl"
-  oss_lib=3D"-lossaudio"
-  HOST_VARIANT_DIR=3D"netbsd"
-;;
-OpenBSD)
-  bsd=3D"yes"
-  make=3D"${MAKE-gmake}"
-  audio_drv_list=3D"try-sdl"
-  audio_possible_drivers=3D"sdl"
-  HOST_VARIANT_DIR=3D"openbsd"
-;;
-Darwin)
-  bsd=3D"yes"
-  darwin=3D"yes"
-  hax=3D"yes"
-  hvf=3D"yes"
-  LDFLAGS_SHARED=3D"-bundle -undefined dynamic_lookup"
-  if [ "$cpu" =3D "x86_64" ] ; then
-    QEMU_CFLAGS=3D"-arch x86_64 $QEMU_CFLAGS"
-    QEMU_LDFLAGS=3D"-arch x86_64 $QEMU_LDFLAGS"
-  fi
-  cocoa=3D"yes"
-  audio_drv_list=3D"coreaudio try-sdl"
-  audio_possible_drivers=3D"coreaudio sdl"
-  QEMU_LDFLAGS=3D"-framework CoreFoundation -framework IOKit $QEMU_LDFLAGS"
-  # Disable attempts to use ObjectiveC features in os/object.h since they
-  # won't work when we're compiling with gcc as a C compiler.
-  QEMU_CFLAGS=3D"-DOS_OBJECT_USE_OBJC=3D0 $QEMU_CFLAGS"
-  HOST_VARIANT_DIR=3D"darwin"
-;;
-SunOS)
-  solaris=3D"yes"
-  make=3D"${MAKE-gmake}"
-  install=3D"${INSTALL-ginstall}"
-  smbd=3D"${SMBD-/usr/sfw/sbin/smbd}"
-  if test -f /usr/include/sys/soundcard.h ; then
-    audio_drv_list=3D"oss try-sdl"
-  fi
-  audio_possible_drivers=3D"oss sdl"
-# needed for CMSG_ macros in sys/socket.h
-  QEMU_CFLAGS=3D"-D_XOPEN_SOURCE=3D600 $QEMU_CFLAGS"
-# needed for TIOCWIN* defines in termios.h
-  QEMU_CFLAGS=3D"-D__EXTENSIONS__ $QEMU_CFLAGS"
-  solarisnetlibs=3D"-lsocket -lnsl -lresolv"
-  LIBS=3D"$solarisnetlibs $LIBS"
-;;
-Haiku)
-  haiku=3D"yes"
-  QEMU_CFLAGS=3D"-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"
-  LIBS=3D"-lposix_error_mapper -lnetwork -lbsd $LIBS"
-;;
-Linux)
-  audio_drv_list=3D"try-pa oss"
-  audio_possible_drivers=3D"oss alsa sdl pa"
-  linux=3D"yes"
-  linux_user=3D"yes"
-  kvm=3D"yes"
-  QEMU_INCLUDES=3D"-isystem ${source_path}/linux-headers -I${build_path}/l=
inux-headers $QEMU_INCLUDES"
-  libudev=3D"yes"
-;;
-esac
-
-if [ "$bsd" =3D "yes" ] ; then
-  if [ "$darwin" !=3D "yes" ] ; then
-    bsd_user=3D"yes"
-  fi
-fi
-
-: ${make=3D${MAKE-make}}
-: ${install=3D${INSTALL-install}}
-# We prefer python 3.x. A bare 'python' is traditionally
-# python 2.x, but some distros have it as python 3.x, so
-# we check that too
-python=3D
-explicit_python=3Dno
-for binary in "${PYTHON-python3}" python
-do
-    if has "$binary"
-    then
-        python=3D$(command -v "$binary")
-        break
-    fi
-done
-
-sphinx_build=3D
-for binary in sphinx-build-3 sphinx-build
-do
-    if has "$binary"
-    then
-        sphinx_build=3D$(command -v "$binary")
-        break
-    fi
-done
-
-# Check for ancillary tools used in testing
-genisoimage=3D
-for binary in genisoimage mkisofs
-do
-    if has $binary
-    then
-        genisoimage=3D$(command -v "$binary")
-        break
-    fi
-done
-
-: ${smbd=3D${SMBD-/usr/sbin/smbd}}
-
-# Default objcc to clang if available, otherwise use CC
-if has clang; then
-  objcc=3Dclang
-else
-  objcc=3D"$cc"
-fi
-
-if test "$mingw32" =3D "yes" ; then
-  EXESUF=3D".exe"
-  HOST_DSOSUF=3D".dll"
-  # MinGW needs -mthreads for TLS and macro _MT.
-  CFLAGS=3D"-mthreads $CFLAGS"
-  LIBS=3D"-lwinmm -lws2_32 $LIBS"
-  write_c_skeleton;
-  if compile_prog "" "-liberty" ; then
-    LIBS=3D"-liberty $LIBS"
-  fi
-  prefix=3D"c:/Program Files/QEMU"
-  qemu_suffix=3D""
-  libs_qga=3D"-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi =
-lnetapi32 $libs_qga"
-fi
-
-werror=3D""
-
-for opt do
-  optarg=3D$(expr "x$opt" : 'x[^=3D]*=3D\(.*\)')
-  case "$opt" in
-  --help|-h) show_help=3Dyes
-  ;;
-  --version|-V) exec cat $source_path/VERSION
-  ;;
-  --prefix=3D*) prefix=3D"$optarg"
-  ;;
-  --interp-prefix=3D*) interp_prefix=3D"$optarg"
-  ;;
-  --cross-prefix=3D*)
-  ;;
-  --cc=3D*)
-  ;;
-  --host-cc=3D*) host_cc=3D"$optarg"
-  ;;
-  --cxx=3D*)
-  ;;
-  --iasl=3D*) iasl=3D"$optarg"
-  ;;
-  --objcc=3D*) objcc=3D"$optarg"
-  ;;
-  --make=3D*) make=3D"$optarg"
-  ;;
-  --install=3D*) install=3D"$optarg"
-  ;;
-  --python=3D*) python=3D"$optarg" ; explicit_python=3Dyes
-  ;;
-  --sphinx-build=3D*) sphinx_build=3D"$optarg"
-  ;;
-  --skip-meson) skip_meson=3Dyes
-  ;;
-  --meson=3D*) meson=3D"$optarg"
-  ;;
-  --ninja=3D*) ninja=3D"$optarg"
-  ;;
-  --smbd=3D*) smbd=3D"$optarg"
-  ;;
-  --extra-cflags=3D*)
-  ;;
-  --extra-cxxflags=3D*)
-  ;;
-  --extra-ldflags=3D*)
-  ;;
-  --enable-debug-info)
-  ;;
-  --disable-debug-info)
-  ;;
-  --cross-cc-*)
-  ;;
-  --enable-modules)
-      modules=3D"yes"
-  ;;
-  --disable-modules)
-      modules=3D"no"
-  ;;
-  --disable-module-upgrades) module_upgrades=3D"no"
-  ;;
-  --enable-module-upgrades) module_upgrades=3D"yes"
-  ;;
-  --cpu=3D*)
-  ;;
-  --target-list=3D*) target_list=3D"$optarg"
-                   if test "$target_list_exclude"; then
-                       error_exit "Can't mix --target-list with --target-l=
ist-exclude"
-                   fi
-  ;;
-  --target-list-exclude=3D*) target_list_exclude=3D"$optarg"
-                   if test "$target_list"; then
-                       error_exit "Can't mix --target-list-exclude with --=
target-list"
-                   fi
-  ;;
-  --enable-trace-backends=3D*) trace_backends=3D"$optarg"
-  ;;
-  # XXX: backwards compatibility
-  --enable-trace-backend=3D*) trace_backends=3D"$optarg"
-  ;;
-  --with-trace-file=3D*) trace_file=3D"$optarg"
-  ;;
-  --with-default-devices) default_devices=3D"yes"
-  ;;
-  --without-default-devices) default_devices=3D"no"
-  ;;
-  --enable-gprof) gprof=3D"yes"
-  ;;
-  --enable-gcov) gcov=3D"yes"
-  ;;
-  --static)
-    static=3D"yes"
-    QEMU_PKG_CONFIG_FLAGS=3D"--static $QEMU_PKG_CONFIG_FLAGS"
-  ;;
-  --mandir=3D*) mandir=3D"$optarg"
-  ;;
-  --bindir=3D*) bindir=3D"$optarg"
-  ;;
-  --libdir=3D*) libdir=3D"$optarg"
-  ;;
-  --libexecdir=3D*) libexecdir=3D"$optarg"
-  ;;
-  --includedir=3D*) includedir=3D"$optarg"
-  ;;
-  --datadir=3D*) datadir=3D"$optarg"
-  ;;
-  --with-suffix=3D*) qemu_suffix=3D"$optarg"
-  ;;
-  --docdir=3D*) qemu_docdir=3D"$optarg"
-  ;;
-  --sysconfdir=3D*) sysconfdir=3D"$optarg"
-  ;;
-  --localstatedir=3D*) local_statedir=3D"$optarg"
-  ;;
-  --firmwarepath=3D*) firmwarepath=3D"$optarg"
-  ;;
-  --host=3D*|--build=3D*|\
-  --disable-dependency-tracking|\
-  --sbindir=3D*|--sharedstatedir=3D*|\
-  --oldincludedir=3D*|--datarootdir=3D*|--infodir=3D*|--localedir=3D*|\
-  --htmldir=3D*|--dvidir=3D*|--pdfdir=3D*|--psdir=3D*)
-    # These switches are silently ignored, for compatibility with
-    # autoconf-generated configure scripts. This allows QEMU's
-    # configure to be used by RPM and similar macros that set
-    # lots of directory switches by default.
-  ;;
-  --disable-sdl) sdl=3D"disabled"
-  ;;
-  --enable-sdl) sdl=3D"enabled"
-  ;;
-  --disable-sdl-image) sdl_image=3D"disabled"
-  ;;
-  --enable-sdl-image) sdl_image=3D"enabled"
-  ;;
-  --disable-qom-cast-debug) qom_cast_debug=3D"no"
-  ;;
-  --enable-qom-cast-debug) qom_cast_debug=3D"yes"
-  ;;
-  --disable-virtfs) virtfs=3D"no"
-  ;;
-  --enable-virtfs) virtfs=3D"yes"
-  ;;
-  --disable-mpath) mpath=3D"no"
-  ;;
-  --enable-mpath) mpath=3D"yes"
-  ;;
-  --disable-vnc) vnc=3D"disabled"
-  ;;
-  --enable-vnc) vnc=3D"enabled"
-  ;;
-  --disable-gettext) gettext=3D"false"
-  ;;
-  --enable-gettext) gettext=3D"true"
-  ;;
-  --oss-lib=3D*) oss_lib=3D"$optarg"
-  ;;
-  --audio-drv-list=3D*) audio_drv_list=3D"$optarg"
-  ;;
-  --block-drv-rw-whitelist=3D*|--block-drv-whitelist=3D*) block_drv_rw_whi=
telist=3D$(echo "$optarg" | sed -e 's/,/ /g')
-  ;;
-  --block-drv-ro-whitelist=3D*) block_drv_ro_whitelist=3D$(echo "$optarg" =
| sed -e 's/,/ /g')
-  ;;
-  --enable-debug-tcg) debug_tcg=3D"yes"
-  ;;
-  --disable-debug-tcg) debug_tcg=3D"no"
-  ;;
-  --enable-debug)
-      # Enable debugging options that aren't excessively noisy
-      debug_tcg=3D"yes"
-      debug_mutex=3D"yes"
-      debug=3D"yes"
-      strip_opt=3D"no"
-      fortify_source=3D"no"
-  ;;
-  --enable-sanitizers) sanitizers=3D"yes"
-  ;;
-  --disable-sanitizers) sanitizers=3D"no"
-  ;;
-  --enable-tsan) tsan=3D"yes"
-  ;;
-  --disable-tsan) tsan=3D"no"
-  ;;
-  --enable-sparse) sparse=3D"yes"
-  ;;
-  --disable-sparse) sparse=3D"no"
-  ;;
-  --disable-strip) strip_opt=3D"no"
-  ;;
-  --disable-vnc-sasl) vnc_sasl=3D"disabled"
-  ;;
-  --enable-vnc-sasl) vnc_sasl=3D"enabled"
-  ;;
-  --disable-vnc-jpeg) vnc_jpeg=3D"disabled"
-  ;;
-  --enable-vnc-jpeg) vnc_jpeg=3D"enabled"
-  ;;
-  --disable-vnc-png) vnc_png=3D"disabled"
-  ;;
-  --enable-vnc-png) vnc_png=3D"enabled"
-  ;;
-  --disable-slirp) slirp=3D"no"
-  ;;
-  --enable-slirp=3Dgit) slirp=3D"git"
-  ;;
-  --enable-slirp=3Dsystem) slirp=3D"system"
-  ;;
-  --disable-vde) vde=3D"no"
-  ;;
-  --enable-vde) vde=3D"yes"
-  ;;
-  --disable-netmap) netmap=3D"no"
-  ;;
-  --enable-netmap) netmap=3D"yes"
-  ;;
-  --disable-xen) xen=3D"no"
-  ;;
-  --enable-xen) xen=3D"yes"
-  ;;
-  --disable-xen-pci-passthrough) xen_pci_passthrough=3D"no"
-  ;;
-  --enable-xen-pci-passthrough) xen_pci_passthrough=3D"yes"
-  ;;
-  --disable-brlapi) brlapi=3D"no"
-  ;;
-  --enable-brlapi) brlapi=3D"yes"
-  ;;
-  --disable-kvm) kvm=3D"no"
-  ;;
-  --enable-kvm) kvm=3D"yes"
-  ;;
-  --disable-hax) hax=3D"no"
-  ;;
-  --enable-hax) hax=3D"yes"
-  ;;
-  --disable-hvf) hvf=3D"no"
-  ;;
-  --enable-hvf) hvf=3D"yes"
-  ;;
-  --disable-whpx) whpx=3D"no"
-  ;;
-  --enable-whpx) whpx=3D"yes"
-  ;;
-  --disable-tcg-interpreter) tcg_interpreter=3D"no"
-  ;;
-  --enable-tcg-interpreter) tcg_interpreter=3D"yes"
-  ;;
-  --disable-cap-ng)  cap_ng=3D"no"
-  ;;
-  --enable-cap-ng) cap_ng=3D"yes"
-  ;;
-  --disable-tcg) tcg=3D"no"
-  ;;
-  --enable-tcg) tcg=3D"yes"
-  ;;
-  --disable-malloc-trim) malloc_trim=3D"no"
-  ;;
-  --enable-malloc-trim) malloc_trim=3D"yes"
-  ;;
-  --disable-spice) spice=3D"no"
-  ;;
-  --enable-spice) spice=3D"yes"
-  ;;
-  --disable-libiscsi) libiscsi=3D"no"
-  ;;
-  --enable-libiscsi) libiscsi=3D"yes"
-  ;;
-  --disable-libnfs) libnfs=3D"no"
-  ;;
-  --enable-libnfs) libnfs=3D"yes"
-  ;;
-  --enable-profiler) profiler=3D"yes"
-  ;;
-  --disable-cocoa) cocoa=3D"no"
-  ;;
-  --enable-cocoa)
-      cocoa=3D"yes" ;
-      audio_drv_list=3D"coreaudio $(echo $audio_drv_list | sed s,coreaudio=
,,g)"
-  ;;
-  --disable-system) softmmu=3D"no"
-  ;;
-  --enable-system) softmmu=3D"yes"
-  ;;
-  --disable-user)
-      linux_user=3D"no" ;
-      bsd_user=3D"no" ;
-  ;;
-  --enable-user) ;;
-  --disable-linux-user) linux_user=3D"no"
-  ;;
-  --enable-linux-user) linux_user=3D"yes"
-  ;;
-  --disable-bsd-user) bsd_user=3D"no"
-  ;;
-  --enable-bsd-user) bsd_user=3D"yes"
-  ;;
-  --enable-pie) pie=3D"yes"
-  ;;
-  --disable-pie) pie=3D"no"
-  ;;
-  --enable-werror) werror=3D"yes"
-  ;;
-  --disable-werror) werror=3D"no"
-  ;;
-  --enable-stack-protector) stack_protector=3D"yes"
-  ;;
-  --disable-stack-protector) stack_protector=3D"no"
-  ;;
-  --enable-safe-stack) safe_stack=3D"yes"
-  ;;
-  --disable-safe-stack) safe_stack=3D"no"
-  ;;
-  --disable-curses) curses=3D"no"
-  ;;
-  --enable-curses) curses=3D"yes"
-  ;;
-  --disable-iconv) iconv=3D"no"
-  ;;
-  --enable-iconv) iconv=3D"yes"
-  ;;
-  --disable-curl) curl=3D"no"
-  ;;
-  --enable-curl) curl=3D"yes"
-  ;;
-  --disable-fdt) fdt=3D"no"
-  ;;
-  --enable-fdt) fdt=3D"yes"
-  ;;
-  --disable-linux-aio) linux_aio=3D"no"
-  ;;
-  --enable-linux-aio) linux_aio=3D"yes"
-  ;;
-  --disable-linux-io-uring) linux_io_uring=3D"no"
-  ;;
-  --enable-linux-io-uring) linux_io_uring=3D"yes"
-  ;;
-  --disable-attr) attr=3D"no"
-  ;;
-  --enable-attr) attr=3D"yes"
-  ;;
-  --disable-membarrier) membarrier=3D"no"
-  ;;
-  --enable-membarrier) membarrier=3D"yes"
-  ;;
-  --disable-blobs) blobs=3D"no"
-  ;;
-  --with-pkgversion=3D*) pkgversion=3D"$optarg"
-  ;;
-  --with-coroutine=3D*) coroutine=3D"$optarg"
-  ;;
-  --disable-coroutine-pool) coroutine_pool=3D"no"
-  ;;
-  --enable-coroutine-pool) coroutine_pool=3D"yes"
-  ;;
-  --enable-debug-stack-usage) debug_stack_usage=3D"yes"
-  ;;
-  --enable-crypto-afalg) crypto_afalg=3D"yes"
-  ;;
-  --disable-crypto-afalg) crypto_afalg=3D"no"
-  ;;
-  --disable-docs) docs=3D"no"
-  ;;
-  --enable-docs) docs=3D"yes"
-  ;;
-  --disable-vhost-net) vhost_net=3D"no"
-  ;;
-  --enable-vhost-net) vhost_net=3D"yes"
-  ;;
-  --disable-vhost-crypto) vhost_crypto=3D"no"
-  ;;
-  --enable-vhost-crypto) vhost_crypto=3D"yes"
-  ;;
-  --disable-vhost-scsi) vhost_scsi=3D"no"
-  ;;
-  --enable-vhost-scsi) vhost_scsi=3D"yes"
-  ;;
-  --disable-vhost-vsock) vhost_vsock=3D"no"
-  ;;
-  --enable-vhost-vsock) vhost_vsock=3D"yes"
-  ;;
-  --disable-vhost-user-fs) vhost_user_fs=3D"no"
-  ;;
-  --enable-vhost-user-fs) vhost_user_fs=3D"yes"
-  ;;
-  --disable-opengl) opengl=3D"no"
-  ;;
-  --enable-opengl) opengl=3D"yes"
-  ;;
-  --disable-rbd) rbd=3D"no"
-  ;;
-  --enable-rbd) rbd=3D"yes"
-  ;;
-  --disable-xfsctl) xfs=3D"no"
-  ;;
-  --enable-xfsctl) xfs=3D"yes"
-  ;;
-  --disable-smartcard) smartcard=3D"no"
-  ;;
-  --enable-smartcard) smartcard=3D"yes"
-  ;;
-  --disable-u2f) u2f=3D"disabled"
-  ;;
-  --enable-u2f) u2f=3D"enabled"
-  ;;
-  --disable-libusb) libusb=3D"no"
-  ;;
-  --enable-libusb) libusb=3D"yes"
-  ;;
-  --disable-usb-redir) usb_redir=3D"no"
-  ;;
-  --enable-usb-redir) usb_redir=3D"yes"
-  ;;
-  --disable-zlib-test)
-  ;;
-  --disable-lzo) lzo=3D"no"
-  ;;
-  --enable-lzo) lzo=3D"yes"
-  ;;
-  --disable-snappy) snappy=3D"no"
-  ;;
-  --enable-snappy) snappy=3D"yes"
-  ;;
-  --disable-bzip2) bzip2=3D"no"
-  ;;
-  --enable-bzip2) bzip2=3D"yes"
-  ;;
-  --enable-lzfse) lzfse=3D"yes"
-  ;;
-  --disable-lzfse) lzfse=3D"no"
-  ;;
-  --disable-zstd) zstd=3D"no"
-  ;;
-  --enable-zstd) zstd=3D"yes"
-  ;;
-  --enable-guest-agent) guest_agent=3D"yes"
-  ;;
-  --disable-guest-agent) guest_agent=3D"no"
-  ;;
-  --enable-guest-agent-msi) guest_agent_msi=3D"yes"
-  ;;
-  --disable-guest-agent-msi) guest_agent_msi=3D"no"
-  ;;
-  --with-vss-sdk) vss_win32_sdk=3D""
-  ;;
-  --with-vss-sdk=3D*) vss_win32_sdk=3D"$optarg"
-  ;;
-  --without-vss-sdk) vss_win32_sdk=3D"no"
-  ;;
-  --with-win-sdk) win_sdk=3D""
-  ;;
-  --with-win-sdk=3D*) win_sdk=3D"$optarg"
-  ;;
-  --without-win-sdk) win_sdk=3D"no"
-  ;;
-  --enable-tools) want_tools=3D"yes"
-  ;;
-  --disable-tools) want_tools=3D"no"
-  ;;
-  --enable-seccomp) seccomp=3D"yes"
-  ;;
-  --disable-seccomp) seccomp=3D"no"
-  ;;
-  --disable-glusterfs) glusterfs=3D"no"
-  ;;
-  --disable-avx2) avx2_opt=3D"no"
-  ;;
-  --enable-avx2) avx2_opt=3D"yes"
-  ;;
-  --disable-avx512f) avx512f_opt=3D"no"
-  ;;
-  --enable-avx512f) avx512f_opt=3D"yes"
-  ;;
-
-  --enable-glusterfs) glusterfs=3D"yes"
-  ;;
-  --disable-virtio-blk-data-plane|--enable-virtio-blk-data-plane)
-      echo "$0: $opt is obsolete, virtio-blk data-plane is always on" >&2
-  ;;
-  --enable-vhdx|--disable-vhdx)
-      echo "$0: $opt is obsolete, VHDX driver is always built" >&2
-  ;;
-  --enable-uuid|--disable-uuid)
-      echo "$0: $opt is obsolete, UUID support is always built" >&2
-  ;;
-  --disable-gtk) gtk=3D"no"
-  ;;
-  --enable-gtk) gtk=3D"yes"
-  ;;
-  --tls-priority=3D*) tls_priority=3D"$optarg"
-  ;;
-  --disable-gnutls) gnutls=3D"no"
-  ;;
-  --enable-gnutls) gnutls=3D"yes"
-  ;;
-  --disable-nettle) nettle=3D"no"
-  ;;
-  --enable-nettle) nettle=3D"yes"
-  ;;
-  --disable-gcrypt) gcrypt=3D"no"
-  ;;
-  --enable-gcrypt) gcrypt=3D"yes"
-  ;;
-  --disable-auth-pam) auth_pam=3D"no"
-  ;;
-  --enable-auth-pam) auth_pam=3D"yes"
-  ;;
-  --enable-rdma) rdma=3D"yes"
-  ;;
-  --disable-rdma) rdma=3D"no"
-  ;;
-  --enable-pvrdma) pvrdma=3D"yes"
-  ;;
-  --disable-pvrdma) pvrdma=3D"no"
-  ;;
-  --disable-vte) vte=3D"no"
-  ;;
-  --enable-vte) vte=3D"yes"
-  ;;
-  --disable-virglrenderer) virglrenderer=3D"no"
-  ;;
-  --enable-virglrenderer) virglrenderer=3D"yes"
-  ;;
-  --disable-tpm) tpm=3D"no"
-  ;;
-  --enable-tpm) tpm=3D"yes"
-  ;;
-  --disable-libssh) libssh=3D"no"
-  ;;
-  --enable-libssh) libssh=3D"yes"
-  ;;
-  --disable-live-block-migration) live_block_migration=3D"no"
-  ;;
-  --enable-live-block-migration) live_block_migration=3D"yes"
-  ;;
-  --disable-numa) numa=3D"no"
-  ;;
-  --enable-numa) numa=3D"yes"
-  ;;
-  --disable-libxml2) libxml2=3D"no"
-  ;;
-  --enable-libxml2) libxml2=3D"yes"
-  ;;
-  --disable-tcmalloc) tcmalloc=3D"no"
-  ;;
-  --enable-tcmalloc) tcmalloc=3D"yes"
-  ;;
-  --disable-jemalloc) jemalloc=3D"no"
-  ;;
-  --enable-jemalloc) jemalloc=3D"yes"
-  ;;
-  --disable-replication) replication=3D"no"
-  ;;
-  --enable-replication) replication=3D"yes"
-  ;;
-  --disable-bochs) bochs=3D"no"
-  ;;
-  --enable-bochs) bochs=3D"yes"
-  ;;
-  --disable-cloop) cloop=3D"no"
-  ;;
-  --enable-cloop) cloop=3D"yes"
-  ;;
-  --disable-dmg) dmg=3D"no"
-  ;;
-  --enable-dmg) dmg=3D"yes"
-  ;;
-  --disable-qcow1) qcow1=3D"no"
-  ;;
-  --enable-qcow1) qcow1=3D"yes"
-  ;;
-  --disable-vdi) vdi=3D"no"
-  ;;
-  --enable-vdi) vdi=3D"yes"
-  ;;
-  --disable-vvfat) vvfat=3D"no"
-  ;;
-  --enable-vvfat) vvfat=3D"yes"
-  ;;
-  --disable-qed) qed=3D"no"
-  ;;
-  --enable-qed) qed=3D"yes"
-  ;;
-  --disable-parallels) parallels=3D"no"
-  ;;
-  --enable-parallels) parallels=3D"yes"
-  ;;
-  --disable-sheepdog) sheepdog=3D"no"
-  ;;
-  --enable-sheepdog) sheepdog=3D"yes"
-  ;;
-  --disable-vhost-user) vhost_user=3D"no"
-  ;;
-  --enable-vhost-user) vhost_user=3D"yes"
-  ;;
-  --disable-vhost-vdpa) vhost_vdpa=3D"no"
-  ;;
-  --enable-vhost-vdpa) vhost_vdpa=3D"yes"
-  ;;
-  --disable-vhost-kernel) vhost_kernel=3D"no"
-  ;;
-  --enable-vhost-kernel) vhost_kernel=3D"yes"
-  ;;
-  --disable-capstone) capstone=3D"no"
-  ;;
-  --enable-capstone) capstone=3D"yes"
-  ;;
-  --enable-capstone=3Dgit) capstone=3D"git"
-  ;;
-  --enable-capstone=3Dsystem) capstone=3D"system"
-  ;;
-  --with-git=3D*) git=3D"$optarg"
-  ;;
-  --enable-git-update) git_update=3Dyes
-  ;;
-  --disable-git-update) git_update=3Dno
-  ;;
-  --enable-debug-mutex) debug_mutex=3Dyes
-  ;;
-  --disable-debug-mutex) debug_mutex=3Dno
-  ;;
-  --enable-libpmem) libpmem=3Dyes
-  ;;
-  --disable-libpmem) libpmem=3Dno
-  ;;
-  --enable-xkbcommon) xkbcommon=3D"enabled"
-  ;;
-  --disable-xkbcommon) xkbcommon=3D"disabled"
-  ;;
-  --enable-plugins) plugins=3D"yes"
-  ;;
-  --disable-plugins) plugins=3D"no"
-  ;;
-  --enable-containers) use_containers=3D"yes"
-  ;;
-  --disable-containers) use_containers=3D"no"
-  ;;
-  --enable-fuzzing) fuzzing=3Dyes
-  ;;
-  --disable-fuzzing) fuzzing=3Dno
-  ;;
-  --gdb=3D*) gdb_bin=3D"$optarg"
-  ;;
-  --enable-rng-none) rng_none=3Dyes
-  ;;
-  --disable-rng-none) rng_none=3Dno
-  ;;
-  --enable-keyring) secret_keyring=3D"yes"
-  ;;
-  --disable-keyring) secret_keyring=3D"no"
-  ;;
-  --enable-libdaxctl) libdaxctl=3Dyes
-  ;;
-  --disable-libdaxctl) libdaxctl=3Dno
-  ;;
-  *)
-      echo "ERROR: unknown option $opt"
-      echo "Try '$0 --help' for more information"
-      exit 1
-  ;;
-  esac
-done
-
-firmwarepath=3D"${firmwarepath:-$prefix/share/qemu-firmware}"
-libdir=3D"${libdir:-$prefix/lib}"
-libexecdir=3D"${libexecdir:-$prefix/libexec}"
-includedir=3D"${includedir:-$prefix/include}"
-
-if test "$mingw32" =3D "yes" ; then
-    mandir=3D"$prefix"
-    datadir=3D"$prefix"
-    docdir=3D"$prefix"
-    bindir=3D"$prefix"
-    sysconfdir=3D"$prefix"
-    local_statedir=3D
-else
-    mandir=3D"${mandir:-$prefix/share/man}"
-    datadir=3D"${datadir:-$prefix/share}"
-    docdir=3D"${docdir:-$prefix/share/doc}"
-    bindir=3D"${bindir:-$prefix/bin}"
-    sysconfdir=3D"${sysconfdir:-$prefix/etc}"
-    local_statedir=3D"${local_statedir:-$prefix/var}"
-fi
-
-case "$cpu" in
-    ppc)
-           CPU_CFLAGS=3D"-m32"
-           QEMU_LDFLAGS=3D"-m32 $QEMU_LDFLAGS"
-           ;;
-    ppc64)
-           CPU_CFLAGS=3D"-m64"
-           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
-           ;;
-    sparc)
-           CPU_CFLAGS=3D"-m32 -mv8plus -mcpu=3Dultrasparc"
-           QEMU_LDFLAGS=3D"-m32 -mv8plus $QEMU_LDFLAGS"
-           ;;
-    sparc64)
-           CPU_CFLAGS=3D"-m64 -mcpu=3Dultrasparc"
-           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
-           ;;
-    s390)
-           CPU_CFLAGS=3D"-m31"
-           QEMU_LDFLAGS=3D"-m31 $QEMU_LDFLAGS"
-           ;;
-    s390x)
-           CPU_CFLAGS=3D"-m64"
-           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
-           ;;
-    i386)
-           CPU_CFLAGS=3D"-m32"
-           QEMU_LDFLAGS=3D"-m32 $QEMU_LDFLAGS"
-           ;;
-    x86_64)
-           # ??? Only extremely old AMD cpus do not have cmpxchg16b.
-           # If we truly care, we should simply detect this case at
-           # runtime and generate the fallback to serial emulation.
-           CPU_CFLAGS=3D"-m64 -mcx16"
-           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"
-           ;;
-    x32)
-           CPU_CFLAGS=3D"-mx32"
-           QEMU_LDFLAGS=3D"-mx32 $QEMU_LDFLAGS"
-           ;;
-    # No special flags required for other host CPUs
-esac
-
-eval "cross_cc_${cpu}=3D\$host_cc"
-cross_cc_vars=3D"$cross_cc_vars cross_cc_${cpu}"
-QEMU_CFLAGS=3D"$CPU_CFLAGS $QEMU_CFLAGS"
-
-# For user-mode emulation the host arch has to be one we explicitly
-# support, even if we're using TCI.
-if [ "$ARCH" =3D "unknown" ]; then
-  bsd_user=3D"no"
-  linux_user=3D"no"
-fi
-
-if [ "$bsd_user" =3D "no" -a "$linux_user" =3D "no" -a "$softmmu" =3D "no"=
 ] ; then
-  tcg=3D"no"
-fi
-
-default_target_list=3D""
-
-mak_wilds=3D""
-
-if [ "$softmmu" =3D "yes" ]; then
-    mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-softmmu.mak"
-fi
-if [ "$linux_user" =3D "yes" ]; then
-    mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-linux-user.ma=
k"
-fi
-if [ "$bsd_user" =3D "yes" ]; then
-    mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
-fi
-
-if test -z "$target_list_exclude"; then
-    for config in $mak_wilds; do
-        default_target_list=3D"${default_target_list} $(basename "$config"=
 .mak)"
-    done
-else
-    exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')
-    for config in $mak_wilds; do
-        target=3D"$(basename "$config" .mak)"
-        exclude=3D"no"
-        for excl in $exclude_list; do
-            if test "$excl" =3D "$target"; then
-                exclude=3D"yes"
-                break;
-            fi
-        done
-        if test "$exclude" =3D "no"; then
-            default_target_list=3D"${default_target_list} $target"
-        fi
-    done
-fi
-
-# Enumerate public trace backends for --help output
-trace_backend_list=3D$(echo $(grep -le '^PUBLIC =3D True$' "$source_path"/=
scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
-
-if test x"$show_help" =3D x"yes" ; then
-cat << EOF
-
-Usage: configure [options]
-Options: [defaults in brackets after descriptions]
-
-Standard options:
-  --help                   print this message
-  --prefix=3DPREFIX          install in PREFIX [$prefix]
-  --interp-prefix=3DPREFIX   where to find shared libraries, etc.
-                           use %M for cpu name [$interp_prefix]
-  --target-list=3DLIST       set target list (default: build everything)
-$(echo Available targets: $default_target_list | \
-  fold -s -w 53 | sed -e 's/^/                           /')
-  --target-list-exclude=3DLIST exclude a set of targets from the default t=
arget-list
-
-Advanced options (experts only):
-  --cross-prefix=3DPREFIX    use PREFIX for compile tools [$cross_prefix]
-  --cc=3DCC                  use C compiler CC [$cc]
-  --iasl=3DIASL              use ACPI compiler IASL [$iasl]
-  --host-cc=3DCC             use C compiler CC [$host_cc] for code run at
-                           build time
-  --cxx=3DCXX                use C++ compiler CXX [$cxx]
-  --objcc=3DOBJCC            use Objective-C compiler OBJCC [$objcc]
-  --extra-cflags=3DCFLAGS    append extra C compiler flags QEMU_CFLAGS
-  --extra-cxxflags=3DCXXFLAGS append extra C++ compiler flags QEMU_CXXFLAGS
-  --extra-ldflags=3DLDFLAGS  append extra linker flags LDFLAGS
-  --cross-cc-ARCH=3DCC       use compiler when building ARCH guest test ca=
ses
-  --cross-cc-flags-ARCH=3D   use compiler flags when building ARCH guest t=
ests
-  --make=3DMAKE              use specified make [$make]
-  --install=3DINSTALL        use specified install [$install]
-  --python=3DPYTHON          use specified python [$python]
-  --sphinx-build=3DSPHINX    use specified sphinx-build [$sphinx_build]
-  --meson=3DMESON            use specified meson [$meson]
-  --ninja=3DNINJA            use specified ninja [$ninja]
-  --smbd=3DSMBD              use specified smbd [$smbd]
-  --with-git=3DGIT           use specified git [$git]
-  --static                 enable static build [$static]
-  --mandir=3DPATH            install man pages in PATH
-  --datadir=3DPATH           install firmware in PATH/$qemu_suffix
-  --docdir=3DPATH            install documentation in PATH/$qemu_suffix
-  --bindir=3DPATH            install binaries in PATH
-  --libdir=3DPATH            install libraries in PATH
-  --libexecdir=3DPATH        install helper binaries in PATH
-  --sysconfdir=3DPATH        install config in PATH/$qemu_suffix
-  --localstatedir=3DPATH     install local state in PATH (set at runtime o=
n win32)
-  --firmwarepath=3DPATH      search PATH for firmware files
-  --efi-aarch64=3DPATH       PATH of efi file to use for aarch64 VMs.
-  --with-suffix=3DSUFFIX     suffix for QEMU data inside datadir/libdir/sy=
sconfdir/docdir [$qemu_suffix]
-  --with-pkgversion=3DVERS   use specified string as sub-version of the pa=
ckage
-  --enable-debug           enable common debug build options
-  --enable-sanitizers      enable default sanitizers
-  --enable-tsan            enable thread sanitizer
-  --disable-strip          disable stripping binaries
-  --disable-werror         disable compilation abort on warning
-  --disable-stack-protector disable compiler-provided stack protection
-  --audio-drv-list=3DLIST    set audio drivers list:
-                           Available drivers: $audio_possible_drivers
-  --block-drv-whitelist=3DL  Same as --block-drv-rw-whitelist=3DL
-  --block-drv-rw-whitelist=3DL
-                           set block driver read-write whitelist
-                           (affects only QEMU, not qemu-img)
-  --block-drv-ro-whitelist=3DL
-                           set block driver read-only whitelist
-                           (affects only QEMU, not qemu-img)
-  --enable-trace-backends=3DB Set trace backend
-                           Available backends: $trace_backend_list
-  --with-trace-file=3DNAME   Full PATH,NAME of file to store traces
-                           Default:trace-<pid>
-  --disable-slirp          disable SLIRP userspace network connectivity
-  --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
-  --enable-malloc-trim     enable libc malloc_trim() for memory optimizati=
on
-  --oss-lib                path to OSS library
-  --cpu=3DCPU                Build for host CPU [$cpu]
-  --with-coroutine=3DBACKEND coroutine backend. Supported options:
-                           ucontext, sigaltstack, windows
-  --enable-gcov            enable test coverage analysis with gcov
-  --disable-blobs          disable installing provided firmware blobs
-  --with-vss-sdk=3DSDK-path  enable Windows VSS support in QEMU Guest Agent
-  --with-win-sdk=3DSDK-path  path to Windows Platform SDK (to build VSS .t=
lb)
-  --tls-priority           default TLS protocol/cipher priority string
-  --enable-gprof           QEMU profiling with gprof
-  --enable-profiler        profiler support
-  --enable-debug-stack-usage
-                           track the maximum stack usage of stacks created=
 by qemu_alloc_stack
-  --enable-plugins
-                           enable plugins via shared library loading
-  --disable-containers     don't use containers for cross-building
-  --gdb=3DGDB-path           gdb to use for gdbstub tests [$gdb_bin]
-
-Optional features, enabled with --enable-FEATURE and
-disabled with --disable-FEATURE, default is enabled if available:
-
-  system          all system emulation targets
-  user            supported user emulation targets
-  linux-user      all linux usermode emulation targets
-  bsd-user        all BSD usermode emulation targets
-  docs            build documentation
-  guest-agent     build the QEMU Guest Agent
-  guest-agent-msi build guest agent Windows MSI installation package
-  pie             Position Independent Executables
-  modules         modules support (non-Windows)
-  module-upgrades try to load modules from alternate paths for upgrades
-  debug-tcg       TCG debugging (default is disabled)
-  debug-info      debugging information
-  sparse          sparse checker
-  safe-stack      SafeStack Stack Smash Protection. Depends on
-                  clang/llvm >=3D 3.7 and requires coroutine backend ucont=
ext.
-
-  gnutls          GNUTLS cryptography support
-  nettle          nettle cryptography support
-  gcrypt          libgcrypt cryptography support
-  auth-pam        PAM access control
-  sdl             SDL UI
-  sdl-image       SDL Image support for icons
-  gtk             gtk UI
-  vte             vte support for the gtk UI
-  curses          curses UI
-  iconv           font glyph conversion support
-  vnc             VNC UI support
-  vnc-sasl        SASL encryption for VNC server
-  vnc-jpeg        JPEG lossy compression for VNC server
-  vnc-png         PNG compression for VNC server
-  cocoa           Cocoa UI (Mac OS X only)
-  virtfs          VirtFS
-  mpath           Multipath persistent reservation passthrough
-  xen             xen backend driver support
-  xen-pci-passthrough    PCI passthrough support for Xen
-  brlapi          BrlAPI (Braile)
-  curl            curl connectivity
-  membarrier      membarrier system call (for Linux 4.14+ or Windows)
-  fdt             fdt device tree
-  kvm             KVM acceleration support
-  hax             HAX acceleration support
-  hvf             Hypervisor.framework acceleration support
-  whpx            Windows Hypervisor Platform acceleration support
-  rdma            Enable RDMA-based migration
-  pvrdma          Enable PVRDMA support
-  vde             support for vde network
-  netmap          support for netmap network
-  linux-aio       Linux AIO support
-  linux-io-uring  Linux io_uring support
-  cap-ng          libcap-ng support
-  attr            attr and xattr support
-  vhost-net       vhost-net kernel acceleration support
-  vhost-vsock     virtio sockets device support
-  vhost-scsi      vhost-scsi kernel target support
-  vhost-crypto    vhost-user-crypto backend support
-  vhost-kernel    vhost kernel backend support
-  vhost-user      vhost-user backend support
-  vhost-vdpa      vhost-vdpa kernel backend support
-  spice           spice
-  rbd             rados block device (rbd)
-  libiscsi        iscsi support
-  libnfs          nfs support
-  smartcard       smartcard support (libcacard)
-  u2f             U2F support (u2f-emu)
-  libusb          libusb (for usb passthrough)
-  live-block-migration   Block migration in the main migration stream
-  usb-redir       usb network redirection support
-  lzo             support of lzo compression library
-  snappy          support of snappy compression library
-  bzip2           support of bzip2 compression library
-                  (for reading bzip2-compressed dmg images)
-  lzfse           support of lzfse compression library
-                  (for reading lzfse-compressed dmg images)
-  zstd            support for zstd compression library
-                  (for migration compression and qcow2 cluster compression)
-  seccomp         seccomp support
-  coroutine-pool  coroutine freelist (better performance)
-  glusterfs       GlusterFS backend
-  tpm             TPM support
-  libssh          ssh block device support
-  numa            libnuma support
-  libxml2         for Parallels image format
-  tcmalloc        tcmalloc support
-  jemalloc        jemalloc support
-  avx2            AVX2 optimization support
-  avx512f         AVX512F optimization support
-  replication     replication support
-  opengl          opengl support
-  virglrenderer   virgl rendering support
-  xfsctl          xfsctl support
-  qom-cast-debug  cast debugging support
-  tools           build qemu-io, qemu-nbd and qemu-img tools
-  bochs           bochs image format support
-  cloop           cloop image format support
-  dmg             dmg image format support
-  qcow1           qcow v1 image format support
-  vdi             vdi image format support
-  vvfat           vvfat image format support
-  qed             qed image format support
-  parallels       parallels image format support
-  sheepdog        sheepdog block driver support
-  crypto-afalg    Linux AF_ALG crypto backend driver
-  capstone        capstone disassembler support
-  debug-mutex     mutex debugging support
-  libpmem         libpmem support
-  xkbcommon       xkbcommon support
-  rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()
-  libdaxctl       libdaxctl support
-
-NOTE: The object files are built at the place where configure is launched
-EOF
-exit 0
-fi
-
-# Remove old dependency files to make sure that they get properly regenera=
ted
-rm -f */config-devices.mak.d
-
-if test -z "$python"
-then
-    error_exit "Python not found. Use --python=3D/path/to/python"
-fi
-
-# Note that if the Python conditional here evaluates True we will exit
-# with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
-  error_exit "Cannot use '$python', Python >=3D 3.5 is required." \
-      "Use --python=3D/path/to/python to specify a supported Python."
-fi
-
-# Preserve python version since some functionality is dependent on it
-python_version=3D$($python -c 'import sys; print("%d.%d.%d" % (sys.version=
_info[0], sys.version_info[1], sys.version_info[2]))' 2>/dev/null)
-
-# Suppress writing compiled files
-python=3D"$python -B"
-
-if test -z "$meson"; then
-    if test "$explicit_python" =3D no && has meson && version_ge "$(meson =
--version)" 0.55.1; then
-        meson=3Dmeson
-    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; then
-        meson=3Dgit
-    elif test -e "${source_path}/meson/meson.py" ; then
-        meson=3Dinternal
-    else
-        if test "$explicit_python" =3D yes; then
-            error_exit "--python requires using QEMU's embedded Meson dist=
ribution, but it was not found."
-        else
-            error_exit "Meson not found.  Use --meson=3D/path/to/meson"
-        fi
-    fi
-else
-    # Meson uses its own Python interpreter to invoke other Python scripts,
-    # but the user wants to use the one they specified with --python.
-    #
-    # We do not want to override the distro Python interpreter (and someti=
mes
-    # cannot: for example in Homebrew /usr/bin/meson is a bash script), so
-    # just require --meson=3Dgit|internal together with --python.
-    if test "$explicit_python" =3D yes; then
-        case "$meson" in
-            git | internal) ;;
-            *) error_exit "--python requires using QEMU's embedded Meson d=
istribution." ;;
-        esac
-    fi
-fi
-
-if test "$meson" =3D git; then
-    git_submodules=3D"${git_submodules} meson"
-fi
-
-case "$meson" in
-    git | internal)
-        if ! $python -c 'import pkg_resources' > /dev/null 2>&1; then
-            error_exit "Python setuptools not found"
-        fi
-        meson=3D"$python ${source_path}/meson/meson.py"
-        ;;
-    *) meson=3D$(command -v meson) ;;
-esac
-
-# Probe for ninja (used for compdb)
-
-if test -z "$ninja"; then
-    for c in ninja ninja-build samu; do
-        if has $c; then
-            ninja=3D$(command -v "$c")
-            break
-        fi
-    done
-fi
-
-# Check that the C compiler works. Doing this here before testing
-# the host CPU ensures that we had a valid CC to autodetect the
-# $cpu var (and we should bail right here if that's not the case).
-# It also allows the help message to be printed without a CC.
-write_c_skeleton;
-if compile_object ; then
-  : C compiler works ok
-else
-    error_exit "\"$cc\" either does not exist or does not work"
-fi
-if ! compile_prog ; then
-    error_exit "\"$cc\" cannot build an executable (is your linker broken?=
)"
-fi
-
-# Now we have handled --enable-tcg-interpreter and know we're not just
-# printing the help message, bail out if the host CPU isn't supported.
-if test "$ARCH" =3D "unknown"; then
-    if test "$tcg_interpreter" =3D "yes" ; then
-        echo "Unsupported CPU =3D $cpu, will use TCG with TCI (experimenta=
l)"
-    else
-        error_exit "Unsupported CPU =3D $cpu, try --enable-tcg-interpreter"
-    fi
-fi
-
-# Consult white-list to determine whether to enable werror
-# by default.  Only enable by default for git builds
-if test -z "$werror" ; then
-    if test -e "$source_path/.git" && \
-        { test "$linux" =3D "yes" || test "$mingw32" =3D "yes"; }; then
-        werror=3D"yes"
-    else
-        werror=3D"no"
-    fi
-fi
-
-if test "$bogus_os" =3D "yes"; then
-    # Now that we know that we're not printing the help and that
-    # the compiler works (so the results of the check_defines we used
-    # to identify the OS are reliable), if we didn't recognize the
-    # host OS we should stop now.
-    error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
-fi
-
-# Check whether the compiler matches our minimum requirements:
-cat > $TMPC << EOF
-#if defined(__clang_major__) && defined(__clang_minor__)
-# ifdef __apple_build_version__
-#  if __clang_major__ < 5 || (__clang_major__ =3D=3D 5 && __clang_minor__ =
< 1)
-#   error You need at least XCode Clang v5.1 to compile QEMU
-#  endif
-# else
-#  if __clang_major__ < 3 || (__clang_major__ =3D=3D 3 && __clang_minor__ =
< 4)
-#   error You need at least Clang v3.4 to compile QEMU
-#  endif
-# endif
-#elif defined(__GNUC__) && defined(__GNUC_MINOR__)
-# if __GNUC__ < 4 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ < 8)
-#  error You need at least GCC v4.8 to compile QEMU
-# endif
-#else
-# error You either need GCC or Clang to compiler QEMU
-#endif
-int main (void) { return 0; }
-EOF
-if ! compile_prog "" "" ; then
-    error_exit "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v=
5.1)"
-fi
-
-# Accumulate -Wfoo and -Wno-bar separately.
-# We will list all of the enable flags first, and the disable flags second.
-# Note that we do not add -Werror, because that would enable it for all
-# configure tests. If a configure test failed due to -Werror this would
-# just silently disable some features, so it's too error prone.
-
-warn_flags=3D
-add_to warn_flags -Wold-style-declaration
-add_to warn_flags -Wold-style-definition
-add_to warn_flags -Wtype-limits
-add_to warn_flags -Wformat-security
-add_to warn_flags -Wformat-y2k
-add_to warn_flags -Winit-self
-add_to warn_flags -Wignored-qualifiers
-add_to warn_flags -Wempty-body
-add_to warn_flags -Wnested-externs
-add_to warn_flags -Wendif-labels
-add_to warn_flags -Wexpansion-to-defined
-
-nowarn_flags=3D
-add_to nowarn_flags -Wno-initializer-overrides
-add_to nowarn_flags -Wno-missing-include-dirs
-add_to nowarn_flags -Wno-shift-negative-value
-add_to nowarn_flags -Wno-string-plus-int
-add_to nowarn_flags -Wno-typedef-redefinition
-add_to nowarn_flags -Wno-tautological-type-limit-compare
-add_to nowarn_flags -Wno-psabi
-
-gcc_flags=3D"$warn_flags $nowarn_flags"
-
-cc_has_warning_flag() {
-    write_c_skeleton;
-
-    # Use the positive sense of the flag when testing for -Wno-wombat
-    # support (gcc will happily accept the -Wno- form of unknown
-    # warning options).
-    optflag=3D"$(echo $1 | sed -e 's/^-Wno-/-W/')"
-    compile_prog "-Werror $optflag" ""
-}
-
-for flag in $gcc_flags; do
-    if cc_has_warning_flag $flag ; then
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"
-    fi
-done
-
-if test "$stack_protector" !=3D "no"; then
-  cat > $TMPC << EOF
-int main(int argc, char *argv[])
-{
-    char arr[64], *p =3D arr, *c =3D argv[0];
-    while (*c) {
-        *p++ =3D *c++;
-    }
-    return 0;
-}
-EOF
-  gcc_flags=3D"-fstack-protector-strong -fstack-protector-all"
-  sp_on=3D0
-  for flag in $gcc_flags; do
-    # We need to check both a compile and a link, since some compiler
-    # setups fail only on a .c->.o compile and some only at link time
-    if compile_object "-Werror $flag" &&
-       compile_prog "-Werror $flag" ""; then
-      QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"
-      QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $flag"
-      sp_on=3D1
-      break
-    fi
-  done
-  if test "$stack_protector" =3D yes; then
-    if test $sp_on =3D 0; then
-      error_exit "Stack protector not supported"
-    fi
-  fi
-fi
-
-# Disable -Wmissing-braces on older compilers that warn even for
-# the "universal" C zero initializer {0}.
-cat > $TMPC << EOF
-struct {
-  int a[2];
-} x =3D {0};
-EOF
-if compile_object "-Werror" "" ; then
-  :
-else
-  QEMU_CFLAGS=3D"$QEMU_CFLAGS -Wno-missing-braces"
-fi
-
-# Our module code doesn't support Windows
-if test "$modules" =3D "yes" && test "$mingw32" =3D "yes" ; then
-  error_exit "Modules are not available for Windows"
-fi
-
-# module_upgrades is only reasonable if modules are enabled
-if test "$modules" =3D "no" && test "$module_upgrades" =3D "yes" ; then
-  error_exit "Can't enable module-upgrades as Modules are not enabled"
-fi
-
-# Static linking is not possible with modules or PIE
-if test "$static" =3D "yes" ; then
-  if test "$modules" =3D "yes" ; then
-    error_exit "static and modules are mutually incompatible"
-  fi
-fi
-
-# Unconditional check for compiler __thread support
-  cat > $TMPC << EOF
-static __thread int tls_var;
-int main(void) { return tls_var; }
-EOF
-
-if ! compile_prog "-Werror" "" ; then
-    error_exit "Your compiler does not support the __thread specifier for =
" \
-	"Thread-Local Storage (TLS). Please upgrade to a version that does."
-fi
-
-cat > $TMPC << EOF
-
-#ifdef __linux__
-#  define THREAD __thread
-#else
-#  define THREAD
-#endif
-static THREAD int tls_var;
-int main(void) { return tls_var; }
-EOF
-
-# Check we support --no-pie first; we will need this for building ROMs.
-if compile_prog "-Werror -fno-pie" "-no-pie"; then
-  CFLAGS_NOPIE=3D"-fno-pie"
-  LDFLAGS_NOPIE=3D"-no-pie"
-fi
-
-if test "$static" =3D "yes"; then
-  if test "$pie" !=3D "no" && compile_prog "-Werror -fPIE -DPIE" "-static-=
pie"; then
-    CFLAGS=3D"-fPIE -DPIE $CFLAGS"
-    QEMU_LDFLAGS=3D"-static-pie $QEMU_LDFLAGS"
-    pie=3D"yes"
-  elif test "$pie" =3D "yes"; then
-    error_exit "-static-pie not available due to missing toolchain support"
-  else
-    QEMU_LDFLAGS=3D"-static $QEMU_LDFLAGS"
-    pie=3D"no"
-  fi
-elif test "$pie" =3D "no"; then
-  CFLAGS=3D"$CFLAGS_NOPIE $CFLAGS"
-  LDFLAGS=3D"$LDFLAGS_NOPIE $LDFLAGS"
-elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-  CFLAGS=3D"-fPIE -DPIE $CFLAGS"
-  LDFLAGS=3D"-pie $LDFLAGS"
-  pie=3D"yes"
-elif test "$pie" =3D "yes"; then
-  error_exit "PIE not available due to missing toolchain support"
-else
-  echo "Disabling PIE due to missing toolchain support"
-  pie=3D"no"
-fi
-
-# Detect support for PT_GNU_RELRO + DT_BIND_NOW.
-# The combination is known as "full relro", because .got.plt is read-only =
too.
-if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
-  QEMU_LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $QEMU_LDFLAGS"
-fi
-
-##########################################
-# __sync_fetch_and_and requires at least -march=3Di486. Many toolchains
-# use i686 as default anyway, but for those that don't, an explicit
-# specification is necessary
-
-if test "$cpu" =3D "i386"; then
-  cat > $TMPC << EOF
-static int sfaa(int *ptr)
-{
-  return __sync_fetch_and_and(ptr, 0);
-}
-
-int main(void)
-{
-  int val =3D 42;
-  val =3D __sync_val_compare_and_swap(&val, 0, 1);
-  sfaa(&val);
-  return val;
-}
-EOF
-  if ! compile_prog "" "" ; then
-    QEMU_CFLAGS=3D"-march=3Di486 $QEMU_CFLAGS"
-  fi
-fi
-
-#########################################
-# Solaris specific configure tool chain decisions
-
-if test "$solaris" =3D "yes" ; then
-  if has $install; then
-    :
-  else
-    error_exit "Solaris install program not found. Use --install=3D/usr/uc=
b/install or" \
-        "install fileutils from www.blastwave.org using pkg-get -i fileuti=
ls" \
-        "to get ginstall which is used by default (which lives in /opt/csw=
/bin)"
-  fi
-  if test "$(path_of $install)" =3D "/usr/sbin/install" ; then
-    error_exit "Solaris /usr/sbin/install is not an appropriate install pr=
ogram." \
-        "try ginstall from the GNU fileutils available from www.blastwave.=
org" \
-        "using pkg-get -i fileutils, or use --install=3D/usr/ucb/install"
-  fi
-  if has ar; then
-    :
-  else
-    if test -f /usr/ccs/bin/ar ; then
-      error_exit "No path includes ar" \
-          "Add /usr/ccs/bin to your path and rerun configure"
-    fi
-    error_exit "No path includes ar"
-  fi
-fi
-
-if test -z "${target_list+xxx}" ; then
-    for target in $default_target_list; do
-        supported_target $target 2>/dev/null && \
-            target_list=3D"$target_list $target"
-    done
-    target_list=3D"${target_list# }"
-else
-    target_list=3D$(echo "$target_list" | sed -e 's/,/ /g')
-    for target in $target_list; do
-        # Check that we recognised the target name; this allows a more
-        # friendly error message than if we let it fall through.
-        case " $default_target_list " in
-            *" $target "*)
-                ;;
-            *)
-                error_exit "Unknown target name '$target'"
-                ;;
-        esac
-        supported_target $target || exit 1
-    done
-fi
-
-# see if system emulation was really requested
-case " $target_list " in
-  *"-softmmu "*) softmmu=3Dyes
-  ;;
-  *) softmmu=3Dno
-  ;;
-esac
-
-for target in $target_list; do
-  case "$target" in
-    arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
-      edk2_blobs=3D"yes"
-      ;;
-  esac
-done
-# The EDK2 binaries are compressed with bzip2
-if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
-  error_exit "The bzip2 program is required for building QEMU"
-fi
-
-feature_not_found() {
-  feature=3D$1
-  remedy=3D$2
-
-  error_exit "User requested feature $feature" \
-      "configure was not able to find it." \
-      "$remedy"
-}
-
-# ---
-# big/little endian test
-cat > $TMPC << EOF
-short big_endian[] =3D { 0x4269, 0x4765, 0x4e64, 0x4961, 0x4e00, 0, };
-short little_endian[] =3D { 0x694c, 0x7454, 0x654c, 0x6e45, 0x6944, 0x6e41=
, 0, };
-extern int foo(short *, short *);
-int main(int argc, char *argv[]) {
-    return foo(big_endian, little_endian);
-}
-EOF
-
-if compile_object ; then
-    if strings -a $TMPO | grep -q BiGeNdIaN ; then
-        bigendian=3D"yes"
-    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then
-        bigendian=3D"no"
-    else
-        echo big/little test failed
-    fi
-else
-    echo big/little test failed
-fi
-
-##########################################
-# system tools
-if test -z "$want_tools"; then
-    if test "$softmmu" =3D "no"; then
-        want_tools=3Dno
-    else
-        want_tools=3Dyes
-    fi
-fi
-
-##########################################
-# cocoa implies not SDL or GTK
-# (the cocoa UI code currently assumes it is always the active UI
-# and doesn't interact well with other UI frontend code)
-if test "$cocoa" =3D "yes"; then
-    if test "$sdl" =3D "yes"; then
-        error_exit "Cocoa and SDL UIs cannot both be enabled at once"
-    fi
-    if test "$gtk" =3D "yes"; then
-        error_exit "Cocoa and GTK UIs cannot both be enabled at once"
-    fi
-    gtk=3Dno
-    sdl=3Ddisabled
-fi
-
-# Some versions of Mac OS X incorrectly define SIZE_MAX
-cat > $TMPC << EOF
-#include <stdint.h>
-#include <stdio.h>
-int main(int argc, char *argv[]) {
-    return printf("%zu", SIZE_MAX);
-}
-EOF
-have_broken_size_max=3Dno
-if ! compile_object -Werror ; then
-    have_broken_size_max=3Dyes
-fi
-
-##########################################
-# L2TPV3 probe
-
-cat > $TMPC <<EOF
-#include <sys/socket.h>
-#include <linux/ip.h>
-int main(void) { return sizeof(struct mmsghdr); }
-EOF
-if compile_prog "" "" ; then
-  l2tpv3=3Dyes
-else
-  l2tpv3=3Dno
-fi
-
-if check_include "pty.h" ; then
-  pty_h=3Dyes
-else
-  pty_h=3Dno
-fi
-
-cat > $TMPC <<EOF
-#include <sys/mman.h>
-int main(int argc, char *argv[]) {
-    return mlockall(MCL_FUTURE);
-}
-EOF
-if compile_prog "" "" ; then
-  have_mlockall=3Dyes
-else
-  have_mlockall=3Dno
-fi
-
-#########################################
-# vhost interdependencies and host support
-
-# vhost backends
-test "$vhost_user" =3D "" && vhost_user=3Dyes
-if test "$vhost_user" =3D "yes" && test "$mingw32" =3D "yes"; then
-  error_exit "vhost-user isn't available on win32"
-fi
-test "$vhost_vdpa" =3D "" && vhost_vdpa=3D$linux
-if test "$vhost_vdpa" =3D "yes" && test "$linux" !=3D "yes"; then
-  error_exit "vhost-vdpa is only available on Linux"
-fi
-test "$vhost_kernel" =3D "" && vhost_kernel=3D$linux
-if test "$vhost_kernel" =3D "yes" && test "$linux" !=3D "yes"; then
-  error_exit "vhost-kernel is only available on Linux"
-fi
-
-# vhost-kernel devices
-test "$vhost_scsi" =3D "" && vhost_scsi=3D$vhost_kernel
-if test "$vhost_scsi" =3D "yes" && test "$vhost_kernel" !=3D "yes"; then
-  error_exit "--enable-vhost-scsi requires --enable-vhost-kernel"
-fi
-test "$vhost_vsock" =3D "" && vhost_vsock=3D$vhost_kernel
-if test "$vhost_vsock" =3D "yes" && test "$vhost_kernel" !=3D "yes"; then
-  error_exit "--enable-vhost-vsock requires --enable-vhost-kernel"
-fi
-
-# vhost-user backends
-test "$vhost_net_user" =3D "" && vhost_net_user=3D$vhost_user
-if test "$vhost_net_user" =3D "yes" && test "$vhost_user" =3D "no"; then
-  error_exit "--enable-vhost-net-user requires --enable-vhost-user"
-fi
-test "$vhost_crypto" =3D "" && vhost_crypto=3D$vhost_user
-if test "$vhost_crypto" =3D "yes" && test "$vhost_user" =3D "no"; then
-  error_exit "--enable-vhost-crypto requires --enable-vhost-user"
-fi
-test "$vhost_user_fs" =3D "" && vhost_user_fs=3D$vhost_user
-if test "$vhost_user_fs" =3D "yes" && test "$vhost_user" =3D "no"; then
-  error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
-fi
-#vhost-vdpa backends
-test "$vhost_net_vdpa" =3D "" && vhost_net_vdpa=3D$vhost_vdpa
-if test "$vhost_net_vdpa" =3D "yes" && test "$vhost_vdpa" =3D "no"; then
-  error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
-fi
-
-# OR the vhost-kernel and vhost-user values for simplicity
-if test "$vhost_net" =3D ""; then
-  test "$vhost_net_user" =3D "yes" && vhost_net=3Dyes
-  test "$vhost_kernel" =3D "yes" && vhost_net=3Dyes
-fi
-
-##########################################
-# MinGW / Mingw-w64 localtime_r/gmtime_r check
-
-if test "$mingw32" =3D "yes"; then
-    # Some versions of MinGW / Mingw-w64 lack localtime_r
-    # and gmtime_r entirely.
-    #
-    # Some versions of Mingw-w64 define a macro for
-    # localtime_r/gmtime_r.
-    #
-    # Some versions of Mingw-w64 will define functions
-    # for localtime_r/gmtime_r, but only if you have
-    # _POSIX_THREAD_SAFE_FUNCTIONS defined. For fun
-    # though, unistd.h and pthread.h both define
-    # that for you.
-    #
-    # So this #undef localtime_r and #include <unistd.h>
-    # are not in fact redundant.
-cat > $TMPC << EOF
-#include <unistd.h>
-#include <time.h>
-#undef localtime_r
-int main(void) { localtime_r(NULL, NULL); return 0; }
-EOF
-    if compile_prog "" "" ; then
-        localtime_r=3D"yes"
-    else
-        localtime_r=3D"no"
-    fi
-fi
-
-##########################################
-# pkg-config probe
-
-if ! has "$pkg_config_exe"; then
-  error_exit "pkg-config binary '$pkg_config_exe' not found"
-fi
-
-##########################################
-# NPTL probe
-
-if test "$linux_user" =3D "yes"; then
-  cat > $TMPC <<EOF
-#include <sched.h>
-#include <linux/futex.h>
-int main(void) {
-#if !defined(CLONE_SETTLS) || !defined(FUTEX_WAIT)
-#error bork
-#endif
-  return 0;
-}
-EOF
-  if ! compile_object ; then
-    feature_not_found "nptl" "Install glibc and linux kernel headers."
-  fi
-fi
-
-##########################################
-# lzo check
-
-if test "$lzo" !=3D "no" ; then
-    cat > $TMPC << EOF
-#include <lzo/lzo1x.h>
-int main(void) { lzo_version(); return 0; }
-EOF
-    if compile_prog "" "-llzo2" ; then
-        lzo_libs=3D"-llzo2"
-        lzo=3D"yes"
-    else
-        if test "$lzo" =3D "yes"; then
-            feature_not_found "liblzo2" "Install liblzo2 devel"
-        fi
-        lzo=3D"no"
-    fi
-fi
-
-##########################################
-# snappy check
-
-if test "$snappy" !=3D "no" ; then
-    cat > $TMPC << EOF
-#include <snappy-c.h>
-int main(void) { snappy_max_compressed_length(4096); return 0; }
-EOF
-    if compile_prog "" "-lsnappy" ; then
-        snappy_libs=3D'-lsnappy'
-        snappy=3D"yes"
-    else
-        if test "$snappy" =3D "yes"; then
-            feature_not_found "libsnappy" "Install libsnappy devel"
-        fi
-        snappy=3D"no"
-    fi
-fi
-
-##########################################
-# bzip2 check
-
-if test "$bzip2" !=3D "no" ; then
-    cat > $TMPC << EOF
-#include <bzlib.h>
-int main(void) { BZ2_bzlibVersion(); return 0; }
-EOF
-    if compile_prog "" "-lbz2" ; then
-        bzip2=3D"yes"
-    else
-        if test "$bzip2" =3D "yes"; then
-            feature_not_found "libbzip2" "Install libbzip2 devel"
-        fi
-        bzip2=3D"no"
-    fi
-fi
-
-##########################################
-# lzfse check
-
-if test "$lzfse" !=3D "no" ; then
-    cat > $TMPC << EOF
-#include <lzfse.h>
-int main(void) { lzfse_decode_scratch_size(); return 0; }
-EOF
-    if compile_prog "" "-llzfse" ; then
-        lzfse=3D"yes"
-    else
-        if test "$lzfse" =3D "yes"; then
-            feature_not_found "lzfse" "Install lzfse devel"
-        fi
-        lzfse=3D"no"
-    fi
-fi
-
-##########################################
-# zstd check
-
-if test "$zstd" !=3D "no" ; then
-    libzstd_minver=3D"1.4.0"
-    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
-        zstd_cflags=3D"$($pkg_config --cflags libzstd)"
-        zstd_libs=3D"$($pkg_config --libs libzstd)"
-        zstd=3D"yes"
-    else
-        if test "$zstd" =3D "yes" ; then
-            feature_not_found "libzstd" "Install libzstd devel"
-        fi
-        zstd=3D"no"
-    fi
-fi
-
-##########################################
-# libseccomp check
-
-if test "$seccomp" !=3D "no" ; then
-    libseccomp_minver=3D"2.3.0"
-    if $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; then
-        seccomp_cflags=3D"$($pkg_config --cflags libseccomp)"
-        seccomp_libs=3D"$($pkg_config --libs libseccomp)"
-        seccomp=3D"yes"
-    else
-        if test "$seccomp" =3D "yes" ; then
-            feature_not_found "libseccomp" \
-                 "Install libseccomp devel >=3D $libseccomp_minver"
-        fi
-        seccomp=3D"no"
-    fi
-fi
-##########################################
-# xen probe
-
-if test "$xen" !=3D "no" ; then
-  # Check whether Xen library path is specified via --extra-ldflags to avo=
id
-  # overriding this setting with pkg-config output. If not, try pkg-config
-  # to obtain all needed flags.
-
-  if ! echo $EXTRA_LDFLAGS | grep tools/libxc > /dev/null && \
-     $pkg_config --exists xencontrol ; then
-    xen_ctrl_version=3D"$(printf '%d%02d%02d' \
-      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
-    xen=3Dyes
-    xen_pc=3D"xencontrol xenstore xenguest xenforeignmemory xengnttab"
-    xen_pc=3D"$xen_pc xenevtchn xendevicemodel"
-    if $pkg_config --exists xentoolcore; then
-      xen_pc=3D"$xen_pc xentoolcore"
-    fi
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
-    xen_cflags=3D"$($pkg_config --cflags $xen_pc)"
-    xen_libs=3D"$($pkg_config --libs $xen_pc)"
-  else
-
-    xen_libs=3D"-lxenstore -lxenctrl -lxenguest"
-    xen_stable_libs=3D"-lxenforeignmemory -lxengnttab -lxenevtchn"
-
-    # First we test whether Xen headers and libraries are available.
-    # If no, we are done and there is no Xen support.
-    # If yes, more tests are run to detect the Xen version.
-
-    # Xen (any)
-    cat > $TMPC <<EOF
-#include <xenctrl.h>
-int main(void) {
-  return 0;
-}
-EOF
-    if ! compile_prog "" "$xen_libs" ; then
-      # Xen not found
-      if test "$xen" =3D "yes" ; then
-        feature_not_found "xen" "Install xen devel"
-      fi
-      xen=3Dno
-
-    # Xen unstable
-    elif
-        cat > $TMPC <<EOF &&
-#undef XC_WANT_COMPAT_DEVICEMODEL_API
-#define __XEN_TOOLS__
-#include <xendevicemodel.h>
-#include <xenforeignmemory.h>
-int main(void) {
-  xendevicemodel_handle *xd;
-  xenforeignmemory_handle *xfmem;
-
-  xd =3D xendevicemodel_open(0, 0);
-  xendevicemodel_pin_memory_cacheattr(xd, 0, 0, 0, 0);
-
-  xfmem =3D xenforeignmemory_open(0, 0);
-  xenforeignmemory_map_resource(xfmem, 0, 0, 0, 0, 0, NULL, 0, 0);
-
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxen=
toolcore"
-      then
-      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs -lxentoolcore"
-      xen_ctrl_version=3D41100
-      xen=3Dyes
-    elif
-        cat > $TMPC <<EOF &&
-#undef XC_WANT_COMPAT_MAP_FOREIGN_API
-#include <xenforeignmemory.h>
-#include <xentoolcore.h>
-int main(void) {
-  xenforeignmemory_handle *xfmem;
-
-  xfmem =3D xenforeignmemory_open(0, 0);
-  xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
-  xentoolcore_restrict_all(0);
-
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxen=
toolcore"
-      then
-      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs -lxentoolcore"
-      xen_ctrl_version=3D41000
-      xen=3Dyes
-    elif
-        cat > $TMPC <<EOF &&
-#undef XC_WANT_COMPAT_DEVICEMODEL_API
-#define __XEN_TOOLS__
-#include <xendevicemodel.h>
-int main(void) {
-  xendevicemodel_handle *xd;
-
-  xd =3D xendevicemodel_open(0, 0);
-  xendevicemodel_close(xd);
-
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
-      then
-      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs"
-      xen_ctrl_version=3D40900
-      xen=3Dyes
-    elif
-        cat > $TMPC <<EOF &&
-/*
- * If we have stable libs the we don't want the libxc compat
- * layers, regardless of what CFLAGS we may have been given.
- *
- * Also, check if xengnttab_grant_copy_segment_t is defined and
- * grant copy operation is implemented.
- */
-#undef XC_WANT_COMPAT_EVTCHN_API
-#undef XC_WANT_COMPAT_GNTTAB_API
-#undef XC_WANT_COMPAT_MAP_FOREIGN_API
-#include <xenctrl.h>
-#include <xenstore.h>
-#include <xenevtchn.h>
-#include <xengnttab.h>
-#include <xenforeignmemory.h>
-#include <stdint.h>
-#include <xen/hvm/hvm_info_table.h>
-#if !defined(HVM_MAX_VCPUS)
-# error HVM_MAX_VCPUS not defined
-#endif
-int main(void) {
-  xc_interface *xc =3D NULL;
-  xenforeignmemory_handle *xfmem;
-  xenevtchn_handle *xe;
-  xengnttab_handle *xg;
-  xengnttab_grant_copy_segment_t* seg =3D NULL;
-
-  xs_daemon_open();
-
-  xc =3D xc_interface_open(0, 0, 0);
-  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-
-  xfmem =3D xenforeignmemory_open(0, 0);
-  xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
-
-  xe =3D xenevtchn_open(0, 0);
-  xenevtchn_fd(xe);
-
-  xg =3D xengnttab_open(0, 0);
-  xengnttab_grant_copy(xg, 0, seg);
-
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs $xen_stable_libs"
-      then
-      xen_ctrl_version=3D40800
-      xen=3Dyes
-    elif
-        cat > $TMPC <<EOF &&
-/*
- * If we have stable libs the we don't want the libxc compat
- * layers, regardless of what CFLAGS we may have been given.
- */
-#undef XC_WANT_COMPAT_EVTCHN_API
-#undef XC_WANT_COMPAT_GNTTAB_API
-#undef XC_WANT_COMPAT_MAP_FOREIGN_API
-#include <xenctrl.h>
-#include <xenstore.h>
-#include <xenevtchn.h>
-#include <xengnttab.h>
-#include <xenforeignmemory.h>
-#include <stdint.h>
-#include <xen/hvm/hvm_info_table.h>
-#if !defined(HVM_MAX_VCPUS)
-# error HVM_MAX_VCPUS not defined
-#endif
-int main(void) {
-  xc_interface *xc =3D NULL;
-  xenforeignmemory_handle *xfmem;
-  xenevtchn_handle *xe;
-  xengnttab_handle *xg;
-
-  xs_daemon_open();
-
-  xc =3D xc_interface_open(0, 0, 0);
-  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-
-  xfmem =3D xenforeignmemory_open(0, 0);
-  xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
-
-  xe =3D xenevtchn_open(0, 0);
-  xenevtchn_fd(xe);
-
-  xg =3D xengnttab_open(0, 0);
-  xengnttab_map_grant_ref(xg, 0, 0, 0);
-
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs $xen_stable_libs"
-      then
-      xen_ctrl_version=3D40701
-      xen=3Dyes
-
-    # Xen 4.6
-    elif
-        cat > $TMPC <<EOF &&
-#include <xenctrl.h>
-#include <xenstore.h>
-#include <stdint.h>
-#include <xen/hvm/hvm_info_table.h>
-#if !defined(HVM_MAX_VCPUS)
-# error HVM_MAX_VCPUS not defined
-#endif
-int main(void) {
-  xc_interface *xc;
-  xs_daemon_open();
-  xc =3D xc_interface_open(0, 0, 0);
-  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-  xc_gnttab_open(NULL, 0);
-  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-  xc_reserved_device_memory_map(xc, 0, 0, 0, 0, NULL, 0);
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs"
-      then
-      xen_ctrl_version=3D40600
-      xen=3Dyes
-
-    # Xen 4.5
-    elif
-        cat > $TMPC <<EOF &&
-#include <xenctrl.h>
-#include <xenstore.h>
-#include <stdint.h>
-#include <xen/hvm/hvm_info_table.h>
-#if !defined(HVM_MAX_VCPUS)
-# error HVM_MAX_VCPUS not defined
-#endif
-int main(void) {
-  xc_interface *xc;
-  xs_daemon_open();
-  xc =3D xc_interface_open(0, 0, 0);
-  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-  xc_gnttab_open(NULL, 0);
-  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-  xc_hvm_create_ioreq_server(xc, 0, 0, NULL);
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs"
-      then
-      xen_ctrl_version=3D40500
-      xen=3Dyes
-
-    elif
-        cat > $TMPC <<EOF &&
-#include <xenctrl.h>
-#include <xenstore.h>
-#include <stdint.h>
-#include <xen/hvm/hvm_info_table.h>
-#if !defined(HVM_MAX_VCPUS)
-# error HVM_MAX_VCPUS not defined
-#endif
-int main(void) {
-  xc_interface *xc;
-  xs_daemon_open();
-  xc =3D xc_interface_open(0, 0, 0);
-  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-  xc_gnttab_open(NULL, 0);
-  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-  return 0;
-}
-EOF
-        compile_prog "" "$xen_libs"
-      then
-      xen_ctrl_version=3D40200
-      xen=3Dyes
-
-    else
-      if test "$xen" =3D "yes" ; then
-        feature_not_found "xen (unsupported version)" \
-                          "Install a supported xen (xen 4.2 or newer)"
-      fi
-      xen=3Dno
-    fi
-
-    if test "$xen" =3D yes; then
-      if test $xen_ctrl_version -ge 40701  ; then
-        xen_libs=3D"$xen_libs $xen_stable_libs "
-      fi
-    fi
-  fi
-fi
-
-if test "$xen_pci_passthrough" !=3D "no"; then
-  if test "$xen" =3D "yes" && test "$linux" =3D "yes"; then
-    xen_pci_passthrough=3Dyes
-  else
-    if test "$xen_pci_passthrough" =3D "yes"; then
-      error_exit "User requested feature Xen PCI Passthrough" \
-          " but this feature requires /sys from Linux"
-    fi
-    xen_pci_passthrough=3Dno
-  fi
-fi
-
-##########################################
-# Windows Hypervisor Platform accelerator (WHPX) check
-if test "$whpx" !=3D "no" ; then
-    if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"=
; then
-        whpx=3D"yes"
-    else
-        if test "$whpx" =3D "yes"; then
-            feature_not_found "WinHvPlatform" "WinHvEmulation is not insta=
lled"
-        fi
-        whpx=3D"no"
-    fi
-fi
-
-##########################################
-# gettext probe
-if test "$gettext" !=3D "false" ; then
-  if has xgettext; then
-    gettext=3Dtrue
-  else
-    if test "$gettext" =3D "true" ; then
-      feature_not_found "gettext" "Install xgettext binary"
-    fi
-    gettext=3Dfalse
-  fi
-fi
-
-##########################################
-# Sparse probe
-if test "$sparse" !=3D "no" ; then
-  if has sparse; then
-    sparse=3Dyes
-  else
-    if test "$sparse" =3D "yes" ; then
-      feature_not_found "sparse" "Install sparse binary"
-    fi
-    sparse=3Dno
-  fi
-fi
-
-##########################################
-# X11 probe
-if $pkg_config --exists "x11"; then
-    have_x11=3Dyes
-    x11_cflags=3D$($pkg_config --cflags x11)
-    x11_libs=3D$($pkg_config --libs x11)
-fi
-
-##########################################
-# GTK probe
-
-if test "$gtk" !=3D "no"; then
-    gtkpackage=3D"gtk+-3.0"
-    gtkx11package=3D"gtk+-x11-3.0"
-    gtkversion=3D"3.22.0"
-    if $pkg_config --exists "$gtkpackage >=3D $gtkversion"; then
-        gtk_cflags=3D$($pkg_config --cflags $gtkpackage)
-        gtk_libs=3D$($pkg_config --libs $gtkpackage)
-        gtk_version=3D$($pkg_config --modversion $gtkpackage)
-        if $pkg_config --exists "$gtkx11package >=3D $gtkversion"; then
-            need_x11=3Dyes
-            gtk_cflags=3D"$gtk_cflags $x11_cflags"
-            gtk_libs=3D"$gtk_libs $x11_libs"
-        fi
-        gtk=3D"yes"
-    elif test "$gtk" =3D "yes"; then
-        feature_not_found "gtk" "Install gtk3-devel"
-    else
-        gtk=3D"no"
-    fi
-fi
-
-
-##########################################
-# GNUTLS probe
-
-if test "$gnutls" !=3D "no"; then
-    pass=3D"no"
-    if $pkg_config --exists "gnutls >=3D 3.1.18"; then
-        gnutls_cflags=3D$($pkg_config --cflags gnutls)
-        gnutls_libs=3D$($pkg_config --libs gnutls)
-        # Packaging for the static libraries is not always correct.
-        # At least ubuntu 18.04 ships only shared libraries.
-        write_c_skeleton
-        if compile_prog "" "$gnutls_libs" ; then
-            LIBS=3D"$gnutls_libs $LIBS"
-            QEMU_CFLAGS=3D"$QEMU_CFLAGS $gnutls_cflags"
-            pass=3D"yes"
-        fi
-    fi
-    if test "$pass" =3D "no" && test "$gnutls" =3D "yes"; then
-	feature_not_found "gnutls" "Install gnutls devel >=3D 3.1.18"
-    else
-        gnutls=3D"$pass"
-    fi
-fi
-
-
-# If user didn't give a --disable/enable-gcrypt flag,
-# then mark as disabled if user requested nettle
-# explicitly
-if test -z "$gcrypt"
-then
-    if test "$nettle" =3D "yes"
-    then
-        gcrypt=3D"no"
-    fi
-fi
-
-# If user didn't give a --disable/enable-nettle flag,
-# then mark as disabled if user requested gcrypt
-# explicitly
-if test -z "$nettle"
-then
-    if test "$gcrypt" =3D "yes"
-    then
-        nettle=3D"no"
-    fi
-fi
-
-has_libgcrypt() {
-    if ! has "libgcrypt-config"
-    then
-	return 1
-    fi
-
-    if test -n "$cross_prefix"
-    then
-	host=3D$(libgcrypt-config --host)
-	if test "$host-" !=3D $cross_prefix
-	then
-	    return 1
-	fi
-    fi
-
-    maj=3D`libgcrypt-config --version | awk -F . '{print $1}'`
-    min=3D`libgcrypt-config --version | awk -F . '{print $2}'`
-
-    if test $maj !=3D 1 || test $min -lt 5
-    then
-       return 1
-    fi
-
-    return 0
-}
-
-
-if test "$nettle" !=3D "no"; then
-    pass=3D"no"
-    if $pkg_config --exists "nettle >=3D 2.7.1"; then
-        nettle_cflags=3D$($pkg_config --cflags nettle)
-        nettle_libs=3D$($pkg_config --libs nettle)
-        nettle_version=3D$($pkg_config --modversion nettle)
-        # Link test to make sure the given libraries work (e.g for static).
-        write_c_skeleton
-        if compile_prog "" "$nettle_libs" ; then
-            LIBS=3D"$nettle_libs $LIBS"
-            QEMU_CFLAGS=3D"$QEMU_CFLAGS $nettle_cflags"
-            if test -z "$gcrypt"; then
-               gcrypt=3D"no"
-            fi
-            pass=3D"yes"
-        fi
-    fi
-    if test "$pass" =3D "yes"
-    then
-        cat > $TMPC << EOF
-#include <nettle/xts.h>
-int main(void) {
-  return 0;
-}
-EOF
-        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
-            nettle_xts=3Dyes
-            qemu_private_xts=3Dno
-        fi
-    fi
-    if test "$pass" =3D "no" && test "$nettle" =3D "yes"; then
-        feature_not_found "nettle" "Install nettle devel >=3D 2.7.1"
-    else
-        nettle=3D"$pass"
-    fi
-fi
-
-if test "$gcrypt" !=3D "no"; then
-    pass=3D"no"
-    if has_libgcrypt; then
-        gcrypt_cflags=3D$(libgcrypt-config --cflags)
-        gcrypt_libs=3D$(libgcrypt-config --libs)
-        # Debian has removed -lgpg-error from libgcrypt-config
-        # as it "spreads unnecessary dependencies" which in
-        # turn breaks static builds...
-        if test "$static" =3D "yes"
-        then
-            gcrypt_libs=3D"$gcrypt_libs -lgpg-error"
-        fi
-
-        # Link test to make sure the given libraries work (e.g for static).
-        write_c_skeleton
-        if compile_prog "" "$gcrypt_libs" ; then
-            LIBS=3D"$gcrypt_libs $LIBS"
-            QEMU_CFLAGS=3D"$QEMU_CFLAGS $gcrypt_cflags"
-            pass=3D"yes"
-        fi
-    fi
-    if test "$pass" =3D "yes"; then
-        gcrypt=3D"yes"
-        cat > $TMPC << EOF
-#include <gcrypt.h>
-int main(void) {
-  gcry_mac_hd_t handle;
-  gcry_mac_open(&handle, GCRY_MAC_HMAC_MD5,
-                GCRY_MAC_FLAG_SECURE, NULL);
-  return 0;
-}
-EOF
-        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
-            gcrypt_hmac=3Dyes
-        fi
-        cat > $TMPC << EOF
-#include <gcrypt.h>
-int main(void) {
-  gcry_cipher_hd_t handle;
-  gcry_cipher_open(&handle, GCRY_CIPHER_AES, GCRY_CIPHER_MODE_XTS, 0);
-  return 0;
-}
-EOF
-        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then
-            gcrypt_xts=3Dyes
-            qemu_private_xts=3Dno
-        fi
-    elif test "$gcrypt" =3D "yes"; then
-        feature_not_found "gcrypt" "Install gcrypt devel >=3D 1.5.0"
-    else
-        gcrypt=3D"no"
-    fi
-fi
-
-
-if test "$gcrypt" =3D "yes" && test "$nettle" =3D "yes"
-then
-    error_exit "Only one of gcrypt & nettle can be enabled"
-fi
-
-##########################################
-# libtasn1 - only for the TLS creds/session test suite
-
-tasn1=3Dyes
-tasn1_cflags=3D""
-tasn1_libs=3D""
-if $pkg_config --exists "libtasn1"; then
-    tasn1_cflags=3D$($pkg_config --cflags libtasn1)
-    tasn1_libs=3D$($pkg_config --libs libtasn1)
-else
-    tasn1=3Dno
-fi
-
-
-##########################################
-# PAM probe
-
-if test "$auth_pam" !=3D "no"; then
-    cat > $TMPC <<EOF
-#include <security/pam_appl.h>
-#include <stdio.h>
-int main(void) {
-   const char *service_name =3D "qemu";
-   const char *user =3D "frank";
-   const struct pam_conv pam_conv =3D { 0 };
-   pam_handle_t *pamh =3D NULL;
-   pam_start(service_name, user, &pam_conv, &pamh);
-   return 0;
-}
-EOF
-    if compile_prog "" "-lpam" ; then
-        auth_pam=3Dyes
-    else
-        if test "$auth_pam" =3D "yes"; then
-            feature_not_found "PAM" "Install PAM development package"
-        else
-            auth_pam=3Dno
-        fi
-    fi
-fi
-
-##########################################
-# getifaddrs (for tests/test-io-channel-socket )
-
-have_ifaddrs_h=3Dyes
-if ! check_include "ifaddrs.h" ; then
-  have_ifaddrs_h=3Dno
-fi
-
-#########################################
-# libdrm check
-have_drm_h=3Dno
-if check_include "libdrm/drm.h" ; then
-    have_drm_h=3Dyes
-fi
-
-#########################################
-# sys/signal.h check
-have_sys_signal_h=3Dno
-if check_include "sys/signal.h" ; then
-  have_sys_signal_h=3Dyes
-fi
-
-##########################################
-# VTE probe
-
-if test "$vte" !=3D "no"; then
-    vteminversion=3D"0.32.0"
-    if $pkg_config --exists "vte-2.91"; then
-      vtepackage=3D"vte-2.91"
-    else
-      vtepackage=3D"vte-2.90"
-    fi
-    if $pkg_config --exists "$vtepackage >=3D $vteminversion"; then
-        vte_cflags=3D$($pkg_config --cflags $vtepackage)
-        vte_libs=3D$($pkg_config --libs $vtepackage)
-        vteversion=3D$($pkg_config --modversion $vtepackage)
-        vte=3D"yes"
-    elif test "$vte" =3D "yes"; then
-        feature_not_found "vte" "Install libvte-2.90/2.91 devel"
-    else
-        vte=3D"no"
-    fi
-fi
-
-##########################################
-# RDMA needs OpenFabrics libraries
-if test "$rdma" !=3D "no" ; then
-  cat > $TMPC <<EOF
-#include <rdma/rdma_cma.h>
-int main(void) { return 0; }
-EOF
-  rdma_libs=3D"-lrdmacm -libverbs -libumad"
-  if compile_prog "" "$rdma_libs" ; then
-    rdma=3D"yes"
-  else
-    if test "$rdma" =3D "yes" ; then
-        error_exit \
-            " OpenFabrics librdmacm/libibverbs/libibumad not present." \
-            " Your options:" \
-            "  (1) Fast: Install infiniband packages (devel) from your dis=
tro." \
-            "  (2) Cleanest: Install libraries from www.openfabrics.org" \
-            "  (3) Also: Install softiwarp if you don't have RDMA hardware"
-    fi
-    rdma=3D"no"
-  fi
-fi
-
-##########################################
-# PVRDMA detection
-
-cat > $TMPC <<EOF &&
-#include <sys/mman.h>
-
-int
-main(void)
-{
-    char buf =3D 0;
-    void *addr =3D &buf;
-    addr =3D mremap(addr, 0, 1, MREMAP_MAYMOVE | MREMAP_FIXED);
-
-    return 0;
-}
-EOF
-
-if test "$rdma" =3D "yes" ; then
-    case "$pvrdma" in
-    "")
-        if compile_prog "" ""; then
-            pvrdma=3D"yes"
-        else
-            pvrdma=3D"no"
-        fi
-        ;;
-    "yes")
-        if ! compile_prog "" ""; then
-            error_exit "PVRDMA is not supported since mremap is not implem=
ented"
-        fi
-        pvrdma=3D"yes"
-        ;;
-    "no")
-        pvrdma=3D"no"
-        ;;
-    esac
-else
-    if test "$pvrdma" =3D "yes" ; then
-        error_exit "PVRDMA requires rdma suppport"
-    fi
-    pvrdma=3D"no"
-fi
-
-# Let's see if enhanced reg_mr is supported
-if test "$pvrdma" =3D "yes" ; then
-
-cat > $TMPC <<EOF &&
-#include <infiniband/verbs.h>
-
-int
-main(void)
-{
-    struct ibv_mr *mr;
-    struct ibv_pd *pd =3D NULL;
-    size_t length =3D 10;
-    uint64_t iova =3D 0;
-    int access =3D 0;
-    void *addr =3D NULL;
-
-    mr =3D ibv_reg_mr_iova(pd, addr, length, iova, access);
-
-    ibv_dereg_mr(mr);
-
-    return 0;
-}
-EOF
-    if ! compile_prog "" "-libverbs"; then
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS -DLEGACY_RDMA_REG_MR"
-    fi
-fi
-
-##########################################
-# xfsctl() probe, used for file-posix.c
-if test "$xfs" !=3D "no" ; then
-  cat > $TMPC << EOF
-#include <stddef.h>  /* NULL */
-#include <xfs/xfs.h>
-int main(void)
-{
-    xfsctl(NULL, 0, 0, NULL);
-    return 0;
-}
-EOF
-  if compile_prog "" "" ; then
-    xfs=3D"yes"
-  else
-    if test "$xfs" =3D "yes" ; then
-      feature_not_found "xfs" "Instal xfsprogs/xfslibs devel"
-    fi
-    xfs=3Dno
-  fi
-fi
-
-##########################################
-# vde libraries probe
-if test "$vde" !=3D "no" ; then
-  vde_libs=3D"-lvdeplug"
-  cat > $TMPC << EOF
-#include <libvdeplug.h>
-int main(void)
-{
-    struct vde_open_args a =3D {0, 0, 0};
-    char s[] =3D "";
-    vde_open(s, s, &a);
-    return 0;
-}
-EOF
-  if compile_prog "" "$vde_libs" ; then
-    vde=3Dyes
-  else
-    if test "$vde" =3D "yes" ; then
-      feature_not_found "vde" "Install vde (Virtual Distributed Ethernet) =
devel"
-    fi
-    vde=3Dno
-  fi
-fi
-
-##########################################
-# netmap support probe
-# Apart from looking for netmap headers, we make sure that the host API ve=
rsion
-# supports the netmap backend (>=3D11). The upper bound (15) is meant to s=
imulate
-# a minor/major version number. Minor new features will be marked with val=
ues up
-# to 15, and if something happens that requires a change to the backend we=
 will
-# move above 15, submit the backend fixes and modify this two bounds.
-if test "$netmap" !=3D "no" ; then
-  cat > $TMPC << EOF
-#include <inttypes.h>
-#include <net/if.h>
-#include <net/netmap.h>
-#include <net/netmap_user.h>
-#if (NETMAP_API < 11) || (NETMAP_API > 15)
-#error
-#endif
-int main(void) { return 0; }
-EOF
-  if compile_prog "" "" ; then
-    netmap=3Dyes
-  else
-    if test "$netmap" =3D "yes" ; then
-      feature_not_found "netmap"
-    fi
-    netmap=3Dno
-  fi
-fi
-
-##########################################
-# libcap-ng library probe
-if test "$cap_ng" !=3D "no" ; then
-  cap_libs=3D"-lcap-ng"
-  cat > $TMPC << EOF
-#include <cap-ng.h>
-int main(void)
-{
-    capng_capability_to_name(CAPNG_EFFECTIVE);
-    return 0;
-}
-EOF
-  if compile_prog "" "$cap_libs" ; then
-    cap_ng=3Dyes
-  else
-    if test "$cap_ng" =3D "yes" ; then
-      feature_not_found "cap_ng" "Install libcap-ng devel"
-    fi
-    cap_ng=3Dno
-  fi
-fi
-
-##########################################
-# Sound support libraries probe
-
-audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/,/ /g')
-for drv in $audio_drv_list; do
-    case $drv in
-    alsa | try-alsa)
-    if $pkg_config alsa --exists; then
-        alsa_libs=3D$($pkg_config alsa --libs)
-        alsa_cflags=3D$($pkg_config alsa --cflags)
-        alsa=3Dyes
-        if test "$drv" =3D "try-alsa"; then
-            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-alsa=
/alsa/')
-        fi
-    else
-        if test "$drv" =3D "try-alsa"; then
-            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-alsa=
//')
-        else
-            error_exit "$drv check failed" \
-                "Make sure to have the $drv libs and headers installed."
-        fi
-    fi
-    ;;
-
-    pa | try-pa)
-    if $pkg_config libpulse --exists; then
-        libpulse=3Dyes
-        pulse_libs=3D$($pkg_config libpulse --libs)
-        pulse_cflags=3D$($pkg_config libpulse --cflags)
-        if test "$drv" =3D "try-pa"; then
-            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-pa/p=
a/')
-        fi
-    else
-        if test "$drv" =3D "try-pa"; then
-            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-pa//=
')
-        else
-            error_exit "$drv check failed" \
-                "Make sure to have the $drv libs and headers installed."
-        fi
-    fi
-    ;;
-
-    sdl)
-    if test "$sdl" =3D "no"; then
-        error_exit "sdl not found or disabled, can not use sdl audio drive=
r"
-    fi
-    ;;
-
-    try-sdl)
-    if test "$sdl" =3D "no"; then
-        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-sdl//')
-    else
-        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-sdl/sdl/=
')
-    fi
-    ;;
-
-    coreaudio)
-      coreaudio_libs=3D"-framework CoreAudio"
-    ;;
-
-    dsound)
-      dsound_libs=3D"-lole32 -ldxguid"
-      audio_win_int=3D"yes"
-    ;;
-
-    oss)
-      oss_libs=3D"$oss_lib"
-    ;;
-
-    jack | try-jack)
-    if $pkg_config jack --exists; then
-        libjack=3Dyes
-        jack_libs=3D$($pkg_config jack --libs)
-        if test "$drv" =3D "try-jack"; then
-            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-jack=
/jack/')
-        fi
-    else
-        if test "$drv" =3D "try-jack"; then
-            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-jack=
//')
-        else
-            error_exit "$drv check failed" \
-                "Make sure to have the $drv libs and headers installed."
-        fi
-    fi
-    ;;
-
-    *)
-    echo "$audio_possible_drivers" | grep -q "\<$drv\>" || {
-        error_exit "Unknown driver '$drv' selected" \
-            "Possible drivers are: $audio_possible_drivers"
-    }
-    ;;
-    esac
-done
-
-##########################################
-# BrlAPI probe
-
-if test "$brlapi" !=3D "no" ; then
-  brlapi_libs=3D"-lbrlapi"
-  cat > $TMPC << EOF
-#include <brlapi.h>
-#include <stddef.h>
-int main( void ) { return brlapi__openConnection (NULL, NULL, NULL); }
-EOF
-  if compile_prog "" "$brlapi_libs" ; then
-    brlapi=3Dyes
-  else
-    if test "$brlapi" =3D "yes" ; then
-      feature_not_found "brlapi" "Install brlapi devel"
-    fi
-    brlapi=3Dno
-  fi
-fi
-
-##########################################
-# iconv probe
-if test "$iconv" !=3D "no" ; then
-  cat > $TMPC << EOF
-#include <iconv.h>
-int main(void) {
-  iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");
-  return conv !=3D (iconv_t) -1;
-}
-EOF
-  iconv_prefix_list=3D"/usr/local:/usr"
-  iconv_lib_list=3D":-liconv"
-  IFS=3D:
-  for iconv_prefix in $iconv_prefix_list; do
-    IFS=3D:
-    iconv_cflags=3D"-I$iconv_prefix/include"
-    iconv_ldflags=3D"-L$iconv_prefix/lib"
-    for iconv_link in $iconv_lib_list; do
-      unset IFS
-      iconv_lib=3D"$iconv_ldflags $iconv_link"
-      echo "looking at iconv in '$iconv_cflags' '$iconv_lib'" >> config.log
-      if compile_prog "$iconv_cflags" "$iconv_lib" ; then
-        iconv_found=3Dyes
-        break
-      fi
-    done
-    if test "$iconv_found" =3D yes ; then
-      break
-    fi
-  done
-  if test "$iconv_found" =3D "yes" ; then
-    iconv=3Dyes
-  else
-    if test "$iconv" =3D "yes" ; then
-      feature_not_found "iconv" "Install iconv devel"
-    fi
-    iconv=3Dno
-  fi
-fi
-
-##########################################
-# curses probe
-if test "$iconv" =3D "no" ; then
-  # curses will need iconv
-  curses=3Dno
-fi
-if test "$curses" !=3D "no" ; then
-  if test "$mingw32" =3D "yes" ; then
-    curses_inc_list=3D"$($pkg_config --cflags ncurses 2>/dev/null):"
-    curses_lib_list=3D"$($pkg_config --libs ncurses 2>/dev/null):-lpdcurse=
s"
-  else
-    curses_inc_list=3D"$($pkg_config --cflags ncursesw 2>/dev/null):-I/usr=
/include/ncursesw:"
-    curses_lib_list=3D"$($pkg_config --libs ncursesw 2>/dev/null):-lncurse=
sw:-lcursesw"
-  fi
-  curses_found=3Dno
-  cat > $TMPC << EOF
-#include <locale.h>
-#include <curses.h>
-#include <wchar.h>
-#include <langinfo.h>
-int main(void) {
-  const char *codeset;
-  wchar_t wch =3D L'w';
-  setlocale(LC_ALL, "");
-  resize_term(0, 0);
-  addwstr(L"wide chars\n");
-  addnwstr(&wch, 1);
-  add_wch(WACS_DEGREE);
-  codeset =3D nl_langinfo(CODESET);
-  return codeset !=3D 0;
-}
-EOF
-  IFS=3D:
-  for curses_inc in $curses_inc_list; do
-    # Make sure we get the wide character prototypes
-    curses_inc=3D"-DNCURSES_WIDECHAR $curses_inc"
-    IFS=3D:
-    for curses_lib in $curses_lib_list; do
-      unset IFS
-      if compile_prog "$curses_inc" "$curses_lib" ; then
-        curses_found=3Dyes
-        break
-      fi
-    done
-    if test "$curses_found" =3D yes ; then
-      break
-    fi
-  done
-  unset IFS
-  if test "$curses_found" =3D "yes" ; then
-    curses=3Dyes
-  else
-    if test "$curses" =3D "yes" ; then
-      feature_not_found "curses" "Install ncurses devel"
-    fi
-    curses=3Dno
-  fi
-fi
-
-##########################################
-# curl probe
-if test "$curl" !=3D "no" ; then
-  if $pkg_config libcurl --exists; then
-    curlconfig=3D"$pkg_config libcurl"
-  else
-    curlconfig=3Dcurl-config
-  fi
-  cat > $TMPC << EOF
-#include <curl/curl.h>
-int main(void) { curl_easy_init(); curl_multi_setopt(0, 0, 0); return 0; }
-EOF
-  curl_cflags=3D$($curlconfig --cflags 2>/dev/null)
-  curl_libs=3D$($curlconfig --libs 2>/dev/null)
-  if compile_prog "$curl_cflags" "$curl_libs" ; then
-    curl=3Dyes
-  else
-    if test "$curl" =3D "yes" ; then
-      feature_not_found "curl" "Install libcurl devel"
-    fi
-    curl=3Dno
-  fi
-fi # test "$curl"
-
-##########################################
-# glib support probe
-
-glib_req_ver=3D2.48
-glib_modules=3Dgthread-2.0
-if test "$modules" =3D yes; then
-    glib_modules=3D"$glib_modules gmodule-export-2.0"
-fi
-if test "$plugins" =3D yes; then
-    glib_modules=3D"$glib_modules gmodule-2.0"
-fi
-
-# This workaround is required due to a bug in pkg-config file for glib as =
it
-# doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
-
-if test "$static" =3D yes && test "$mingw32" =3D yes; then
-    QEMU_CFLAGS=3D"-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
-fi
-
-for i in $glib_modules; do
-    if $pkg_config --atleast-version=3D$glib_req_ver $i; then
-        glib_cflags=3D$($pkg_config --cflags $i)
-        glib_libs=3D$($pkg_config --libs $i)
-        QEMU_CFLAGS=3D"$glib_cflags $QEMU_CFLAGS"
-        LIBS=3D"$glib_libs $LIBS"
-    else
-        error_exit "glib-$glib_req_ver $i is required to compile QEMU"
-    fi
-done
-
-if $pkg_config --atleast-version=3D$glib_req_ver gio-2.0; then
-    gio=3Dyes
-    gio_cflags=3D$($pkg_config --cflags gio-2.0)
-    gio_libs=3D$($pkg_config --libs gio-2.0)
-    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
-    if [ ! -x "$gdbus_codegen" ]; then
-        gdbus_codegen=3D
-    fi
-else
-    gio=3Dno
-fi
-
-if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then
-    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"
-    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
-fi
-
-# Sanity check that the current size_t matches the
-# size that glib thinks it should be. This catches
-# problems on multi-arch where people try to build
-# 32-bit QEMU while pointing at 64-bit glib headers
-cat > $TMPC <<EOF
-#include <glib.h>
-#include <unistd.h>
-
-#define QEMU_BUILD_BUG_ON(x) \
-  typedef char qemu_build_bug_on[(x)?-1:1] __attribute__((unused));
-
-int main(void) {
-   QEMU_BUILD_BUG_ON(sizeof(size_t) !=3D GLIB_SIZEOF_SIZE_T);
-   return 0;
-}
-EOF
-
-if ! compile_prog "$CFLAGS" "$LIBS" ; then
-    error_exit "sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T."\
-               "You probably need to set PKG_CONFIG_LIBDIR"\
-	       "to point to the right pkg-config files for your"\
-	       "build target"
-fi
-
-# Silence clang 3.5.0 warnings about glib attribute __alloc_size__ usage
-cat > $TMPC << EOF
-#include <glib.h>
-int main(void) { return 0; }
-EOF
-if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
-    if cc_has_warning_flag "-Wno-unknown-attributes"; then
-        glib_cflags=3D"-Wno-unknown-attributes $glib_cflags"
-        QEMU_CFLAGS=3D"-Wno-unknown-attributes $CFLAGS"
-    fi
-fi
-
-# Silence clang warnings triggered by glib < 2.57.2
-cat > $TMPC << EOF
-#include <glib.h>
-typedef struct Foo {
-    int i;
-} Foo;
-static void foo_free(Foo *f)
-{
-    g_free(f);
-}
-G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free);
-int main(void) { return 0; }
-EOF
-if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
-    if cc_has_warning_flag "-Wno-unused-function"; then
-        glib_cflags=3D"$glib_cflags -Wno-unused-function"
-        CFLAGS=3D"$CFLAGS -Wno-unused-function"
-    fi
-fi
-
-##########################################
-# SHA command probe for modules
-if test "$modules" =3D yes; then
-    shacmd_probe=3D"sha1sum sha1 shasum"
-    for c in $shacmd_probe; do
-        if has $c; then
-            shacmd=3D"$c"
-            break
-        fi
-    done
-    if test "$shacmd" =3D ""; then
-        error_exit "one of the checksum commands is required to enable mod=
ules: $shacmd_probe"
-    fi
-fi
-
-##########################################
-# libmpathpersist probe
-
-if test "$mpath" !=3D "no" ; then
-  # probe for the new API
-  cat > $TMPC <<EOF
-#include <libudev.h>
-#include <mpath_persist.h>
-unsigned mpath_mx_alloc_len =3D 1024;
-int logsink;
-static struct config *multipath_conf;
-extern struct udev *udev;
-extern struct config *get_multipath_config(void);
-extern void put_multipath_config(struct config *conf);
-struct udev *udev;
-struct config *get_multipath_config(void) { return multipath_conf; }
-void put_multipath_config(struct config *conf) { }
-
-int main(void) {
-    udev =3D udev_new();
-    multipath_conf =3D mpath_lib_init();
-    return 0;
-}
-EOF
-  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
-    mpathpersist=3Dyes
-    mpathpersist_new_api=3Dyes
-  else
-    # probe for the old API
-    cat > $TMPC <<EOF
-#include <libudev.h>
-#include <mpath_persist.h>
-unsigned mpath_mx_alloc_len =3D 1024;
-int logsink;
-int main(void) {
-    struct udev *udev =3D udev_new();
-    mpath_lib_init(udev);
-    return 0;
-}
-EOF
-    if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
-      mpathpersist=3Dyes
-      mpathpersist_new_api=3Dno
-    else
-      mpathpersist=3Dno
-    fi
-  fi
-else
-  mpathpersist=3Dno
-fi
-
-##########################################
-# pthread probe
-PTHREADLIBS_LIST=3D"-pthread -lpthread -lpthreadGC2"
-
-pthread=3Dno
-cat > $TMPC << EOF
-#include <pthread.h>
-static void *f(void *p) { return NULL; }
-int main(void) {
-  pthread_t thread;
-  pthread_create(&thread, 0, f, 0);
-  return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  pthread=3Dyes
-else
-  for pthread_lib in $PTHREADLIBS_LIST; do
-    if compile_prog "" "$pthread_lib" ; then
-      pthread=3Dyes
-      found=3Dno
-      for lib_entry in $LIBS; do
-        if test "$lib_entry" =3D "$pthread_lib"; then
-          found=3Dyes
-          break
-        fi
-      done
-      if test "$found" =3D "no"; then
-        LIBS=3D"$pthread_lib $LIBS"
-      fi
-      PTHREAD_LIB=3D"$pthread_lib"
-      break
-    fi
-  done
-fi
-
-if test "$mingw32" !=3D yes && test "$pthread" =3D no; then
-  error_exit "pthread check failed" \
-      "Make sure to have the pthread libs and headers installed."
-fi
-
-# check for pthread_setname_np with thread id
-pthread_setname_np_w_tid=3Dno
-cat > $TMPC << EOF
-#include <pthread.h>
-
-static void *f(void *p) { return NULL; }
-int main(void)
-{
-    pthread_t thread;
-    pthread_create(&thread, 0, f, 0);
-    pthread_setname_np(thread, "QEMU");
-    return 0;
-}
-EOF
-if compile_prog "" "$pthread_lib" ; then
-  pthread_setname_np_w_tid=3Dyes
-fi
-
-# check for pthread_setname_np without thread id
-pthread_setname_np_wo_tid=3Dno
-cat > $TMPC << EOF
-#include <pthread.h>
-
-static void *f(void *p) { pthread_setname_np("QEMU"); return NULL; }
-int main(void)
-{
-    pthread_t thread;
-    pthread_create(&thread, 0, f, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "$pthread_lib" ; then
-  pthread_setname_np_wo_tid=3Dyes
-fi
-
-##########################################
-# rbd probe
-if test "$rbd" !=3D "no" ; then
-  cat > $TMPC <<EOF
-#include <stdio.h>
-#include <rbd/librbd.h>
-int main(void) {
-    rados_t cluster;
-    rados_create(&cluster, NULL);
-    return 0;
-}
-EOF
-  rbd_libs=3D"-lrbd -lrados"
-  if compile_prog "" "$rbd_libs" ; then
-    rbd=3Dyes
-  else
-    if test "$rbd" =3D "yes" ; then
-      feature_not_found "rados block device" "Install librbd/ceph devel"
-    fi
-    rbd=3Dno
-  fi
-fi
-
-##########################################
-# libssh probe
-if test "$libssh" !=3D "no" ; then
-  if $pkg_config --exists libssh; then
-    libssh_cflags=3D$($pkg_config libssh --cflags)
-    libssh_libs=3D$($pkg_config libssh --libs)
-    libssh=3Dyes
-  else
-    if test "$libssh" =3D "yes" ; then
-      error_exit "libssh required for --enable-libssh"
-    fi
-    libssh=3Dno
-  fi
-fi
-
-##########################################
-# Check for libssh 0.8
-# This is done like this instead of using the LIBSSH_VERSION_* and
-# SSH_VERSION_* macros because some distributions in the past shipped
-# snapshots of the future 0.8 from Git, and those snapshots did not
-# have updated version numbers (still referring to 0.7.0).
-
-if test "$libssh" =3D "yes"; then
-  cat > $TMPC <<EOF
-#include <libssh/libssh.h>
-int main(void) { return ssh_get_server_publickey(NULL, NULL); }
-EOF
-  if compile_prog "$libssh_cflags" "$libssh_libs"; then
-    libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
-  fi
-fi
-
-##########################################
-# linux-aio probe
-
-if test "$linux_aio" !=3D "no" ; then
-  cat > $TMPC <<EOF
-#include <libaio.h>
-#include <sys/eventfd.h>
-#include <stddef.h>
-int main(void) { io_setup(0, NULL); io_set_eventfd(NULL, 0); eventfd(0, 0)=
; return 0; }
-EOF
-  if compile_prog "" "-laio" ; then
-    linux_aio=3Dyes
-  else
-    if test "$linux_aio" =3D "yes" ; then
-      feature_not_found "linux AIO" "Install libaio devel"
-    fi
-    linux_aio=3Dno
-  fi
-fi
-##########################################
-# linux-io-uring probe
-
-if test "$linux_io_uring" !=3D "no" ; then
-  if $pkg_config liburing; then
-    linux_io_uring_cflags=3D$($pkg_config --cflags liburing)
-    linux_io_uring_libs=3D$($pkg_config --libs liburing)
-    linux_io_uring=3Dyes
-
-    # io_uring is used in libqemuutil.a where per-file -libs variables are=
 not
-    # seen by programs linking the archive.  It's not ideal, but just add =
the
-    # library dependency globally.
-    LIBS=3D"$linux_io_uring_libs $LIBS"
-  else
-    if test "$linux_io_uring" =3D "yes" ; then
-      feature_not_found "linux io_uring" "Install liburing devel"
-    fi
-    linux_io_uring=3Dno
-  fi
-fi
-
-##########################################
-# TPM emulation is only on POSIX
-
-if test "$tpm" =3D ""; then
-  if test "$mingw32" =3D "yes"; then
-    tpm=3Dno
-  else
-    tpm=3Dyes
-  fi
-elif test "$tpm" =3D "yes"; then
-  if test "$mingw32" =3D "yes" ; then
-    error_exit "TPM emulation only available on POSIX systems"
-  fi
-fi
-
-##########################################
-# attr probe
-
-libattr_libs=3D
-if test "$attr" !=3D "no" ; then
-  cat > $TMPC <<EOF
-#include <stdio.h>
-#include <sys/types.h>
-#ifdef CONFIG_LIBATTR
-#include <attr/xattr.h>
-#else
-#include <sys/xattr.h>
-#endif
-int main(void) { getxattr(NULL, NULL, NULL, 0); setxattr(NULL, NULL, NULL,=
 0, 0); return 0; }
-EOF
-  if compile_prog "" "" ; then
-    attr=3Dyes
-  # Older distros have <attr/xattr.h>, and need -lattr:
-  elif compile_prog "-DCONFIG_LIBATTR" "-lattr" ; then
-    attr=3Dyes
-    libattr_libs=3D"-lattr"
-    LIBS=3D"$libattr_libs $LIBS"
-    libattr=3Dyes
-  else
-    if test "$attr" =3D "yes" ; then
-      feature_not_found "ATTR" "Install libc6 or libattr devel"
-    fi
-    attr=3Dno
-  fi
-fi
-
-##########################################
-# iovec probe
-cat > $TMPC <<EOF
-#include <sys/types.h>
-#include <sys/uio.h>
-#include <unistd.h>
-int main(void) { return sizeof(struct iovec); }
-EOF
-iovec=3Dno
-if compile_prog "" "" ; then
-  iovec=3Dyes
-fi
-
-##########################################
-# preadv probe
-cat > $TMPC <<EOF
-#include <sys/types.h>
-#include <sys/uio.h>
-#include <unistd.h>
-int main(void) { return preadv(0, 0, 0, 0); }
-EOF
-preadv=3Dno
-if compile_prog "" "" ; then
-  preadv=3Dyes
-fi
-
-##########################################
-# fdt probe
-# fdt support is mandatory for at least some target architectures,
-# so insist on it if we're building those system emulators.
-fdt_required=3Dno
-for target in $target_list; do
-  case $target in
-    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64e=
l-softmmu|riscv*-softmmu|rx-softmmu)
-      fdt_required=3Dyes
-    ;;
-  esac
-done
-
-if test "$fdt_required" =3D "yes"; then
-  if test "$fdt" =3D "no"; then
-    error_exit "fdt disabled but some requested targets require it." \
-      "You can turn off fdt only if you also disable all the system emulat=
ion" \
-      "targets which need it (by specifying a cut down --target-list)."
-  fi
-  fdt=3Dyes
-elif test "$fdt" !=3D "yes" ; then
-  fdt=3Dno
-fi
-
-# fdt is only required when building softmmu targets
-if test -z "$fdt" -a "$softmmu" !=3D "yes" ; then
-    fdt=3D"no"
-fi
-
-if test "$fdt" !=3D "no" ; then
-  fdt_libs=3D"-lfdt"
-  # explicitly check for libfdt_env.h as it is missing in some stable inst=
alls
-  # and test for required functions to make sure we are on a version >=3D =
1.4.2
-  cat > $TMPC << EOF
-#include <libfdt.h>
-#include <libfdt_env.h>
-int main(void) { fdt_check_full(NULL, 0); return 0; }
-EOF
-  if compile_prog "" "$fdt_libs" ; then
-    # system DTC is good - use it
-    fdt=3Dsystem
-  else
-      # have GIT checkout, so activate dtc submodule
-      if test -e "${source_path}/.git" ; then
-          git_submodules=3D"${git_submodules} dtc"
-      fi
-      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.g=
it" ; then
-          fdt=3Dgit
-          mkdir -p dtc
-          fdt_cflags=3D"-I${source_path}/dtc/libfdt"
-          fdt_ldflags=3D"-L${build_path}/dtc/libfdt"
-          fdt_libs=3D"$fdt_libs"
-      elif test "$fdt" =3D "yes" ; then
-          # Not a git build & no libfdt found, prompt for system install
-          error_exit "DTC (libfdt) version >=3D 1.4.2 not present." \
-                     "Please install the DTC (libfdt) devel package"
-      else
-          # don't have and don't want
-          fdt_libs=3D
-          fdt=3Dno
-      fi
-  fi
-fi
-
-##########################################
-# opengl probe (for sdl2, gtk, milkymist-tmu2)
-
-gbm=3D"no"
-if $pkg_config gbm; then
-    gbm_cflags=3D"$($pkg_config --cflags gbm)"
-    gbm_libs=3D"$($pkg_config --libs gbm)"
-    gbm=3D"yes"
-fi
-
-if test "$opengl" !=3D "no" ; then
-  opengl_pkgs=3D"epoxy gbm"
-  if $pkg_config $opengl_pkgs; then
-    opengl_cflags=3D"$($pkg_config --cflags $opengl_pkgs)"
-    opengl_libs=3D"$($pkg_config --libs $opengl_pkgs)"
-    opengl=3Dyes
-    if test "$gtk" =3D "yes" && $pkg_config --exists "$gtkpackage >=3D 3.1=
6"; then
-        gtk_gl=3D"yes"
-    fi
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $opengl_cflags"
-  else
-    if test "$opengl" =3D "yes" ; then
-      feature_not_found "opengl" "Please install opengl (mesa) devel pkgs:=
 $opengl_pkgs"
-    fi
-    opengl_cflags=3D""
-    opengl_libs=3D""
-    opengl=3Dno
-  fi
-fi
-
-if test "$opengl" =3D "yes"; then
-  cat > $TMPC << EOF
-#include <epoxy/egl.h>
-#ifndef EGL_MESA_image_dma_buf_export
-# error mesa/epoxy lacks support for dmabufs (mesa 10.6+)
-#endif
-int main(void) { return 0; }
-EOF
-  if compile_prog "" "" ; then
-    opengl_dmabuf=3Dyes
-  fi
-fi
-
-if test "$opengl" =3D "yes" && test "$have_x11" =3D "yes"; then
-  for target in $target_list; do
-    case $target in
-      lm32-softmmu) # milkymist-tmu2 requires X11 and OpenGL
-        need_x11=3Dyes
-      ;;
-    esac
-  done
-fi
-
-##########################################
-# libxml2 probe
-if test "$libxml2" !=3D "no" ; then
-    if $pkg_config --exists libxml-2.0; then
-        libxml2=3D"yes"
-        libxml2_cflags=3D$($pkg_config --cflags libxml-2.0)
-        libxml2_libs=3D$($pkg_config --libs libxml-2.0)
-    else
-        if test "$libxml2" =3D "yes"; then
-            feature_not_found "libxml2" "Install libxml2 devel"
-        fi
-        libxml2=3D"no"
-    fi
-fi
-
-##########################################
-# glusterfs probe
-if test "$glusterfs" !=3D "no" ; then
-  if $pkg_config --atleast-version=3D3 glusterfs-api; then
-    glusterfs=3D"yes"
-    glusterfs_cflags=3D$($pkg_config --cflags glusterfs-api)
-    glusterfs_libs=3D$($pkg_config --libs glusterfs-api)
-    if $pkg_config --atleast-version=3D4 glusterfs-api; then
-      glusterfs_xlator_opt=3D"yes"
-    fi
-    if $pkg_config --atleast-version=3D5 glusterfs-api; then
-      glusterfs_discard=3D"yes"
-    fi
-    if $pkg_config --atleast-version=3D6 glusterfs-api; then
-      glusterfs_fallocate=3D"yes"
-      glusterfs_zerofill=3D"yes"
-    fi
-    cat > $TMPC << EOF
-#include <glusterfs/api/glfs.h>
-
-int
-main(void)
-{
-	/* new glfs_ftruncate() passes two additional args */
-	return glfs_ftruncate(NULL, 0, NULL, NULL);
-}
-EOF
-    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
-      glusterfs_ftruncate_has_stat=3D"yes"
-    fi
-    cat > $TMPC << EOF
-#include <glusterfs/api/glfs.h>
-
-/* new glfs_io_cbk() passes two additional glfs_stat structs */
-static void
-glusterfs_iocb(glfs_fd_t *fd, ssize_t ret, struct glfs_stat *prestat, stru=
ct glfs_stat *poststat, void *data)
-{}
-
-int
-main(void)
-{
-	glfs_io_cbk iocb =3D &glusterfs_iocb;
-	iocb(NULL, 0 , NULL, NULL, NULL);
-	return 0;
-}
-EOF
-    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then
-      glusterfs_iocb_has_stat=3D"yes"
-    fi
-  else
-    if test "$glusterfs" =3D "yes" ; then
-      feature_not_found "GlusterFS backend support" \
-          "Install glusterfs-api devel >=3D 3"
-    fi
-    glusterfs=3D"no"
-  fi
-fi
-
-# Check for inotify functions when we are building linux-user
-# emulator.  This is done because older glibc versions don't
-# have syscall stubs for these implemented.  In that case we
-# don't provide them even if kernel supports them.
-#
-inotify=3Dno
-cat > $TMPC << EOF
-#include <sys/inotify.h>
-
-int
-main(void)
-{
-	/* try to start inotify */
-	return inotify_init();
-}
-EOF
-if compile_prog "" "" ; then
-  inotify=3Dyes
-fi
-
-inotify1=3Dno
-cat > $TMPC << EOF
-#include <sys/inotify.h>
-
-int
-main(void)
-{
-    /* try to start inotify */
-    return inotify_init1(0);
-}
-EOF
-if compile_prog "" "" ; then
-  inotify1=3Dyes
-fi
-
-# check if pipe2 is there
-pipe2=3Dno
-cat > $TMPC << EOF
-#include <unistd.h>
-#include <fcntl.h>
-
-int main(void)
-{
-    int pipefd[2];
-    return pipe2(pipefd, O_CLOEXEC);
-}
-EOF
-if compile_prog "" "" ; then
-  pipe2=3Dyes
-fi
-
-# check if accept4 is there
-accept4=3Dno
-cat > $TMPC << EOF
-#include <sys/socket.h>
-#include <stddef.h>
-
-int main(void)
-{
-    accept4(0, NULL, NULL, SOCK_CLOEXEC);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  accept4=3Dyes
-fi
-
-# check if tee/splice is there. vmsplice was added same time.
-splice=3Dno
-cat > $TMPC << EOF
-#include <unistd.h>
-#include <fcntl.h>
-#include <limits.h>
-
-int main(void)
-{
-    int len, fd =3D 0;
-    len =3D tee(STDIN_FILENO, STDOUT_FILENO, INT_MAX, SPLICE_F_NONBLOCK);
-    splice(STDIN_FILENO, NULL, fd, NULL, len, SPLICE_F_MOVE);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  splice=3Dyes
-fi
-
-##########################################
-# libnuma probe
-
-if test "$numa" !=3D "no" ; then
-  cat > $TMPC << EOF
-#include <numa.h>
-int main(void) { return numa_available(); }
-EOF
-
-  if compile_prog "" "-lnuma" ; then
-    numa=3Dyes
-    numa_libs=3D"-lnuma"
-  else
-    if test "$numa" =3D "yes" ; then
-      feature_not_found "numa" "install numactl devel"
-    fi
-    numa=3Dno
-  fi
-fi
-
-if test "$tcmalloc" =3D "yes" && test "$jemalloc" =3D "yes" ; then
-    echo "ERROR: tcmalloc && jemalloc can't be used at the same time"
-    exit 1
-fi
-
-# Even if malloc_trim() is available, these non-libc memory allocators
-# do not support it.
-if test "$tcmalloc" =3D "yes" || test "$jemalloc" =3D "yes" ; then
-    if test "$malloc_trim" =3D "yes" ; then
-        echo "Disabling malloc_trim with non-libc memory allocator"
-    fi
-    malloc_trim=3D"no"
-fi
-
-#######################################
-# malloc_trim
-
-if test "$malloc_trim" !=3D "no" ; then
-    cat > $TMPC << EOF
-#include <malloc.h>
-int main(void) { malloc_trim(0); return 0; }
-EOF
-    if compile_prog "" "" ; then
-        malloc_trim=3D"yes"
-    else
-        malloc_trim=3D"no"
-    fi
-fi
-
-##########################################
-# tcmalloc probe
-
-if test "$tcmalloc" =3D "yes" ; then
-  cat > $TMPC << EOF
-#include <stdlib.h>
-int main(void) {
-    void *tmp =3D malloc(1);
-    if (tmp !=3D NULL) {
-        return 0;
-    }
-    return 1;
-}
-EOF
-
-  if compile_prog "" "-ltcmalloc" ; then
-    LIBS=3D"-ltcmalloc $LIBS"
-  else
-    feature_not_found "tcmalloc" "install gperftools devel"
-  fi
-fi
-
-##########################################
-# jemalloc probe
-
-if test "$jemalloc" =3D "yes" ; then
-  cat > $TMPC << EOF
-#include <stdlib.h>
-int main(void) {
-    void *tmp =3D malloc(1);
-    if (tmp !=3D NULL) {
-        return 0;
-    }
-    return 1;
-}
-EOF
-
-  if compile_prog "" "-ljemalloc" ; then
-    LIBS=3D"-ljemalloc $LIBS"
-  else
-    feature_not_found "jemalloc" "install jemalloc devel"
-  fi
-fi
-
-##########################################
-# signalfd probe
-signalfd=3D"no"
-cat > $TMPC << EOF
-#include <unistd.h>
-#include <sys/syscall.h>
-#include <signal.h>
-int main(void) { return syscall(SYS_signalfd, -1, NULL, _NSIG / 8); }
-EOF
-
-if compile_prog "" "" ; then
-  signalfd=3Dyes
-fi
-
-# check if optreset global is declared by <getopt.h>
-optreset=3D"no"
-cat > $TMPC << EOF
-#include <getopt.h>
-int main(void) { return optreset; }
-EOF
-
-if compile_prog "" "" ; then
-  optreset=3Dyes
-fi
-
-# check if eventfd is supported
-eventfd=3Dno
-cat > $TMPC << EOF
-#include <sys/eventfd.h>
-
-int main(void)
-{
-    return eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
-}
-EOF
-if compile_prog "" "" ; then
-  eventfd=3Dyes
-fi
-
-# check if memfd is supported
-memfd=3Dno
-cat > $TMPC << EOF
-#include <sys/mman.h>
-
-int main(void)
-{
-    return memfd_create("foo", MFD_ALLOW_SEALING);
-}
-EOF
-if compile_prog "" "" ; then
-  memfd=3Dyes
-fi
-
-# check for usbfs
-have_usbfs=3Dno
-if test "$linux_user" =3D "yes"; then
-  cat > $TMPC << EOF
-#include <linux/usbdevice_fs.h>
-
-#ifndef USBDEVFS_GET_CAPABILITIES
-#error "USBDEVFS_GET_CAPABILITIES undefined"
-#endif
-
-#ifndef USBDEVFS_DISCONNECT_CLAIM
-#error "USBDEVFS_DISCONNECT_CLAIM undefined"
-#endif
-
-int main(void)
-{
-    return 0;
-}
-EOF
-  if compile_prog "" ""; then
-    have_usbfs=3Dyes
-  fi
-fi
-
-# check for fallocate
-fallocate=3Dno
-cat > $TMPC << EOF
-#include <fcntl.h>
-
-int main(void)
-{
-    fallocate(0, 0, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  fallocate=3Dyes
-fi
-
-# check for fallocate hole punching
-fallocate_punch_hole=3Dno
-cat > $TMPC << EOF
-#include <fcntl.h>
-#include <linux/falloc.h>
-
-int main(void)
-{
-    fallocate(0, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  fallocate_punch_hole=3Dyes
-fi
-
-# check that fallocate supports range zeroing inside the file
-fallocate_zero_range=3Dno
-cat > $TMPC << EOF
-#include <fcntl.h>
-#include <linux/falloc.h>
-
-int main(void)
-{
-    fallocate(0, FALLOC_FL_ZERO_RANGE, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  fallocate_zero_range=3Dyes
-fi
-
-# check for posix_fallocate
-posix_fallocate=3Dno
-cat > $TMPC << EOF
-#include <fcntl.h>
-
-int main(void)
-{
-    posix_fallocate(0, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    posix_fallocate=3Dyes
-fi
-
-# check for sync_file_range
-sync_file_range=3Dno
-cat > $TMPC << EOF
-#include <fcntl.h>
-
-int main(void)
-{
-    sync_file_range(0, 0, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  sync_file_range=3Dyes
-fi
-
-# check for linux/fiemap.h and FS_IOC_FIEMAP
-fiemap=3Dno
-cat > $TMPC << EOF
-#include <sys/ioctl.h>
-#include <linux/fs.h>
-#include <linux/fiemap.h>
-
-int main(void)
-{
-    ioctl(0, FS_IOC_FIEMAP, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  fiemap=3Dyes
-fi
-
-# check for dup3
-dup3=3Dno
-cat > $TMPC << EOF
-#include <unistd.h>
-
-int main(void)
-{
-    dup3(0, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  dup3=3Dyes
-fi
-
-# check for ppoll support
-ppoll=3Dno
-cat > $TMPC << EOF
-#include <poll.h>
-
-int main(void)
-{
-    struct pollfd pfd =3D { .fd =3D 0, .events =3D 0, .revents =3D 0 };
-    ppoll(&pfd, 1, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  ppoll=3Dyes
-fi
-
-# check for prctl(PR_SET_TIMERSLACK , ... ) support
-prctl_pr_set_timerslack=3Dno
-cat > $TMPC << EOF
-#include <sys/prctl.h>
-
-int main(void)
-{
-    prctl(PR_SET_TIMERSLACK, 1, 0, 0, 0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  prctl_pr_set_timerslack=3Dyes
-fi
-
-# check for epoll support
-epoll=3Dno
-cat > $TMPC << EOF
-#include <sys/epoll.h>
-
-int main(void)
-{
-    epoll_create(0);
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  epoll=3Dyes
-fi
-
-# epoll_create1 is a later addition
-# so we must check separately for its presence
-epoll_create1=3Dno
-cat > $TMPC << EOF
-#include <sys/epoll.h>
-
-int main(void)
-{
-    /* Note that we use epoll_create1 as a value, not as
-     * a function being called. This is necessary so that on
-     * old SPARC glibc versions where the function was present in
-     * the library but not declared in the header file we will
-     * fail the configure check. (Otherwise we will get a compiler
-     * warning but not an error, and will proceed to fail the
-     * qemu compile where we compile with -Werror.)
-     */
-    return (int)(uintptr_t)&epoll_create1;
-}
-EOF
-if compile_prog "" "" ; then
-  epoll_create1=3Dyes
-fi
-
-# check for sendfile support
-sendfile=3Dno
-cat > $TMPC << EOF
-#include <sys/sendfile.h>
-
-int main(void)
-{
-    return sendfile(0, 0, 0, 0);
-}
-EOF
-if compile_prog "" "" ; then
-  sendfile=3Dyes
-fi
-
-# check for timerfd support (glibc 2.8 and newer)
-timerfd=3Dno
-cat > $TMPC << EOF
-#include <sys/timerfd.h>
-
-int main(void)
-{
-    return(timerfd_create(CLOCK_REALTIME, 0));
-}
-EOF
-if compile_prog "" "" ; then
-  timerfd=3Dyes
-fi
-
-# check for setns and unshare support
-setns=3Dno
-cat > $TMPC << EOF
-#include <sched.h>
-
-int main(void)
-{
-    int ret;
-    ret =3D setns(0, 0);
-    ret =3D unshare(0);
-    return ret;
-}
-EOF
-if compile_prog "" "" ; then
-  setns=3Dyes
-fi
-
-# clock_adjtime probe
-clock_adjtime=3Dno
-cat > $TMPC <<EOF
-#include <time.h>
-
-int main(void)
-{
-    return clock_adjtime(0, 0);
-}
-EOF
-clock_adjtime=3Dno
-if compile_prog "" "" ; then
-  clock_adjtime=3Dyes
-fi
-
-# syncfs probe
-syncfs=3Dno
-cat > $TMPC <<EOF
-#include <unistd.h>
-
-int main(void)
-{
-    return syncfs(0);
-}
-EOF
-syncfs=3Dno
-if compile_prog "" "" ; then
-  syncfs=3Dyes
-fi
-
-# check for kcov support (kernel must be 4.4+, compiled with certain optio=
ns)
-kcov=3Dno
-if check_include sys/kcov.h ; then
-    kcov=3Dyes
-fi
-
-# If we're making warnings fatal, apply this to Sphinx runs as well
-sphinx_werror=3D""
-if test "$werror" =3D "yes"; then
-    sphinx_werror=3D"-W"
-fi
-
-# Check we have a new enough version of sphinx-build
-has_sphinx_build() {
-    # This is a bit awkward but works: create a trivial document and
-    # try to run it with our configuration file (which enforces a
-    # version requirement). This will fail if either
-    # sphinx-build doesn't exist at all or if it is too old.
-    mkdir -p "$TMPDIR1/sphinx"
-    touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
-                    -b html "$TMPDIR1/sphinx" \
-                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
-}
-
-# Check if tools are available to build documentation.
-if test "$docs" !=3D "no" ; then
-  if has_sphinx_build; then
-    sphinx_ok=3Dyes
-  else
-    sphinx_ok=3Dno
-  fi
-  if has makeinfo && has pod2man && test "$sphinx_ok" =3D "yes"; then
-    docs=3Dyes
-  else
-    if test "$docs" =3D "yes" ; then
-      if has $sphinx_build && test "$sphinx_ok" !=3D "yes"; then
-        echo "Warning: $sphinx_build exists but it is either too old or us=
es too old a Python version" >&2
-      fi
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a=
 Python 3 version of python-sphinx"
-    fi
-    docs=3Dno
-  fi
-fi
-
-# Search for bswap_32 function
-byteswap_h=3Dno
-cat > $TMPC << EOF
-#include <byteswap.h>
-int main(void) { return bswap_32(0); }
-EOF
-if compile_prog "" "" ; then
-  byteswap_h=3Dyes
-fi
-
-# Search for bswap32 function
-bswap_h=3Dno
-cat > $TMPC << EOF
-#include <sys/endian.h>
-#include <sys/types.h>
-#include <machine/bswap.h>
-int main(void) { return bswap32(0); }
-EOF
-if compile_prog "" "" ; then
-  bswap_h=3Dyes
-fi
-
-##########################################
-# Do we have libiscsi >=3D 1.9.0
-if test "$libiscsi" !=3D "no" ; then
-  if $pkg_config --atleast-version=3D1.9.0 libiscsi; then
-    libiscsi=3D"yes"
-    libiscsi_cflags=3D$($pkg_config --cflags libiscsi)
-    libiscsi_libs=3D$($pkg_config --libs libiscsi)
-  else
-    if test "$libiscsi" =3D "yes" ; then
-      feature_not_found "libiscsi" "Install libiscsi >=3D 1.9.0"
-    fi
-    libiscsi=3D"no"
-  fi
-fi
-
-##########################################
-# Do we need libm
-cat > $TMPC << EOF
-#include <math.h>
-int main(int argc, char **argv) { return isnan(sin((double)argc)); }
-EOF
-if compile_prog "" "" ; then
-  :
-elif compile_prog "" "-lm" ; then
-  LIBS=3D"-lm $LIBS"
-else
-  error_exit "libm check failed"
-fi
-
-##########################################
-# Do we need librt
-# uClibc provides 2 versions of clock_gettime(), one with realtime
-# support and one without. This means that the clock_gettime() don't
-# need -lrt. We still need it for timer_create() so we check for this
-# function in addition.
-cat > $TMPC <<EOF
-#include <signal.h>
-#include <time.h>
-int main(void) {
-  timer_create(CLOCK_REALTIME, NULL, NULL);
-  return clock_gettime(CLOCK_REALTIME, NULL);
-}
-EOF
-
-if compile_prog "" "" ; then
-  :
-# we need pthread for static linking. use previous pthread test result
-elif compile_prog "" "$pthread_lib -lrt" ; then
-  LIBS=3D"$LIBS -lrt"
-fi
-
-# Check whether we need to link libutil for openpty()
-cat > $TMPC << EOF
-extern int openpty(int *am, int *as, char *name, void *termp, void *winp);
-int main(void) { return openpty(0, 0, 0, 0, 0); }
-EOF
-
-have_openpty=3D"no"
-if compile_prog "" "" ; then
-  have_openpty=3D"yes"
-else
-  if compile_prog "" "-lutil" ; then
-    libs_tools=3D"-lutil $libs_tools"
-    have_openpty=3D"yes"
-  fi
-fi
-
-##########################################
-# spice probe
-if test "$spice" !=3D "no" ; then
-  cat > $TMPC << EOF
-#include <spice.h>
-int main(void) { spice_server_new(); return 0; }
-EOF
-  spice_cflags=3D$($pkg_config --cflags spice-protocol spice-server 2>/dev=
/null)
-  spice_libs=3D$($pkg_config --libs spice-protocol spice-server 2>/dev/nul=
l)
-  if $pkg_config --atleast-version=3D0.12.5 spice-server && \
-     $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
-     compile_prog "$spice_cflags" "$spice_libs" ; then
-    spice=3D"yes"
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $spice_cflags"
-  else
-    if test "$spice" =3D "yes" ; then
-      feature_not_found "spice" \
-          "Install spice-server(>=3D0.12.5) and spice-protocol(>=3D0.12.3)=
 devel"
-    fi
-    spice=3D"no"
-  fi
-fi
-
-# check for smartcard support
-if test "$smartcard" !=3D "no"; then
-    if $pkg_config --atleast-version=3D2.5.1 libcacard; then
-        libcacard_cflags=3D$($pkg_config --cflags libcacard)
-        libcacard_libs=3D$($pkg_config --libs libcacard)
-        smartcard=3D"yes"
-    else
-        if test "$smartcard" =3D "yes"; then
-            feature_not_found "smartcard" "Install libcacard devel"
-        fi
-        smartcard=3D"no"
-    fi
-fi
-
-# check for libusb
-if test "$libusb" !=3D "no" ; then
-    if $pkg_config --atleast-version=3D1.0.13 libusb-1.0; then
-        libusb=3D"yes"
-        libusb_cflags=3D$($pkg_config --cflags libusb-1.0)
-        libusb_libs=3D$($pkg_config --libs libusb-1.0)
-    else
-        if test "$libusb" =3D "yes"; then
-            feature_not_found "libusb" "Install libusb devel >=3D 1.0.13"
-        fi
-        libusb=3D"no"
-    fi
-fi
-
-# check for usbredirparser for usb network redirection support
-if test "$usb_redir" !=3D "no" ; then
-    if $pkg_config --atleast-version=3D0.6 libusbredirparser-0.5; then
-        usb_redir=3D"yes"
-        usb_redir_cflags=3D$($pkg_config --cflags libusbredirparser-0.5)
-        usb_redir_libs=3D$($pkg_config --libs libusbredirparser-0.5)
-    else
-        if test "$usb_redir" =3D "yes"; then
-            feature_not_found "usb-redir" "Install usbredir devel"
-        fi
-        usb_redir=3D"no"
-    fi
-fi
-
-##########################################
-# check if we have VSS SDK headers for win
-
-if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no" && \
-        test "$vss_win32_sdk" !=3D "no" ; then
-  case "$vss_win32_sdk" in
-    "")   vss_win32_include=3D"-isystem $source_path" ;;
-    *\ *) # The SDK is installed in "Program Files" by default, but we can=
not
-          # handle path with spaces. So we symlink the headers into ".sdk/=
vss".
-          vss_win32_include=3D"-isystem $source_path/.sdk/vss"
-	  symlink "$vss_win32_sdk/inc" "$source_path/.sdk/vss/inc"
-	  ;;
-    *)    vss_win32_include=3D"-isystem $vss_win32_sdk"
-  esac
-  cat > $TMPC << EOF
-#define __MIDL_user_allocate_free_DEFINED__
-#include <inc/win2003/vss.h>
-int main(void) { return VSS_CTX_BACKUP; }
-EOF
-  if compile_prog "$vss_win32_include" "" ; then
-    guest_agent_with_vss=3D"yes"
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $vss_win32_include"
-    libs_qga=3D"-lole32 -loleaut32 -lshlwapi -lstdc++ -Wl,--enable-stdcall=
-fixup $libs_qga"
-    qga_vss_provider=3D"qga/vss-win32/qga-vss.dll qga/vss-win32/qga-vss.tl=
b"
-  else
-    if test "$vss_win32_sdk" !=3D "" ; then
-      echo "ERROR: Please download and install Microsoft VSS SDK:"
-      echo "ERROR:   http://www.microsoft.com/en-us/download/details.aspx?=
id=3D23490"
-      echo "ERROR: On POSIX-systems, you can extract the SDK headers by:"
-      echo "ERROR:   scripts/extract-vsssdk-headers setup.exe"
-      echo "ERROR: The headers are extracted in the directory \`inc'."
-      feature_not_found "VSS support"
-    fi
-    guest_agent_with_vss=3D"no"
-  fi
-fi
-
-##########################################
-# lookup Windows platform SDK (if not specified)
-# The SDK is needed only to build .tlb (type library) file of guest agent
-# VSS provider from the source. It is usually unnecessary because the
-# pre-compiled .tlb file is included.
-
-if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no" && \
-        test "$guest_agent_with_vss" =3D "yes" ; then
-  if test -z "$win_sdk"; then
-    programfiles=3D"$PROGRAMFILES"
-    test -n "$PROGRAMW6432" && programfiles=3D"$PROGRAMW6432"
-    if test -n "$programfiles"; then
-      win_sdk=3D$(ls -d "$programfiles/Microsoft SDKs/Windows/v"* | tail -=
1) 2>/dev/null
-    else
-      feature_not_found "Windows SDK"
-    fi
-  elif test "$win_sdk" =3D "no"; then
-    win_sdk=3D""
-  fi
-fi
-
-##########################################
-# check if mingw environment provides a recent ntddscsi.h
-if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no"; then
-  cat > $TMPC << EOF
-#include <windows.h>
-#include <ntddscsi.h>
-int main(void) {
-#if !defined(IOCTL_SCSI_GET_ADDRESS)
-#error Missing required ioctl definitions
-#endif
-  SCSI_ADDRESS addr =3D { .Lun =3D 0, .TargetId =3D 0, .PathId =3D 0 };
-  return addr.Lun;
-}
-EOF
-  if compile_prog "" "" ; then
-    guest_agent_ntddscsi=3Dyes
-    libs_qga=3D"-lsetupapi -lcfgmgr32 $libs_qga"
-  fi
-fi
-
-##########################################
-# virgl renderer probe
-
-if test "$virglrenderer" !=3D "no" ; then
-  cat > $TMPC << EOF
-#include <virglrenderer.h>
-int main(void) { virgl_renderer_poll(); return 0; }
-EOF
-  virgl_cflags=3D$($pkg_config --cflags virglrenderer 2>/dev/null)
-  virgl_libs=3D$($pkg_config --libs virglrenderer 2>/dev/null)
-  virgl_version=3D$($pkg_config --modversion virglrenderer 2>/dev/null)
-  if $pkg_config virglrenderer >/dev/null 2>&1 && \
-     compile_prog "$virgl_cflags" "$virgl_libs" ; then
-    virglrenderer=3D"yes"
-  else
-    if test "$virglrenderer" =3D "yes" ; then
-      feature_not_found "virglrenderer"
-    fi
-    virglrenderer=3D"no"
-  fi
-fi
-
-##########################################
-# capstone
-
-case "$capstone" in
-  "" | yes)
-    if $pkg_config capstone; then
-      capstone=3Dsystem
-    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; then
-      capstone=3Dgit
-    elif test -e "${source_path}/capstone/Makefile" ; then
-      capstone=3Dinternal
-    elif test -z "$capstone" ; then
-      capstone=3Dno
-    else
-      feature_not_found "capstone" "Install capstone devel or git submodul=
e"
-    fi
-    ;;
-
-  system)
-    if ! $pkg_config capstone; then
-      feature_not_found "capstone" "Install capstone devel"
-    fi
-    ;;
-esac
-
-case "$capstone" in
-  git | internal)
-    if test "$capstone" =3D git; then
-      git_submodules=3D"${git_submodules} capstone"
-    fi
-    mkdir -p capstone
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS -I${source_path}/capstone/include"
-    if test "$mingw32" =3D "yes"; then
-      LIBCAPSTONE=3Dcapstone.lib
-    else
-      LIBCAPSTONE=3Dlibcapstone.a
-    fi
-    capstone_libs=3D"-L${build_path}/capstone -lcapstone"
-    capstone_cflags=3D"-I${source_path}/capstone/include"
-    ;;
-
-  system)
-    capstone_libs=3D"$($pkg_config --libs capstone)"
-    capstone_cflags=3D"$($pkg_config --cflags capstone)"
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags capstone)"
-    ;;
-
-  no)
-    ;;
-  *)
-    error_exit "Unknown state for capstone: $capstone"
-    ;;
-esac
-
-##########################################
-# check if we have fdatasync
-
-fdatasync=3Dno
-cat > $TMPC << EOF
-#include <unistd.h>
-int main(void) {
-#if defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0
-return fdatasync(0);
-#else
-#error Not supported
-#endif
-}
-EOF
-if compile_prog "" "" ; then
-    fdatasync=3Dyes
-fi
-
-##########################################
-# check if we have madvise
-
-madvise=3Dno
-cat > $TMPC << EOF
-#include <sys/types.h>
-#include <sys/mman.h>
-#include <stddef.h>
-int main(void) { return madvise(NULL, 0, MADV_DONTNEED); }
-EOF
-if compile_prog "" "" ; then
-    madvise=3Dyes
-fi
-
-##########################################
-# check if we have posix_madvise
-
-posix_madvise=3Dno
-cat > $TMPC << EOF
-#include <sys/mman.h>
-#include <stddef.h>
-int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }
-EOF
-if compile_prog "" "" ; then
-    posix_madvise=3Dyes
-fi
-
-##########################################
-# check if we have posix_memalign()
-
-posix_memalign=3Dno
-cat > $TMPC << EOF
-#include <stdlib.h>
-int main(void) {
-    void *p;
-    return posix_memalign(&p, 8, 8);
-}
-EOF
-if compile_prog "" "" ; then
-    posix_memalign=3Dyes
-fi
-
-##########################################
-# check if we have posix_syslog
-
-posix_syslog=3Dno
-cat > $TMPC << EOF
-#include <syslog.h>
-int main(void) { openlog("qemu", LOG_PID, LOG_DAEMON); syslog(LOG_INFO, "c=
onfigure"); return 0; }
-EOF
-if compile_prog "" "" ; then
-    posix_syslog=3Dyes
-fi
-
-##########################################
-# check if we have sem_timedwait
-
-sem_timedwait=3Dno
-cat > $TMPC << EOF
-#include <semaphore.h>
-int main(void) { sem_t s; struct timespec t =3D {0}; return sem_timedwait(=
&s, &t); }
-EOF
-if compile_prog "" "" ; then
-    sem_timedwait=3Dyes
-fi
-
-##########################################
-# check if we have strchrnul
-
-strchrnul=3Dno
-cat > $TMPC << EOF
-#include <string.h>
-int main(void);
-// Use a haystack that the compiler shouldn't be able to constant fold
-char *haystack =3D (char*)&main;
-int main(void) { return strchrnul(haystack, 'x') !=3D &haystack[6]; }
-EOF
-if compile_prog "" "" ; then
-    strchrnul=3Dyes
-fi
-
-#########################################
-# check if we have st_atim
-
-st_atim=3Dno
-cat > $TMPC << EOF
-#include <sys/stat.h>
-#include <stddef.h>
-int main(void) { return offsetof(struct stat, st_atim); }
-EOF
-if compile_prog "" "" ; then
-    st_atim=3Dyes
-fi
-
-##########################################
-# check if trace backend exists
-
-$python "$source_path/scripts/tracetool.py" "--backends=3D$trace_backends"=
 --check-backends  > /dev/null 2> /dev/null
-if test "$?" -ne 0 ; then
-  error_exit "invalid trace backends" \
-      "Please choose supported trace backends."
-fi
-
-##########################################
-# For 'ust' backend, test if ust headers are present
-if have_backend "ust"; then
-  cat > $TMPC << EOF
-#include <lttng/tracepoint.h>
-int main(void) { return 0; }
-EOF
-  if compile_prog "" "-Wl,--no-as-needed -ldl" ; then
-    if $pkg_config lttng-ust --exists; then
-      lttng_ust_libs=3D$($pkg_config --libs lttng-ust)
-    else
-      lttng_ust_libs=3D"-llttng-ust -ldl"
-    fi
-    if $pkg_config liburcu-bp --exists; then
-      urcu_bp_libs=3D$($pkg_config --libs liburcu-bp)
-    else
-      urcu_bp_libs=3D"-lurcu-bp"
-    fi
-
-    LIBS=3D"$lttng_ust_libs $urcu_bp_libs $LIBS"
-  else
-    error_exit "Trace backend 'ust' missing lttng-ust header files"
-  fi
-fi
-
-##########################################
-# For 'dtrace' backend, test if 'dtrace' command is present
-if have_backend "dtrace"; then
-  if ! has 'dtrace' ; then
-    error_exit "dtrace command is not found in PATH $PATH"
-  fi
-  trace_backend_stap=3D"no"
-  if has 'stap' ; then
-    trace_backend_stap=3D"yes"
-  fi
-fi
-
-##########################################
-# check and set a backend for coroutine
-
-# We prefer ucontext, but it's not always possible. The fallback
-# is sigcontext. On Windows the only valid backend is the Windows
-# specific one.
-
-ucontext_works=3Dno
-if test "$darwin" !=3D "yes"; then
-  cat > $TMPC << EOF
-#include <ucontext.h>
-#ifdef __stub_makecontext
-#error Ignoring glibc stub makecontext which will always fail
-#endif
-int main(void) { makecontext(0, 0, 0); return 0; }
-EOF
-  if compile_prog "" "" ; then
-    ucontext_works=3Dyes
-  fi
-fi
-
-if test "$coroutine" =3D ""; then
-  if test "$mingw32" =3D "yes"; then
-    coroutine=3Dwin32
-  elif test "$ucontext_works" =3D "yes"; then
-    coroutine=3Ducontext
-  else
-    coroutine=3Dsigaltstack
-  fi
-else
-  case $coroutine in
-  windows)
-    if test "$mingw32" !=3D "yes"; then
-      error_exit "'windows' coroutine backend only valid for Windows"
-    fi
-    # Unfortunately the user visible backend name doesn't match the
-    # coroutine-*.c filename for this case, so we have to adjust it here.
-    coroutine=3Dwin32
-    ;;
-  ucontext)
-    if test "$ucontext_works" !=3D "yes"; then
-      feature_not_found "ucontext"
-    fi
-    ;;
-  sigaltstack)
-    if test "$mingw32" =3D "yes"; then
-      error_exit "only the 'windows' coroutine backend is valid for Window=
s"
-    fi
-    ;;
-  *)
-    error_exit "unknown coroutine backend $coroutine"
-    ;;
-  esac
-fi
-
-if test "$coroutine_pool" =3D ""; then
-  coroutine_pool=3Dyes
-fi
-
-if test "$debug_stack_usage" =3D "yes"; then
-  if test "$coroutine_pool" =3D "yes"; then
-    echo "WARN: disabling coroutine pool for stack usage debugging"
-    coroutine_pool=3Dno
-  fi
-fi
-
-##################################################
-# SafeStack
-
-
-if test "$safe_stack" =3D "yes"; then
-cat > $TMPC << EOF
-int main(int argc, char *argv[])
-{
-#if ! __has_feature(safe_stack)
-#error SafeStack Disabled
-#endif
-    return 0;
-}
-EOF
-  flag=3D"-fsanitize=3Dsafe-stack"
-  # Check that safe-stack is supported and enabled.
-  if compile_prog "-Werror $flag" "$flag"; then
-    # Flag needed both at compilation and at linking
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"
-    QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $flag"
-  else
-    error_exit "SafeStack not supported by your compiler"
-  fi
-  if test "$coroutine" !=3D "ucontext"; then
-    error_exit "SafeStack is only supported by the coroutine backend ucont=
ext"
-  fi
-else
-cat > $TMPC << EOF
-int main(int argc, char *argv[])
-{
-#if defined(__has_feature)
-#if __has_feature(safe_stack)
-#error SafeStack Enabled
-#endif
-#endif
-    return 0;
-}
-EOF
-if test "$safe_stack" =3D "no"; then
-  # Make sure that safe-stack is disabled
-  if ! compile_prog "-Werror" ""; then
-    # SafeStack was already enabled, try to explicitly remove the feature
-    flag=3D"-fno-sanitize=3Dsafe-stack"
-    if ! compile_prog "-Werror $flag" "$flag"; then
-      error_exit "Configure cannot disable SafeStack"
-    fi
-    QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"
-    QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $flag"
-  fi
-else # "$safe_stack" =3D ""
-  # Set safe_stack to yes or no based on pre-existing flags
-  if compile_prog "-Werror" ""; then
-    safe_stack=3D"no"
-  else
-    safe_stack=3D"yes"
-    if test "$coroutine" !=3D "ucontext"; then
-      error_exit "SafeStack is only supported by the coroutine backend uco=
ntext"
-    fi
-  fi
-fi
-fi
-
-##########################################
-# check if we have open_by_handle_at
-
-open_by_handle_at=3Dno
-cat > $TMPC << EOF
-#include <fcntl.h>
-#if !defined(AT_EMPTY_PATH)
-# error missing definition
-#else
-int main(void) { struct file_handle fh; return open_by_handle_at(0, &fh, 0=
); }
-#endif
-EOF
-if compile_prog "" "" ; then
-    open_by_handle_at=3Dyes
-fi
-
-########################################
-# check if we have linux/magic.h
-
-linux_magic_h=3Dno
-cat > $TMPC << EOF
-#include <linux/magic.h>
-int main(void) {
-  return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    linux_magic_h=3Dyes
-fi
-
-########################################
-# check if we have valgrind/valgrind.h
-
-valgrind_h=3Dno
-cat > $TMPC << EOF
-#include <valgrind/valgrind.h>
-int main(void) {
-  return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    valgrind_h=3Dyes
-fi
-
-########################################
-# check if environ is declared
-
-has_environ=3Dno
-cat > $TMPC << EOF
-#include <unistd.h>
-int main(void) {
-    environ =3D 0;
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    has_environ=3Dyes
-fi
-
-########################################
-# check if cpuid.h is usable.
-
-cat > $TMPC << EOF
-#include <cpuid.h>
-int main(void) {
-    unsigned a, b, c, d;
-    int max =3D __get_cpuid_max(0, 0);
-
-    if (max >=3D 1) {
-        __cpuid(1, a, b, c, d);
-    }
-
-    if (max >=3D 7) {
-        __cpuid_count(7, 0, a, b, c, d);
-    }
-
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    cpuid_h=3Dyes
-fi
-
-##########################################
-# avx2 optimization requirement check
-#
-# There is no point enabling this if cpuid.h is not usable,
-# since we won't be able to select the new routines.
-
-if test "$cpuid_h" =3D "yes" && test "$avx2_opt" !=3D "no"; then
-  cat > $TMPC << EOF
-#pragma GCC push_options
-#pragma GCC target("avx2")
-#include <cpuid.h>
-#include <immintrin.h>
-static int bar(void *a) {
-    __m256i x =3D *(__m256i *)a;
-    return _mm256_testz_si256(x, x);
-}
-int main(int argc, char *argv[]) { return bar(argv[0]); }
-EOF
-  if compile_object "" ; then
-    avx2_opt=3D"yes"
-  else
-    avx2_opt=3D"no"
-  fi
-fi
-
-##########################################
-# avx512f optimization requirement check
-#
-# There is no point enabling this if cpuid.h is not usable,
-# since we won't be able to select the new routines.
-# by default, it is turned off.
-# if user explicitly want to enable it, check environment
-
-if test "$cpuid_h" =3D "yes" && test "$avx512f_opt" =3D "yes"; then
-  cat > $TMPC << EOF
-#pragma GCC push_options
-#pragma GCC target("avx512f")
-#include <cpuid.h>
-#include <immintrin.h>
-static int bar(void *a) {
-    __m512i x =3D *(__m512i *)a;
-    return _mm512_test_epi64_mask(x, x);
-}
-int main(int argc, char *argv[])
-{
-	return bar(argv[0]);
-}
-EOF
-  if ! compile_object "" ; then
-    avx512f_opt=3D"no"
-  fi
-else
-  avx512f_opt=3D"no"
-fi
-
-########################################
-# check if __[u]int128_t is usable.
-
-int128=3Dno
-cat > $TMPC << EOF
-__int128_t a;
-__uint128_t b;
-int main (void) {
-  a =3D a + b;
-  b =3D a * b;
-  a =3D a * a;
-  return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    int128=3Dyes
-fi
-
-#########################################
-# See if 128-bit atomic operations are supported.
-
-atomic128=3Dno
-if test "$int128" =3D "yes"; then
-  cat > $TMPC << EOF
-int main(void)
-{
-  unsigned __int128 x =3D 0, y =3D 0;
-  y =3D __atomic_load_16(&x, 0);
-  __atomic_store_16(&x, y, 0);
-  __atomic_compare_exchange_16(&x, &y, x, 0, 0, 0);
-  return 0;
-}
-EOF
-  if compile_prog "" "" ; then
-    atomic128=3Dyes
-  fi
-fi
-
-cmpxchg128=3Dno
-if test "$int128" =3D yes && test "$atomic128" =3D no; then
-  cat > $TMPC << EOF
-int main(void)
-{
-  unsigned __int128 x =3D 0, y =3D 0;
-  __sync_val_compare_and_swap_16(&x, y, x);
-  return 0;
-}
-EOF
-  if compile_prog "" "" ; then
-    cmpxchg128=3Dyes
-  fi
-fi
-
-#########################################
-# See if 64-bit atomic operations are supported.
-# Note that without __atomic builtins, we can only
-# assume atomic loads/stores max at pointer size.
-
-cat > $TMPC << EOF
-#include <stdint.h>
-int main(void)
-{
-  uint64_t x =3D 0, y =3D 0;
-#ifdef __ATOMIC_RELAXED
-  y =3D __atomic_load_8(&x, 0);
-  __atomic_store_8(&x, y, 0);
-  __atomic_compare_exchange_8(&x, &y, x, 0, 0, 0);
-  __atomic_exchange_8(&x, y, 0);
-  __atomic_fetch_add_8(&x, y, 0);
-#else
-  typedef char is_host64[sizeof(void *) >=3D sizeof(uint64_t) ? 1 : -1];
-  __sync_lock_test_and_set(&x, y);
-  __sync_val_compare_and_swap(&x, y, 0);
-  __sync_fetch_and_add(&x, y);
-#endif
-  return 0;
-}
-EOF
-if compile_prog "" "" ; then
-  atomic64=3Dyes
-fi
-
-#########################################
-# See if --dynamic-list is supported by the linker
-ld_dynamic_list=3D"no"
-if test "$static" =3D "no" ; then
-    cat > $TMPTXT <<EOF
-{
-  foo;
-};
-EOF
-
-    cat > $TMPC <<EOF
-#include <stdio.h>
-void foo(void);
-
-void foo(void)
-{
-  printf("foo\n");
-}
-
-int main(void)
-{
-  foo();
-  return 0;
-}
-EOF
-
-    if compile_prog "" "-Wl,--dynamic-list=3D$TMPTXT" ; then
-        ld_dynamic_list=3D"yes"
-    fi
-fi
-
-#########################################
-# See if -exported_symbols_list is supported by the linker
-
-ld_exported_symbols_list=3D"no"
-if test "$static" =3D "no" ; then
-    cat > $TMPTXT <<EOF
-  _foo
-EOF
-
-    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
-        ld_exported_symbols_list=3D"yes"
-    fi
-fi
-
-if  test "$plugins" =3D "yes" &&
-    test "$ld_dynamic_list" =3D "no" &&
-    test "$ld_exported_symbols_list" =3D "no" ; then
-  error_exit \
-      "Plugin support requires dynamic linking and specifying a set of sym=
bols " \
-      "that are exported to plugins. Unfortunately your linker doesn't " \
-      "support the flag (--dynamic-list or -exported_symbols_list) used " \
-      "for this purpose. You can't build with --static."
-fi
-
-########################################
-# See if __attribute__((alias)) is supported.
-# This false for Xcode 9, but has been remedied for Xcode 10.
-# Unfortunately, travis uses Xcode 9 by default.
-
-attralias=3Dno
-cat > $TMPC << EOF
-int x =3D 1;
-extern const int y __attribute__((alias("x")));
-int main(void) { return 0; }
-EOF
-if compile_prog "" "" ; then
-    attralias=3Dyes
-fi
-
-########################################
-# check if getauxval is available.
-
-getauxval=3Dno
-cat > $TMPC << EOF
-#include <sys/auxv.h>
-int main(void) {
-  return getauxval(AT_HWCAP) =3D=3D 0;
-}
-EOF
-if compile_prog "" "" ; then
-    getauxval=3Dyes
-fi
-
-########################################
-# check if ccache is interfering with
-# semantic analysis of macros
-
-unset CCACHE_CPP2
-ccache_cpp2=3Dno
-cat > $TMPC << EOF
-static const int Z =3D 1;
-#define fn() ({ Z; })
-#define TAUT(X) ((X) =3D=3D Z)
-#define PAREN(X, Y) (X =3D=3D Y)
-#define ID(X) (X)
-int main(int argc, char *argv[])
-{
-    int x =3D 0, y =3D 0;
-    x =3D ID(x);
-    x =3D fn();
-    fn();
-    if (PAREN(x, y)) return 0;
-    if (TAUT(Z)) return 0;
-    return 0;
-}
-EOF
-
-if ! compile_object "-Werror"; then
-    ccache_cpp2=3Dyes
-fi
-
-#################################################
-# clang does not support glibc + FORTIFY_SOURCE.
-
-if test "$fortify_source" !=3D "no"; then
-  if echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
-    fortify_source=3D"no";
-  elif test -n "$cxx" && has $cxx &&
-       echo | $cxx -dM -E - | grep __clang__ >/dev/null 2>&1 ; then
-    fortify_source=3D"no";
-  else
-    fortify_source=3D"yes"
-  fi
-fi
-
-###############################################
-# Check if copy_file_range is provided by glibc
-have_copy_file_range=3Dno
-cat > $TMPC << EOF
-#include <unistd.h>
-int main(void) {
-  copy_file_range(0, NULL, 0, NULL, 0, 0);
-  return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    have_copy_file_range=3Dyes
-fi
-
-##########################################
-# check if struct fsxattr is available via linux/fs.h
-
-have_fsxattr=3Dno
-cat > $TMPC << EOF
-#include <linux/fs.h>
-struct fsxattr foo;
-int main(void) {
-  return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    have_fsxattr=3Dyes
-fi
-
-##########################################
-# check for usable membarrier system call
-if test "$membarrier" =3D "yes"; then
-    have_membarrier=3Dno
-    if test "$mingw32" =3D "yes" ; then
-        have_membarrier=3Dyes
-    elif test "$linux" =3D "yes" ; then
-        cat > $TMPC << EOF
-    #include <linux/membarrier.h>
-    #include <sys/syscall.h>
-    #include <unistd.h>
-    #include <stdlib.h>
-    int main(void) {
-        syscall(__NR_membarrier, MEMBARRIER_CMD_QUERY, 0);
-        syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0);
-	exit(0);
-    }
-EOF
-        if compile_prog "" "" ; then
-            have_membarrier=3Dyes
-        fi
-    fi
-    if test "$have_membarrier" =3D "no"; then
-      feature_not_found "membarrier" "membarrier system call not available"
-    fi
-else
-    # Do not enable it by default even for Mingw32, because it doesn't
-    # work on Wine.
-    membarrier=3Dno
-fi
-
-##########################################
-# check if rtnetlink.h exists and is useful
-have_rtnetlink=3Dno
-cat > $TMPC << EOF
-#include <linux/rtnetlink.h>
-int main(void) {
-  return IFLA_PROTO_DOWN;
-}
-EOF
-if compile_prog "" "" ; then
-    have_rtnetlink=3Dyes
-fi
-
-##########################################
-# check for usable AF_VSOCK environment
-have_af_vsock=3Dno
-cat > $TMPC << EOF
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#if !defined(AF_VSOCK)
-# error missing AF_VSOCK flag
-#endif
-#include <linux/vm_sockets.h>
-int main(void) {
-    int sock, ret;
-    struct sockaddr_vm svm;
-    socklen_t len =3D sizeof(svm);
-    sock =3D socket(AF_VSOCK, SOCK_STREAM, 0);
-    ret =3D getpeername(sock, (struct sockaddr *)&svm, &len);
-    if ((ret =3D=3D -1) && (errno =3D=3D ENOTCONN)) {
-        return 0;
-    }
-    return -1;
-}
-EOF
-if compile_prog "" "" ; then
-    have_af_vsock=3Dyes
-fi
-
-##########################################
-# check for usable AF_ALG environment
-have_afalg=3Dno
-cat > $TMPC << EOF
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <linux/if_alg.h>
-int main(void) {
-    int sock;
-    sock =3D socket(AF_ALG, SOCK_SEQPACKET, 0);
-    return sock;
-}
-EOF
-if compile_prog "" "" ; then
-    have_afalg=3Dyes
-fi
-if test "$crypto_afalg" =3D "yes"
-then
-    if test "$have_afalg" !=3D "yes"
-    then
-	error_exit "AF_ALG requested but could not be detected"
-    fi
-fi
-
-
-#################################################
-# Check to see if we have the Hypervisor framework
-if [ "$darwin" =3D "yes" ] ; then
-  cat > $TMPC << EOF
-#include <Hypervisor/hv.h>
-int main() { return 0;}
-EOF
-  if ! compile_object ""; then
-    hvf=3D'no'
-  else
-    hvf=3D'yes'
-    QEMU_LDFLAGS=3D"-framework Hypervisor $QEMU_LDFLAGS"
-  fi
-fi
-
-##########################################
-# check for sysmacros.h
-
-have_sysmacros=3Dno
-cat > $TMPC << EOF
-#include <sys/sysmacros.h>
-int main(void) {
-    return makedev(0, 0);
-}
-EOF
-if compile_prog "" "" ; then
-    have_sysmacros=3Dyes
-fi
-
-##########################################
-# check for _Static_assert()
-
-have_static_assert=3Dno
-cat > $TMPC << EOF
-_Static_assert(1, "success");
-int main(void) {
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    have_static_assert=3Dyes
-fi
-
-##########################################
-# check for utmpx.h, it is missing e.g. on OpenBSD
-
-have_utmpx=3Dno
-cat > $TMPC << EOF
-#include <utmpx.h>
-struct utmpx user_info;
-int main(void) {
-    return 0;
-}
-EOF
-if compile_prog "" "" ; then
-    have_utmpx=3Dyes
-fi
-
-##########################################
-# check for getrandom()
-
-have_getrandom=3Dno
-cat > $TMPC << EOF
-#include <sys/random.h>
-int main(void) {
-    return getrandom(0, 0, GRND_NONBLOCK);
-}
-EOF
-if compile_prog "" "" ; then
-    have_getrandom=3Dyes
-fi
-
-##########################################
-# checks for sanitizers
-
-have_asan=3Dno
-have_ubsan=3Dno
-have_asan_iface_h=3Dno
-have_asan_iface_fiber=3Dno
-
-if test "$sanitizers" =3D "yes" ; then
-  write_c_skeleton
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then
-      have_asan=3Dyes
-  fi
-
-  # we could use a simple skeleton for flags checks, but this also
-  # detect the static linking issue of ubsan, see also:
-  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84285
-  cat > $TMPC << EOF
-#include <stdlib.h>
-int main(void) {
-    void *tmp =3D malloc(10);
-    if (tmp !=3D NULL) {
-        return *(int *)(tmp + 2);
-    }
-    return 1;
-}
-EOF
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dundefined" ""; then
-      have_ubsan=3Dyes
-  fi
-
-  if check_include "sanitizer/asan_interface.h" ; then
-      have_asan_iface_h=3Dyes
-  fi
-
-  cat > $TMPC << EOF
-#include <sanitizer/asan_interface.h>
-int main(void) {
-  __sanitizer_start_switch_fiber(0, 0, 0);
-  return 0;
-}
-EOF
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" "" ; then
-      have_asan_iface_fiber=3Dyes
-  fi
-fi
-
-##########################################
-# checks for fuzzer
-if test "$fuzzing" =3D "yes" ; then
-  write_c_fuzzer_skeleton
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dfuzzer" ""; then
-    have_fuzzer=3Dyes
-  else
-    error_exit "Your compiler doesn't support -fsanitize=3Dfuzzer"
-    exit 1
-  fi
-fi
-
-# Thread sanitizer is, for now, much noisier than the other sanitizers;
-# keep it separate until that is not the case.
-if test "$tsan" =3D "yes" && test "$sanitizers" =3D "yes"; then
-  error_exit "TSAN is not supported with other sanitiziers."
-fi
-have_tsan=3Dno
-have_tsan_iface_fiber=3Dno
-if test "$tsan" =3D "yes" ; then
-  write_c_skeleton
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dthread" "" ; then
-      have_tsan=3Dyes
-  fi
-  cat > $TMPC << EOF
-#include <sanitizer/tsan_interface.h>
-int main(void) {
-  __tsan_create_fiber(0);
-  return 0;
-}
-EOF
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dthread" "" ; then
-      have_tsan_iface_fiber=3Dyes
-  fi
-fi
-
-##########################################
-# check for libpmem
-
-if test "$libpmem" !=3D "no"; then
-	if $pkg_config --exists "libpmem"; then
-		libpmem=3D"yes"
-		libpmem_libs=3D$($pkg_config --libs libpmem)
-		libpmem_cflags=3D$($pkg_config --cflags libpmem)
-		QEMU_CFLAGS=3D"$QEMU_CFLAGS $libpmem_cflags"
-	else
-		if test "$libpmem" =3D "yes" ; then
-			feature_not_found "libpmem" "Install nvml or pmdk"
-		fi
-		libpmem=3D"no"
-	fi
-fi
-
-##########################################
-# check for libdaxctl
-
-if test "$libdaxctl" !=3D "no"; then
-	if $pkg_config --atleast-version=3D57 "libdaxctl"; then
-		libdaxctl=3D"yes"
-		libdaxctl_libs=3D$($pkg_config --libs libdaxctl)
-		libdaxctl_cflags=3D$($pkg_config --cflags libdaxctl)
-		QEMU_CFLAGS=3D"$QEMU_CFLAGS $libdaxctl_cflags"
-	else
-		if test "$libdaxctl" =3D "yes" ; then
-			feature_not_found "libdaxctl" "Install libdaxctl"
-		fi
-		libdaxctl=3D"no"
-	fi
-fi
-
-##########################################
-# check for slirp
-
-# slirp is only required when building softmmu targets
-if test -z "$slirp" -a "$softmmu" !=3D "yes" ; then
-    slirp=3D"no"
-fi
-
-case "$slirp" in
-  "" | yes)
-    if $pkg_config slirp; then
-      slirp=3Dsystem
-    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; then
-      slirp=3Dgit
-    elif test -e "${source_path}/slirp/Makefile" ; then
-      slirp=3Dinternal
-    elif test -z "$slirp" ; then
-      slirp=3Dno
-    else
-      feature_not_found "slirp" "Install slirp devel or git submodule"
-    fi
-    ;;
-
-  system)
-    if ! $pkg_config slirp; then
-      feature_not_found "slirp" "Install slirp devel"
-    fi
-    ;;
-esac
-
-case "$slirp" in
-  git | internal)
-    if test "$slirp" =3D git; then
-      git_submodules=3D"${git_submodules} slirp"
-    fi
-    mkdir -p slirp
-    slirp_cflags=3D"-I${source_path}/slirp/src -I${build_path}/slirp/src"
-    slirp_libs=3D"-L${build_path}/slirp -lslirp"
-    if test "$mingw32" =3D "yes" ; then
-      slirp_libs=3D"$slirp_libs -lws2_32 -liphlpapi"
-    fi
-    ;;
-
-  system)
-    slirp_version=3D$($pkg_config --modversion slirp 2>/dev/null)
-    slirp_cflags=3D$($pkg_config --cflags slirp 2>/dev/null)
-    slirp_libs=3D$($pkg_config --libs slirp 2>/dev/null)
-    ;;
-
-  no)
-    ;;
-  *)
-    error_exit "Unknown state for slirp: $slirp"
-    ;;
-esac
-
-##########################################
-# check for usable __NR_keyctl syscall
-
-if test "$linux" =3D "yes" ; then
-
-    have_keyring=3Dno
-    cat > $TMPC << EOF
-#include <errno.h>
-#include <asm/unistd.h>
-#include <linux/keyctl.h>
-#include <unistd.h>
-int main(void) {
-    return syscall(__NR_keyctl, KEYCTL_READ, 0, NULL, NULL, 0);
-}
-EOF
-    if compile_prog "" "" ; then
-        have_keyring=3Dyes
-    fi
-fi
-if test "$secret_keyring" !=3D "no"
-then
-    if test "$have_keyring" =3D "yes"
-    then
-	secret_keyring=3Dyes
-    else
-	if test "$secret_keyring" =3D "yes"
-	then
-	    error_exit "syscall __NR_keyctl requested, \
-but not implemented on your system"
-	else
-	    secret_keyring=3Dno
-	fi
-    fi
-fi
-
-##########################################
-# check for usable keyutils.h
-
-if test "$linux" =3D "yes" ; then
-
-    have_keyutils=3Dno
-    cat > $TMPC << EOF
-#include <errno.h>
-#include <asm/unistd.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <keyutils.h>
-int main(void) {
-    return request_key("user", NULL, NULL, 0);
-}
-EOF
-    if compile_prog "" "-lkeyutils"; then
-        have_keyutils=3Dyes
-    fi
-fi
-
-
-##########################################
-# End of CC checks
-# After here, no more $cc or $ld runs
-
-write_c_skeleton
-
-if test "$gcov" =3D "yes" ; then
-  :
-elif test "$fortify_source" =3D "yes" ; then
-  QEMU_CFLAGS=3D"-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $QEMU_CFLAGS"
-  debug=3Dno
-fi
-if test "$debug_info" =3D "yes"; then
-  CFLAGS=3D"-g $CFLAGS"
-  LDFLAGS=3D"-g $LDFLAGS"
-fi
-if test "$debug" =3D "no"; then
-  CFLAGS=3D"-O2 $CFLAGS"
-fi
-
-case "$ARCH" in
-alpha)
-  # Ensure there's only a single GP
-  QEMU_CFLAGS=3D"-msmall-data $QEMU_CFLAGS"
-;;
-esac
-
-if test "$gprof" =3D "yes" ; then
-  QEMU_CFLAGS=3D"-p $QEMU_CFLAGS"
-  QEMU_LDFLAGS=3D"-p $QEMU_LDFLAGS"
-fi
-
-if test "$have_asan" =3D "yes"; then
-  QEMU_CFLAGS=3D"-fsanitize=3Daddress $QEMU_CFLAGS"
-  QEMU_LDFLAGS=3D"-fsanitize=3Daddress $QEMU_LDFLAGS"
-  if test "$have_asan_iface_h" =3D "no" ; then
-      echo "ASAN build enabled, but ASAN header missing." \
-           "Without code annotation, the report may be inferior."
-  elif test "$have_asan_iface_fiber" =3D "no" ; then
-      echo "ASAN build enabled, but ASAN header is too old." \
-           "Without code annotation, the report may be inferior."
-  fi
-fi
-if test "$have_tsan" =3D "yes" ; then
-  if test "$have_tsan_iface_fiber" =3D "yes" ; then
-    QEMU_CFLAGS=3D"-fsanitize=3Dthread $QEMU_CFLAGS"
-    QEMU_LDFLAGS=3D"-fsanitize=3Dthread $QEMU_LDFLAGS"
-  else
-    error_exit "Cannot enable TSAN due to missing fiber annotation interfa=
ce."
-  fi
-elif test "$tsan" =3D "yes" ; then
-  error_exit "Cannot enable TSAN due to missing sanitize thread interface."
-fi
-if test "$have_ubsan" =3D "yes"; then
-  QEMU_CFLAGS=3D"-fsanitize=3Dundefined $QEMU_CFLAGS"
-  QEMU_LDFLAGS=3D"-fsanitize=3Dundefined $QEMU_LDFLAGS"
-fi
-
-##########################################
-# Do we have libnfs
-if test "$libnfs" !=3D "no" ; then
-  if $pkg_config --atleast-version=3D1.9.3 libnfs; then
-    libnfs=3D"yes"
-    libnfs_libs=3D$($pkg_config --libs libnfs)
-  else
-    if test "$libnfs" =3D "yes" ; then
-      feature_not_found "libnfs" "Install libnfs devel >=3D 1.9.3"
-    fi
-    libnfs=3D"no"
-  fi
-fi
-
-##########################################
-# Do we have libudev
-if test "$libudev" !=3D "no" ; then
-  if $pkg_config libudev && test "$static" !=3D "yes"; then
-    libudev=3D"yes"
-    libudev_libs=3D$($pkg_config --libs libudev)
-  else
-    libudev=3D"no"
-  fi
-fi
-
-# Now we've finished running tests it's OK to add -Werror to the compiler =
flags
-if test "$werror" =3D "yes"; then
-    QEMU_CFLAGS=3D"-Werror $QEMU_CFLAGS"
-fi
-
-# Exclude --warn-common with TSan to suppress warnings from the TSan libra=
ries.
-if test "$solaris" =3D "no" && test "$tsan" =3D "no"; then
-    if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; =
then
-        QEMU_LDFLAGS=3D"-Wl,--warn-common $QEMU_LDFLAGS"
-    fi
-fi
-
-# test if pod2man has --utf8 option
-if pod2man --help | grep -q utf8; then
-    POD2MAN=3D"pod2man --utf8"
-else
-    POD2MAN=3D"pod2man"
-fi
-
-# Use ASLR, no-SEH and DEP if available
-if test "$mingw32" =3D "yes" ; then
-    for flag in --dynamicbase --no-seh --nxcompat; do
-        if ld_has $flag ; then
-            QEMU_LDFLAGS=3D"-Wl,$flag $QEMU_LDFLAGS"
-        fi
-    done
-fi
-
-# Disable OpenBSD W^X if available
-if test "$tcg" =3D "yes" && test "$targetos" =3D "OpenBSD"; then
-    cat > $TMPC <<EOF
-    int main(void) { return 0; }
-EOF
-    wx_ldflags=3D"-Wl,-z,wxneeded"
-    if compile_prog "" "$wx_ldflags"; then
-        QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $wx_ldflags"
-    fi
-fi
-
-qemu_confdir=3D"$sysconfdir/$qemu_suffix"
-qemu_moddir=3D"$libdir/$qemu_suffix"
-qemu_datadir=3D"$datadir/$qemu_suffix"
-qemu_docdir=3D"$docdir/$qemu_suffix"
-qemu_localedir=3D"$datadir/locale"
-qemu_icondir=3D"$datadir/icons"
-qemu_desktopdir=3D"$datadir/applications"
-
-# We can only support ivshmem if we have eventfd
-if [ "$eventfd" =3D "yes" ]; then
-  ivshmem=3Dyes
-fi
-
-if test "$softmmu" =3D yes ; then
-  if test "$linux" =3D yes; then
-    if test "$virtfs" !=3D no && test "$cap_ng" =3D yes && test "$attr" =
=3D yes ; then
-      virtfs=3Dyes
-    else
-      if test "$virtfs" =3D yes; then
-        error_exit "VirtFS requires libcap-ng devel and libattr devel"
-      fi
-      virtfs=3Dno
-    fi
-    if test "$mpath" !=3D no && test "$mpathpersist" =3D yes ; then
-      mpath=3Dyes
-    else
-      if test "$mpath" =3D yes; then
-        error_exit "Multipath requires libmpathpersist devel"
-      fi
-      mpath=3Dno
-    fi
-  else
-    if test "$virtfs" =3D yes; then
-      error_exit "VirtFS is supported only on Linux"
-    fi
-    virtfs=3Dno
-    if test "$mpath" =3D yes; then
-      error_exit "Multipath is supported only on Linux"
-    fi
-    mpath=3Dno
-  fi
-fi
-
-# Probe for guest agent support/options
-
-if [ "$guest_agent" !=3D "no" ]; then
-  if [ "$softmmu" =3D no -a "$want_tools" =3D no ] ; then
-      guest_agent=3Dno
-  elif [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" -o=
 "$mingw32" =3D "yes" ] ; then
-      guest_agent=3Dyes
-  elif [ "$guest_agent" !=3D yes ]; then
-      guest_agent=3Dno
-  else
-      error_exit "Guest agent is not supported on this platform"
-  fi
-fi
-
-# Guest agent Window MSI  package
-
-if test "$guest_agent" !=3D yes; then
-  if test "$guest_agent_msi" =3D yes; then
-    error_exit "MSI guest agent package requires guest agent enabled"
-  fi
-  guest_agent_msi=3Dno
-elif test "$mingw32" !=3D "yes"; then
-  if test "$guest_agent_msi" =3D "yes"; then
-    error_exit "MSI guest agent package is available only for MinGW Window=
s cross-compilation"
-  fi
-  guest_agent_msi=3Dno
-elif ! has wixl; then
-  if test "$guest_agent_msi" =3D "yes"; then
-    error_exit "MSI guest agent package requires wixl tool installed ( usu=
ally from msitools package )"
-  fi
-  guest_agent_msi=3Dno
-else
-  # we support qemu-ga, mingw32, and wixl: default to MSI enabled if it wa=
sn't
-  # disabled explicitly
-  if test "$guest_agent_msi" !=3D "no"; then
-    guest_agent_msi=3Dyes
-  fi
-fi
-
-if test "$guest_agent_msi" =3D "yes"; then
-  if test "$guest_agent_with_vss" =3D "yes"; then
-    QEMU_GA_MSI_WITH_VSS=3D"-D InstallVss"
-  fi
-
-  if test "$QEMU_GA_MANUFACTURER" =3D ""; then
-    QEMU_GA_MANUFACTURER=3DQEMU
-  fi
-
-  if test "$QEMU_GA_DISTRO" =3D ""; then
-    QEMU_GA_DISTRO=3DLinux
-  fi
-
-  if test "$QEMU_GA_VERSION" =3D ""; then
-      QEMU_GA_VERSION=3D$(cat $source_path/VERSION)
-  fi
-
-  QEMU_GA_MSI_MINGW_DLL_PATH=3D"-D Mingw_dlls=3D$($pkg_config --variable=
=3Dprefix glib-2.0)/bin"
-
-  case "$cpu" in
-  x86_64)
-    QEMU_GA_MSI_ARCH=3D"-a x64 -D Arch=3D64"
-    ;;
-  i386)
-    QEMU_GA_MSI_ARCH=3D"-D Arch=3D32"
-    ;;
-  *)
-    error_exit "CPU $cpu not supported for building installation package"
-    ;;
-  esac
-fi
-
-# Mac OS X ships with a broken assembler
-roms=3D
-if { test "$cpu" =3D "i386" || test "$cpu" =3D "x86_64"; } && \
-        test "$targetos" !=3D "Darwin" && test "$targetos" !=3D "SunOS" &&=
 \
-        test "$softmmu" =3D yes ; then
-    # Different host OS linkers have different ideas about the name of the=
 ELF
-    # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses the =
_fbsd
-    # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i386p=
e.
-    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
-        if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$";=
 then
-            ld_i386_emulation=3D"$emu"
-            roms=3D"optionrom"
-            break
-        fi
-    done
-fi
-
-# Only build s390-ccw bios if we're on s390x and the compiler has -march=
=3Dz900
-if test "$cpu" =3D "s390x" ; then
-  write_c_skeleton
-  if compile_prog "-march=3Dz900" ""; then
-    roms=3D"$roms s390-ccw"
-    # SLOF is required for building the s390-ccw firmware on s390x,
-    # since it is using the libnet code from SLOF for network booting.
-    if test -e "${source_path}/.git" ; then
-      git_submodules=3D"${git_submodules} roms/SLOF"
-    fi
-  fi
-fi
-
-if test $git_update =3D 'yes' ; then
-    (cd "${source_path}" && GIT=3D"$git" "./scripts/git-submodule.sh" upda=
te "$git_submodules")
-
-    if test "$fdt" =3D "git" ; then
-        if [ "$pwd_is_source_path" !=3D "y" ] ; then
-            symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-        fi
-    fi
-fi
-
-# Check that the C++ compiler exists and works with the C compiler.
-# All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the end to =
don't miss any other that could be added.
-if has $cxx; then
-    cat > $TMPC <<EOF
-int c_function(void);
-int main(void) { return c_function(); }
-EOF
-
-    compile_object
-
-    cat > $TMPCXX <<EOF
-extern "C" {
-   int c_function(void);
-}
-int c_function(void) { return 42; }
-EOF
-
-    update_cxxflags
-
-    if do_cxx $CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAG=
S; then
-        # C++ compiler $cxx works ok with C compiler $cc
-        :
-    else
-        echo "C++ compiler $cxx does not work with C compiler $cc"
-        echo "Disabling C++ specific optional code"
-        cxx=3D
-    fi
-else
-    echo "No C++ compiler available; disabling C++ specific optional code"
-    cxx=3D
-fi
-
-echo_version() {
-    if test "$1" =3D "yes" ; then
-        echo "($2)"
-    fi
-}
-
-# prepend ftd flags after all config tests are done
-QEMU_CFLAGS=3D"$fdt_cflags $QEMU_CFLAGS"
-QEMU_LDFLAGS=3D"$fdt_ldflags $QEMU_LDFLAGS"
-
-config_host_mak=3D"config-host.mak"
-
-echo "# Automatically generated by configure - do not modify" >config-all-=
disas.mak
-
-echo "# Automatically generated by configure - do not modify" > $config_ho=
st_mak
-echo >> $config_host_mak
-
-echo all: >> $config_host_mak
-echo "prefix=3D$prefix" >> $config_host_mak
-echo "bindir=3D$bindir" >> $config_host_mak
-echo "libdir=3D$libdir" >> $config_host_mak
-echo "libexecdir=3D$libexecdir" >> $config_host_mak
-echo "includedir=3D$includedir" >> $config_host_mak
-echo "sysconfdir=3D$sysconfdir" >> $config_host_mak
-echo "qemu_confdir=3D$qemu_confdir" >> $config_host_mak
-echo "qemu_datadir=3D$qemu_datadir" >> $config_host_mak
-echo "qemu_firmwarepath=3D$firmwarepath" >> $config_host_mak
-echo "qemu_moddir=3D$qemu_moddir" >> $config_host_mak
-if test "$mingw32" =3D "no" ; then
-  echo "qemu_localstatedir=3D$local_statedir" >> $config_host_mak
-fi
-echo "qemu_helperdir=3D$libexecdir" >> $config_host_mak
-echo "qemu_localedir=3D$qemu_localedir" >> $config_host_mak
-echo "qemu_icondir=3D$qemu_icondir" >> $config_host_mak
-echo "qemu_desktopdir=3D$qemu_desktopdir" >> $config_host_mak
-echo "GIT=3D$git" >> $config_host_mak
-echo "GIT_SUBMODULES=3D$git_submodules" >> $config_host_mak
-echo "GIT_UPDATE=3D$git_update" >> $config_host_mak
-
-echo "ARCH=3D$ARCH" >> $config_host_mak
-
-if test "$default_devices" =3D "yes" ; then
-  echo "CONFIG_MINIKCONF_MODE=3D--defconfig" >> $config_host_mak
-else
-  echo "CONFIG_MINIKCONF_MODE=3D--allnoconfig" >> $config_host_mak
-fi
-if test "$debug_tcg" =3D "yes" ; then
-  echo "CONFIG_DEBUG_TCG=3Dy" >> $config_host_mak
-fi
-if test "$strip_opt" =3D "yes" ; then
-  echo "STRIP=3D${strip}" >> $config_host_mak
-fi
-if test "$bigendian" =3D "yes" ; then
-  echo "HOST_WORDS_BIGENDIAN=3Dy" >> $config_host_mak
-fi
-if test "$mingw32" =3D "yes" ; then
-  echo "CONFIG_WIN32=3Dy" >> $config_host_mak
-  rc_version=3D$(cat $source_path/VERSION)
-  version_major=3D${rc_version%%.*}
-  rc_version=3D${rc_version#*.}
-  version_minor=3D${rc_version%%.*}
-  rc_version=3D${rc_version#*.}
-  version_subminor=3D${rc_version%%.*}
-  version_micro=3D0
-  echo "CONFIG_FILEVERSION=3D$version_major,$version_minor,$version_submin=
or,$version_micro" >> $config_host_mak
-  echo "CONFIG_PRODUCTVERSION=3D$version_major,$version_minor,$version_sub=
minor,$version_micro" >> $config_host_mak
-  if test "$guest_agent_with_vss" =3D "yes" ; then
-    echo "CONFIG_QGA_VSS=3Dy" >> $config_host_mak
-    echo "QGA_VSS_PROVIDER=3D$qga_vss_provider" >> $config_host_mak
-    echo "WIN_SDK=3D\"$win_sdk\"" >> $config_host_mak
-  fi
-  if test "$guest_agent_ntddscsi" =3D "yes" ; then
-    echo "CONFIG_QGA_NTDDSCSI=3Dy" >> $config_host_mak
-  fi
-  if test "$guest_agent_msi" =3D "yes"; then
-    echo "QEMU_GA_MSI_ENABLED=3Dyes" >> $config_host_mak
-    echo "QEMU_GA_MSI_MINGW_DLL_PATH=3D${QEMU_GA_MSI_MINGW_DLL_PATH}" >> $=
config_host_mak
-    echo "QEMU_GA_MSI_WITH_VSS=3D${QEMU_GA_MSI_WITH_VSS}" >> $config_host_=
mak
-    echo "QEMU_GA_MSI_ARCH=3D${QEMU_GA_MSI_ARCH}" >> $config_host_mak
-    echo "QEMU_GA_MANUFACTURER=3D${QEMU_GA_MANUFACTURER}" >> $config_host_=
mak
-    echo "QEMU_GA_DISTRO=3D${QEMU_GA_DISTRO}" >> $config_host_mak
-    echo "QEMU_GA_VERSION=3D${QEMU_GA_VERSION}" >> $config_host_mak
-  fi
-else
-  echo "CONFIG_POSIX=3Dy" >> $config_host_mak
-fi
-
-if test "$linux" =3D "yes" ; then
-  echo "CONFIG_LINUX=3Dy" >> $config_host_mak
-fi
-
-if test "$darwin" =3D "yes" ; then
-  echo "CONFIG_DARWIN=3Dy" >> $config_host_mak
-fi
-
-if test "$solaris" =3D "yes" ; then
-  echo "CONFIG_SOLARIS=3Dy" >> $config_host_mak
-fi
-if test "$haiku" =3D "yes" ; then
-  echo "CONFIG_HAIKU=3Dy" >> $config_host_mak
-fi
-if test "$static" =3D "yes" ; then
-  echo "CONFIG_STATIC=3Dy" >> $config_host_mak
-fi
-if test "$profiler" =3D "yes" ; then
-  echo "CONFIG_PROFILER=3Dy" >> $config_host_mak
-fi
-if test "$want_tools" =3D "yes" ; then
-  echo "CONFIG_TOOLS=3Dy" >> $config_host_mak
-fi
-if test "$guest_agent" =3D "yes" ; then
-  echo "CONFIG_GUEST_AGENT=3Dy" >> $config_host_mak
-fi
-if test "$slirp" !=3D "no"; then
-  echo "CONFIG_SLIRP=3Dy" >> $config_host_mak
-  echo "CONFIG_SMBD_COMMAND=3D\"$smbd\"" >> $config_host_mak
-  echo "SLIRP_CFLAGS=3D$slirp_cflags" >> $config_host_mak
-  echo "SLIRP_LIBS=3D$slirp_libs" >> $config_host_mak
-fi
-subdirs=3D
-if [ "$slirp" =3D "git" -o "$slirp" =3D "internal" ]; then
-  subdirs=3D"$subdirs slirp"
-fi
-if test "$vde" =3D "yes" ; then
-  echo "CONFIG_VDE=3Dy" >> $config_host_mak
-  echo "VDE_LIBS=3D$vde_libs" >> $config_host_mak
-fi
-if test "$netmap" =3D "yes" ; then
-  echo "CONFIG_NETMAP=3Dy" >> $config_host_mak
-fi
-if test "$l2tpv3" =3D "yes" ; then
-  echo "CONFIG_L2TPV3=3Dy" >> $config_host_mak
-fi
-if test "$gprof" =3D "yes" ; then
-  echo "CONFIG_GPROF=3Dy" >> $config_host_mak
-fi
-if test "$cap_ng" =3D "yes" ; then
-  echo "CONFIG_LIBCAP_NG=3Dy" >> $config_host_mak
-  echo "LIBCAP_NG_LIBS=3D$cap_libs" >> $config_host_mak
-fi
-echo "CONFIG_AUDIO_DRIVERS=3D$audio_drv_list" >> $config_host_mak
-for drv in $audio_drv_list; do
-    def=3DCONFIG_AUDIO_$(echo $drv | LC_ALL=3DC tr '[a-z]' '[A-Z]')
-    echo "$def=3Dy" >> $config_host_mak
-done
-if test "$alsa" =3D "yes" ; then
-    echo "CONFIG_ALSA=3Dy" >> $config_host_mak
-fi
-echo "ALSA_LIBS=3D$alsa_libs" >> $config_host_mak
-echo "ALSA_CFLAGS=3D$alsa_cflags" >> $config_host_mak
-if test "$libpulse" =3D "yes" ; then
-    echo "CONFIG_LIBPULSE=3Dy" >> $config_host_mak
-fi
-echo "PULSE_LIBS=3D$pulse_libs" >> $config_host_mak
-echo "PULSE_CFLAGS=3D$pulse_cflags" >> $config_host_mak
-echo "COREAUDIO_LIBS=3D$coreaudio_libs" >> $config_host_mak
-echo "DSOUND_LIBS=3D$dsound_libs" >> $config_host_mak
-echo "OSS_LIBS=3D$oss_libs" >> $config_host_mak
-if test "$libjack" =3D "yes" ; then
-    echo "CONFIG_LIBJACK=3Dy" >> $config_host_mak
-fi
-echo "JACK_LIBS=3D$jack_libs" >> $config_host_mak
-if test "$audio_win_int" =3D "yes" ; then
-  echo "CONFIG_AUDIO_WIN_INT=3Dy" >> $config_host_mak
-fi
-echo "CONFIG_BDRV_RW_WHITELIST=3D$block_drv_rw_whitelist" >> $config_host_=
mak
-echo "CONFIG_BDRV_RO_WHITELIST=3D$block_drv_ro_whitelist" >> $config_host_=
mak
-if test "$xfs" =3D "yes" ; then
-  echo "CONFIG_XFS=3Dy" >> $config_host_mak
-fi
-qemu_version=3D$(head $source_path/VERSION)
-echo "PKGVERSION=3D$pkgversion" >>$config_host_mak
-echo "SRC_PATH=3D$source_path" >> $config_host_mak
-echo "TARGET_DIRS=3D$target_list" >> $config_host_mak
-if [ "$docs" =3D "yes" ] ; then
-  echo "BUILD_DOCS=3Dyes" >> $config_host_mak
-fi
-if test "$modules" =3D "yes"; then
-  # $shacmd can generate a hash started with digit, which the compiler doe=
sn't
-  # like as an symbol. So prefix it with an underscore
-  echo "CONFIG_STAMP=3D_$( (echo $qemu_version; echo $pkgversion; cat $0) =
| $shacmd - | cut -f1 -d\ )" >> $config_host_mak
-  echo "CONFIG_MODULES=3Dy" >> $config_host_mak
-fi
-if test "$module_upgrades" =3D "yes"; then
-  echo "CONFIG_MODULE_UPGRADES=3Dy" >> $config_host_mak
-fi
-if test "$have_x11" =3D "yes" && test "$need_x11" =3D "yes"; then
-  echo "CONFIG_X11=3Dy" >> $config_host_mak
-  echo "X11_CFLAGS=3D$x11_cflags" >> $config_host_mak
-  echo "X11_LIBS=3D$x11_libs" >> $config_host_mak
-fi
-if test "$cocoa" =3D "yes" ; then
-  echo "CONFIG_COCOA=3Dy" >> $config_host_mak
-fi
-if test "$iconv" =3D "yes" ; then
-  echo "CONFIG_ICONV=3Dy" >> $config_host_mak
-  echo "ICONV_CFLAGS=3D$iconv_cflags" >> $config_host_mak
-  echo "ICONV_LIBS=3D$iconv_lib" >> $config_host_mak
-fi
-if test "$curses" =3D "yes" ; then
-  echo "CONFIG_CURSES=3Dy" >> $config_host_mak
-  echo "CURSES_CFLAGS=3D$curses_inc" >> $config_host_mak
-  echo "CURSES_LIBS=3D$curses_lib" >> $config_host_mak
-fi
-if test "$pipe2" =3D "yes" ; then
-  echo "CONFIG_PIPE2=3Dy" >> $config_host_mak
-fi
-if test "$accept4" =3D "yes" ; then
-  echo "CONFIG_ACCEPT4=3Dy" >> $config_host_mak
-fi
-if test "$splice" =3D "yes" ; then
-  echo "CONFIG_SPLICE=3Dy" >> $config_host_mak
-fi
-if test "$eventfd" =3D "yes" ; then
-  echo "CONFIG_EVENTFD=3Dy" >> $config_host_mak
-fi
-if test "$memfd" =3D "yes" ; then
-  echo "CONFIG_MEMFD=3Dy" >> $config_host_mak
-fi
-if test "$have_usbfs" =3D "yes" ; then
-  echo "CONFIG_USBFS=3Dy" >> $config_host_mak
-fi
-if test "$fallocate" =3D "yes" ; then
-  echo "CONFIG_FALLOCATE=3Dy" >> $config_host_mak
-fi
-if test "$fallocate_punch_hole" =3D "yes" ; then
-  echo "CONFIG_FALLOCATE_PUNCH_HOLE=3Dy" >> $config_host_mak
-fi
-if test "$fallocate_zero_range" =3D "yes" ; then
-  echo "CONFIG_FALLOCATE_ZERO_RANGE=3Dy" >> $config_host_mak
-fi
-if test "$posix_fallocate" =3D "yes" ; then
-  echo "CONFIG_POSIX_FALLOCATE=3Dy" >> $config_host_mak
-fi
-if test "$sync_file_range" =3D "yes" ; then
-  echo "CONFIG_SYNC_FILE_RANGE=3Dy" >> $config_host_mak
-fi
-if test "$fiemap" =3D "yes" ; then
-  echo "CONFIG_FIEMAP=3Dy" >> $config_host_mak
-fi
-if test "$dup3" =3D "yes" ; then
-  echo "CONFIG_DUP3=3Dy" >> $config_host_mak
-fi
-if test "$ppoll" =3D "yes" ; then
-  echo "CONFIG_PPOLL=3Dy" >> $config_host_mak
-fi
-if test "$prctl_pr_set_timerslack" =3D "yes" ; then
-  echo "CONFIG_PRCTL_PR_SET_TIMERSLACK=3Dy" >> $config_host_mak
-fi
-if test "$epoll" =3D "yes" ; then
-  echo "CONFIG_EPOLL=3Dy" >> $config_host_mak
-fi
-if test "$epoll_create1" =3D "yes" ; then
-  echo "CONFIG_EPOLL_CREATE1=3Dy" >> $config_host_mak
-fi
-if test "$sendfile" =3D "yes" ; then
-  echo "CONFIG_SENDFILE=3Dy" >> $config_host_mak
-fi
-if test "$timerfd" =3D "yes" ; then
-  echo "CONFIG_TIMERFD=3Dy" >> $config_host_mak
-fi
-if test "$setns" =3D "yes" ; then
-  echo "CONFIG_SETNS=3Dy" >> $config_host_mak
-fi
-if test "$clock_adjtime" =3D "yes" ; then
-  echo "CONFIG_CLOCK_ADJTIME=3Dy" >> $config_host_mak
-fi
-if test "$syncfs" =3D "yes" ; then
-  echo "CONFIG_SYNCFS=3Dy" >> $config_host_mak
-fi
-if test "$kcov" =3D "yes" ; then
-  echo "CONFIG_KCOV=3Dy" >> $config_host_mak
-fi
-if test "$inotify" =3D "yes" ; then
-  echo "CONFIG_INOTIFY=3Dy" >> $config_host_mak
-fi
-if test "$inotify1" =3D "yes" ; then
-  echo "CONFIG_INOTIFY1=3Dy" >> $config_host_mak
-fi
-if test "$sem_timedwait" =3D "yes" ; then
-  echo "CONFIG_SEM_TIMEDWAIT=3Dy" >> $config_host_mak
-fi
-if test "$strchrnul" =3D "yes" ; then
-  echo "HAVE_STRCHRNUL=3Dy" >> $config_host_mak
-fi
-if test "$st_atim" =3D "yes" ; then
-  echo "HAVE_STRUCT_STAT_ST_ATIM=3Dy" >> $config_host_mak
-fi
-if test "$byteswap_h" =3D "yes" ; then
-  echo "CONFIG_BYTESWAP_H=3Dy" >> $config_host_mak
-fi
-if test "$bswap_h" =3D "yes" ; then
-  echo "CONFIG_MACHINE_BSWAP_H=3Dy" >> $config_host_mak
-fi
-if test "$curl" =3D "yes" ; then
-  echo "CONFIG_CURL=3Dy" >> $config_host_mak
-  echo "CURL_CFLAGS=3D$curl_cflags" >> $config_host_mak
-  echo "CURL_LIBS=3D$curl_libs" >> $config_host_mak
-fi
-if test "$brlapi" =3D "yes" ; then
-  echo "CONFIG_BRLAPI=3Dy" >> $config_host_mak
-  echo "BRLAPI_LIBS=3D$brlapi_libs" >> $config_host_mak
-fi
-if test "$gtk" =3D "yes" ; then
-  echo "CONFIG_GTK=3Dy" >> $config_host_mak
-  echo "GTK_CFLAGS=3D$gtk_cflags" >> $config_host_mak
-  echo "GTK_LIBS=3D$gtk_libs" >> $config_host_mak
-  if test "$gtk_gl" =3D "yes" ; then
-    echo "CONFIG_GTK_GL=3Dy" >> $config_host_mak
-  fi
-fi
-if test "$gio" =3D "yes" ; then
-    echo "CONFIG_GIO=3Dy" >> $config_host_mak
-    echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
-    echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
-    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
-fi
-echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
-if test "$gnutls" =3D "yes" ; then
-  echo "CONFIG_GNUTLS=3Dy" >> $config_host_mak
-  echo "GNUTLS_CFLAGS=3D$gnutls_cflags" >> $config_host_mak
-  echo "GNUTLS_LIBS=3D$gnutls_libs" >> $config_host_mak
-fi
-if test "$gcrypt" =3D "yes" ; then
-  echo "CONFIG_GCRYPT=3Dy" >> $config_host_mak
-  if test "$gcrypt_hmac" =3D "yes" ; then
-    echo "CONFIG_GCRYPT_HMAC=3Dy" >> $config_host_mak
-  fi
-fi
-if test "$nettle" =3D "yes" ; then
-  echo "CONFIG_NETTLE=3Dy" >> $config_host_mak
-  echo "CONFIG_NETTLE_VERSION_MAJOR=3D${nettle_version%%.*}" >> $config_ho=
st_mak
-  echo "NETTLE_CFLAGS=3D$nettle_cflags" >> $config_host_mak
-  echo "NETTLE_LIBS=3D$nettle_libs" >> $config_host_mak
-fi
-if test "$qemu_private_xts" =3D "yes" ; then
-  echo "CONFIG_QEMU_PRIVATE_XTS=3Dy" >> $config_host_mak
-fi
-if test "$tasn1" =3D "yes" ; then
-  echo "CONFIG_TASN1=3Dy" >> $config_host_mak
-fi
-if test "$auth_pam" =3D "yes" ; then
-    echo "CONFIG_AUTH_PAM=3Dy" >> $config_host_mak
-fi
-if test "$have_ifaddrs_h" =3D "yes" ; then
-    echo "HAVE_IFADDRS_H=3Dy" >> $config_host_mak
-fi
-if test "$have_drm_h" =3D "yes" ; then
-  echo "HAVE_DRM_H=3Dy" >> $config_host_mak
-fi
-if test "$have_broken_size_max" =3D "yes" ; then
-    echo "HAVE_BROKEN_SIZE_MAX=3Dy" >> $config_host_mak
-fi
-if test "$have_openpty" =3D "yes" ; then
-    echo "HAVE_OPENPTY=3Dy" >> $config_host_mak
-fi
-if test "$have_sys_signal_h" =3D "yes" ; then
-    echo "HAVE_SYS_SIGNAL_H=3Dy" >> $config_host_mak
-fi
-
-# Work around a system header bug with some kernel/XFS header
-# versions where they both try to define 'struct fsxattr':
-# xfs headers will not try to redefine structs from linux headers
-# if this macro is set.
-if test "$have_fsxattr" =3D "yes" ; then
-    echo "HAVE_FSXATTR=3Dy" >> $config_host_mak
-fi
-if test "$have_copy_file_range" =3D "yes" ; then
-    echo "HAVE_COPY_FILE_RANGE=3Dy" >> $config_host_mak
-fi
-if test "$vte" =3D "yes" ; then
-  echo "CONFIG_VTE=3Dy" >> $config_host_mak
-  echo "VTE_CFLAGS=3D$vte_cflags" >> $config_host_mak
-  echo "VTE_LIBS=3D$vte_libs" >> $config_host_mak
-fi
-if test "$virglrenderer" =3D "yes" ; then
-  echo "CONFIG_VIRGL=3Dy" >> $config_host_mak
-  echo "VIRGL_CFLAGS=3D$virgl_cflags" >> $config_host_mak
-  echo "VIRGL_LIBS=3D$virgl_libs" >> $config_host_mak
-fi
-if test "$xen" =3D "yes" ; then
-  echo "CONFIG_XEN_BACKEND=3Dy" >> $config_host_mak
-  echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=3D$xen_ctrl_version" >> $config_=
host_mak
-  echo "XEN_CFLAGS=3D$xen_cflags" >> $config_host_mak
-  echo "XEN_LIBS=3D$xen_libs" >> $config_host_mak
-fi
-if test "$linux_aio" =3D "yes" ; then
-  echo "CONFIG_LINUX_AIO=3Dy" >> $config_host_mak
-fi
-if test "$linux_io_uring" =3D "yes" ; then
-  echo "CONFIG_LINUX_IO_URING=3Dy" >> $config_host_mak
-  echo "LINUX_IO_URING_CFLAGS=3D$linux_io_uring_cflags" >> $config_host_mak
-  echo "LINUX_IO_URING_LIBS=3D$linux_io_uring_libs" >> $config_host_mak
-fi
-if test "$attr" =3D "yes" ; then
-  echo "CONFIG_ATTR=3Dy" >> $config_host_mak
-  echo "LIBATTR_LIBS=3D$libattr_libs" >> $config_host_mak
-fi
-if test "$libattr" =3D "yes" ; then
-  echo "CONFIG_LIBATTR=3Dy" >> $config_host_mak
-fi
-if test "$virtfs" =3D "yes" ; then
-  echo "CONFIG_VIRTFS=3Dy" >> $config_host_mak
-fi
-if test "$mpath" =3D "yes" ; then
-  echo "CONFIG_MPATH=3Dy" >> $config_host_mak
-  if test "$mpathpersist_new_api" =3D "yes"; then
-    echo "CONFIG_MPATH_NEW_API=3Dy" >> $config_host_mak
-  fi
-fi
-if test "$vhost_scsi" =3D "yes" ; then
-  echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak
-fi
-if test "$vhost_net" =3D "yes" ; then
-  echo "CONFIG_VHOST_NET=3Dy" >> $config_host_mak
-fi
-if test "$vhost_net_user" =3D "yes" ; then
-  echo "CONFIG_VHOST_NET_USER=3Dy" >> $config_host_mak
-fi
-if test "$vhost_net_vdpa" =3D "yes" ; then
-  echo "CONFIG_VHOST_NET_VDPA=3Dy" >> $config_host_mak
-fi
-if test "$vhost_crypto" =3D "yes" ; then
-  echo "CONFIG_VHOST_CRYPTO=3Dy" >> $config_host_mak
-fi
-if test "$vhost_vsock" =3D "yes" ; then
-  echo "CONFIG_VHOST_VSOCK=3Dy" >> $config_host_mak
-  if test "$vhost_user" =3D "yes" ; then
-    echo "CONFIG_VHOST_USER_VSOCK=3Dy" >> $config_host_mak
-  fi
-fi
-if test "$vhost_kernel" =3D "yes" ; then
-  echo "CONFIG_VHOST_KERNEL=3Dy" >> $config_host_mak
-fi
-if test "$vhost_user" =3D "yes" ; then
-  echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak
-fi
-if test "$vhost_vdpa" =3D "yes" ; then
-  echo "CONFIG_VHOST_VDPA=3Dy" >> $config_host_mak
-fi
-if test "$vhost_user_fs" =3D "yes" ; then
-  echo "CONFIG_VHOST_USER_FS=3Dy" >> $config_host_mak
-fi
-if test "$blobs" =3D "yes" ; then
-  echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak
-fi
-if test "$iovec" =3D "yes" ; then
-  echo "CONFIG_IOVEC=3Dy" >> $config_host_mak
-fi
-if test "$preadv" =3D "yes" ; then
-  echo "CONFIG_PREADV=3Dy" >> $config_host_mak
-fi
-if test "$fdt" !=3D "no" ; then
-  echo "CONFIG_FDT=3Dy" >> $config_host_mak
-  echo "FDT_CFLAGS=3D$fdt_cflags" >> $config_host_mak
-  echo "FDT_LIBS=3D$fdt_ldflags $fdt_libs" >> $config_host_mak
-fi
-if test "$membarrier" =3D "yes" ; then
-  echo "CONFIG_MEMBARRIER=3Dy" >> $config_host_mak
-fi
-if test "$signalfd" =3D "yes" ; then
-  echo "CONFIG_SIGNALFD=3Dy" >> $config_host_mak
-fi
-if test "$optreset" =3D "yes" ; then
-  echo "HAVE_OPTRESET=3Dy" >> $config_host_mak
-fi
-if test "$tcg" =3D "yes"; then
-  echo "CONFIG_TCG=3Dy" >> $config_host_mak
-  if test "$tcg_interpreter" =3D "yes" ; then
-    echo "CONFIG_TCG_INTERPRETER=3Dy" >> $config_host_mak
-  fi
-fi
-if test "$fdatasync" =3D "yes" ; then
-  echo "CONFIG_FDATASYNC=3Dy" >> $config_host_mak
-fi
-if test "$madvise" =3D "yes" ; then
-  echo "CONFIG_MADVISE=3Dy" >> $config_host_mak
-fi
-if test "$posix_madvise" =3D "yes" ; then
-  echo "CONFIG_POSIX_MADVISE=3Dy" >> $config_host_mak
-fi
-if test "$posix_memalign" =3D "yes" ; then
-  echo "CONFIG_POSIX_MEMALIGN=3Dy" >> $config_host_mak
-fi
-if test "$spice" =3D "yes" ; then
-  echo "CONFIG_SPICE=3Dy" >> $config_host_mak
-  echo "SPICE_CFLAGS=3D$spice_cflags" >> $config_host_mak
-  echo "SPICE_LIBS=3D$spice_libs" >> $config_host_mak
-fi
-
-if test "$smartcard" =3D "yes" ; then
-  echo "CONFIG_SMARTCARD=3Dy" >> $config_host_mak
-  echo "SMARTCARD_CFLAGS=3D$libcacard_cflags" >> $config_host_mak
-  echo "SMARTCARD_LIBS=3D$libcacard_libs" >> $config_host_mak
-fi
-
-if test "$libusb" =3D "yes" ; then
-  echo "CONFIG_USB_LIBUSB=3Dy" >> $config_host_mak
-  echo "LIBUSB_CFLAGS=3D$libusb_cflags" >> $config_host_mak
-  echo "LIBUSB_LIBS=3D$libusb_libs" >> $config_host_mak
-fi
-
-if test "$usb_redir" =3D "yes" ; then
-  echo "CONFIG_USB_REDIR=3Dy" >> $config_host_mak
-  echo "USB_REDIR_CFLAGS=3D$usb_redir_cflags" >> $config_host_mak
-  echo "USB_REDIR_LIBS=3D$usb_redir_libs" >> $config_host_mak
-fi
-
-if test "$opengl" =3D "yes" ; then
-  echo "CONFIG_OPENGL=3Dy" >> $config_host_mak
-  echo "OPENGL_LIBS=3D$opengl_libs" >> $config_host_mak
-  if test "$opengl_dmabuf" =3D "yes" ; then
-    echo "CONFIG_OPENGL_DMABUF=3Dy" >> $config_host_mak
-  fi
-fi
-
-if test "$gbm" =3D "yes" ; then
-    echo "CONFIG_GBM=3Dy" >> $config_host_mak
-    echo "GBM_LIBS=3D$gbm_libs" >> $config_host_mak
-    echo "GBM_CFLAGS=3D$gbm_cflags" >> $config_host_mak
-fi
-
-
-if test "$malloc_trim" =3D "yes" ; then
-  echo "CONFIG_MALLOC_TRIM=3Dy" >> $config_host_mak
-fi
-
-if test "$avx2_opt" =3D "yes" ; then
-  echo "CONFIG_AVX2_OPT=3Dy" >> $config_host_mak
-fi
-
-if test "$avx512f_opt" =3D "yes" ; then
-  echo "CONFIG_AVX512F_OPT=3Dy" >> $config_host_mak
-fi
-
-if test "$lzo" =3D "yes" ; then
-  echo "CONFIG_LZO=3Dy" >> $config_host_mak
-  echo "LZO_LIBS=3D$lzo_libs" >> $config_host_mak
-fi
-
-if test "$snappy" =3D "yes" ; then
-  echo "CONFIG_SNAPPY=3Dy" >> $config_host_mak
-  echo "SNAPPY_LIBS=3D$snappy_libs" >> $config_host_mak
-fi
-
-if test "$bzip2" =3D "yes" ; then
-  echo "CONFIG_BZIP2=3Dy" >> $config_host_mak
-  echo "BZIP2_LIBS=3D-lbz2" >> $config_host_mak
-fi
-
-if test "$lzfse" =3D "yes" ; then
-  echo "CONFIG_LZFSE=3Dy" >> $config_host_mak
-  echo "LZFSE_LIBS=3D-llzfse" >> $config_host_mak
-fi
-
-if test "$zstd" =3D "yes" ; then
-  echo "CONFIG_ZSTD=3Dy" >> $config_host_mak
-  echo "ZSTD_CFLAGS=3D$zstd_cflags" >> $config_host_mak
-  echo "ZSTD_LIBS=3D$zstd_libs" >> $config_host_mak
-fi
-
-if test "$libiscsi" =3D "yes" ; then
-  echo "CONFIG_LIBISCSI=3Dy" >> $config_host_mak
-  echo "LIBISCSI_CFLAGS=3D$libiscsi_cflags" >> $config_host_mak
-  echo "LIBISCSI_LIBS=3D$libiscsi_libs" >> $config_host_mak
-fi
-
-if test "$libnfs" =3D "yes" ; then
-  echo "CONFIG_LIBNFS=3Dy" >> $config_host_mak
-  echo "LIBNFS_LIBS=3D$libnfs_libs" >> $config_host_mak
-fi
-
-if test "$seccomp" =3D "yes"; then
-  echo "CONFIG_SECCOMP=3Dy" >> $config_host_mak
-  echo "SECCOMP_CFLAGS=3D$seccomp_cflags" >> $config_host_mak
-  echo "SECCOMP_LIBS=3D$seccomp_libs" >> $config_host_mak
-fi
-
-# XXX: suppress that
-if [ "$bsd" =3D "yes" ] ; then
-  echo "CONFIG_BSD=3Dy" >> $config_host_mak
-fi
-
-if test "$localtime_r" =3D "yes" ; then
-  echo "CONFIG_LOCALTIME_R=3Dy" >> $config_host_mak
-fi
-if test "$qom_cast_debug" =3D "yes" ; then
-  echo "CONFIG_QOM_CAST_DEBUG=3Dy" >> $config_host_mak
-fi
-if test "$rbd" =3D "yes" ; then
-  echo "CONFIG_RBD=3Dy" >> $config_host_mak
-  echo "RBD_LIBS=3D$rbd_libs" >> $config_host_mak
-fi
-
-echo "CONFIG_COROUTINE_BACKEND=3D$coroutine" >> $config_host_mak
-if test "$coroutine_pool" =3D "yes" ; then
-  echo "CONFIG_COROUTINE_POOL=3D1" >> $config_host_mak
-else
-  echo "CONFIG_COROUTINE_POOL=3D0" >> $config_host_mak
-fi
-
-if test "$debug_stack_usage" =3D "yes" ; then
-  echo "CONFIG_DEBUG_STACK_USAGE=3Dy" >> $config_host_mak
-fi
-
-if test "$crypto_afalg" =3D "yes" ; then
-  echo "CONFIG_AF_ALG=3Dy" >> $config_host_mak
-fi
-
-if test "$open_by_handle_at" =3D "yes" ; then
-  echo "CONFIG_OPEN_BY_HANDLE=3Dy" >> $config_host_mak
-fi
-
-if test "$linux_magic_h" =3D "yes" ; then
-  echo "CONFIG_LINUX_MAGIC_H=3Dy" >> $config_host_mak
-fi
-
-if test "$valgrind_h" =3D "yes" ; then
-  echo "CONFIG_VALGRIND_H=3Dy" >> $config_host_mak
-fi
-
-if test "$have_asan_iface_fiber" =3D "yes" ; then
-    echo "CONFIG_ASAN_IFACE_FIBER=3Dy" >> $config_host_mak
-fi
-
-if test "$have_tsan" =3D "yes" && test "$have_tsan_iface_fiber" =3D "yes" =
; then
-    echo "CONFIG_TSAN=3Dy" >> $config_host_mak
-fi
-
-if test "$has_environ" =3D "yes" ; then
-  echo "CONFIG_HAS_ENVIRON=3Dy" >> $config_host_mak
-fi
-
-if test "$cpuid_h" =3D "yes" ; then
-  echo "CONFIG_CPUID_H=3Dy" >> $config_host_mak
-fi
-
-if test "$int128" =3D "yes" ; then
-  echo "CONFIG_INT128=3Dy" >> $config_host_mak
-fi
-
-if test "$atomic128" =3D "yes" ; then
-  echo "CONFIG_ATOMIC128=3Dy" >> $config_host_mak
-fi
-
-if test "$cmpxchg128" =3D "yes" ; then
-  echo "CONFIG_CMPXCHG128=3Dy" >> $config_host_mak
-fi
-
-if test "$atomic64" =3D "yes" ; then
-  echo "CONFIG_ATOMIC64=3Dy" >> $config_host_mak
-fi
-
-if test "$attralias" =3D "yes" ; then
-  echo "CONFIG_ATTRIBUTE_ALIAS=3Dy" >> $config_host_mak
-fi
-
-if test "$getauxval" =3D "yes" ; then
-  echo "CONFIG_GETAUXVAL=3Dy" >> $config_host_mak
-fi
-
-if test "$glusterfs" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS=3Dy" >> $config_host_mak
-  echo "GLUSTERFS_CFLAGS=3D$glusterfs_cflags" >> $config_host_mak
-  echo "GLUSTERFS_LIBS=3D$glusterfs_libs" >> $config_host_mak
-fi
-
-if test "$glusterfs_xlator_opt" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_XLATOR_OPT=3Dy" >> $config_host_mak
-fi
-
-if test "$glusterfs_discard" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_DISCARD=3Dy" >> $config_host_mak
-fi
-
-if test "$glusterfs_fallocate" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_FALLOCATE=3Dy" >> $config_host_mak
-fi
-
-if test "$glusterfs_zerofill" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak
-fi
-
-if test "$glusterfs_ftruncate_has_stat" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=3Dy" >> $config_host_mak
-fi
-
-if test "$glusterfs_iocb_has_stat" =3D "yes" ; then
-  echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak
-fi
-
-if test "$libssh" =3D "yes" ; then
-  echo "CONFIG_LIBSSH=3Dy" >> $config_host_mak
-  echo "LIBSSH_CFLAGS=3D$libssh_cflags" >> $config_host_mak
-  echo "LIBSSH_LIBS=3D$libssh_libs" >> $config_host_mak
-fi
-
-if test "$live_block_migration" =3D "yes" ; then
-  echo "CONFIG_LIVE_BLOCK_MIGRATION=3Dy" >> $config_host_mak
-fi
-
-if test "$tpm" =3D "yes"; then
-  echo 'CONFIG_TPM=3Dy' >> $config_host_mak
-fi
-
-echo "TRACE_BACKENDS=3D$trace_backends" >> $config_host_mak
-if have_backend "nop"; then
-  echo "CONFIG_TRACE_NOP=3Dy" >> $config_host_mak
-fi
-if have_backend "simple"; then
-  echo "CONFIG_TRACE_SIMPLE=3Dy" >> $config_host_mak
-  # Set the appropriate trace file.
-  trace_file=3D"\"$trace_file-\" FMT_pid"
-fi
-if have_backend "log"; then
-  echo "CONFIG_TRACE_LOG=3Dy" >> $config_host_mak
-fi
-if have_backend "ust"; then
-  echo "CONFIG_TRACE_UST=3Dy" >> $config_host_mak
-  echo "LTTNG_UST_LIBS=3D$lttng_ust_libs" >> $config_host_mak
-  echo "URCU_BP_LIBS=3D$urcu_bp_libs" >> $config_host_mak
-fi
-if have_backend "dtrace"; then
-  echo "CONFIG_TRACE_DTRACE=3Dy" >> $config_host_mak
-  if test "$trace_backend_stap" =3D "yes" ; then
-    echo "CONFIG_TRACE_SYSTEMTAP=3Dy" >> $config_host_mak
-  fi
-fi
-if have_backend "ftrace"; then
-  if test "$linux" =3D "yes" ; then
-    echo "CONFIG_TRACE_FTRACE=3Dy" >> $config_host_mak
-  else
-    feature_not_found "ftrace(trace backend)" "ftrace requires Linux"
-  fi
-fi
-if have_backend "syslog"; then
-  if test "$posix_syslog" =3D "yes" ; then
-    echo "CONFIG_TRACE_SYSLOG=3Dy" >> $config_host_mak
-  else
-    feature_not_found "syslog(trace backend)" "syslog not available"
-  fi
-fi
-echo "CONFIG_TRACE_FILE=3D$trace_file" >> $config_host_mak
-
-if test "$rdma" =3D "yes" ; then
-  echo "CONFIG_RDMA=3Dy" >> $config_host_mak
-  echo "RDMA_LIBS=3D$rdma_libs" >> $config_host_mak
-fi
-
-if test "$pvrdma" =3D "yes" ; then
-  echo "CONFIG_PVRDMA=3Dy" >> $config_host_mak
-fi
-
-if test "$have_rtnetlink" =3D "yes" ; then
-  echo "CONFIG_RTNETLINK=3Dy" >> $config_host_mak
-fi
-
-if test "$libxml2" =3D "yes" ; then
-  echo "CONFIG_LIBXML2=3Dy" >> $config_host_mak
-  echo "LIBXML2_CFLAGS=3D$libxml2_cflags" >> $config_host_mak
-  echo "LIBXML2_LIBS=3D$libxml2_libs" >> $config_host_mak
-fi
-
-if test "$replication" =3D "yes" ; then
-  echo "CONFIG_REPLICATION=3Dy" >> $config_host_mak
-fi
-
-if test "$have_af_vsock" =3D "yes" ; then
-  echo "CONFIG_AF_VSOCK=3Dy" >> $config_host_mak
-fi
-
-if test "$have_sysmacros" =3D "yes" ; then
-  echo "CONFIG_SYSMACROS=3Dy" >> $config_host_mak
-fi
-
-if test "$have_static_assert" =3D "yes" ; then
-  echo "CONFIG_STATIC_ASSERT=3Dy" >> $config_host_mak
-fi
-
-if test "$have_utmpx" =3D "yes" ; then
-  echo "HAVE_UTMPX=3Dy" >> $config_host_mak
-fi
-if test "$have_getrandom" =3D "yes" ; then
-  echo "CONFIG_GETRANDOM=3Dy" >> $config_host_mak
-fi
-if test "$ivshmem" =3D "yes" ; then
-  echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak
-fi
-if test "$capstone" !=3D "no" ; then
-  echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
-  echo "CAPSTONE_CFLAGS=3D$capstone_cflags" >> $config_host_mak
-  echo "CAPSTONE_LIBS=3D$capstone_libs" >> $config_host_mak
-fi
-if test "$debug_mutex" =3D "yes" ; then
-  echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak
-fi
-
-# Hold two types of flag:
-#   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name =
on
-#                                     a thread we have a handle to
-#   CONFIG_PTHREAD_SETNAME_NP_W_TID - A way of doing it on a particular
-#                                     platform
-if test "$pthread_setname_np_w_tid" =3D "yes" ; then
-  echo "CONFIG_THREAD_SETNAME_BYTHREAD=3Dy" >> $config_host_mak
-  echo "CONFIG_PTHREAD_SETNAME_NP_W_TID=3Dy" >> $config_host_mak
-elif test "$pthread_setname_np_wo_tid" =3D "yes" ; then
-  echo "CONFIG_THREAD_SETNAME_BYTHREAD=3Dy" >> $config_host_mak
-  echo "CONFIG_PTHREAD_SETNAME_NP_WO_TID=3Dy" >> $config_host_mak
-fi
-
-if test "$libpmem" =3D "yes" ; then
-  echo "CONFIG_LIBPMEM=3Dy" >> $config_host_mak
-  echo "LIBPMEM_LIBS=3D$libpmem_libs" >> $config_host_mak
-  echo "LIBPMEM_CFLAGS=3D$libpmem_cflags" >> $config_host_mak
-fi
-
-if test "$libdaxctl" =3D "yes" ; then
-  echo "CONFIG_LIBDAXCTL=3Dy" >> $config_host_mak
-  echo "LIBDAXCTL_LIBS=3D$libdaxctl_libs" >> $config_host_mak
-fi
-
-if test "$bochs" =3D "yes" ; then
-  echo "CONFIG_BOCHS=3Dy" >> $config_host_mak
-fi
-if test "$cloop" =3D "yes" ; then
-  echo "CONFIG_CLOOP=3Dy" >> $config_host_mak
-fi
-if test "$dmg" =3D "yes" ; then
-  echo "CONFIG_DMG=3Dy" >> $config_host_mak
-fi
-if test "$qcow1" =3D "yes" ; then
-  echo "CONFIG_QCOW1=3Dy" >> $config_host_mak
-fi
-if test "$vdi" =3D "yes" ; then
-  echo "CONFIG_VDI=3Dy" >> $config_host_mak
-fi
-if test "$vvfat" =3D "yes" ; then
-  echo "CONFIG_VVFAT=3Dy" >> $config_host_mak
-fi
-if test "$qed" =3D "yes" ; then
-  echo "CONFIG_QED=3Dy" >> $config_host_mak
-fi
-if test "$parallels" =3D "yes" ; then
-  echo "CONFIG_PARALLELS=3Dy" >> $config_host_mak
-fi
-if test "$sheepdog" =3D "yes" ; then
-  echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
-fi
-if test "$pty_h" =3D "yes" ; then
-  echo "HAVE_PTY_H=3Dy" >> $config_host_mak
-fi
-if test "$have_mlockall" =3D "yes" ; then
-  echo "HAVE_MLOCKALL=3Dy" >> $config_host_mak
-fi
-if test "$fuzzing" =3D "yes" ; then
-  QEMU_CFLAGS=3D"$QEMU_CFLAGS -fsanitize=3Dfuzzer-no-link"
-fi
-
-if test "$plugins" =3D "yes" ; then
-    echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
-    LIBS=3D"-ldl $LIBS"
-    # Copy the export object list to the build dir
-    if test "$ld_dynamic_list" =3D "yes" ; then
-	echo "CONFIG_HAS_LD_DYNAMIC_LIST=3Dyes" >> $config_host_mak
-	ld_symbols=3Dqemu-plugins-ld.symbols
-	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
-    elif test "$ld_exported_symbols_list" =3D "yes" ; then
-	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=3Dyes" >> $config_host_mak
-	ld64_symbols=3Dqemu-plugins-ld64.symbols
-	echo "# Automatically generated by configure - do not modify" > $ld64_sym=
bols
-	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g' |=
 \
-	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
-    else
-	error_exit \
-	    "If \$plugins=3Dyes, either \$ld_dynamic_list or " \
-	    "\$ld_exported_symbols_list should have been set to 'yes'."
-    fi
-fi
-
-if test -n "$gdb_bin" ; then
-    echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak
-fi
-
-if test "$secret_keyring" =3D "yes" ; then
-  echo "CONFIG_SECRET_KEYRING=3Dy" >> $config_host_mak
-  if test "$have_keyutils" =3D "yes" ; then
-    echo "CONFIG_TEST_SECRET_KEYRING=3Dy" >> $config_host_mak
-  fi
-fi
-
-if test "$tcg_interpreter" =3D "yes"; then
-  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/tci $QEMU_INCLUDES"
-elif test "$ARCH" =3D "sparc64" ; then
-  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/sparc $QEMU_INCLUDES"
-elif test "$ARCH" =3D "s390x" ; then
-  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/s390 $QEMU_INCLUDES"
-elif test "$ARCH" =3D "x86_64" || test "$ARCH" =3D "x32" ; then
-  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/i386 $QEMU_INCLUDES"
-elif test "$ARCH" =3D "ppc64" ; then
-  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/ppc $QEMU_INCLUDES"
-elif test "$ARCH" =3D "riscv32" || test "$ARCH" =3D "riscv64" ; then
-  QEMU_INCLUDES=3D"-I${source_path}/tcg/riscv $QEMU_INCLUDES"
-else
-  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/${ARCH} $QEMU_INCLUDES"
-fi
-
-echo "ROMS=3D$roms" >> $config_host_mak
-echo "MAKE=3D$make" >> $config_host_mak
-echo "INSTALL=3D$install" >> $config_host_mak
-echo "INSTALL_DIR=3D$install -d -m 0755" >> $config_host_mak
-echo "INSTALL_DATA=3D$install -c -m 0644" >> $config_host_mak
-echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
-echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
-echo "PYTHON=3D$python" >> $config_host_mak
-echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
-echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak
-echo "MESON=3D$meson" >> $config_host_mak
-echo "CC=3D$cc" >> $config_host_mak
-if $iasl -h > /dev/null 2>&1; then
-  echo "CONFIG_IASL=3D$iasl" >> $config_host_mak
-fi
-echo "CXX=3D$cxx" >> $config_host_mak
-echo "OBJCC=3D$objcc" >> $config_host_mak
-echo "AR=3D$ar" >> $config_host_mak
-echo "ARFLAGS=3D$ARFLAGS" >> $config_host_mak
-echo "AS=3D$as" >> $config_host_mak
-echo "CCAS=3D$ccas" >> $config_host_mak
-echo "CPP=3D$cpp" >> $config_host_mak
-echo "OBJCOPY=3D$objcopy" >> $config_host_mak
-echo "LD=3D$ld" >> $config_host_mak
-echo "RANLIB=3D$ranlib" >> $config_host_mak
-echo "NM=3D$nm" >> $config_host_mak
-echo "PKG_CONFIG=3D$pkg_config_exe" >> $config_host_mak
-echo "WINDRES=3D$windres" >> $config_host_mak
-echo "CFLAGS=3D$CFLAGS" >> $config_host_mak
-echo "CXXFLAGS=3D$CXXFLAGS" >> $config_host_mak
-echo "CFLAGS_NOPIE=3D$CFLAGS_NOPIE" >> $config_host_mak
-echo "QEMU_CFLAGS=3D$QEMU_CFLAGS" >> $config_host_mak
-echo "QEMU_CXXFLAGS=3D$QEMU_CXXFLAGS" >> $config_host_mak
-echo "QEMU_INCLUDES=3D$QEMU_INCLUDES" >> $config_host_mak
-echo "GLIB_CFLAGS=3D$glib_cflags" >> $config_host_mak
-echo "GLIB_LIBS=3D$glib_libs" >> $config_host_mak
-if test "$sparse" =3D "yes" ; then
-  echo "SPARSE_CFLAGS =3D -Wbitwise -Wno-transparent-union -Wno-old-initia=
lizer -Wno-non-pointer-null" >> $config_host_mak
-fi
-echo "QEMU_LDFLAGS=3D$QEMU_LDFLAGS" >> $config_host_mak
-echo "LDFLAGS_NOPIE=3D$LDFLAGS_NOPIE" >> $config_host_mak
-echo "LD_REL_FLAGS=3D$LD_REL_FLAGS" >> $config_host_mak
-echo "LD_I386_EMULATION=3D$ld_i386_emulation" >> $config_host_mak
-echo "LIBS+=3D$LIBS" >> $config_host_mak
-echo "LIBS_TOOLS+=3D$libs_tools" >> $config_host_mak
-echo "PTHREAD_LIB=3D$PTHREAD_LIB" >> $config_host_mak
-echo "EXESUF=3D$EXESUF" >> $config_host_mak
-echo "HOST_DSOSUF=3D$HOST_DSOSUF" >> $config_host_mak
-echo "LDFLAGS_SHARED=3D$LDFLAGS_SHARED" >> $config_host_mak
-echo "LIBS_QGA=3D$libs_qga" >> $config_host_mak
-echo "TASN1_LIBS=3D$tasn1_libs" >> $config_host_mak
-echo "TASN1_CFLAGS=3D$tasn1_cflags" >> $config_host_mak
-echo "POD2MAN=3D$POD2MAN" >> $config_host_mak
-if test "$gcov" =3D "yes" ; then
-  echo "CONFIG_GCOV=3Dy" >> $config_host_mak
-fi
-
-if test "$libudev" !=3D "no"; then
-    echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak
-    echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak
-fi
-if test "$fuzzing" !=3D "no"; then
-    echo "CONFIG_FUZZ=3Dy" >> $config_host_mak
-fi
-
-if test "$edk2_blobs" =3D "yes" ; then
-  echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak
-fi
-
-if test "$rng_none" =3D "yes"; then
-  echo "CONFIG_RNG_NONE=3Dy" >> $config_host_mak
-fi
-
-# use included Linux headers
-if test "$linux" =3D "yes" ; then
-  mkdir -p linux-headers
-  case "$cpu" in
-  i386|x86_64|x32)
-    linux_arch=3Dx86
-    ;;
-  ppc|ppc64|ppc64le)
-    linux_arch=3Dpowerpc
-    ;;
-  s390x)
-    linux_arch=3Ds390
-    ;;
-  aarch64)
-    linux_arch=3Darm64
-    ;;
-  mips64)
-    linux_arch=3Dmips
-    ;;
-  *)
-    # For most CPUs the kernel architecture name and QEMU CPU name match.
-    linux_arch=3D"$cpu"
-    ;;
-  esac
-    # For non-KVM architectures we will not have asm headers
-    if [ -e "$source_path/linux-headers/asm-$linux_arch" ]; then
-      symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/a=
sm
-    fi
-fi
-
-for target in $target_list; do
-target_dir=3D"$target"
-config_target_mak=3D$target_dir/config-target.mak
-target_name=3D$(echo $target | cut -d '-' -f 1)
-target_aligned_only=3D"no"
-case "$target_name" in
-  alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc=
|sparc64|sparc32plus|xtensa|xtensaeb)
-  target_aligned_only=3D"yes"
-  ;;
-esac
-target_bigendian=3D"no"
-case "$target_name" in
-  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1=
k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
-  target_bigendian=3D"yes"
-  ;;
-esac
-target_softmmu=3D"no"
-target_user_only=3D"no"
-target_linux_user=3D"no"
-target_bsd_user=3D"no"
-case "$target" in
-  ${target_name}-softmmu)
-    target_softmmu=3D"yes"
-    ;;
-  ${target_name}-linux-user)
-    target_user_only=3D"yes"
-    target_linux_user=3D"yes"
-    ;;
-  ${target_name}-bsd-user)
-    target_user_only=3D"yes"
-    target_bsd_user=3D"yes"
-    ;;
-  *)
-    error_exit "Target '$target' not recognised"
-    exit 1
-    ;;
-esac
-
-mkdir -p $target_dir
-echo "# Automatically generated by configure - do not modify" > $config_ta=
rget_mak
-
-bflt=3D"no"
-mttcg=3D"no"
-interp_prefix1=3D$(echo "$interp_prefix" | sed "s/%M/$target_name/g")
-gdb_xml_files=3D""
-
-TARGET_ARCH=3D"$target_name"
-TARGET_BASE_ARCH=3D""
-TARGET_ABI_DIR=3D""
-TARGET_SYSTBL_ABI=3D""
-TARGET_SYSTBL=3D""
-
-case "$target_name" in
-  i386)
-    mttcg=3D"yes"
-	gdb_xml_files=3D"i386-32bit.xml"
-    TARGET_SYSTBL_ABI=3Di386
-    TARGET_SYSTBL=3Dsyscall_32.tbl
-  ;;
-  x86_64)
-    TARGET_BASE_ARCH=3Di386
-    TARGET_SYSTBL_ABI=3Dcommon,64
-    TARGET_SYSTBL=3Dsyscall_64.tbl
-    mttcg=3D"yes"
-    gdb_xml_files=3D"i386-64bit.xml"
-  ;;
-  alpha)
-    mttcg=3D"yes"
-    TARGET_SYSTBL_ABI=3Dcommon
-  ;;
-  arm|armeb)
-    TARGET_ARCH=3Darm
-    TARGET_SYSTBL_ABI=3Dcommon,oabi
-    bflt=3D"yes"
-    mttcg=3D"yes"
-    gdb_xml_files=3D"arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml ar=
m-m-profile.xml"
-  ;;
-  aarch64|aarch64_be)
-    TARGET_ARCH=3Daarch64
-    TARGET_BASE_ARCH=3Darm
-    bflt=3D"yes"
-    mttcg=3D"yes"
-    gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp=
.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
-  ;;
-  avr)
-    gdb_xml_files=3D"avr-cpu.xml"
-    target_compiler=3D$cross_cc_avr
-  ;;
-  cris)
-  ;;
-  hppa)
-    mttcg=3D"yes"
-    TARGET_SYSTBL_ABI=3Dcommon,32
-  ;;
-  lm32)
-  ;;
-  m68k)
-    bflt=3D"yes"
-    gdb_xml_files=3D"cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
-    TARGET_SYSTBL_ABI=3Dcommon
-  ;;
-  microblaze|microblazeel)
-    TARGET_ARCH=3Dmicroblaze
-    TARGET_SYSTBL_ABI=3Dcommon
-    mttcg=3D"yes"
-    bflt=3D"yes"
-    echo "TARGET_ABI32=3Dy" >> $config_target_mak
-  ;;
-  mips|mipsel)
-    mttcg=3D"yes"
-    TARGET_ARCH=3Dmips
-    echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
-    TARGET_SYSTBL_ABI=3Do32
-    TARGET_SYSTBL=3Dsyscall_o32.tbl
-  ;;
-  mipsn32|mipsn32el)
-    mttcg=3D"yes"
-    TARGET_ARCH=3Dmips64
-    TARGET_BASE_ARCH=3Dmips
-    echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
-    echo "TARGET_ABI32=3Dy" >> $config_target_mak
-    TARGET_SYSTBL_ABI=3Dn32
-    TARGET_SYSTBL=3Dsyscall_n32.tbl
-  ;;
-  mips64|mips64el)
-    mttcg=3D"no"
-    TARGET_ARCH=3Dmips64
-    TARGET_BASE_ARCH=3Dmips
-    echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
-    TARGET_SYSTBL_ABI=3Dn64
-    TARGET_SYSTBL=3Dsyscall_n64.tbl
-  ;;
-  moxie)
-  ;;
-  nios2)
-  ;;
-  or1k)
-    TARGET_ARCH=3Dopenrisc
-    TARGET_BASE_ARCH=3Dopenrisc
-  ;;
-  ppc)
-    gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml power-=
spe.xml"
-    TARGET_SYSTBL_ABI=3Dcommon,nospu,32
-  ;;
-  ppc64)
-    TARGET_BASE_ARCH=3Dppc
-    TARGET_ABI_DIR=3Dppc
-    TARGET_SYSTBL_ABI=3Dcommon,nospu,64
-    mttcg=3Dyes
-    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml power-vsx.xml"
-  ;;
-  ppc64le)
-    TARGET_ARCH=3Dppc64
-    TARGET_BASE_ARCH=3Dppc
-    TARGET_ABI_DIR=3Dppc
-    TARGET_SYSTBL_ABI=3Dcommon,nospu,64
-    mttcg=3Dyes
-    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml power-vsx.xml"
-  ;;
-  ppc64abi32)
-    TARGET_ARCH=3Dppc64
-    TARGET_BASE_ARCH=3Dppc
-    TARGET_ABI_DIR=3Dppc
-    TARGET_SYSTBL_ABI=3Dcommon,nospu,32
-    echo "TARGET_ABI32=3Dy" >> $config_target_mak
-    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml power-vsx.xml"
-  ;;
-  riscv32)
-    TARGET_BASE_ARCH=3Driscv
-    TARGET_ABI_DIR=3Driscv
-    mttcg=3Dyes
-    gdb_xml_files=3D"riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-f=
pu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
-  ;;
-  riscv64)
-    TARGET_BASE_ARCH=3Driscv
-    TARGET_ABI_DIR=3Driscv
-    mttcg=3Dyes
-    gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-f=
pu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
-  ;;
-  rx)
-    TARGET_ARCH=3Drx
-    bflt=3D"yes"
-    target_compiler=3D$cross_cc_rx
-    gdb_xml_files=3D"rx-core.xml"
-  ;;
-  sh4|sh4eb)
-    TARGET_ARCH=3Dsh4
-    TARGET_SYSTBL_ABI=3Dcommon
-    bflt=3D"yes"
-  ;;
-  sparc)
-    TARGET_SYSTBL_ABI=3Dcommon,32
-  ;;
-  sparc64)
-    TARGET_BASE_ARCH=3Dsparc
-    TARGET_SYSTBL_ABI=3Dcommon,64
-  ;;
-  sparc32plus)
-    TARGET_ARCH=3Dsparc64
-    TARGET_BASE_ARCH=3Dsparc
-    TARGET_ABI_DIR=3Dsparc
-    TARGET_SYSTBL_ABI=3Dcommon,32
-    echo "TARGET_ABI32=3Dy" >> $config_target_mak
-  ;;
-  s390x)
-    TARGET_SYSTBL_ABI=3Dcommon,64
-    mttcg=3Dyes
-    gdb_xml_files=3D"s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xm=
l s390-cr.xml s390-virt.xml s390-gs.xml"
-  ;;
-  tilegx)
-  ;;
-  tricore)
-  ;;
-  unicore32)
-  ;;
-  xtensa|xtensaeb)
-    TARGET_ARCH=3Dxtensa
-    TARGET_SYSTBL_ABI=3Dcommon
-    bflt=3D"yes"
-    mttcg=3D"yes"
-  ;;
-  *)
-    error_exit "Unsupported target CPU"
-  ;;
-esac
-# TARGET_BASE_ARCH needs to be defined after TARGET_ARCH
-if [ "$TARGET_BASE_ARCH" =3D "" ]; then
-  TARGET_BASE_ARCH=3D$TARGET_ARCH
-fi
-if [ "$TARGET_SYSTBL_ABI" !=3D "" ] && [ "$TARGET_SYSTBL" =3D "" ]; then
-  TARGET_SYSTBL=3Dsyscall.tbl
-fi
-
-upper() {
-    echo "$@"| LC_ALL=3DC tr '[a-z]' '[A-Z]'
-}
-
-target_arch_name=3D"$(upper $TARGET_ARCH)"
-echo "TARGET_$target_arch_name=3Dy" >> $config_target_mak
-echo "TARGET_NAME=3D$target_name" >> $config_target_mak
-echo "TARGET_BASE_ARCH=3D$TARGET_BASE_ARCH" >> $config_target_mak
-if [ "$TARGET_ABI_DIR" =3D "" ]; then
-  TARGET_ABI_DIR=3D$TARGET_ARCH
-fi
-echo "TARGET_ABI_DIR=3D$TARGET_ABI_DIR" >> $config_target_mak
-if [ "$HOST_VARIANT_DIR" !=3D "" ]; then
-    echo "HOST_VARIANT_DIR=3D$HOST_VARIANT_DIR" >> $config_target_mak
-fi
-if [ "$TARGET_SYSTBL_ABI" !=3D "" ]; then
-    echo "TARGET_SYSTBL_ABI=3D$TARGET_SYSTBL_ABI" >> $config_target_mak
-    echo "TARGET_SYSTBL=3D$TARGET_SYSTBL" >> $config_target_mak
-fi
-
-if supported_xen_target $target; then
-    echo "CONFIG_XEN=3Dy" >> $config_target_mak
-    if test "$xen_pci_passthrough" =3D yes; then
-        echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_mak"
-    fi
-fi
-if supported_kvm_target $target; then
-    echo "CONFIG_KVM=3Dy" >> $config_target_mak
-fi
-if supported_hax_target $target; then
-    echo "CONFIG_HAX=3Dy" >> $config_target_mak
-fi
-if supported_hvf_target $target; then
-    echo "CONFIG_HVF=3Dy" >> $config_target_mak
-fi
-if supported_whpx_target $target; then
-    echo "CONFIG_WHPX=3Dy" >> $config_target_mak
-fi
-if test "$target_aligned_only" =3D "yes" ; then
-  echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
-fi
-if test "$target_bigendian" =3D "yes" ; then
-  echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
-fi
-if test "$target_softmmu" =3D "yes" ; then
-  echo "CONFIG_SOFTMMU=3Dy" >> $config_target_mak
-  if test "$mttcg" =3D "yes" ; then
-    echo "TARGET_SUPPORTS_MTTCG=3Dy" >> $config_target_mak
-  fi
-fi
-if test "$target_user_only" =3D "yes" ; then
-  echo "CONFIG_USER_ONLY=3Dy" >> $config_target_mak
-  echo "CONFIG_QEMU_INTERP_PREFIX=3D\"$interp_prefix1\"" >> $config_target=
_mak
-  symlink "../qemu-$target_name" "$target_dir/qemu-$target_name"
-else
-  symlink "../qemu-system-$target_name" "$target_dir/qemu-system-$target_n=
ame"
-fi
-if test "$target_linux_user" =3D "yes" ; then
-  echo "CONFIG_LINUX_USER=3Dy" >> $config_target_mak
-fi
-list=3D""
-if test ! -z "$gdb_xml_files" ; then
-  for x in $gdb_xml_files; do
-    list=3D"$list gdb-xml/$x"
-  done
-  echo "TARGET_XML_FILES=3D$list" >> $config_target_mak
-fi
-
-if test "$target_user_only" =3D "yes" && test "$bflt" =3D "yes"; then
-  echo "TARGET_HAS_BFLT=3Dy" >> $config_target_mak
-fi
-if test "$target_bsd_user" =3D "yes" ; then
-  echo "CONFIG_BSD_USER=3Dy" >> $config_target_mak
-fi
-
-
-# generate QEMU_CFLAGS/QEMU_LDFLAGS for targets
-
-disas_config() {
-  echo "CONFIG_${1}_DIS=3Dy" >> $config_target_mak
-  echo "CONFIG_${1}_DIS=3Dy" >> config-all-disas.mak
-}
-
-for i in $ARCH $TARGET_BASE_ARCH ; do
-  case "$i" in
-  alpha)
-    disas_config "ALPHA"
-  ;;
-  aarch64)
-    if test -n "${cxx}"; then
-      disas_config "ARM_A64"
-    fi
-  ;;
-  arm)
-    disas_config "ARM"
-    if test -n "${cxx}"; then
-      disas_config "ARM_A64"
-    fi
-  ;;
-  avr)
-    disas_config "AVR"
-  ;;
-  cris)
-    disas_config "CRIS"
-  ;;
-  hppa)
-    disas_config "HPPA"
-  ;;
-  i386|x86_64|x32)
-    disas_config "I386"
-  ;;
-  lm32)
-    disas_config "LM32"
-  ;;
-  m68k)
-    disas_config "M68K"
-  ;;
-  microblaze*)
-    disas_config "MICROBLAZE"
-  ;;
-  mips*)
-    disas_config "MIPS"
-    if test -n "${cxx}"; then
-      disas_config "NANOMIPS"
-    fi
-  ;;
-  moxie*)
-    disas_config "MOXIE"
-  ;;
-  nios2)
-    disas_config "NIOS2"
-  ;;
-  or1k)
-    disas_config "OPENRISC"
-  ;;
-  ppc*)
-    disas_config "PPC"
-  ;;
-  riscv*)
-    disas_config "RISCV"
-  ;;
-  rx)
-    disas_config "RX"
-  ;;
-  s390*)
-    disas_config "S390"
-  ;;
-  sh4)
-    disas_config "SH4"
-  ;;
-  sparc*)
-    disas_config "SPARC"
-  ;;
-  xtensa*)
-    disas_config "XTENSA"
-  ;;
-  esac
-done
-if test "$tcg_interpreter" =3D "yes" ; then
-  disas_config "TCI"
-fi
-
-done # for target in $targets
-
-if [ "$fdt" =3D "git" ]; then
-  subdirs=3D"$subdirs dtc"
-fi
-if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
-  subdirs=3D"$subdirs capstone"
-fi
-echo "SUBDIRS=3D$subdirs" >> $config_host_mak
-if test -n "$LIBCAPSTONE"; then
-  echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak
-fi
-
-if test "$numa" =3D "yes"; then
-  echo "CONFIG_NUMA=3Dy" >> $config_host_mak
-  echo "NUMA_LIBS=3D$numa_libs" >> $config_host_mak
-fi
-
-if test "$ccache_cpp2" =3D "yes"; then
-  echo "export CCACHE_CPP2=3Dy" >> $config_host_mak
-fi
-
-if test "$safe_stack" =3D "yes"; then
-  echo "CONFIG_SAFESTACK=3Dy" >> $config_host_mak
-fi
-
-# If we're using a separate build tree, set it up now.
-# DIRS are directories which we simply mkdir in the build tree;
-# LINKS are things to symlink back into the source tree
-# (these can be both files and directories).
-# Caution: do not add files or directories here using wildcards. This
-# will result in problems later if a new file matching the wildcard is
-# added to the source tree -- nothing will cause configure to be rerun
-# so the build tree will be missing the link back to the new file, and
-# tests might fail. Prefer to keep the relevant files in their own
-# directory and symlink the directory instead.
-DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/qapi-schema tests/qtest/libqo=
s"
-DIRS=3D"$DIRS tests/qtest tests/qemu-iotests tests/vm tests/fp tests/qgrap=
h"
-DIRS=3D"$DIRS docs docs/interop fsdev scsi"
-DIRS=3D"$DIRS pc-bios/optionrom pc-bios/s390-ccw"
-DIRS=3D"$DIRS roms/seabios"
-LINKS=3D"Makefile"
-LINKS=3D"$LINKS tests/tcg/lm32/Makefile"
-LINKS=3D"$LINKS tests/tcg/Makefile.target"
-LINKS=3D"$LINKS pc-bios/optionrom/Makefile"
-LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"
-LINKS=3D"$LINKS roms/seabios/Makefile"
-LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"
-LINKS=3D"$LINKS .gdbinit scripts" # scripts needed by relative path in .gd=
binit
-LINKS=3D"$LINKS tests/acceptance tests/data"
-LINKS=3D"$LINKS tests/qemu-iotests/check"
-LINKS=3D"$LINKS python"
-for bios_file in \
-    $source_path/pc-bios/*.bin \
-    $source_path/pc-bios/*.elf \
-    $source_path/pc-bios/*.lid \
-    $source_path/pc-bios/*.rom \
-    $source_path/pc-bios/*.dtb \
-    $source_path/pc-bios/*.img \
-    $source_path/pc-bios/openbios-* \
-    $source_path/pc-bios/u-boot.* \
-    $source_path/pc-bios/edk2-*.fd.bz2 \
-    $source_path/pc-bios/palcode-*
-do
-    LINKS=3D"$LINKS pc-bios/$(basename $bios_file)"
-done
-mkdir -p $DIRS
-for f in $LINKS ; do
-    if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" !=3D "y" ]; then
-        symlink "$source_path/$f" "$f"
-    fi
-done
-
-(for i in $cross_cc_vars; do
-  export $i
-done
-export target_list source_path use_containers
-$source_path/tests/tcg/configure.sh)
-
-# temporary config to build submodules
-for rom in seabios; do
-    config_mak=3Droms/$rom/config.mak
-    echo "# Automatically generated by configure - do not modify" > $confi=
g_mak
-    echo "SRC_PATH=3D$source_path/roms/$rom" >> $config_mak
-    echo "AS=3D$as" >> $config_mak
-    echo "CCAS=3D$ccas" >> $config_mak
-    echo "CC=3D$cc" >> $config_mak
-    echo "BCC=3Dbcc" >> $config_mak
-    echo "CPP=3D$cpp" >> $config_mak
-    echo "OBJCOPY=3Dobjcopy" >> $config_mak
-    echo "IASL=3D$iasl" >> $config_mak
-    echo "LD=3D$ld" >> $config_mak
-    echo "RANLIB=3D$ranlib" >> $config_mak
-done
-
-# set up qemu-iotests in this build directory
-iotests_common_env=3D"tests/qemu-iotests/common.env"
-
-echo "# Automatically generated by configure - do not modify" > "$iotests_=
common_env"
-echo >> "$iotests_common_env"
-echo "export PYTHON=3D'$python'" >> "$iotests_common_env"
-
-if test "$skip_meson" =3D no; then
-cross=3D"config-meson.cross.new"
-meson_quote() {
-    echo "['$(echo $* | sed "s/ /','/g")']"
-}
-
-echo "# Automatically generated by configure - do not modify" > $cross
-echo "[properties]" >> $cross
-test -z "$cxx" && echo "link_language =3D 'c'" >> $cross
-echo "[binaries]" >> $cross
-echo "c =3D $(meson_quote $cc)" >> $cross
-test -n "$cxx" && echo "cpp =3D $(meson_quote $cxx)" >> $cross
-echo "ar =3D $(meson_quote $ar)" >> $cross
-echo "nm =3D $(meson_quote $nm)" >> $cross
-echo "pkgconfig =3D $(meson_quote $pkg_config_exe)" >> $cross
-echo "ranlib =3D $(meson_quote $ranlib)" >> $cross
-echo "strip =3D $(meson_quote $strip)" >> $cross
-echo "windres =3D $(meson_quote $windres)" >> $cross
-if test -n "$cross_prefix"; then
-    cross_arg=3D"--cross-file config-meson.cross"
-    # Hack: Meson expects an absolute path for the *build* machine
-    # for the prefix, so add a slash in front of a Windows path that
-    # includes a drive letter.
-    #
-    # See https://github.com/mesonbuild/meson/issues/7577.
-    echo "[host_machine]" >> $cross
-    if test "$mingw32" =3D "yes" ; then
-        echo "system =3D 'windows'" >> $cross
-        case $prefix in
-            ?:*) pre_prefix=3D/ ;;
-        esac
-    fi
-    case "$ARCH" in
-        i386|x86_64)
-            echo "cpu_family =3D 'x86'" >> $cross
-            ;;
-        ppc64le)
-            echo "cpu_family =3D 'ppc64'" >> $cross
-            ;;
-        *)
-            echo "cpu_family =3D '$ARCH'" >> $cross
-            ;;
-    esac
-    echo "cpu =3D '$cpu'" >> $cross
-    if test "$bigendian" =3D "yes" ; then
-        echo "endian =3D 'big'" >> $cross
-    else
-        echo "endian =3D 'little'" >> $cross
-    fi
-else
-    cross_arg=3D"--native-file config-meson.cross"
-fi
-mv $cross config-meson.cross
-
-rm -rf meson-private meson-info meson-logs
-NINJA=3D${ninja:-${build_path}/ninjatool} $meson setup \
-        --prefix "${pre_prefix}$prefix" \
-        --libdir "${pre_prefix}$libdir" \
-        --libexecdir "${pre_prefix}$libexecdir" \
-        --bindir "${pre_prefix}$bindir" \
-        --includedir "${pre_prefix}$includedir" \
-        --datadir "${pre_prefix}$datadir" \
-        --mandir "${pre_prefix}$mandir" \
-        --sysconfdir "${pre_prefix}$sysconfdir" \
-        --localstatedir "${pre_prefix}$local_statedir" \
-        -Ddocdir=3D"${pre_prefix}$docdir" \
-        -Dqemu_suffix=3D"$qemu_suffix" \
-        -Doptimization=3D$(if test "$debug" =3D yes; then echo 0; else ech=
o 2; fi) \
-        -Ddebug=3D$(if test "$debug_info" =3D yes; then echo true; else ec=
ho false; fi) \
-        -Dwerror=3D$(if test "$werror" =3D yes; then echo true; else echo =
false; fi) \
-        -Dstrip=3D$(if test "$strip_opt" =3D yes; then echo true; else ech=
o false; fi) \
-        -Db_pie=3D$(if test "$pie" =3D yes; then echo true; else echo fals=
e; fi) \
-        -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; else ech=
o false; fi) \
-	-Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
-	-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D$v=
nc_png \
-	-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
-        $cross_arg \
-        "$build_path" "$source_path"
-
-if test "$?" -ne 0 ; then
-    error_exit "meson setup failed"
-fi
-touch ninjatool.stamp
-fi
-
-# Save the configure command line for later reuse.
-cat <<EOD >config.status
-#!/bin/sh
-# Generated by configure.
-# Run this file to recreate the current configuration.
-# Compiler output produced by configure, useful for debugging
-# configure, is in config.log if it exists.
-EOD
-
-preserve_env() {
-    envname=3D$1
-
-    eval envval=3D\$$envname
-
-    if test -n "$envval"
-    then
-	echo "$envname=3D'$envval'" >> config.status
-	echo "export $envname" >> config.status
-    else
-	echo "unset $envname" >> config.status
-    fi
-}
-
-# Preserve various env variables that influence what
-# features/build target configure will detect
-preserve_env AR
-preserve_env AS
-preserve_env CC
-preserve_env CPP
-preserve_env CXX
-preserve_env INSTALL
-preserve_env LD
-preserve_env LD_LIBRARY_PATH
-preserve_env LIBTOOL
-preserve_env MAKE
-preserve_env NM
-preserve_env OBJCOPY
-preserve_env PATH
-preserve_env PKG_CONFIG
-preserve_env PKG_CONFIG_LIBDIR
-preserve_env PKG_CONFIG_PATH
-preserve_env PYTHON
-preserve_env SDL2_CONFIG
-preserve_env SMBD
-preserve_env STRIP
-preserve_env WINDRES
-
-printf "exec" >>config.status
-for i in "$0" "$@"; do
-  test "$i" =3D --skip-meson || printf " '%s'" "$i" >>config.status
-done
-echo ' "$@"' >>config.status
-chmod +x config.status
-
-rm -r "$TMPDIR1"
+#!/bin/sh=0D
+#=0D
+# qemu configure script (c) 2003 Fabrice Bellard=0D
+#=0D
+=0D
+# Unset some variables known to interfere with behavior of common tools,=0D
+# just as autoconf does.=0D
+CLICOLOR_FORCE=3D GREP_OPTIONS=3D=0D
+unset CLICOLOR_FORCE GREP_OPTIONS=0D
+=0D
+# Don't allow CCACHE, if present, to use cached results of compile tests!=
=0D
+export CCACHE_RECACHE=3Dyes=0D
+=0D
+# make source path absolute=0D
+source_path=3D$(cd "$(dirname -- "$0")"; pwd)=0D
+build_path=3D$PWD=0D
+if [ "$MSYSTEM" =3D "MINGW64" -o  "$MSYSTEM" =3D "MINGW32" ]; then=0D
+source_path=3D$(cd "$(dirname -- "$0")"; pwd -W)=0D
+build_path=3D`pwd -W`=0D
+fi=0D
+=0D
+if test "$build_path" =3D "$source_path"=0D
+then=0D
+    echo "Using './build' as the directory for build output"=0D
+=0D
+    MARKER=3Dbuild/auto-created-by-configure=0D
+=0D
+    if test -e build=0D
+    then=0D
+        if test -f $MARKER=0D
+        then=0D
+           rm -rf build=0D
+        else=0D
+            echo "ERROR: ./build dir already exists and was not previously=
 created by configure"=0D
+            exit 1=0D
+        fi=0D
+    fi=0D
+=0D
+    mkdir build=0D
+    touch $MARKER=0D
+=0D
+    cat > GNUmakefile <<'EOF'=0D
+# This file is auto-generated by configure to support in-source tree=0D
+# 'make' command invocation=0D
+=0D
+ifeq ($(MAKECMDGOALS),)=0D
+recurse: all=0D
+endif=0D
+=0D
+.NOTPARALLEL: %=0D
+%: force=0D
+	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'=0D
+	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)=0D
+	@if test "$(MAKECMDGOALS)" =3D "distclean" && \=0D
+	    test -e build/auto-created-by-configure ; \=0D
+	then \=0D
+	    rm -rf build GNUmakefile ; \=0D
+	fi=0D
+force: ;=0D
+.PHONY: force=0D
+GNUmakefile: ;=0D
+=0D
+EOF=0D
+    cd build=0D
+    exec $source_path/configure "$@"=0D
+fi=0D
+=0D
+# Temporary directory used for files created while=0D
+# configure runs. Since it is in the build directory=0D
+# we can safely blow away any previous version of it=0D
+# (and we need not jump through hoops to try to delete=0D
+# it when configure exits.)=0D
+TMPDIR1=3D"config-temp"=0D
+rm -rf "${TMPDIR1}"=0D
+mkdir -p "${TMPDIR1}"=0D
+if [ $? -ne 0 ]; then=0D
+    echo "ERROR: failed to create temporary directory"=0D
+    exit 1=0D
+fi=0D
+=0D
+TMPB=3D"qemu-conf"=0D
+TMPC=3D"${TMPDIR1}/${TMPB}.c"=0D
+TMPO=3D"${TMPDIR1}/${TMPB}.o"=0D
+TMPCXX=3D"${TMPDIR1}/${TMPB}.cxx"=0D
+TMPE=3D"${TMPDIR1}/${TMPB}.exe"=0D
+TMPTXT=3D"${TMPDIR1}/${TMPB}.txt"=0D
+=0D
+rm -f config.log=0D
+=0D
+# Print a helpful header at the top of config.log=0D
+echo "# QEMU configure log $(date)" >> config.log=0D
+printf "# Configured with:" >> config.log=0D
+printf " '%s'" "$0" "$@" >> config.log=0D
+echo >> config.log=0D
+echo "#" >> config.log=0D
+=0D
+print_error() {=0D
+    (echo=0D
+    echo "ERROR: $1"=0D
+    while test -n "$2"; do=0D
+        echo "       $2"=0D
+        shift=0D
+    done=0D
+    echo) >&2=0D
+}=0D
+=0D
+error_exit() {=0D
+    print_error "$@"=0D
+    exit 1=0D
+}=0D
+=0D
+do_compiler() {=0D
+    # Run the compiler, capturing its output to the log. First argument=0D
+    # is compiler binary to execute.=0D
+    local compiler=3D"$1"=0D
+    shift=0D
+    if test -n "$BASH_VERSION"; then eval '=0D
+        echo >>config.log "=0D
+funcs: ${FUNCNAME[*]}=0D
+lines: ${BASH_LINENO[*]}"=0D
+    '; fi=0D
+    echo $compiler "$@" >> config.log=0D
+    $compiler "$@" >> config.log 2>&1 || return $?=0D
+    # Test passed. If this is an --enable-werror build, rerun=0D
+    # the test with -Werror and bail out if it fails. This=0D
+    # makes warning-generating-errors in configure test code=0D
+    # obvious to developers.=0D
+    if test "$werror" !=3D "yes"; then=0D
+        return 0=0D
+    fi=0D
+    # Don't bother rerunning the compile if we were already using -Werror=
=0D
+    case "$*" in=0D
+        *-Werror*)=0D
+           return 0=0D
+        ;;=0D
+    esac=0D
+    echo $compiler -Werror "$@" >> config.log=0D
+    $compiler -Werror "$@" >> config.log 2>&1 && return $?=0D
+    error_exit "configure test passed without -Werror but failed with -Wer=
ror." \=0D
+        "This is probably a bug in the configure script. The failing comma=
nd" \=0D
+        "will be at the bottom of config.log." \=0D
+        "You can run configure with --disable-werror to bypass this check.=
"=0D
+}=0D
+=0D
+do_cc() {=0D
+    do_compiler "$cc" "$@"=0D
+}=0D
+=0D
+do_cxx() {=0D
+    do_compiler "$cxx" "$@"=0D
+}=0D
+=0D
+# Append $2 to the variable named $1, with space separation=0D
+add_to() {=0D
+    eval $1=3D\${$1:+\"\$$1 \"}\$2=0D
+}=0D
+=0D
+update_cxxflags() {=0D
+    # Set QEMU_CXXFLAGS from QEMU_CFLAGS by filtering out those=0D
+    # options which some versions of GCC's C++ compiler complain about=0D
+    # because they only make sense for C programs.=0D
+    QEMU_CXXFLAGS=3D"$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTAN=
T_MACROS -D__STDC_FORMAT_MACROS"=0D
+    CXXFLAGS=3D$(echo "$CFLAGS" | sed s/-std=3Dgnu99/-std=3Dgnu++11/)=0D
+    for arg in $QEMU_CFLAGS; do=0D
+        case $arg in=0D
+            -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\=0D
+            -Wold-style-declaration|-Wold-style-definition|-Wredundant-dec=
ls)=0D
+                ;;=0D
+            *)=0D
+                QEMU_CXXFLAGS=3D${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg=0D
+                ;;=0D
+        esac=0D
+    done=0D
+}=0D
+=0D
+compile_object() {=0D
+  local_cflags=3D"$1"=0D
+  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC=0D
+}=0D
+=0D
+compile_prog() {=0D
+  local_cflags=3D"$1"=0D
+  local_ldflags=3D"$2"=0D
+  do_cc $CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC $LDFLAGS $QEMU_L=
DFLAGS $local_ldflags=0D
+}=0D
+=0D
+# symbolically link $1 to $2.  Portable version of "ln -sf".=0D
+symlink() {=0D
+  rm -rf "$2"=0D
+  mkdir -p "$(dirname "$2")"=0D
+  ln -s "$1" "$2"=0D
+}=0D
+=0D
+# check whether a command is available to this shell (may be either an=0D
+# executable or a builtin)=0D
+has() {=0D
+    type "$1" >/dev/null 2>&1=0D
+}=0D
+=0D
+# search for an executable in PATH=0D
+path_of() {=0D
+    local_command=3D"$1"=0D
+    local_ifs=3D"$IFS"=0D
+    local_dir=3D""=0D
+=0D
+    # pathname has a dir component?=0D
+    if [ "${local_command#*/}" !=3D "$local_command" ]; then=0D
+        if [ -x "$local_command" ] && [ ! -d "$local_command" ]; then=0D
+            echo "$local_command"=0D
+            return 0=0D
+        fi=0D
+    fi=0D
+    if [ -z "$local_command" ]; then=0D
+        return 1=0D
+    fi=0D
+=0D
+    IFS=3D:=0D
+    for local_dir in $PATH; do=0D
+        if [ -x "$local_dir/$local_command" ] && [ ! -d "$local_dir/$local=
_command" ]; then=0D
+            echo "$local_dir/$local_command"=0D
+            IFS=3D"${local_ifs:-$(printf ' \t\n')}"=0D
+            return 0=0D
+        fi=0D
+    done=0D
+    # not found=0D
+    IFS=3D"${local_ifs:-$(printf ' \t\n')}"=0D
+    return 1=0D
+}=0D
+=0D
+version_ge () {=0D
+    local_ver1=3D`echo $1 | tr . ' '`=0D
+    local_ver2=3D`echo $2 | tr . ' '`=0D
+    while true; do=0D
+        set x $local_ver1=0D
+        local_first=3D${2-0}=0D
+        # 'shift 2' if $2 is set, or 'shift' if $2 is not set=0D
+        shift ${2:+2}=0D
+        local_ver1=3D$*=0D
+        set x $local_ver2=0D
+        # the second argument finished, the first must be greater or equal=
=0D
+        test $# =3D 1 && return 0=0D
+        test $local_first -lt $2 && return 1=0D
+        test $local_first -gt $2 && return 0=0D
+        shift ${2:+2}=0D
+        local_ver2=3D$*=0D
+    done=0D
+}=0D
+=0D
+have_backend () {=0D
+    echo "$trace_backends" | grep "$1" >/dev/null=0D
+}=0D
+=0D
+glob() {=0D
+    eval test -z '"${1#'"$2"'}"'=0D
+}=0D
+=0D
+supported_hax_target() {=0D
+    test "$hax" =3D "yes" || return 1=0D
+    glob "$1" "*-softmmu" || return 1=0D
+    case "${1%-softmmu}" in=0D
+        i386|x86_64)=0D
+            return 0=0D
+        ;;=0D
+    esac=0D
+    return 1=0D
+}=0D
+=0D
+supported_kvm_target() {=0D
+    test "$kvm" =3D "yes" || return 1=0D
+    glob "$1" "*-softmmu" || return 1=0D
+    case "${1%-softmmu}:$cpu" in=0D
+        arm:arm | aarch64:aarch64 | \=0D
+        i386:i386 | i386:x86_64 | i386:x32 | \=0D
+        x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \=0D
+        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \=0D
+        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \=
=0D
+        s390x:s390x)=0D
+            return 0=0D
+        ;;=0D
+    esac=0D
+    return 1=0D
+}=0D
+=0D
+supported_xen_target() {=0D
+    test "$xen" =3D "yes" || return 1=0D
+    glob "$1" "*-softmmu" || return 1=0D
+    # Only i386 and x86_64 provide the xenpv machine.=0D
+    case "${1%-softmmu}" in=0D
+        i386|x86_64)=0D
+            return 0=0D
+        ;;=0D
+    esac=0D
+    return 1=0D
+}=0D
+=0D
+supported_hvf_target() {=0D
+    test "$hvf" =3D "yes" || return 1=0D
+    glob "$1" "*-softmmu" || return 1=0D
+    case "${1%-softmmu}" in=0D
+        x86_64)=0D
+            return 0=0D
+        ;;=0D
+    esac=0D
+    return 1=0D
+}=0D
+=0D
+supported_whpx_target() {=0D
+    test "$whpx" =3D "yes" || return 1=0D
+    glob "$1" "*-softmmu" || return 1=0D
+    case "${1%-softmmu}" in=0D
+        i386|x86_64)=0D
+            return 0=0D
+        ;;=0D
+    esac=0D
+    return 1=0D
+}=0D
+=0D
+supported_target() {=0D
+    case "$1" in=0D
+        *-softmmu)=0D
+            ;;=0D
+        *-linux-user)=0D
+            if test "$linux" !=3D "yes"; then=0D
+                print_error "Target '$target' is only available on a Linux=
 host"=0D
+                return 1=0D
+            fi=0D
+            ;;=0D
+        *-bsd-user)=0D
+            if test "$bsd" !=3D "yes"; then=0D
+                print_error "Target '$target' is only available on a BSD h=
ost"=0D
+                return 1=0D
+            fi=0D
+            ;;=0D
+        *)=0D
+            print_error "Invalid target name '$target'"=0D
+            return 1=0D
+            ;;=0D
+    esac=0D
+    test "$tcg" =3D "yes" && return 0=0D
+    supported_kvm_target "$1" && return 0=0D
+    supported_xen_target "$1" && return 0=0D
+    supported_hax_target "$1" && return 0=0D
+    supported_hvf_target "$1" && return 0=0D
+    supported_whpx_target "$1" && return 0=0D
+    print_error "TCG disabled, but hardware accelerator not available for =
'$target'"=0D
+    return 1=0D
+}=0D
+=0D
+=0D
+ld_has() {=0D
+    $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1=0D
+}=0D
+=0D
+check_valid_build_path=3D"[[:space:]:]"=0D
+if [ "$MSYSTEM" =3D "MINGW64" -o  "$MSYSTEM" =3D "MINGW32" ]; then=0D
+check_valid_build_path=3D"[[:space:]]"=0D
+fi=0D
+=0D
+if printf %s\\n "$source_path" "$build_path" | grep -q "$check_valid_build=
_path";=0D
+then=0D
+  error_exit "main directory cannot contain spaces nor colons"=0D
+fi=0D
+=0D
+# default parameters=0D
+cpu=3D""=0D
+iasl=3D"iasl"=0D
+interp_prefix=3D"/usr/gnemul/qemu-%M"=0D
+static=3D"no"=0D
+cross_prefix=3D""=0D
+audio_drv_list=3D""=0D
+block_drv_rw_whitelist=3D""=0D
+block_drv_ro_whitelist=3D""=0D
+host_cc=3D"cc"=0D
+libs_tools=3D""=0D
+audio_win_int=3D""=0D
+libs_qga=3D""=0D
+debug_info=3D"yes"=0D
+stack_protector=3D""=0D
+safe_stack=3D""=0D
+use_containers=3D"yes"=0D
+gdb_bin=3D$(command -v "gdb-multiarch" || command -v "gdb")=0D
+=0D
+if test -e "$source_path/.git"=0D
+then=0D
+    git_update=3Dyes=0D
+    git_submodules=3D"ui/keycodemapdb"=0D
+    git_submodules=3D"$git_submodules tests/fp/berkeley-testfloat-3"=0D
+    git_submodules=3D"$git_submodules tests/fp/berkeley-softfloat-3"=0D
+else=0D
+    git_update=3Dno=0D
+    git_submodules=3D""=0D
+=0D
+    if ! test -f "$source_path/ui/keycodemapdb/README"=0D
+    then=0D
+        echo=0D
+        echo "ERROR: missing file $source_path/ui/keycodemapdb/README"=0D
+        echo=0D
+        echo "This is not a GIT checkout but module content appears to"=0D
+        echo "be missing. Do not use 'git archive' or GitHub download link=
s"=0D
+        echo "to acquire QEMU source archives. Non-GIT builds are only"=0D
+        echo "supported with source archives linked from:"=0D
+        echo=0D
+        echo "  https://www.qemu.org/download/#source"=0D
+        echo=0D
+        echo "Developers working with GIT can use scripts/archive-source.s=
h"=0D
+        echo "if they need to create valid source archives."=0D
+        echo=0D
+        exit 1=0D
+    fi=0D
+fi=0D
+git=3D"git"=0D
+=0D
+# Don't accept a target_list environment variable.=0D
+unset target_list=0D
+unset target_list_exclude=0D
+=0D
+# Default value for a variable defining feature "foo".=0D
+#  * foo=3D"no"  feature will only be used if --enable-foo arg is given=0D
+#  * foo=3D""    feature will be searched for, and if found, will be used=
=0D
+#              unless --disable-foo is given=0D
+#  * foo=3D"yes" this value will only be set by --enable-foo flag.=0D
+#              feature will searched for,=0D
+#              if not found, configure exits with error=0D
+#=0D
+# Always add --enable-foo and --disable-foo command line args.=0D
+# Distributions want to ensure that several features are compiled in, and =
it=0D
+# is impossible without a --enable-foo that exits if a feature is not foun=
d.=0D
+=0D
+brlapi=3D""=0D
+curl=3D""=0D
+curses=3D""=0D
+docs=3D""=0D
+fdt=3D""=0D
+netmap=3D"no"=0D
+sdl=3D"auto"=0D
+sdl_image=3D"auto"=0D
+virtfs=3D""=0D
+mpath=3D""=0D
+vnc=3D"enabled"=0D
+sparse=3D"no"=0D
+vde=3D""=0D
+vnc_sasl=3D"auto"=0D
+vnc_jpeg=3D"auto"=0D
+vnc_png=3D"auto"=0D
+xkbcommon=3D"auto"=0D
+xen=3D""=0D
+xen_ctrl_version=3D""=0D
+xen_pci_passthrough=3D""=0D
+linux_aio=3D""=0D
+linux_io_uring=3D""=0D
+cap_ng=3D""=0D
+attr=3D""=0D
+libattr=3D""=0D
+xfs=3D""=0D
+tcg=3D"yes"=0D
+membarrier=3D""=0D
+vhost_net=3D""=0D
+vhost_crypto=3D""=0D
+vhost_scsi=3D""=0D
+vhost_vsock=3D""=0D
+vhost_user=3D""=0D
+vhost_user_fs=3D""=0D
+kvm=3D"no"=0D
+hax=3D"no"=0D
+hvf=3D"no"=0D
+whpx=3D"no"=0D
+rdma=3D""=0D
+pvrdma=3D""=0D
+gprof=3D"no"=0D
+debug_tcg=3D"no"=0D
+debug=3D"no"=0D
+sanitizers=3D"no"=0D
+tsan=3D"no"=0D
+fortify_source=3D""=0D
+strip_opt=3D"yes"=0D
+tcg_interpreter=3D"no"=0D
+bigendian=3D"no"=0D
+mingw32=3D"no"=0D
+gcov=3D"no"=0D
+EXESUF=3D""=0D
+HOST_DSOSUF=3D".so"=0D
+LDFLAGS_SHARED=3D"-shared"=0D
+modules=3D"no"=0D
+module_upgrades=3D"no"=0D
+prefix=3D"/usr/local"=0D
+qemu_suffix=3D"qemu"=0D
+slirp=3D""=0D
+oss_lib=3D""=0D
+bsd=3D"no"=0D
+linux=3D"no"=0D
+solaris=3D"no"=0D
+profiler=3D"no"=0D
+cocoa=3D"no"=0D
+softmmu=3D"yes"=0D
+linux_user=3D"no"=0D
+bsd_user=3D"no"=0D
+blobs=3D"yes"=0D
+edk2_blobs=3D"no"=0D
+pkgversion=3D""=0D
+pie=3D""=0D
+qom_cast_debug=3D"yes"=0D
+trace_backends=3D"log"=0D
+trace_file=3D"trace"=0D
+spice=3D""=0D
+rbd=3D""=0D
+smartcard=3D""=0D
+u2f=3D"auto"=0D
+libusb=3D""=0D
+usb_redir=3D""=0D
+opengl=3D""=0D
+opengl_dmabuf=3D"no"=0D
+cpuid_h=3D"no"=0D
+avx2_opt=3D""=0D
+capstone=3D""=0D
+lzo=3D""=0D
+snappy=3D""=0D
+bzip2=3D""=0D
+lzfse=3D""=0D
+zstd=3D""=0D
+guest_agent=3D""=0D
+guest_agent_with_vss=3D"no"=0D
+guest_agent_ntddscsi=3D"no"=0D
+guest_agent_msi=3D""=0D
+vss_win32_sdk=3D""=0D
+win_sdk=3D"no"=0D
+want_tools=3D""=0D
+libiscsi=3D""=0D
+libnfs=3D""=0D
+coroutine=3D""=0D
+coroutine_pool=3D""=0D
+debug_stack_usage=3D"no"=0D
+crypto_afalg=3D"no"=0D
+seccomp=3D""=0D
+glusterfs=3D""=0D
+glusterfs_xlator_opt=3D"no"=0D
+glusterfs_discard=3D"no"=0D
+glusterfs_fallocate=3D"no"=0D
+glusterfs_zerofill=3D"no"=0D
+glusterfs_ftruncate_has_stat=3D"no"=0D
+glusterfs_iocb_has_stat=3D"no"=0D
+gtk=3D""=0D
+gtk_gl=3D"no"=0D
+tls_priority=3D"NORMAL"=0D
+gnutls=3D""=0D
+nettle=3D""=0D
+nettle_xts=3D"no"=0D
+gcrypt=3D""=0D
+gcrypt_hmac=3D"no"=0D
+gcrypt_xts=3D"no"=0D
+qemu_private_xts=3D"yes"=0D
+auth_pam=3D""=0D
+vte=3D""=0D
+virglrenderer=3D""=0D
+tpm=3D""=0D
+libssh=3D""=0D
+live_block_migration=3D"yes"=0D
+numa=3D""=0D
+tcmalloc=3D"no"=0D
+jemalloc=3D"no"=0D
+replication=3D"yes"=0D
+bochs=3D"yes"=0D
+cloop=3D"yes"=0D
+dmg=3D"yes"=0D
+qcow1=3D"yes"=0D
+vdi=3D"yes"=0D
+vvfat=3D"yes"=0D
+qed=3D"yes"=0D
+parallels=3D"yes"=0D
+sheepdog=3D"yes"=0D
+libxml2=3D""=0D
+debug_mutex=3D"no"=0D
+libpmem=3D""=0D
+default_devices=3D"yes"=0D
+plugins=3D"no"=0D
+fuzzing=3D"no"=0D
+rng_none=3D"no"=0D
+secret_keyring=3D""=0D
+libdaxctl=3D""=0D
+meson=3D""=0D
+ninja=3D""=0D
+skip_meson=3Dno=0D
+gettext=3D""=0D
+=0D
+bogus_os=3D"no"=0D
+malloc_trim=3D""=0D
+=0D
+# parse CC options first=0D
+for opt do=0D
+  optarg=3D$(expr "x$opt" : 'x[^=3D]*=3D\(.*\)')=0D
+  case "$opt" in=0D
+  --cross-prefix=3D*) cross_prefix=3D"$optarg"=0D
+  ;;=0D
+  --cc=3D*) CC=3D"$optarg"=0D
+  ;;=0D
+  --cxx=3D*) CXX=3D"$optarg"=0D
+  ;;=0D
+  --cpu=3D*) cpu=3D"$optarg"=0D
+  ;;=0D
+  --extra-cflags=3D*) QEMU_CFLAGS=3D"$QEMU_CFLAGS $optarg"=0D
+                    QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $optarg"=0D
+  ;;=0D
+  --extra-cxxflags=3D*) QEMU_CXXFLAGS=3D"$QEMU_CXXFLAGS $optarg"=0D
+  ;;=0D
+  --extra-ldflags=3D*) QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $optarg"=0D
+                     EXTRA_LDFLAGS=3D"$optarg"=0D
+  ;;=0D
+  --enable-debug-info) debug_info=3D"yes"=0D
+  ;;=0D
+  --disable-debug-info) debug_info=3D"no"=0D
+  ;;=0D
+  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FOO o=
ption"=0D
+  ;;=0D
+  --cross-cc-cflags-*) cc_arch=3D${opt#--cross-cc-flags-}; cc_arch=3D${cc_=
arch%%=3D*}=0D
+                      eval "cross_cc_cflags_${cc_arch}=3D\$optarg"=0D
+                      cross_cc_vars=3D"$cross_cc_vars cross_cc_cflags_${cc=
_arch}"=0D
+  ;;=0D
+  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}=0D
+                cc_archs=3D"$cc_archs $cc_arch"=0D
+                eval "cross_cc_${cc_arch}=3D\$optarg"=0D
+                cross_cc_vars=3D"$cross_cc_vars cross_cc_${cc_arch}"=0D
+  ;;=0D
+  esac=0D
+done=0D
+# OS specific=0D
+# Using uname is really, really broken.  Once we have the right set of che=
cks=0D
+# we can eliminate its usage altogether.=0D
+=0D
+# Preferred compiler:=0D
+#  ${CC} (if set)=0D
+#  ${cross_prefix}gcc (if cross-prefix specified)=0D
+#  system compiler=0D
+if test -z "${CC}${cross_prefix}"; then=0D
+  cc=3D"$host_cc"=0D
+else=0D
+  cc=3D"${CC-${cross_prefix}gcc}"=0D
+fi=0D
+=0D
+if test -z "${CXX}${cross_prefix}"; then=0D
+  cxx=3D"c++"=0D
+else=0D
+  cxx=3D"${CXX-${cross_prefix}g++}"=0D
+fi=0D
+=0D
+ar=3D"${AR-${cross_prefix}ar}"=0D
+as=3D"${AS-${cross_prefix}as}"=0D
+ccas=3D"${CCAS-$cc}"=0D
+cpp=3D"${CPP-$cc -E}"=0D
+objcopy=3D"${OBJCOPY-${cross_prefix}objcopy}"=0D
+ld=3D"${LD-${cross_prefix}ld}"=0D
+ranlib=3D"${RANLIB-${cross_prefix}ranlib}"=0D
+nm=3D"${NM-${cross_prefix}nm}"=0D
+strip=3D"${STRIP-${cross_prefix}strip}"=0D
+windres=3D"${WINDRES-${cross_prefix}windres}"=0D
+pkg_config_exe=3D"${PKG_CONFIG-${cross_prefix}pkg-config}"=0D
+query_pkg_config() {=0D
+    "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"=0D
+}=0D
+pkg_config=3Dquery_pkg_config=0D
+sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"=0D
+=0D
+# If the user hasn't specified ARFLAGS, default to 'rv', just as make does=
.=0D
+ARFLAGS=3D"${ARFLAGS-rv}"=0D
+=0D
+# default flags for all hosts=0D
+# We use -fwrapv to tell the compiler that we require a C dialect where=0D
+# left shift of signed integers is well defined and has the expected=0D
+# 2s-complement style results. (Both clang and gcc agree that it=0D
+# provides these semantics.)=0D
+QEMU_CFLAGS=3D"-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"=0D
+QEMU_CFLAGS=3D"-Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"=
=0D
+QEMU_CFLAGS=3D"-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"=0D
+QEMU_CFLAGS=3D"-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE =
$QEMU_CFLAGS"=0D
+QEMU_INCLUDES=3D"-iquote . -iquote ${source_path} -iquote ${source_path}/a=
ccel/tcg -iquote ${source_path}/include"=0D
+QEMU_INCLUDES=3D"$QEMU_INCLUDES -iquote ${source_path}/disas/libvixl"=0D
+CFLAGS=3D"-std=3Dgnu99 -Wall"=0D
+=0D
+=0D
+# running configure in the source tree?=0D
+# we know that's the case if configure is there.=0D
+if test -f "./configure"; then=0D
+    pwd_is_source_path=3D"y"=0D
+else=0D
+    pwd_is_source_path=3D"n"=0D
+fi=0D
+=0D
+check_define() {=0D
+cat > $TMPC <<EOF=0D
+#if !defined($1)=0D
+#error $1 not defined=0D
+#endif=0D
+int main(void) { return 0; }=0D
+EOF=0D
+  compile_object=0D
+}=0D
+=0D
+check_include() {=0D
+cat > $TMPC <<EOF=0D
+#include <$1>=0D
+int main(void) { return 0; }=0D
+EOF=0D
+  compile_object=0D
+}=0D
+=0D
+write_c_skeleton() {=0D
+    cat > $TMPC <<EOF=0D
+int main(void) { return 0; }=0D
+EOF=0D
+}=0D
+=0D
+write_c_fuzzer_skeleton() {=0D
+    cat > $TMPC <<EOF=0D
+#include <stdint.h>=0D
+#include <sys/types.h>=0D
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size);=0D
+int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) { return 0; }=
=0D
+EOF=0D
+}=0D
+=0D
+if check_define __linux__ ; then=0D
+  targetos=3D"Linux"=0D
+elif check_define _WIN32 ; then=0D
+  targetos=3D'MINGW32'=0D
+elif check_define __OpenBSD__ ; then=0D
+  targetos=3D'OpenBSD'=0D
+elif check_define __sun__ ; then=0D
+  targetos=3D'SunOS'=0D
+elif check_define __HAIKU__ ; then=0D
+  targetos=3D'Haiku'=0D
+elif check_define __FreeBSD__ ; then=0D
+  targetos=3D'FreeBSD'=0D
+elif check_define __FreeBSD_kernel__ && check_define __GLIBC__; then=0D
+  targetos=3D'GNU/kFreeBSD'=0D
+elif check_define __DragonFly__ ; then=0D
+  targetos=3D'DragonFly'=0D
+elif check_define __NetBSD__; then=0D
+  targetos=3D'NetBSD'=0D
+elif check_define __APPLE__; then=0D
+  targetos=3D'Darwin'=0D
+else=0D
+  # This is a fatal error, but don't report it yet, because we=0D
+  # might be going to just print the --help text, or it might=0D
+  # be the result of a missing compiler.=0D
+  targetos=3D'bogus'=0D
+  bogus_os=3D'yes'=0D
+fi=0D
+=0D
+# Some host OSes need non-standard checks for which CPU to use.=0D
+# Note that these checks are broken for cross-compilation: if you're=0D
+# cross-compiling to one of these OSes then you'll need to specify=0D
+# the correct CPU with the --cpu option.=0D
+case $targetos in=0D
+Darwin)=0D
+  # on Leopard most of the system is 32-bit, so we have to ask the kernel =
if we can=0D
+  # run 64-bit userspace code.=0D
+  # If the user didn't specify a CPU explicitly and the kernel says this i=
s=0D
+  # 64 bit hw, then assume x86_64. Otherwise fall through to the usual det=
ection code.=0D
+  if test -z "$cpu" && test "$(sysctl -n hw.optional.x86_64)" =3D "1"; the=
n=0D
+    cpu=3D"x86_64"=0D
+  fi=0D
+  ;;=0D
+SunOS)=0D
+  # $(uname -m) returns i86pc even on an x86_64 box, so default based on i=
sainfo=0D
+  if test -z "$cpu" && test "$(isainfo -k)" =3D "amd64"; then=0D
+    cpu=3D"x86_64"=0D
+  fi=0D
+esac=0D
+=0D
+if test ! -z "$cpu" ; then=0D
+  # command line argument=0D
+  :=0D
+elif check_define __i386__ ; then=0D
+  cpu=3D"i386"=0D
+elif check_define __x86_64__ ; then=0D
+  if check_define __ILP32__ ; then=0D
+    cpu=3D"x32"=0D
+  else=0D
+    cpu=3D"x86_64"=0D
+  fi=0D
+elif check_define __sparc__ ; then=0D
+  if check_define __arch64__ ; then=0D
+    cpu=3D"sparc64"=0D
+  else=0D
+    cpu=3D"sparc"=0D
+  fi=0D
+elif check_define _ARCH_PPC ; then=0D
+  if check_define _ARCH_PPC64 ; then=0D
+    if check_define _LITTLE_ENDIAN ; then=0D
+      cpu=3D"ppc64le"=0D
+    else=0D
+      cpu=3D"ppc64"=0D
+    fi=0D
+  else=0D
+    cpu=3D"ppc"=0D
+  fi=0D
+elif check_define __mips__ ; then=0D
+  cpu=3D"mips"=0D
+elif check_define __s390__ ; then=0D
+  if check_define __s390x__ ; then=0D
+    cpu=3D"s390x"=0D
+  else=0D
+    cpu=3D"s390"=0D
+  fi=0D
+elif check_define __riscv ; then=0D
+  if check_define _LP64 ; then=0D
+    cpu=3D"riscv64"=0D
+  else=0D
+    cpu=3D"riscv32"=0D
+  fi=0D
+elif check_define __arm__ ; then=0D
+  cpu=3D"arm"=0D
+elif check_define __aarch64__ ; then=0D
+  cpu=3D"aarch64"=0D
+else=0D
+  cpu=3D$(uname -m)=0D
+fi=0D
+=0D
+ARCH=3D=0D
+# Normalise host CPU name and set ARCH.=0D
+# Note that this case should only have supported host CPUs, not guests.=0D
+case "$cpu" in=0D
+  ppc|ppc64|s390x|sparc64|x32|riscv32|riscv64)=0D
+  ;;=0D
+  ppc64le)=0D
+    ARCH=3D"ppc64"=0D
+  ;;=0D
+  i386|i486|i586|i686|i86pc|BePC)=0D
+    cpu=3D"i386"=0D
+  ;;=0D
+  x86_64|amd64)=0D
+    cpu=3D"x86_64"=0D
+  ;;=0D
+  armv*b|armv*l|arm)=0D
+    cpu=3D"arm"=0D
+  ;;=0D
+  aarch64)=0D
+    cpu=3D"aarch64"=0D
+  ;;=0D
+  mips*)=0D
+    cpu=3D"mips"=0D
+  ;;=0D
+  sparc|sun4[cdmuv])=0D
+    cpu=3D"sparc"=0D
+  ;;=0D
+  *)=0D
+    # This will result in either an error or falling back to TCI later=0D
+    ARCH=3Dunknown=0D
+  ;;=0D
+esac=0D
+if test -z "$ARCH"; then=0D
+  ARCH=3D"$cpu"=0D
+fi=0D
+=0D
+# OS specific=0D
+=0D
+# host *BSD for user mode=0D
+HOST_VARIANT_DIR=3D""=0D
+=0D
+case $targetos in=0D
+MINGW32*)=0D
+  mingw32=3D"yes"=0D
+  hax=3D"yes"=0D
+  vhost_user=3D"no"=0D
+  audio_possible_drivers=3D"dsound sdl"=0D
+  if check_include dsound.h; then=0D
+    audio_drv_list=3D"dsound"=0D
+  else=0D
+    audio_drv_list=3D""=0D
+  fi=0D
+  supported_os=3D"yes"=0D
+  pie=3D"no"=0D
+;;=0D
+GNU/kFreeBSD)=0D
+  bsd=3D"yes"=0D
+  audio_drv_list=3D"oss try-sdl"=0D
+  audio_possible_drivers=3D"oss sdl pa"=0D
+;;=0D
+FreeBSD)=0D
+  bsd=3D"yes"=0D
+  make=3D"${MAKE-gmake}"=0D
+  audio_drv_list=3D"oss try-sdl"=0D
+  audio_possible_drivers=3D"oss sdl pa"=0D
+  # needed for kinfo_getvmmap(3) in libutil.h=0D
+  LIBS=3D"-lutil $LIBS"=0D
+  netmap=3D""  # enable netmap autodetect=0D
+  HOST_VARIANT_DIR=3D"freebsd"=0D
+;;=0D
+DragonFly)=0D
+  bsd=3D"yes"=0D
+  make=3D"${MAKE-gmake}"=0D
+  audio_drv_list=3D"oss try-sdl"=0D
+  audio_possible_drivers=3D"oss sdl pa"=0D
+  HOST_VARIANT_DIR=3D"dragonfly"=0D
+;;=0D
+NetBSD)=0D
+  bsd=3D"yes"=0D
+  hax=3D"yes"=0D
+  make=3D"${MAKE-gmake}"=0D
+  audio_drv_list=3D"oss try-sdl"=0D
+  audio_possible_drivers=3D"oss sdl"=0D
+  oss_lib=3D"-lossaudio"=0D
+  HOST_VARIANT_DIR=3D"netbsd"=0D
+;;=0D
+OpenBSD)=0D
+  bsd=3D"yes"=0D
+  make=3D"${MAKE-gmake}"=0D
+  audio_drv_list=3D"try-sdl"=0D
+  audio_possible_drivers=3D"sdl"=0D
+  HOST_VARIANT_DIR=3D"openbsd"=0D
+;;=0D
+Darwin)=0D
+  bsd=3D"yes"=0D
+  darwin=3D"yes"=0D
+  hax=3D"yes"=0D
+  hvf=3D"yes"=0D
+  LDFLAGS_SHARED=3D"-bundle -undefined dynamic_lookup"=0D
+  if [ "$cpu" =3D "x86_64" ] ; then=0D
+    QEMU_CFLAGS=3D"-arch x86_64 $QEMU_CFLAGS"=0D
+    QEMU_LDFLAGS=3D"-arch x86_64 $QEMU_LDFLAGS"=0D
+  fi=0D
+  cocoa=3D"yes"=0D
+  audio_drv_list=3D"coreaudio try-sdl"=0D
+  audio_possible_drivers=3D"coreaudio sdl"=0D
+  QEMU_LDFLAGS=3D"-framework CoreFoundation -framework IOKit $QEMU_LDFLAGS=
"=0D
+  # Disable attempts to use ObjectiveC features in os/object.h since they=
=0D
+  # won't work when we're compiling with gcc as a C compiler.=0D
+  QEMU_CFLAGS=3D"-DOS_OBJECT_USE_OBJC=3D0 $QEMU_CFLAGS"=0D
+  HOST_VARIANT_DIR=3D"darwin"=0D
+;;=0D
+SunOS)=0D
+  solaris=3D"yes"=0D
+  make=3D"${MAKE-gmake}"=0D
+  install=3D"${INSTALL-ginstall}"=0D
+  smbd=3D"${SMBD-/usr/sfw/sbin/smbd}"=0D
+  if test -f /usr/include/sys/soundcard.h ; then=0D
+    audio_drv_list=3D"oss try-sdl"=0D
+  fi=0D
+  audio_possible_drivers=3D"oss sdl"=0D
+# needed for CMSG_ macros in sys/socket.h=0D
+  QEMU_CFLAGS=3D"-D_XOPEN_SOURCE=3D600 $QEMU_CFLAGS"=0D
+# needed for TIOCWIN* defines in termios.h=0D
+  QEMU_CFLAGS=3D"-D__EXTENSIONS__ $QEMU_CFLAGS"=0D
+  solarisnetlibs=3D"-lsocket -lnsl -lresolv"=0D
+  LIBS=3D"$solarisnetlibs $LIBS"=0D
+;;=0D
+Haiku)=0D
+  haiku=3D"yes"=0D
+  QEMU_CFLAGS=3D"-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"=
=0D
+  LIBS=3D"-lposix_error_mapper -lnetwork -lbsd $LIBS"=0D
+;;=0D
+Linux)=0D
+  audio_drv_list=3D"try-pa oss"=0D
+  audio_possible_drivers=3D"oss alsa sdl pa"=0D
+  linux=3D"yes"=0D
+  linux_user=3D"yes"=0D
+  kvm=3D"yes"=0D
+  QEMU_INCLUDES=3D"-isystem ${source_path}/linux-headers -I${build_path}/l=
inux-headers $QEMU_INCLUDES"=0D
+  libudev=3D"yes"=0D
+;;=0D
+esac=0D
+=0D
+if [ "$bsd" =3D "yes" ] ; then=0D
+  if [ "$darwin" !=3D "yes" ] ; then=0D
+    bsd_user=3D"yes"=0D
+  fi=0D
+fi=0D
+=0D
+: ${make=3D${MAKE-make}}=0D
+: ${install=3D${INSTALL-install}}=0D
+# We prefer python 3.x. A bare 'python' is traditionally=0D
+# python 2.x, but some distros have it as python 3.x, so=0D
+# we check that too=0D
+python=3D=0D
+explicit_python=3Dno=0D
+for binary in "${PYTHON-python3}" python=0D
+do=0D
+    if has "$binary"=0D
+    then=0D
+        python=3D$(command -v "$binary")=0D
+        break=0D
+    fi=0D
+done=0D
+=0D
+sphinx_build=3D=0D
+for binary in sphinx-build-3 sphinx-build=0D
+do=0D
+    if has "$binary"=0D
+    then=0D
+        sphinx_build=3D$(command -v "$binary")=0D
+        break=0D
+    fi=0D
+done=0D
+=0D
+# Check for ancillary tools used in testing=0D
+genisoimage=3D=0D
+for binary in genisoimage mkisofs=0D
+do=0D
+    if has $binary=0D
+    then=0D
+        genisoimage=3D$(command -v "$binary")=0D
+        break=0D
+    fi=0D
+done=0D
+=0D
+: ${smbd=3D${SMBD-/usr/sbin/smbd}}=0D
+=0D
+# Default objcc to clang if available, otherwise use CC=0D
+if has clang; then=0D
+  objcc=3Dclang=0D
+else=0D
+  objcc=3D"$cc"=0D
+fi=0D
+=0D
+if test "$mingw32" =3D "yes" ; then=0D
+  EXESUF=3D".exe"=0D
+  HOST_DSOSUF=3D".dll"=0D
+  # MinGW needs -mthreads for TLS and macro _MT.=0D
+  CFLAGS=3D"-mthreads $CFLAGS"=0D
+  LIBS=3D"-lwinmm -lws2_32 $LIBS"=0D
+  write_c_skeleton;=0D
+  if compile_prog "" "-liberty" ; then=0D
+    LIBS=3D"-liberty $LIBS"=0D
+  fi=0D
+  prefix=3D"c:/Program Files/QEMU"=0D
+  qemu_suffix=3D""=0D
+  libs_qga=3D"-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi =
-lnetapi32 $libs_qga"=0D
+fi=0D
+=0D
+werror=3D""=0D
+=0D
+for opt do=0D
+  optarg=3D$(expr "x$opt" : 'x[^=3D]*=3D\(.*\)')=0D
+  case "$opt" in=0D
+  --help|-h) show_help=3Dyes=0D
+  ;;=0D
+  --version|-V) exec cat $source_path/VERSION=0D
+  ;;=0D
+  --prefix=3D*) prefix=3D"$optarg"=0D
+  ;;=0D
+  --interp-prefix=3D*) interp_prefix=3D"$optarg"=0D
+  ;;=0D
+  --cross-prefix=3D*)=0D
+  ;;=0D
+  --cc=3D*)=0D
+  ;;=0D
+  --host-cc=3D*) host_cc=3D"$optarg"=0D
+  ;;=0D
+  --cxx=3D*)=0D
+  ;;=0D
+  --iasl=3D*) iasl=3D"$optarg"=0D
+  ;;=0D
+  --objcc=3D*) objcc=3D"$optarg"=0D
+  ;;=0D
+  --make=3D*) make=3D"$optarg"=0D
+  ;;=0D
+  --install=3D*) install=3D"$optarg"=0D
+  ;;=0D
+  --python=3D*) python=3D"$optarg" ; explicit_python=3Dyes=0D
+  ;;=0D
+  --sphinx-build=3D*) sphinx_build=3D"$optarg"=0D
+  ;;=0D
+  --skip-meson) skip_meson=3Dyes=0D
+  ;;=0D
+  --meson=3D*) meson=3D"$optarg"=0D
+  ;;=0D
+  --ninja=3D*) ninja=3D"$optarg"=0D
+  ;;=0D
+  --smbd=3D*) smbd=3D"$optarg"=0D
+  ;;=0D
+  --extra-cflags=3D*)=0D
+  ;;=0D
+  --extra-cxxflags=3D*)=0D
+  ;;=0D
+  --extra-ldflags=3D*)=0D
+  ;;=0D
+  --enable-debug-info)=0D
+  ;;=0D
+  --disable-debug-info)=0D
+  ;;=0D
+  --cross-cc-*)=0D
+  ;;=0D
+  --enable-modules)=0D
+      modules=3D"yes"=0D
+  ;;=0D
+  --disable-modules)=0D
+      modules=3D"no"=0D
+  ;;=0D
+  --disable-module-upgrades) module_upgrades=3D"no"=0D
+  ;;=0D
+  --enable-module-upgrades) module_upgrades=3D"yes"=0D
+  ;;=0D
+  --cpu=3D*)=0D
+  ;;=0D
+  --target-list=3D*) target_list=3D"$optarg"=0D
+                   if test "$target_list_exclude"; then=0D
+                       error_exit "Can't mix --target-list with --target-l=
ist-exclude"=0D
+                   fi=0D
+  ;;=0D
+  --target-list-exclude=3D*) target_list_exclude=3D"$optarg"=0D
+                   if test "$target_list"; then=0D
+                       error_exit "Can't mix --target-list-exclude with --=
target-list"=0D
+                   fi=0D
+  ;;=0D
+  --enable-trace-backends=3D*) trace_backends=3D"$optarg"=0D
+  ;;=0D
+  # XXX: backwards compatibility=0D
+  --enable-trace-backend=3D*) trace_backends=3D"$optarg"=0D
+  ;;=0D
+  --with-trace-file=3D*) trace_file=3D"$optarg"=0D
+  ;;=0D
+  --with-default-devices) default_devices=3D"yes"=0D
+  ;;=0D
+  --without-default-devices) default_devices=3D"no"=0D
+  ;;=0D
+  --enable-gprof) gprof=3D"yes"=0D
+  ;;=0D
+  --enable-gcov) gcov=3D"yes"=0D
+  ;;=0D
+  --static)=0D
+    static=3D"yes"=0D
+    QEMU_PKG_CONFIG_FLAGS=3D"--static $QEMU_PKG_CONFIG_FLAGS"=0D
+  ;;=0D
+  --mandir=3D*) mandir=3D"$optarg"=0D
+  ;;=0D
+  --bindir=3D*) bindir=3D"$optarg"=0D
+  ;;=0D
+  --libdir=3D*) libdir=3D"$optarg"=0D
+  ;;=0D
+  --libexecdir=3D*) libexecdir=3D"$optarg"=0D
+  ;;=0D
+  --includedir=3D*) includedir=3D"$optarg"=0D
+  ;;=0D
+  --datadir=3D*) datadir=3D"$optarg"=0D
+  ;;=0D
+  --with-suffix=3D*) qemu_suffix=3D"$optarg"=0D
+  ;;=0D
+  --docdir=3D*) qemu_docdir=3D"$optarg"=0D
+  ;;=0D
+  --sysconfdir=3D*) sysconfdir=3D"$optarg"=0D
+  ;;=0D
+  --localstatedir=3D*) local_statedir=3D"$optarg"=0D
+  ;;=0D
+  --firmwarepath=3D*) firmwarepath=3D"$optarg"=0D
+  ;;=0D
+  --host=3D*|--build=3D*|\=0D
+  --disable-dependency-tracking|\=0D
+  --sbindir=3D*|--sharedstatedir=3D*|\=0D
+  --oldincludedir=3D*|--datarootdir=3D*|--infodir=3D*|--localedir=3D*|\=0D
+  --htmldir=3D*|--dvidir=3D*|--pdfdir=3D*|--psdir=3D*)=0D
+    # These switches are silently ignored, for compatibility with=0D
+    # autoconf-generated configure scripts. This allows QEMU's=0D
+    # configure to be used by RPM and similar macros that set=0D
+    # lots of directory switches by default.=0D
+  ;;=0D
+  --disable-sdl) sdl=3D"disabled"=0D
+  ;;=0D
+  --enable-sdl) sdl=3D"enabled"=0D
+  ;;=0D
+  --disable-sdl-image) sdl_image=3D"disabled"=0D
+  ;;=0D
+  --enable-sdl-image) sdl_image=3D"enabled"=0D
+  ;;=0D
+  --disable-qom-cast-debug) qom_cast_debug=3D"no"=0D
+  ;;=0D
+  --enable-qom-cast-debug) qom_cast_debug=3D"yes"=0D
+  ;;=0D
+  --disable-virtfs) virtfs=3D"no"=0D
+  ;;=0D
+  --enable-virtfs) virtfs=3D"yes"=0D
+  ;;=0D
+  --disable-mpath) mpath=3D"no"=0D
+  ;;=0D
+  --enable-mpath) mpath=3D"yes"=0D
+  ;;=0D
+  --disable-vnc) vnc=3D"disabled"=0D
+  ;;=0D
+  --enable-vnc) vnc=3D"enabled"=0D
+  ;;=0D
+  --disable-gettext) gettext=3D"false"=0D
+  ;;=0D
+  --enable-gettext) gettext=3D"true"=0D
+  ;;=0D
+  --oss-lib=3D*) oss_lib=3D"$optarg"=0D
+  ;;=0D
+  --audio-drv-list=3D*) audio_drv_list=3D"$optarg"=0D
+  ;;=0D
+  --block-drv-rw-whitelist=3D*|--block-drv-whitelist=3D*) block_drv_rw_whi=
telist=3D$(echo "$optarg" | sed -e 's/,/ /g')=0D
+  ;;=0D
+  --block-drv-ro-whitelist=3D*) block_drv_ro_whitelist=3D$(echo "$optarg" =
| sed -e 's/,/ /g')=0D
+  ;;=0D
+  --enable-debug-tcg) debug_tcg=3D"yes"=0D
+  ;;=0D
+  --disable-debug-tcg) debug_tcg=3D"no"=0D
+  ;;=0D
+  --enable-debug)=0D
+      # Enable debugging options that aren't excessively noisy=0D
+      debug_tcg=3D"yes"=0D
+      debug_mutex=3D"yes"=0D
+      debug=3D"yes"=0D
+      strip_opt=3D"no"=0D
+      fortify_source=3D"no"=0D
+  ;;=0D
+  --enable-sanitizers) sanitizers=3D"yes"=0D
+  ;;=0D
+  --disable-sanitizers) sanitizers=3D"no"=0D
+  ;;=0D
+  --enable-tsan) tsan=3D"yes"=0D
+  ;;=0D
+  --disable-tsan) tsan=3D"no"=0D
+  ;;=0D
+  --enable-sparse) sparse=3D"yes"=0D
+  ;;=0D
+  --disable-sparse) sparse=3D"no"=0D
+  ;;=0D
+  --disable-strip) strip_opt=3D"no"=0D
+  ;;=0D
+  --disable-vnc-sasl) vnc_sasl=3D"disabled"=0D
+  ;;=0D
+  --enable-vnc-sasl) vnc_sasl=3D"enabled"=0D
+  ;;=0D
+  --disable-vnc-jpeg) vnc_jpeg=3D"disabled"=0D
+  ;;=0D
+  --enable-vnc-jpeg) vnc_jpeg=3D"enabled"=0D
+  ;;=0D
+  --disable-vnc-png) vnc_png=3D"disabled"=0D
+  ;;=0D
+  --enable-vnc-png) vnc_png=3D"enabled"=0D
+  ;;=0D
+  --disable-slirp) slirp=3D"no"=0D
+  ;;=0D
+  --enable-slirp=3Dgit) slirp=3D"git"=0D
+  ;;=0D
+  --enable-slirp=3Dsystem) slirp=3D"system"=0D
+  ;;=0D
+  --disable-vde) vde=3D"no"=0D
+  ;;=0D
+  --enable-vde) vde=3D"yes"=0D
+  ;;=0D
+  --disable-netmap) netmap=3D"no"=0D
+  ;;=0D
+  --enable-netmap) netmap=3D"yes"=0D
+  ;;=0D
+  --disable-xen) xen=3D"no"=0D
+  ;;=0D
+  --enable-xen) xen=3D"yes"=0D
+  ;;=0D
+  --disable-xen-pci-passthrough) xen_pci_passthrough=3D"no"=0D
+  ;;=0D
+  --enable-xen-pci-passthrough) xen_pci_passthrough=3D"yes"=0D
+  ;;=0D
+  --disable-brlapi) brlapi=3D"no"=0D
+  ;;=0D
+  --enable-brlapi) brlapi=3D"yes"=0D
+  ;;=0D
+  --disable-kvm) kvm=3D"no"=0D
+  ;;=0D
+  --enable-kvm) kvm=3D"yes"=0D
+  ;;=0D
+  --disable-hax) hax=3D"no"=0D
+  ;;=0D
+  --enable-hax) hax=3D"yes"=0D
+  ;;=0D
+  --disable-hvf) hvf=3D"no"=0D
+  ;;=0D
+  --enable-hvf) hvf=3D"yes"=0D
+  ;;=0D
+  --disable-whpx) whpx=3D"no"=0D
+  ;;=0D
+  --enable-whpx) whpx=3D"yes"=0D
+  ;;=0D
+  --disable-tcg-interpreter) tcg_interpreter=3D"no"=0D
+  ;;=0D
+  --enable-tcg-interpreter) tcg_interpreter=3D"yes"=0D
+  ;;=0D
+  --disable-cap-ng)  cap_ng=3D"no"=0D
+  ;;=0D
+  --enable-cap-ng) cap_ng=3D"yes"=0D
+  ;;=0D
+  --disable-tcg) tcg=3D"no"=0D
+  ;;=0D
+  --enable-tcg) tcg=3D"yes"=0D
+  ;;=0D
+  --disable-malloc-trim) malloc_trim=3D"no"=0D
+  ;;=0D
+  --enable-malloc-trim) malloc_trim=3D"yes"=0D
+  ;;=0D
+  --disable-spice) spice=3D"no"=0D
+  ;;=0D
+  --enable-spice) spice=3D"yes"=0D
+  ;;=0D
+  --disable-libiscsi) libiscsi=3D"no"=0D
+  ;;=0D
+  --enable-libiscsi) libiscsi=3D"yes"=0D
+  ;;=0D
+  --disable-libnfs) libnfs=3D"no"=0D
+  ;;=0D
+  --enable-libnfs) libnfs=3D"yes"=0D
+  ;;=0D
+  --enable-profiler) profiler=3D"yes"=0D
+  ;;=0D
+  --disable-cocoa) cocoa=3D"no"=0D
+  ;;=0D
+  --enable-cocoa)=0D
+      cocoa=3D"yes" ;=0D
+      audio_drv_list=3D"coreaudio $(echo $audio_drv_list | sed s,coreaudio=
,,g)"=0D
+  ;;=0D
+  --disable-system) softmmu=3D"no"=0D
+  ;;=0D
+  --enable-system) softmmu=3D"yes"=0D
+  ;;=0D
+  --disable-user)=0D
+      linux_user=3D"no" ;=0D
+      bsd_user=3D"no" ;=0D
+  ;;=0D
+  --enable-user) ;;=0D
+  --disable-linux-user) linux_user=3D"no"=0D
+  ;;=0D
+  --enable-linux-user) linux_user=3D"yes"=0D
+  ;;=0D
+  --disable-bsd-user) bsd_user=3D"no"=0D
+  ;;=0D
+  --enable-bsd-user) bsd_user=3D"yes"=0D
+  ;;=0D
+  --enable-pie) pie=3D"yes"=0D
+  ;;=0D
+  --disable-pie) pie=3D"no"=0D
+  ;;=0D
+  --enable-werror) werror=3D"yes"=0D
+  ;;=0D
+  --disable-werror) werror=3D"no"=0D
+  ;;=0D
+  --enable-stack-protector) stack_protector=3D"yes"=0D
+  ;;=0D
+  --disable-stack-protector) stack_protector=3D"no"=0D
+  ;;=0D
+  --enable-safe-stack) safe_stack=3D"yes"=0D
+  ;;=0D
+  --disable-safe-stack) safe_stack=3D"no"=0D
+  ;;=0D
+  --disable-curses) curses=3D"no"=0D
+  ;;=0D
+  --enable-curses) curses=3D"yes"=0D
+  ;;=0D
+  --disable-iconv) iconv=3D"no"=0D
+  ;;=0D
+  --enable-iconv) iconv=3D"yes"=0D
+  ;;=0D
+  --disable-curl) curl=3D"no"=0D
+  ;;=0D
+  --enable-curl) curl=3D"yes"=0D
+  ;;=0D
+  --disable-fdt) fdt=3D"no"=0D
+  ;;=0D
+  --enable-fdt) fdt=3D"yes"=0D
+  ;;=0D
+  --disable-linux-aio) linux_aio=3D"no"=0D
+  ;;=0D
+  --enable-linux-aio) linux_aio=3D"yes"=0D
+  ;;=0D
+  --disable-linux-io-uring) linux_io_uring=3D"no"=0D
+  ;;=0D
+  --enable-linux-io-uring) linux_io_uring=3D"yes"=0D
+  ;;=0D
+  --disable-attr) attr=3D"no"=0D
+  ;;=0D
+  --enable-attr) attr=3D"yes"=0D
+  ;;=0D
+  --disable-membarrier) membarrier=3D"no"=0D
+  ;;=0D
+  --enable-membarrier) membarrier=3D"yes"=0D
+  ;;=0D
+  --disable-blobs) blobs=3D"no"=0D
+  ;;=0D
+  --with-pkgversion=3D*) pkgversion=3D"$optarg"=0D
+  ;;=0D
+  --with-coroutine=3D*) coroutine=3D"$optarg"=0D
+  ;;=0D
+  --disable-coroutine-pool) coroutine_pool=3D"no"=0D
+  ;;=0D
+  --enable-coroutine-pool) coroutine_pool=3D"yes"=0D
+  ;;=0D
+  --enable-debug-stack-usage) debug_stack_usage=3D"yes"=0D
+  ;;=0D
+  --enable-crypto-afalg) crypto_afalg=3D"yes"=0D
+  ;;=0D
+  --disable-crypto-afalg) crypto_afalg=3D"no"=0D
+  ;;=0D
+  --disable-docs) docs=3D"no"=0D
+  ;;=0D
+  --enable-docs) docs=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-net) vhost_net=3D"no"=0D
+  ;;=0D
+  --enable-vhost-net) vhost_net=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-crypto) vhost_crypto=3D"no"=0D
+  ;;=0D
+  --enable-vhost-crypto) vhost_crypto=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-scsi) vhost_scsi=3D"no"=0D
+  ;;=0D
+  --enable-vhost-scsi) vhost_scsi=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-vsock) vhost_vsock=3D"no"=0D
+  ;;=0D
+  --enable-vhost-vsock) vhost_vsock=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-user-fs) vhost_user_fs=3D"no"=0D
+  ;;=0D
+  --enable-vhost-user-fs) vhost_user_fs=3D"yes"=0D
+  ;;=0D
+  --disable-opengl) opengl=3D"no"=0D
+  ;;=0D
+  --enable-opengl) opengl=3D"yes"=0D
+  ;;=0D
+  --disable-rbd) rbd=3D"no"=0D
+  ;;=0D
+  --enable-rbd) rbd=3D"yes"=0D
+  ;;=0D
+  --disable-xfsctl) xfs=3D"no"=0D
+  ;;=0D
+  --enable-xfsctl) xfs=3D"yes"=0D
+  ;;=0D
+  --disable-smartcard) smartcard=3D"no"=0D
+  ;;=0D
+  --enable-smartcard) smartcard=3D"yes"=0D
+  ;;=0D
+  --disable-u2f) u2f=3D"disabled"=0D
+  ;;=0D
+  --enable-u2f) u2f=3D"enabled"=0D
+  ;;=0D
+  --disable-libusb) libusb=3D"no"=0D
+  ;;=0D
+  --enable-libusb) libusb=3D"yes"=0D
+  ;;=0D
+  --disable-usb-redir) usb_redir=3D"no"=0D
+  ;;=0D
+  --enable-usb-redir) usb_redir=3D"yes"=0D
+  ;;=0D
+  --disable-zlib-test)=0D
+  ;;=0D
+  --disable-lzo) lzo=3D"no"=0D
+  ;;=0D
+  --enable-lzo) lzo=3D"yes"=0D
+  ;;=0D
+  --disable-snappy) snappy=3D"no"=0D
+  ;;=0D
+  --enable-snappy) snappy=3D"yes"=0D
+  ;;=0D
+  --disable-bzip2) bzip2=3D"no"=0D
+  ;;=0D
+  --enable-bzip2) bzip2=3D"yes"=0D
+  ;;=0D
+  --enable-lzfse) lzfse=3D"yes"=0D
+  ;;=0D
+  --disable-lzfse) lzfse=3D"no"=0D
+  ;;=0D
+  --disable-zstd) zstd=3D"no"=0D
+  ;;=0D
+  --enable-zstd) zstd=3D"yes"=0D
+  ;;=0D
+  --enable-guest-agent) guest_agent=3D"yes"=0D
+  ;;=0D
+  --disable-guest-agent) guest_agent=3D"no"=0D
+  ;;=0D
+  --enable-guest-agent-msi) guest_agent_msi=3D"yes"=0D
+  ;;=0D
+  --disable-guest-agent-msi) guest_agent_msi=3D"no"=0D
+  ;;=0D
+  --with-vss-sdk) vss_win32_sdk=3D""=0D
+  ;;=0D
+  --with-vss-sdk=3D*) vss_win32_sdk=3D"$optarg"=0D
+  ;;=0D
+  --without-vss-sdk) vss_win32_sdk=3D"no"=0D
+  ;;=0D
+  --with-win-sdk) win_sdk=3D""=0D
+  ;;=0D
+  --with-win-sdk=3D*) win_sdk=3D"$optarg"=0D
+  ;;=0D
+  --without-win-sdk) win_sdk=3D"no"=0D
+  ;;=0D
+  --enable-tools) want_tools=3D"yes"=0D
+  ;;=0D
+  --disable-tools) want_tools=3D"no"=0D
+  ;;=0D
+  --enable-seccomp) seccomp=3D"yes"=0D
+  ;;=0D
+  --disable-seccomp) seccomp=3D"no"=0D
+  ;;=0D
+  --disable-glusterfs) glusterfs=3D"no"=0D
+  ;;=0D
+  --disable-avx2) avx2_opt=3D"no"=0D
+  ;;=0D
+  --enable-avx2) avx2_opt=3D"yes"=0D
+  ;;=0D
+  --disable-avx512f) avx512f_opt=3D"no"=0D
+  ;;=0D
+  --enable-avx512f) avx512f_opt=3D"yes"=0D
+  ;;=0D
+=0D
+  --enable-glusterfs) glusterfs=3D"yes"=0D
+  ;;=0D
+  --disable-virtio-blk-data-plane|--enable-virtio-blk-data-plane)=0D
+      echo "$0: $opt is obsolete, virtio-blk data-plane is always on" >&2=
=0D
+  ;;=0D
+  --enable-vhdx|--disable-vhdx)=0D
+      echo "$0: $opt is obsolete, VHDX driver is always built" >&2=0D
+  ;;=0D
+  --enable-uuid|--disable-uuid)=0D
+      echo "$0: $opt is obsolete, UUID support is always built" >&2=0D
+  ;;=0D
+  --disable-gtk) gtk=3D"no"=0D
+  ;;=0D
+  --enable-gtk) gtk=3D"yes"=0D
+  ;;=0D
+  --tls-priority=3D*) tls_priority=3D"$optarg"=0D
+  ;;=0D
+  --disable-gnutls) gnutls=3D"no"=0D
+  ;;=0D
+  --enable-gnutls) gnutls=3D"yes"=0D
+  ;;=0D
+  --disable-nettle) nettle=3D"no"=0D
+  ;;=0D
+  --enable-nettle) nettle=3D"yes"=0D
+  ;;=0D
+  --disable-gcrypt) gcrypt=3D"no"=0D
+  ;;=0D
+  --enable-gcrypt) gcrypt=3D"yes"=0D
+  ;;=0D
+  --disable-auth-pam) auth_pam=3D"no"=0D
+  ;;=0D
+  --enable-auth-pam) auth_pam=3D"yes"=0D
+  ;;=0D
+  --enable-rdma) rdma=3D"yes"=0D
+  ;;=0D
+  --disable-rdma) rdma=3D"no"=0D
+  ;;=0D
+  --enable-pvrdma) pvrdma=3D"yes"=0D
+  ;;=0D
+  --disable-pvrdma) pvrdma=3D"no"=0D
+  ;;=0D
+  --disable-vte) vte=3D"no"=0D
+  ;;=0D
+  --enable-vte) vte=3D"yes"=0D
+  ;;=0D
+  --disable-virglrenderer) virglrenderer=3D"no"=0D
+  ;;=0D
+  --enable-virglrenderer) virglrenderer=3D"yes"=0D
+  ;;=0D
+  --disable-tpm) tpm=3D"no"=0D
+  ;;=0D
+  --enable-tpm) tpm=3D"yes"=0D
+  ;;=0D
+  --disable-libssh) libssh=3D"no"=0D
+  ;;=0D
+  --enable-libssh) libssh=3D"yes"=0D
+  ;;=0D
+  --disable-live-block-migration) live_block_migration=3D"no"=0D
+  ;;=0D
+  --enable-live-block-migration) live_block_migration=3D"yes"=0D
+  ;;=0D
+  --disable-numa) numa=3D"no"=0D
+  ;;=0D
+  --enable-numa) numa=3D"yes"=0D
+  ;;=0D
+  --disable-libxml2) libxml2=3D"no"=0D
+  ;;=0D
+  --enable-libxml2) libxml2=3D"yes"=0D
+  ;;=0D
+  --disable-tcmalloc) tcmalloc=3D"no"=0D
+  ;;=0D
+  --enable-tcmalloc) tcmalloc=3D"yes"=0D
+  ;;=0D
+  --disable-jemalloc) jemalloc=3D"no"=0D
+  ;;=0D
+  --enable-jemalloc) jemalloc=3D"yes"=0D
+  ;;=0D
+  --disable-replication) replication=3D"no"=0D
+  ;;=0D
+  --enable-replication) replication=3D"yes"=0D
+  ;;=0D
+  --disable-bochs) bochs=3D"no"=0D
+  ;;=0D
+  --enable-bochs) bochs=3D"yes"=0D
+  ;;=0D
+  --disable-cloop) cloop=3D"no"=0D
+  ;;=0D
+  --enable-cloop) cloop=3D"yes"=0D
+  ;;=0D
+  --disable-dmg) dmg=3D"no"=0D
+  ;;=0D
+  --enable-dmg) dmg=3D"yes"=0D
+  ;;=0D
+  --disable-qcow1) qcow1=3D"no"=0D
+  ;;=0D
+  --enable-qcow1) qcow1=3D"yes"=0D
+  ;;=0D
+  --disable-vdi) vdi=3D"no"=0D
+  ;;=0D
+  --enable-vdi) vdi=3D"yes"=0D
+  ;;=0D
+  --disable-vvfat) vvfat=3D"no"=0D
+  ;;=0D
+  --enable-vvfat) vvfat=3D"yes"=0D
+  ;;=0D
+  --disable-qed) qed=3D"no"=0D
+  ;;=0D
+  --enable-qed) qed=3D"yes"=0D
+  ;;=0D
+  --disable-parallels) parallels=3D"no"=0D
+  ;;=0D
+  --enable-parallels) parallels=3D"yes"=0D
+  ;;=0D
+  --disable-sheepdog) sheepdog=3D"no"=0D
+  ;;=0D
+  --enable-sheepdog) sheepdog=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-user) vhost_user=3D"no"=0D
+  ;;=0D
+  --enable-vhost-user) vhost_user=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-vdpa) vhost_vdpa=3D"no"=0D
+  ;;=0D
+  --enable-vhost-vdpa) vhost_vdpa=3D"yes"=0D
+  ;;=0D
+  --disable-vhost-kernel) vhost_kernel=3D"no"=0D
+  ;;=0D
+  --enable-vhost-kernel) vhost_kernel=3D"yes"=0D
+  ;;=0D
+  --disable-capstone) capstone=3D"no"=0D
+  ;;=0D
+  --enable-capstone) capstone=3D"yes"=0D
+  ;;=0D
+  --enable-capstone=3Dgit) capstone=3D"git"=0D
+  ;;=0D
+  --enable-capstone=3Dsystem) capstone=3D"system"=0D
+  ;;=0D
+  --with-git=3D*) git=3D"$optarg"=0D
+  ;;=0D
+  --enable-git-update) git_update=3Dyes=0D
+  ;;=0D
+  --disable-git-update) git_update=3Dno=0D
+  ;;=0D
+  --enable-debug-mutex) debug_mutex=3Dyes=0D
+  ;;=0D
+  --disable-debug-mutex) debug_mutex=3Dno=0D
+  ;;=0D
+  --enable-libpmem) libpmem=3Dyes=0D
+  ;;=0D
+  --disable-libpmem) libpmem=3Dno=0D
+  ;;=0D
+  --enable-xkbcommon) xkbcommon=3D"enabled"=0D
+  ;;=0D
+  --disable-xkbcommon) xkbcommon=3D"disabled"=0D
+  ;;=0D
+  --enable-plugins) plugins=3D"yes"=0D
+  ;;=0D
+  --disable-plugins) plugins=3D"no"=0D
+  ;;=0D
+  --enable-containers) use_containers=3D"yes"=0D
+  ;;=0D
+  --disable-containers) use_containers=3D"no"=0D
+  ;;=0D
+  --enable-fuzzing) fuzzing=3Dyes=0D
+  ;;=0D
+  --disable-fuzzing) fuzzing=3Dno=0D
+  ;;=0D
+  --gdb=3D*) gdb_bin=3D"$optarg"=0D
+  ;;=0D
+  --enable-rng-none) rng_none=3Dyes=0D
+  ;;=0D
+  --disable-rng-none) rng_none=3Dno=0D
+  ;;=0D
+  --enable-keyring) secret_keyring=3D"yes"=0D
+  ;;=0D
+  --disable-keyring) secret_keyring=3D"no"=0D
+  ;;=0D
+  --enable-libdaxctl) libdaxctl=3Dyes=0D
+  ;;=0D
+  --disable-libdaxctl) libdaxctl=3Dno=0D
+  ;;=0D
+  *)=0D
+      echo "ERROR: unknown option $opt"=0D
+      echo "Try '$0 --help' for more information"=0D
+      exit 1=0D
+  ;;=0D
+  esac=0D
+done=0D
+=0D
+firmwarepath=3D"${firmwarepath:-$prefix/share/qemu-firmware}"=0D
+libdir=3D"${libdir:-$prefix/lib}"=0D
+libexecdir=3D"${libexecdir:-$prefix/libexec}"=0D
+includedir=3D"${includedir:-$prefix/include}"=0D
+=0D
+if test "$mingw32" =3D "yes" ; then=0D
+    mandir=3D"$prefix"=0D
+    datadir=3D"$prefix"=0D
+    docdir=3D"$prefix"=0D
+    bindir=3D"$prefix"=0D
+    sysconfdir=3D"$prefix"=0D
+    local_statedir=3D=0D
+else=0D
+    mandir=3D"${mandir:-$prefix/share/man}"=0D
+    datadir=3D"${datadir:-$prefix/share}"=0D
+    docdir=3D"${docdir:-$prefix/share/doc}"=0D
+    bindir=3D"${bindir:-$prefix/bin}"=0D
+    sysconfdir=3D"${sysconfdir:-$prefix/etc}"=0D
+    local_statedir=3D"${local_statedir:-$prefix/var}"=0D
+fi=0D
+=0D
+case "$cpu" in=0D
+    ppc)=0D
+           CPU_CFLAGS=3D"-m32"=0D
+           QEMU_LDFLAGS=3D"-m32 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    ppc64)=0D
+           CPU_CFLAGS=3D"-m64"=0D
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    sparc)=0D
+           CPU_CFLAGS=3D"-m32 -mv8plus -mcpu=3Dultrasparc"=0D
+           QEMU_LDFLAGS=3D"-m32 -mv8plus $QEMU_LDFLAGS"=0D
+           ;;=0D
+    sparc64)=0D
+           CPU_CFLAGS=3D"-m64 -mcpu=3Dultrasparc"=0D
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    s390)=0D
+           CPU_CFLAGS=3D"-m31"=0D
+           QEMU_LDFLAGS=3D"-m31 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    s390x)=0D
+           CPU_CFLAGS=3D"-m64"=0D
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    i386)=0D
+           CPU_CFLAGS=3D"-m32"=0D
+           QEMU_LDFLAGS=3D"-m32 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    x86_64)=0D
+           # ??? Only extremely old AMD cpus do not have cmpxchg16b.=0D
+           # If we truly care, we should simply detect this case at=0D
+           # runtime and generate the fallback to serial emulation.=0D
+           CPU_CFLAGS=3D"-m64 -mcx16"=0D
+           QEMU_LDFLAGS=3D"-m64 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    x32)=0D
+           CPU_CFLAGS=3D"-mx32"=0D
+           QEMU_LDFLAGS=3D"-mx32 $QEMU_LDFLAGS"=0D
+           ;;=0D
+    # No special flags required for other host CPUs=0D
+esac=0D
+=0D
+eval "cross_cc_${cpu}=3D\$host_cc"=0D
+cross_cc_vars=3D"$cross_cc_vars cross_cc_${cpu}"=0D
+QEMU_CFLAGS=3D"$CPU_CFLAGS $QEMU_CFLAGS"=0D
+=0D
+# For user-mode emulation the host arch has to be one we explicitly=0D
+# support, even if we're using TCI.=0D
+if [ "$ARCH" =3D "unknown" ]; then=0D
+  bsd_user=3D"no"=0D
+  linux_user=3D"no"=0D
+fi=0D
+=0D
+if [ "$bsd_user" =3D "no" -a "$linux_user" =3D "no" -a "$softmmu" =3D "no"=
 ] ; then=0D
+  tcg=3D"no"=0D
+fi=0D
+=0D
+default_target_list=3D""=0D
+=0D
+mak_wilds=3D""=0D
+=0D
+if [ "$softmmu" =3D "yes" ]; then=0D
+    mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-softmmu.mak"=
=0D
+fi=0D
+if [ "$linux_user" =3D "yes" ]; then=0D
+    mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-linux-user.ma=
k"=0D
+fi=0D
+if [ "$bsd_user" =3D "yes" ]; then=0D
+    mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-bsd-user.mak"=
=0D
+fi=0D
+=0D
+if test -z "$target_list_exclude"; then=0D
+    for config in $mak_wilds; do=0D
+        default_target_list=3D"${default_target_list} $(basename "$config"=
 .mak)"=0D
+    done=0D
+else=0D
+    exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')=0D
+    for config in $mak_wilds; do=0D
+        target=3D"$(basename "$config" .mak)"=0D
+        exclude=3D"no"=0D
+        for excl in $exclude_list; do=0D
+            if test "$excl" =3D "$target"; then=0D
+                exclude=3D"yes"=0D
+                break;=0D
+            fi=0D
+        done=0D
+        if test "$exclude" =3D "no"; then=0D
+            default_target_list=3D"${default_target_list} $target"=0D
+        fi=0D
+    done=0D
+fi=0D
+=0D
+# Enumerate public trace backends for --help output=0D
+trace_backend_list=3D$(echo $(grep -le '^PUBLIC =3D True$' "$source_path"/=
scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))=0D
+=0D
+if test x"$show_help" =3D x"yes" ; then=0D
+cat << EOF=0D
+=0D
+Usage: configure [options]=0D
+Options: [defaults in brackets after descriptions]=0D
+=0D
+Standard options:=0D
+  --help                   print this message=0D
+  --prefix=3DPREFIX          install in PREFIX [$prefix]=0D
+  --interp-prefix=3DPREFIX   where to find shared libraries, etc.=0D
+                           use %M for cpu name [$interp_prefix]=0D
+  --target-list=3DLIST       set target list (default: build everything)=0D
+$(echo Available targets: $default_target_list | \=0D
+  fold -s -w 53 | sed -e 's/^/                           /')=0D
+  --target-list-exclude=3DLIST exclude a set of targets from the default t=
arget-list=0D
+=0D
+Advanced options (experts only):=0D
+  --cross-prefix=3DPREFIX    use PREFIX for compile tools [$cross_prefix]=
=0D
+  --cc=3DCC                  use C compiler CC [$cc]=0D
+  --iasl=3DIASL              use ACPI compiler IASL [$iasl]=0D
+  --host-cc=3DCC             use C compiler CC [$host_cc] for code run at=
=0D
+                           build time=0D
+  --cxx=3DCXX                use C++ compiler CXX [$cxx]=0D
+  --objcc=3DOBJCC            use Objective-C compiler OBJCC [$objcc]=0D
+  --extra-cflags=3DCFLAGS    append extra C compiler flags QEMU_CFLAGS=0D
+  --extra-cxxflags=3DCXXFLAGS append extra C++ compiler flags QEMU_CXXFLAG=
S=0D
+  --extra-ldflags=3DLDFLAGS  append extra linker flags LDFLAGS=0D
+  --cross-cc-ARCH=3DCC       use compiler when building ARCH guest test ca=
ses=0D
+  --cross-cc-flags-ARCH=3D   use compiler flags when building ARCH guest t=
ests=0D
+  --make=3DMAKE              use specified make [$make]=0D
+  --install=3DINSTALL        use specified install [$install]=0D
+  --python=3DPYTHON          use specified python [$python]=0D
+  --sphinx-build=3DSPHINX    use specified sphinx-build [$sphinx_build]=0D
+  --meson=3DMESON            use specified meson [$meson]=0D
+  --ninja=3DNINJA            use specified ninja [$ninja]=0D
+  --smbd=3DSMBD              use specified smbd [$smbd]=0D
+  --with-git=3DGIT           use specified git [$git]=0D
+  --static                 enable static build [$static]=0D
+  --mandir=3DPATH            install man pages in PATH=0D
+  --datadir=3DPATH           install firmware in PATH/$qemu_suffix=0D
+  --docdir=3DPATH            install documentation in PATH/$qemu_suffix=0D
+  --bindir=3DPATH            install binaries in PATH=0D
+  --libdir=3DPATH            install libraries in PATH=0D
+  --libexecdir=3DPATH        install helper binaries in PATH=0D
+  --sysconfdir=3DPATH        install config in PATH/$qemu_suffix=0D
+  --localstatedir=3DPATH     install local state in PATH (set at runtime o=
n win32)=0D
+  --firmwarepath=3DPATH      search PATH for firmware files=0D
+  --efi-aarch64=3DPATH       PATH of efi file to use for aarch64 VMs.=0D
+  --with-suffix=3DSUFFIX     suffix for QEMU data inside datadir/libdir/sy=
sconfdir/docdir [$qemu_suffix]=0D
+  --with-pkgversion=3DVERS   use specified string as sub-version of the pa=
ckage=0D
+  --enable-debug           enable common debug build options=0D
+  --enable-sanitizers      enable default sanitizers=0D
+  --enable-tsan            enable thread sanitizer=0D
+  --disable-strip          disable stripping binaries=0D
+  --disable-werror         disable compilation abort on warning=0D
+  --disable-stack-protector disable compiler-provided stack protection=0D
+  --audio-drv-list=3DLIST    set audio drivers list:=0D
+                           Available drivers: $audio_possible_drivers=0D
+  --block-drv-whitelist=3DL  Same as --block-drv-rw-whitelist=3DL=0D
+  --block-drv-rw-whitelist=3DL=0D
+                           set block driver read-write whitelist=0D
+                           (affects only QEMU, not qemu-img)=0D
+  --block-drv-ro-whitelist=3DL=0D
+                           set block driver read-only whitelist=0D
+                           (affects only QEMU, not qemu-img)=0D
+  --enable-trace-backends=3DB Set trace backend=0D
+                           Available backends: $trace_backend_list=0D
+  --with-trace-file=3DNAME   Full PATH,NAME of file to store traces=0D
+                           Default:trace-<pid>=0D
+  --disable-slirp          disable SLIRP userspace network connectivity=0D
+  --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)=0D
+  --enable-malloc-trim     enable libc malloc_trim() for memory optimizati=
on=0D
+  --oss-lib                path to OSS library=0D
+  --cpu=3DCPU                Build for host CPU [$cpu]=0D
+  --with-coroutine=3DBACKEND coroutine backend. Supported options:=0D
+                           ucontext, sigaltstack, windows=0D
+  --enable-gcov            enable test coverage analysis with gcov=0D
+  --disable-blobs          disable installing provided firmware blobs=0D
+  --with-vss-sdk=3DSDK-path  enable Windows VSS support in QEMU Guest Agen=
t=0D
+  --with-win-sdk=3DSDK-path  path to Windows Platform SDK (to build VSS .t=
lb)=0D
+  --tls-priority           default TLS protocol/cipher priority string=0D
+  --enable-gprof           QEMU profiling with gprof=0D
+  --enable-profiler        profiler support=0D
+  --enable-debug-stack-usage=0D
+                           track the maximum stack usage of stacks created=
 by qemu_alloc_stack=0D
+  --enable-plugins=0D
+                           enable plugins via shared library loading=0D
+  --disable-containers     don't use containers for cross-building=0D
+  --gdb=3DGDB-path           gdb to use for gdbstub tests [$gdb_bin]=0D
+=0D
+Optional features, enabled with --enable-FEATURE and=0D
+disabled with --disable-FEATURE, default is enabled if available:=0D
+=0D
+  system          all system emulation targets=0D
+  user            supported user emulation targets=0D
+  linux-user      all linux usermode emulation targets=0D
+  bsd-user        all BSD usermode emulation targets=0D
+  docs            build documentation=0D
+  guest-agent     build the QEMU Guest Agent=0D
+  guest-agent-msi build guest agent Windows MSI installation package=0D
+  pie             Position Independent Executables=0D
+  modules         modules support (non-Windows)=0D
+  module-upgrades try to load modules from alternate paths for upgrades=0D
+  debug-tcg       TCG debugging (default is disabled)=0D
+  debug-info      debugging information=0D
+  sparse          sparse checker=0D
+  safe-stack      SafeStack Stack Smash Protection. Depends on=0D
+                  clang/llvm >=3D 3.7 and requires coroutine backend ucont=
ext.=0D
+=0D
+  gnutls          GNUTLS cryptography support=0D
+  nettle          nettle cryptography support=0D
+  gcrypt          libgcrypt cryptography support=0D
+  auth-pam        PAM access control=0D
+  sdl             SDL UI=0D
+  sdl-image       SDL Image support for icons=0D
+  gtk             gtk UI=0D
+  vte             vte support for the gtk UI=0D
+  curses          curses UI=0D
+  iconv           font glyph conversion support=0D
+  vnc             VNC UI support=0D
+  vnc-sasl        SASL encryption for VNC server=0D
+  vnc-jpeg        JPEG lossy compression for VNC server=0D
+  vnc-png         PNG compression for VNC server=0D
+  cocoa           Cocoa UI (Mac OS X only)=0D
+  virtfs          VirtFS=0D
+  mpath           Multipath persistent reservation passthrough=0D
+  xen             xen backend driver support=0D
+  xen-pci-passthrough    PCI passthrough support for Xen=0D
+  brlapi          BrlAPI (Braile)=0D
+  curl            curl connectivity=0D
+  membarrier      membarrier system call (for Linux 4.14+ or Windows)=0D
+  fdt             fdt device tree=0D
+  kvm             KVM acceleration support=0D
+  hax             HAX acceleration support=0D
+  hvf             Hypervisor.framework acceleration support=0D
+  whpx            Windows Hypervisor Platform acceleration support=0D
+  rdma            Enable RDMA-based migration=0D
+  pvrdma          Enable PVRDMA support=0D
+  vde             support for vde network=0D
+  netmap          support for netmap network=0D
+  linux-aio       Linux AIO support=0D
+  linux-io-uring  Linux io_uring support=0D
+  cap-ng          libcap-ng support=0D
+  attr            attr and xattr support=0D
+  vhost-net       vhost-net kernel acceleration support=0D
+  vhost-vsock     virtio sockets device support=0D
+  vhost-scsi      vhost-scsi kernel target support=0D
+  vhost-crypto    vhost-user-crypto backend support=0D
+  vhost-kernel    vhost kernel backend support=0D
+  vhost-user      vhost-user backend support=0D
+  vhost-vdpa      vhost-vdpa kernel backend support=0D
+  spice           spice=0D
+  rbd             rados block device (rbd)=0D
+  libiscsi        iscsi support=0D
+  libnfs          nfs support=0D
+  smartcard       smartcard support (libcacard)=0D
+  u2f             U2F support (u2f-emu)=0D
+  libusb          libusb (for usb passthrough)=0D
+  live-block-migration   Block migration in the main migration stream=0D
+  usb-redir       usb network redirection support=0D
+  lzo             support of lzo compression library=0D
+  snappy          support of snappy compression library=0D
+  bzip2           support of bzip2 compression library=0D
+                  (for reading bzip2-compressed dmg images)=0D
+  lzfse           support of lzfse compression library=0D
+                  (for reading lzfse-compressed dmg images)=0D
+  zstd            support for zstd compression library=0D
+                  (for migration compression and qcow2 cluster compression=
)=0D
+  seccomp         seccomp support=0D
+  coroutine-pool  coroutine freelist (better performance)=0D
+  glusterfs       GlusterFS backend=0D
+  tpm             TPM support=0D
+  libssh          ssh block device support=0D
+  numa            libnuma support=0D
+  libxml2         for Parallels image format=0D
+  tcmalloc        tcmalloc support=0D
+  jemalloc        jemalloc support=0D
+  avx2            AVX2 optimization support=0D
+  avx512f         AVX512F optimization support=0D
+  replication     replication support=0D
+  opengl          opengl support=0D
+  virglrenderer   virgl rendering support=0D
+  xfsctl          xfsctl support=0D
+  qom-cast-debug  cast debugging support=0D
+  tools           build qemu-io, qemu-nbd and qemu-img tools=0D
+  bochs           bochs image format support=0D
+  cloop           cloop image format support=0D
+  dmg             dmg image format support=0D
+  qcow1           qcow v1 image format support=0D
+  vdi             vdi image format support=0D
+  vvfat           vvfat image format support=0D
+  qed             qed image format support=0D
+  parallels       parallels image format support=0D
+  sheepdog        sheepdog block driver support=0D
+  crypto-afalg    Linux AF_ALG crypto backend driver=0D
+  capstone        capstone disassembler support=0D
+  debug-mutex     mutex debugging support=0D
+  libpmem         libpmem support=0D
+  xkbcommon       xkbcommon support=0D
+  rng-none        dummy RNG, avoid using /dev/(u)random and getrandom()=0D
+  libdaxctl       libdaxctl support=0D
+=0D
+NOTE: The object files are built at the place where configure is launched=
=0D
+EOF=0D
+exit 0=0D
+fi=0D
+=0D
+# Remove old dependency files to make sure that they get properly regenera=
ted=0D
+rm -f */config-devices.mak.d=0D
+=0D
+if test -z "$python"=0D
+then=0D
+    error_exit "Python not found. Use --python=3D/path/to/python"=0D
+fi=0D
+=0D
+# Note that if the Python conditional here evaluates True we will exit=0D
+# with status 1 which is a shell 'false' value.=0D
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then=0D
+  error_exit "Cannot use '$python', Python >=3D 3.5 is required." \=0D
+      "Use --python=3D/path/to/python to specify a supported Python."=0D
+fi=0D
+=0D
+# Preserve python version since some functionality is dependent on it=0D
+python_version=3D$($python -c 'import sys; print("%d.%d.%d" % (sys.version=
_info[0], sys.version_info[1], sys.version_info[2]))' 2>/dev/null)=0D
+=0D
+# Suppress writing compiled files=0D
+python=3D"$python -B"=0D
+=0D
+if test -z "$meson"; then=0D
+    if test "$explicit_python" =3D no && has meson && version_ge "$(meson =
--version)" 0.55.1; then=0D
+        meson=3Dmeson=0D
+    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; the=
n=0D
+        meson=3Dgit=0D
+    elif test -e "${source_path}/meson/meson.py" ; then=0D
+        meson=3Dinternal=0D
+    else=0D
+        if test "$explicit_python" =3D yes; then=0D
+            error_exit "--python requires using QEMU's embedded Meson dist=
ribution, but it was not found."=0D
+        else=0D
+            error_exit "Meson not found.  Use --meson=3D/path/to/meson"=0D
+        fi=0D
+    fi=0D
+else=0D
+    # Meson uses its own Python interpreter to invoke other Python scripts=
,=0D
+    # but the user wants to use the one they specified with --python.=0D
+    #=0D
+    # We do not want to override the distro Python interpreter (and someti=
mes=0D
+    # cannot: for example in Homebrew /usr/bin/meson is a bash script), so=
=0D
+    # just require --meson=3Dgit|internal together with --python.=0D
+    if test "$explicit_python" =3D yes; then=0D
+        case "$meson" in=0D
+            git | internal) ;;=0D
+            *) error_exit "--python requires using QEMU's embedded Meson d=
istribution." ;;=0D
+        esac=0D
+    fi=0D
+fi=0D
+=0D
+if test "$meson" =3D git; then=0D
+    git_submodules=3D"${git_submodules} meson"=0D
+fi=0D
+=0D
+case "$meson" in=0D
+    git | internal)=0D
+        if ! $python -c 'import pkg_resources' > /dev/null 2>&1; then=0D
+            error_exit "Python setuptools not found"=0D
+        fi=0D
+        meson=3D"$python ${source_path}/meson/meson.py"=0D
+        ;;=0D
+    *) meson=3D$(command -v meson) ;;=0D
+esac=0D
+=0D
+# Probe for ninja (used for compdb)=0D
+=0D
+if test -z "$ninja"; then=0D
+    for c in ninja ninja-build samu; do=0D
+        if has $c; then=0D
+            ninja=3D$(command -v "$c")=0D
+            break=0D
+        fi=0D
+    done=0D
+fi=0D
+=0D
+# Check that the C compiler works. Doing this here before testing=0D
+# the host CPU ensures that we had a valid CC to autodetect the=0D
+# $cpu var (and we should bail right here if that's not the case).=0D
+# It also allows the help message to be printed without a CC.=0D
+write_c_skeleton;=0D
+if compile_object ; then=0D
+  : C compiler works ok=0D
+else=0D
+    error_exit "\"$cc\" either does not exist or does not work"=0D
+fi=0D
+if ! compile_prog ; then=0D
+    error_exit "\"$cc\" cannot build an executable (is your linker broken?=
)"=0D
+fi=0D
+=0D
+# Now we have handled --enable-tcg-interpreter and know we're not just=0D
+# printing the help message, bail out if the host CPU isn't supported.=0D
+if test "$ARCH" =3D "unknown"; then=0D
+    if test "$tcg_interpreter" =3D "yes" ; then=0D
+        echo "Unsupported CPU =3D $cpu, will use TCG with TCI (experimenta=
l)"=0D
+    else=0D
+        error_exit "Unsupported CPU =3D $cpu, try --enable-tcg-interpreter=
"=0D
+    fi=0D
+fi=0D
+=0D
+# Consult white-list to determine whether to enable werror=0D
+# by default.  Only enable by default for git builds=0D
+if test -z "$werror" ; then=0D
+    if test -e "$source_path/.git" && \=0D
+        { test "$linux" =3D "yes" || test "$mingw32" =3D "yes"; }; then=0D
+        werror=3D"yes"=0D
+    else=0D
+        werror=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+if test "$bogus_os" =3D "yes"; then=0D
+    # Now that we know that we're not printing the help and that=0D
+    # the compiler works (so the results of the check_defines we used=0D
+    # to identify the OS are reliable), if we didn't recognize the=0D
+    # host OS we should stop now.=0D
+    error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"=0D
+fi=0D
+=0D
+# Check whether the compiler matches our minimum requirements:=0D
+cat > $TMPC << EOF=0D
+#if defined(__clang_major__) && defined(__clang_minor__)=0D
+# ifdef __apple_build_version__=0D
+#  if __clang_major__ < 5 || (__clang_major__ =3D=3D 5 && __clang_minor__ =
< 1)=0D
+#   error You need at least XCode Clang v5.1 to compile QEMU=0D
+#  endif=0D
+# else=0D
+#  if __clang_major__ < 3 || (__clang_major__ =3D=3D 3 && __clang_minor__ =
< 4)=0D
+#   error You need at least Clang v3.4 to compile QEMU=0D
+#  endif=0D
+# endif=0D
+#elif defined(__GNUC__) && defined(__GNUC_MINOR__)=0D
+# if __GNUC__ < 4 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ < 8)=0D
+#  error You need at least GCC v4.8 to compile QEMU=0D
+# endif=0D
+#else=0D
+# error You either need GCC or Clang to compiler QEMU=0D
+#endif=0D
+int main (void) { return 0; }=0D
+EOF=0D
+if ! compile_prog "" "" ; then=0D
+    error_exit "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v=
5.1)"=0D
+fi=0D
+=0D
+# Accumulate -Wfoo and -Wno-bar separately.=0D
+# We will list all of the enable flags first, and the disable flags second=
.=0D
+# Note that we do not add -Werror, because that would enable it for all=0D
+# configure tests. If a configure test failed due to -Werror this would=0D
+# just silently disable some features, so it's too error prone.=0D
+=0D
+warn_flags=3D=0D
+add_to warn_flags -Wold-style-declaration=0D
+add_to warn_flags -Wold-style-definition=0D
+add_to warn_flags -Wtype-limits=0D
+add_to warn_flags -Wformat-security=0D
+add_to warn_flags -Wformat-y2k=0D
+add_to warn_flags -Winit-self=0D
+add_to warn_flags -Wignored-qualifiers=0D
+add_to warn_flags -Wempty-body=0D
+add_to warn_flags -Wnested-externs=0D
+add_to warn_flags -Wendif-labels=0D
+add_to warn_flags -Wexpansion-to-defined=0D
+=0D
+nowarn_flags=3D=0D
+add_to nowarn_flags -Wno-initializer-overrides=0D
+add_to nowarn_flags -Wno-missing-include-dirs=0D
+add_to nowarn_flags -Wno-shift-negative-value=0D
+add_to nowarn_flags -Wno-string-plus-int=0D
+add_to nowarn_flags -Wno-typedef-redefinition=0D
+add_to nowarn_flags -Wno-tautological-type-limit-compare=0D
+add_to nowarn_flags -Wno-psabi=0D
+=0D
+gcc_flags=3D"$warn_flags $nowarn_flags"=0D
+=0D
+cc_has_warning_flag() {=0D
+    write_c_skeleton;=0D
+=0D
+    # Use the positive sense of the flag when testing for -Wno-wombat=0D
+    # support (gcc will happily accept the -Wno- form of unknown=0D
+    # warning options).=0D
+    optflag=3D"$(echo $1 | sed -e 's/^-Wno-/-W/')"=0D
+    compile_prog "-Werror $optflag" ""=0D
+}=0D
+=0D
+for flag in $gcc_flags; do=0D
+    if cc_has_warning_flag $flag ; then=0D
+        QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"=0D
+    fi=0D
+done=0D
+=0D
+if test "$stack_protector" !=3D "no"; then=0D
+  cat > $TMPC << EOF=0D
+int main(int argc, char *argv[])=0D
+{=0D
+    char arr[64], *p =3D arr, *c =3D argv[0];=0D
+    while (*c) {=0D
+        *p++ =3D *c++;=0D
+    }=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  gcc_flags=3D"-fstack-protector-strong -fstack-protector-all"=0D
+  sp_on=3D0=0D
+  for flag in $gcc_flags; do=0D
+    # We need to check both a compile and a link, since some compiler=0D
+    # setups fail only on a .c->.o compile and some only at link time=0D
+    if compile_object "-Werror $flag" &&=0D
+       compile_prog "-Werror $flag" ""; then=0D
+      QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"=0D
+      QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $flag"=0D
+      sp_on=3D1=0D
+      break=0D
+    fi=0D
+  done=0D
+  if test "$stack_protector" =3D yes; then=0D
+    if test $sp_on =3D 0; then=0D
+      error_exit "Stack protector not supported"=0D
+    fi=0D
+  fi=0D
+fi=0D
+=0D
+# Disable -Wmissing-braces on older compilers that warn even for=0D
+# the "universal" C zero initializer {0}.=0D
+cat > $TMPC << EOF=0D
+struct {=0D
+  int a[2];=0D
+} x =3D {0};=0D
+EOF=0D
+if compile_object "-Werror" "" ; then=0D
+  :=0D
+else=0D
+  QEMU_CFLAGS=3D"$QEMU_CFLAGS -Wno-missing-braces"=0D
+fi=0D
+=0D
+# Our module code doesn't support Windows=0D
+if test "$modules" =3D "yes" && test "$mingw32" =3D "yes" ; then=0D
+  error_exit "Modules are not available for Windows"=0D
+fi=0D
+=0D
+# module_upgrades is only reasonable if modules are enabled=0D
+if test "$modules" =3D "no" && test "$module_upgrades" =3D "yes" ; then=0D
+  error_exit "Can't enable module-upgrades as Modules are not enabled"=0D
+fi=0D
+=0D
+# Static linking is not possible with modules or PIE=0D
+if test "$static" =3D "yes" ; then=0D
+  if test "$modules" =3D "yes" ; then=0D
+    error_exit "static and modules are mutually incompatible"=0D
+  fi=0D
+fi=0D
+=0D
+# Unconditional check for compiler __thread support=0D
+  cat > $TMPC << EOF=0D
+static __thread int tls_var;=0D
+int main(void) { return tls_var; }=0D
+EOF=0D
+=0D
+if ! compile_prog "-Werror" "" ; then=0D
+    error_exit "Your compiler does not support the __thread specifier for =
" \=0D
+	"Thread-Local Storage (TLS). Please upgrade to a version that does."=0D
+fi=0D
+=0D
+cat > $TMPC << EOF=0D
+=0D
+#ifdef __linux__=0D
+#  define THREAD __thread=0D
+#else=0D
+#  define THREAD=0D
+#endif=0D
+static THREAD int tls_var;=0D
+int main(void) { return tls_var; }=0D
+EOF=0D
+=0D
+# Check we support --no-pie first; we will need this for building ROMs.=0D
+if compile_prog "-Werror -fno-pie" "-no-pie"; then=0D
+  CFLAGS_NOPIE=3D"-fno-pie"=0D
+  LDFLAGS_NOPIE=3D"-no-pie"=0D
+fi=0D
+=0D
+if test "$static" =3D "yes"; then=0D
+  if test "$pie" !=3D "no" && compile_prog "-Werror -fPIE -DPIE" "-static-=
pie"; then=0D
+    CFLAGS=3D"-fPIE -DPIE $CFLAGS"=0D
+    QEMU_LDFLAGS=3D"-static-pie $QEMU_LDFLAGS"=0D
+    pie=3D"yes"=0D
+  elif test "$pie" =3D "yes"; then=0D
+    error_exit "-static-pie not available due to missing toolchain support=
"=0D
+  else=0D
+    QEMU_LDFLAGS=3D"-static $QEMU_LDFLAGS"=0D
+    pie=3D"no"=0D
+  fi=0D
+elif test "$pie" =3D "no"; then=0D
+  CFLAGS=3D"$CFLAGS_NOPIE $CFLAGS"=0D
+  LDFLAGS=3D"$LDFLAGS_NOPIE $LDFLAGS"=0D
+elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then=0D
+  CFLAGS=3D"-fPIE -DPIE $CFLAGS"=0D
+  LDFLAGS=3D"-pie $LDFLAGS"=0D
+  pie=3D"yes"=0D
+elif test "$pie" =3D "yes"; then=0D
+  error_exit "PIE not available due to missing toolchain support"=0D
+else=0D
+  echo "Disabling PIE due to missing toolchain support"=0D
+  pie=3D"no"=0D
+fi=0D
+=0D
+# Detect support for PT_GNU_RELRO + DT_BIND_NOW.=0D
+# The combination is known as "full relro", because .got.plt is read-only =
too.=0D
+if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then=0D
+  QEMU_LDFLAGS=3D"-Wl,-z,relro -Wl,-z,now $QEMU_LDFLAGS"=0D
+fi=0D
+=0D
+##########################################=0D
+# __sync_fetch_and_and requires at least -march=3Di486. Many toolchains=0D
+# use i686 as default anyway, but for those that don't, an explicit=0D
+# specification is necessary=0D
+=0D
+if test "$cpu" =3D "i386"; then=0D
+  cat > $TMPC << EOF=0D
+static int sfaa(int *ptr)=0D
+{=0D
+  return __sync_fetch_and_and(ptr, 0);=0D
+}=0D
+=0D
+int main(void)=0D
+{=0D
+  int val =3D 42;=0D
+  val =3D __sync_val_compare_and_swap(&val, 0, 1);=0D
+  sfaa(&val);=0D
+  return val;=0D
+}=0D
+EOF=0D
+  if ! compile_prog "" "" ; then=0D
+    QEMU_CFLAGS=3D"-march=3Di486 $QEMU_CFLAGS"=0D
+  fi=0D
+fi=0D
+=0D
+#########################################=0D
+# Solaris specific configure tool chain decisions=0D
+=0D
+if test "$solaris" =3D "yes" ; then=0D
+  if has $install; then=0D
+    :=0D
+  else=0D
+    error_exit "Solaris install program not found. Use --install=3D/usr/uc=
b/install or" \=0D
+        "install fileutils from www.blastwave.org using pkg-get -i fileuti=
ls" \=0D
+        "to get ginstall which is used by default (which lives in /opt/csw=
/bin)"=0D
+  fi=0D
+  if test "$(path_of $install)" =3D "/usr/sbin/install" ; then=0D
+    error_exit "Solaris /usr/sbin/install is not an appropriate install pr=
ogram." \=0D
+        "try ginstall from the GNU fileutils available from www.blastwave.=
org" \=0D
+        "using pkg-get -i fileutils, or use --install=3D/usr/ucb/install"=
=0D
+  fi=0D
+  if has ar; then=0D
+    :=0D
+  else=0D
+    if test -f /usr/ccs/bin/ar ; then=0D
+      error_exit "No path includes ar" \=0D
+          "Add /usr/ccs/bin to your path and rerun configure"=0D
+    fi=0D
+    error_exit "No path includes ar"=0D
+  fi=0D
+fi=0D
+=0D
+if test -z "${target_list+xxx}" ; then=0D
+    for target in $default_target_list; do=0D
+        supported_target $target 2>/dev/null && \=0D
+            target_list=3D"$target_list $target"=0D
+    done=0D
+    target_list=3D"${target_list# }"=0D
+else=0D
+    target_list=3D$(echo "$target_list" | sed -e 's/,/ /g')=0D
+    for target in $target_list; do=0D
+        # Check that we recognised the target name; this allows a more=0D
+        # friendly error message than if we let it fall through.=0D
+        case " $default_target_list " in=0D
+            *" $target "*)=0D
+                ;;=0D
+            *)=0D
+                error_exit "Unknown target name '$target'"=0D
+                ;;=0D
+        esac=0D
+        supported_target $target || exit 1=0D
+    done=0D
+fi=0D
+=0D
+# see if system emulation was really requested=0D
+case " $target_list " in=0D
+  *"-softmmu "*) softmmu=3Dyes=0D
+  ;;=0D
+  *) softmmu=3Dno=0D
+  ;;=0D
+esac=0D
+=0D
+for target in $target_list; do=0D
+  case "$target" in=0D
+    arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)=0D
+      edk2_blobs=3D"yes"=0D
+      ;;=0D
+  esac=0D
+done=0D
+# The EDK2 binaries are compressed with bzip2=0D
+if test "$edk2_blobs" =3D "yes" && ! has bzip2; then=0D
+  error_exit "The bzip2 program is required for building QEMU"=0D
+fi=0D
+=0D
+feature_not_found() {=0D
+  feature=3D$1=0D
+  remedy=3D$2=0D
+=0D
+  error_exit "User requested feature $feature" \=0D
+      "configure was not able to find it." \=0D
+      "$remedy"=0D
+}=0D
+=0D
+# ---=0D
+# big/little endian test=0D
+cat > $TMPC << EOF=0D
+short big_endian[] =3D { 0x4269, 0x4765, 0x4e64, 0x4961, 0x4e00, 0, };=0D
+short little_endian[] =3D { 0x694c, 0x7454, 0x654c, 0x6e45, 0x6944, 0x6e41=
, 0, };=0D
+extern int foo(short *, short *);=0D
+int main(int argc, char *argv[]) {=0D
+    return foo(big_endian, little_endian);=0D
+}=0D
+EOF=0D
+=0D
+if compile_object ; then=0D
+    if strings -a $TMPO | grep -q BiGeNdIaN ; then=0D
+        bigendian=3D"yes"=0D
+    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then=0D
+        bigendian=3D"no"=0D
+    else=0D
+        echo big/little test failed=0D
+    fi=0D
+else=0D
+    echo big/little test failed=0D
+fi=0D
+=0D
+##########################################=0D
+# system tools=0D
+if test -z "$want_tools"; then=0D
+    if test "$softmmu" =3D "no"; then=0D
+        want_tools=3Dno=0D
+    else=0D
+        want_tools=3Dyes=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# cocoa implies not SDL or GTK=0D
+# (the cocoa UI code currently assumes it is always the active UI=0D
+# and doesn't interact well with other UI frontend code)=0D
+if test "$cocoa" =3D "yes"; then=0D
+    if test "$sdl" =3D "yes"; then=0D
+        error_exit "Cocoa and SDL UIs cannot both be enabled at once"=0D
+    fi=0D
+    if test "$gtk" =3D "yes"; then=0D
+        error_exit "Cocoa and GTK UIs cannot both be enabled at once"=0D
+    fi=0D
+    gtk=3Dno=0D
+    sdl=3Ddisabled=0D
+fi=0D
+=0D
+# Some versions of Mac OS X incorrectly define SIZE_MAX=0D
+cat > $TMPC << EOF=0D
+#include <stdint.h>=0D
+#include <stdio.h>=0D
+int main(int argc, char *argv[]) {=0D
+    return printf("%zu", SIZE_MAX);=0D
+}=0D
+EOF=0D
+have_broken_size_max=3Dno=0D
+if ! compile_object -Werror ; then=0D
+    have_broken_size_max=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# L2TPV3 probe=0D
+=0D
+cat > $TMPC <<EOF=0D
+#include <sys/socket.h>=0D
+#include <linux/ip.h>=0D
+int main(void) { return sizeof(struct mmsghdr); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  l2tpv3=3Dyes=0D
+else=0D
+  l2tpv3=3Dno=0D
+fi=0D
+=0D
+if check_include "pty.h" ; then=0D
+  pty_h=3Dyes=0D
+else=0D
+  pty_h=3Dno=0D
+fi=0D
+=0D
+cat > $TMPC <<EOF=0D
+#include <sys/mman.h>=0D
+int main(int argc, char *argv[]) {=0D
+    return mlockall(MCL_FUTURE);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  have_mlockall=3Dyes=0D
+else=0D
+  have_mlockall=3Dno=0D
+fi=0D
+=0D
+#########################################=0D
+# vhost interdependencies and host support=0D
+=0D
+# vhost backends=0D
+test "$vhost_user" =3D "" && vhost_user=3Dyes=0D
+if test "$vhost_user" =3D "yes" && test "$mingw32" =3D "yes"; then=0D
+  error_exit "vhost-user isn't available on win32"=0D
+fi=0D
+test "$vhost_vdpa" =3D "" && vhost_vdpa=3D$linux=0D
+if test "$vhost_vdpa" =3D "yes" && test "$linux" !=3D "yes"; then=0D
+  error_exit "vhost-vdpa is only available on Linux"=0D
+fi=0D
+test "$vhost_kernel" =3D "" && vhost_kernel=3D$linux=0D
+if test "$vhost_kernel" =3D "yes" && test "$linux" !=3D "yes"; then=0D
+  error_exit "vhost-kernel is only available on Linux"=0D
+fi=0D
+=0D
+# vhost-kernel devices=0D
+test "$vhost_scsi" =3D "" && vhost_scsi=3D$vhost_kernel=0D
+if test "$vhost_scsi" =3D "yes" && test "$vhost_kernel" !=3D "yes"; then=0D
+  error_exit "--enable-vhost-scsi requires --enable-vhost-kernel"=0D
+fi=0D
+test "$vhost_vsock" =3D "" && vhost_vsock=3D$vhost_kernel=0D
+if test "$vhost_vsock" =3D "yes" && test "$vhost_kernel" !=3D "yes"; then=
=0D
+  error_exit "--enable-vhost-vsock requires --enable-vhost-kernel"=0D
+fi=0D
+=0D
+# vhost-user backends=0D
+test "$vhost_net_user" =3D "" && vhost_net_user=3D$vhost_user=0D
+if test "$vhost_net_user" =3D "yes" && test "$vhost_user" =3D "no"; then=0D
+  error_exit "--enable-vhost-net-user requires --enable-vhost-user"=0D
+fi=0D
+test "$vhost_crypto" =3D "" && vhost_crypto=3D$vhost_user=0D
+if test "$vhost_crypto" =3D "yes" && test "$vhost_user" =3D "no"; then=0D
+  error_exit "--enable-vhost-crypto requires --enable-vhost-user"=0D
+fi=0D
+test "$vhost_user_fs" =3D "" && vhost_user_fs=3D$vhost_user=0D
+if test "$vhost_user_fs" =3D "yes" && test "$vhost_user" =3D "no"; then=0D
+  error_exit "--enable-vhost-user-fs requires --enable-vhost-user"=0D
+fi=0D
+#vhost-vdpa backends=0D
+test "$vhost_net_vdpa" =3D "" && vhost_net_vdpa=3D$vhost_vdpa=0D
+if test "$vhost_net_vdpa" =3D "yes" && test "$vhost_vdpa" =3D "no"; then=0D
+  error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"=0D
+fi=0D
+=0D
+# OR the vhost-kernel and vhost-user values for simplicity=0D
+if test "$vhost_net" =3D ""; then=0D
+  test "$vhost_net_user" =3D "yes" && vhost_net=3Dyes=0D
+  test "$vhost_kernel" =3D "yes" && vhost_net=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# MinGW / Mingw-w64 localtime_r/gmtime_r check=0D
+=0D
+if test "$mingw32" =3D "yes"; then=0D
+    # Some versions of MinGW / Mingw-w64 lack localtime_r=0D
+    # and gmtime_r entirely.=0D
+    #=0D
+    # Some versions of Mingw-w64 define a macro for=0D
+    # localtime_r/gmtime_r.=0D
+    #=0D
+    # Some versions of Mingw-w64 will define functions=0D
+    # for localtime_r/gmtime_r, but only if you have=0D
+    # _POSIX_THREAD_SAFE_FUNCTIONS defined. For fun=0D
+    # though, unistd.h and pthread.h both define=0D
+    # that for you.=0D
+    #=0D
+    # So this #undef localtime_r and #include <unistd.h>=0D
+    # are not in fact redundant.=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+#include <time.h>=0D
+#undef localtime_r=0D
+int main(void) { localtime_r(NULL, NULL); return 0; }=0D
+EOF=0D
+    if compile_prog "" "" ; then=0D
+        localtime_r=3D"yes"=0D
+    else=0D
+        localtime_r=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# pkg-config probe=0D
+=0D
+if ! has "$pkg_config_exe"; then=0D
+  error_exit "pkg-config binary '$pkg_config_exe' not found"=0D
+fi=0D
+=0D
+##########################################=0D
+# NPTL probe=0D
+=0D
+if test "$linux_user" =3D "yes"; then=0D
+  cat > $TMPC <<EOF=0D
+#include <sched.h>=0D
+#include <linux/futex.h>=0D
+int main(void) {=0D
+#if !defined(CLONE_SETTLS) || !defined(FUTEX_WAIT)=0D
+#error bork=0D
+#endif=0D
+  return 0;=0D
+}=0D
+EOF=0D
+  if ! compile_object ; then=0D
+    feature_not_found "nptl" "Install glibc and linux kernel headers."=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# lzo check=0D
+=0D
+if test "$lzo" !=3D "no" ; then=0D
+    cat > $TMPC << EOF=0D
+#include <lzo/lzo1x.h>=0D
+int main(void) { lzo_version(); return 0; }=0D
+EOF=0D
+    if compile_prog "" "-llzo2" ; then=0D
+        lzo_libs=3D"-llzo2"=0D
+        lzo=3D"yes"=0D
+    else=0D
+        if test "$lzo" =3D "yes"; then=0D
+            feature_not_found "liblzo2" "Install liblzo2 devel"=0D
+        fi=0D
+        lzo=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# snappy check=0D
+=0D
+if test "$snappy" !=3D "no" ; then=0D
+    cat > $TMPC << EOF=0D
+#include <snappy-c.h>=0D
+int main(void) { snappy_max_compressed_length(4096); return 0; }=0D
+EOF=0D
+    if compile_prog "" "-lsnappy" ; then=0D
+        snappy_libs=3D'-lsnappy'=0D
+        snappy=3D"yes"=0D
+    else=0D
+        if test "$snappy" =3D "yes"; then=0D
+            feature_not_found "libsnappy" "Install libsnappy devel"=0D
+        fi=0D
+        snappy=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# bzip2 check=0D
+=0D
+if test "$bzip2" !=3D "no" ; then=0D
+    cat > $TMPC << EOF=0D
+#include <bzlib.h>=0D
+int main(void) { BZ2_bzlibVersion(); return 0; }=0D
+EOF=0D
+    if compile_prog "" "-lbz2" ; then=0D
+        bzip2=3D"yes"=0D
+    else=0D
+        if test "$bzip2" =3D "yes"; then=0D
+            feature_not_found "libbzip2" "Install libbzip2 devel"=0D
+        fi=0D
+        bzip2=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# lzfse check=0D
+=0D
+if test "$lzfse" !=3D "no" ; then=0D
+    cat > $TMPC << EOF=0D
+#include <lzfse.h>=0D
+int main(void) { lzfse_decode_scratch_size(); return 0; }=0D
+EOF=0D
+    if compile_prog "" "-llzfse" ; then=0D
+        lzfse=3D"yes"=0D
+    else=0D
+        if test "$lzfse" =3D "yes"; then=0D
+            feature_not_found "lzfse" "Install lzfse devel"=0D
+        fi=0D
+        lzfse=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# zstd check=0D
+=0D
+if test "$zstd" !=3D "no" ; then=0D
+    libzstd_minver=3D"1.4.0"=0D
+    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then=0D
+        zstd_cflags=3D"$($pkg_config --cflags libzstd)"=0D
+        zstd_libs=3D"$($pkg_config --libs libzstd)"=0D
+        zstd=3D"yes"=0D
+    else=0D
+        if test "$zstd" =3D "yes" ; then=0D
+            feature_not_found "libzstd" "Install libzstd devel"=0D
+        fi=0D
+        zstd=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# libseccomp check=0D
+=0D
+if test "$seccomp" !=3D "no" ; then=0D
+    libseccomp_minver=3D"2.3.0"=0D
+    if $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; the=
n=0D
+        seccomp_cflags=3D"$($pkg_config --cflags libseccomp)"=0D
+        seccomp_libs=3D"$($pkg_config --libs libseccomp)"=0D
+        seccomp=3D"yes"=0D
+    else=0D
+        if test "$seccomp" =3D "yes" ; then=0D
+            feature_not_found "libseccomp" \=0D
+                 "Install libseccomp devel >=3D $libseccomp_minver"=0D
+        fi=0D
+        seccomp=3D"no"=0D
+    fi=0D
+fi=0D
+##########################################=0D
+# xen probe=0D
+=0D
+if test "$xen" !=3D "no" ; then=0D
+  # Check whether Xen library path is specified via --extra-ldflags to avo=
id=0D
+  # overriding this setting with pkg-config output. If not, try pkg-config=
=0D
+  # to obtain all needed flags.=0D
+=0D
+  if ! echo $EXTRA_LDFLAGS | grep tools/libxc > /dev/null && \=0D
+     $pkg_config --exists xencontrol ; then=0D
+    xen_ctrl_version=3D"$(printf '%d%02d%02d' \=0D
+      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"=0D
+    xen=3Dyes=0D
+    xen_pc=3D"xencontrol xenstore xenguest xenforeignmemory xengnttab"=0D
+    xen_pc=3D"$xen_pc xenevtchn xendevicemodel"=0D
+    if $pkg_config --exists xentoolcore; then=0D
+      xen_pc=3D"$xen_pc xentoolcore"=0D
+    fi=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"=0D
+    xen_cflags=3D"$($pkg_config --cflags $xen_pc)"=0D
+    xen_libs=3D"$($pkg_config --libs $xen_pc)"=0D
+  else=0D
+=0D
+    xen_libs=3D"-lxenstore -lxenctrl -lxenguest"=0D
+    xen_stable_libs=3D"-lxenforeignmemory -lxengnttab -lxenevtchn"=0D
+=0D
+    # First we test whether Xen headers and libraries are available.=0D
+    # If no, we are done and there is no Xen support.=0D
+    # If yes, more tests are run to detect the Xen version.=0D
+=0D
+    # Xen (any)=0D
+    cat > $TMPC <<EOF=0D
+#include <xenctrl.h>=0D
+int main(void) {=0D
+  return 0;=0D
+}=0D
+EOF=0D
+    if ! compile_prog "" "$xen_libs" ; then=0D
+      # Xen not found=0D
+      if test "$xen" =3D "yes" ; then=0D
+        feature_not_found "xen" "Install xen devel"=0D
+      fi=0D
+      xen=3Dno=0D
+=0D
+    # Xen unstable=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+#undef XC_WANT_COMPAT_DEVICEMODEL_API=0D
+#define __XEN_TOOLS__=0D
+#include <xendevicemodel.h>=0D
+#include <xenforeignmemory.h>=0D
+int main(void) {=0D
+  xendevicemodel_handle *xd;=0D
+  xenforeignmemory_handle *xfmem;=0D
+=0D
+  xd =3D xendevicemodel_open(0, 0);=0D
+  xendevicemodel_pin_memory_cacheattr(xd, 0, 0, 0, 0);=0D
+=0D
+  xfmem =3D xenforeignmemory_open(0, 0);=0D
+  xenforeignmemory_map_resource(xfmem, 0, 0, 0, 0, 0, NULL, 0, 0);=0D
+=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxen=
toolcore"=0D
+      then=0D
+      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs -lxentoolcore"=
=0D
+      xen_ctrl_version=3D41100=0D
+      xen=3Dyes=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+#undef XC_WANT_COMPAT_MAP_FOREIGN_API=0D
+#include <xenforeignmemory.h>=0D
+#include <xentoolcore.h>=0D
+int main(void) {=0D
+  xenforeignmemory_handle *xfmem;=0D
+=0D
+  xfmem =3D xenforeignmemory_open(0, 0);=0D
+  xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);=0D
+  xentoolcore_restrict_all(0);=0D
+=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs -lxen=
toolcore"=0D
+      then=0D
+      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs -lxentoolcore"=
=0D
+      xen_ctrl_version=3D41000=0D
+      xen=3Dyes=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+#undef XC_WANT_COMPAT_DEVICEMODEL_API=0D
+#define __XEN_TOOLS__=0D
+#include <xendevicemodel.h>=0D
+int main(void) {=0D
+  xendevicemodel_handle *xd;=0D
+=0D
+  xd =3D xendevicemodel_open(0, 0);=0D
+  xendevicemodel_close(xd);=0D
+=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"=0D
+      then=0D
+      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs"=0D
+      xen_ctrl_version=3D40900=0D
+      xen=3Dyes=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+/*=0D
+ * If we have stable libs the we don't want the libxc compat=0D
+ * layers, regardless of what CFLAGS we may have been given.=0D
+ *=0D
+ * Also, check if xengnttab_grant_copy_segment_t is defined and=0D
+ * grant copy operation is implemented.=0D
+ */=0D
+#undef XC_WANT_COMPAT_EVTCHN_API=0D
+#undef XC_WANT_COMPAT_GNTTAB_API=0D
+#undef XC_WANT_COMPAT_MAP_FOREIGN_API=0D
+#include <xenctrl.h>=0D
+#include <xenstore.h>=0D
+#include <xenevtchn.h>=0D
+#include <xengnttab.h>=0D
+#include <xenforeignmemory.h>=0D
+#include <stdint.h>=0D
+#include <xen/hvm/hvm_info_table.h>=0D
+#if !defined(HVM_MAX_VCPUS)=0D
+# error HVM_MAX_VCPUS not defined=0D
+#endif=0D
+int main(void) {=0D
+  xc_interface *xc =3D NULL;=0D
+  xenforeignmemory_handle *xfmem;=0D
+  xenevtchn_handle *xe;=0D
+  xengnttab_handle *xg;=0D
+  xengnttab_grant_copy_segment_t* seg =3D NULL;=0D
+=0D
+  xs_daemon_open();=0D
+=0D
+  xc =3D xc_interface_open(0, 0, 0);=0D
+  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);=0D
+  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);=0D
+  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);=0D
+  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);=0D
+=0D
+  xfmem =3D xenforeignmemory_open(0, 0);=0D
+  xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);=0D
+=0D
+  xe =3D xenevtchn_open(0, 0);=0D
+  xenevtchn_fd(xe);=0D
+=0D
+  xg =3D xengnttab_open(0, 0);=0D
+  xengnttab_grant_copy(xg, 0, seg);=0D
+=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs $xen_stable_libs"=0D
+      then=0D
+      xen_ctrl_version=3D40800=0D
+      xen=3Dyes=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+/*=0D
+ * If we have stable libs the we don't want the libxc compat=0D
+ * layers, regardless of what CFLAGS we may have been given.=0D
+ */=0D
+#undef XC_WANT_COMPAT_EVTCHN_API=0D
+#undef XC_WANT_COMPAT_GNTTAB_API=0D
+#undef XC_WANT_COMPAT_MAP_FOREIGN_API=0D
+#include <xenctrl.h>=0D
+#include <xenstore.h>=0D
+#include <xenevtchn.h>=0D
+#include <xengnttab.h>=0D
+#include <xenforeignmemory.h>=0D
+#include <stdint.h>=0D
+#include <xen/hvm/hvm_info_table.h>=0D
+#if !defined(HVM_MAX_VCPUS)=0D
+# error HVM_MAX_VCPUS not defined=0D
+#endif=0D
+int main(void) {=0D
+  xc_interface *xc =3D NULL;=0D
+  xenforeignmemory_handle *xfmem;=0D
+  xenevtchn_handle *xe;=0D
+  xengnttab_handle *xg;=0D
+=0D
+  xs_daemon_open();=0D
+=0D
+  xc =3D xc_interface_open(0, 0, 0);=0D
+  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);=0D
+  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);=0D
+  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);=0D
+  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);=0D
+=0D
+  xfmem =3D xenforeignmemory_open(0, 0);=0D
+  xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);=0D
+=0D
+  xe =3D xenevtchn_open(0, 0);=0D
+  xenevtchn_fd(xe);=0D
+=0D
+  xg =3D xengnttab_open(0, 0);=0D
+  xengnttab_map_grant_ref(xg, 0, 0, 0);=0D
+=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs $xen_stable_libs"=0D
+      then=0D
+      xen_ctrl_version=3D40701=0D
+      xen=3Dyes=0D
+=0D
+    # Xen 4.6=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+#include <xenctrl.h>=0D
+#include <xenstore.h>=0D
+#include <stdint.h>=0D
+#include <xen/hvm/hvm_info_table.h>=0D
+#if !defined(HVM_MAX_VCPUS)=0D
+# error HVM_MAX_VCPUS not defined=0D
+#endif=0D
+int main(void) {=0D
+  xc_interface *xc;=0D
+  xs_daemon_open();=0D
+  xc =3D xc_interface_open(0, 0, 0);=0D
+  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);=0D
+  xc_gnttab_open(NULL, 0);=0D
+  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);=0D
+  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);=0D
+  xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);=0D
+  xc_reserved_device_memory_map(xc, 0, 0, 0, 0, NULL, 0);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs"=0D
+      then=0D
+      xen_ctrl_version=3D40600=0D
+      xen=3Dyes=0D
+=0D
+    # Xen 4.5=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+#include <xenctrl.h>=0D
+#include <xenstore.h>=0D
+#include <stdint.h>=0D
+#include <xen/hvm/hvm_info_table.h>=0D
+#if !defined(HVM_MAX_VCPUS)=0D
+# error HVM_MAX_VCPUS not defined=0D
+#endif=0D
+int main(void) {=0D
+  xc_interface *xc;=0D
+  xs_daemon_open();=0D
+  xc =3D xc_interface_open(0, 0, 0);=0D
+  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);=0D
+  xc_gnttab_open(NULL, 0);=0D
+  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);=0D
+  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);=0D
+  xc_hvm_create_ioreq_server(xc, 0, 0, NULL);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs"=0D
+      then=0D
+      xen_ctrl_version=3D40500=0D
+      xen=3Dyes=0D
+=0D
+    elif=0D
+        cat > $TMPC <<EOF &&=0D
+#include <xenctrl.h>=0D
+#include <xenstore.h>=0D
+#include <stdint.h>=0D
+#include <xen/hvm/hvm_info_table.h>=0D
+#if !defined(HVM_MAX_VCPUS)=0D
+# error HVM_MAX_VCPUS not defined=0D
+#endif=0D
+int main(void) {=0D
+  xc_interface *xc;=0D
+  xs_daemon_open();=0D
+  xc =3D xc_interface_open(0, 0, 0);=0D
+  xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);=0D
+  xc_gnttab_open(NULL, 0);=0D
+  xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);=0D
+  xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        compile_prog "" "$xen_libs"=0D
+      then=0D
+      xen_ctrl_version=3D40200=0D
+      xen=3Dyes=0D
+=0D
+    else=0D
+      if test "$xen" =3D "yes" ; then=0D
+        feature_not_found "xen (unsupported version)" \=0D
+                          "Install a supported xen (xen 4.2 or newer)"=0D
+      fi=0D
+      xen=3Dno=0D
+    fi=0D
+=0D
+    if test "$xen" =3D yes; then=0D
+      if test $xen_ctrl_version -ge 40701  ; then=0D
+        xen_libs=3D"$xen_libs $xen_stable_libs "=0D
+      fi=0D
+    fi=0D
+  fi=0D
+fi=0D
+=0D
+if test "$xen_pci_passthrough" !=3D "no"; then=0D
+  if test "$xen" =3D "yes" && test "$linux" =3D "yes"; then=0D
+    xen_pci_passthrough=3Dyes=0D
+  else=0D
+    if test "$xen_pci_passthrough" =3D "yes"; then=0D
+      error_exit "User requested feature Xen PCI Passthrough" \=0D
+          " but this feature requires /sys from Linux"=0D
+    fi=0D
+    xen_pci_passthrough=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# Windows Hypervisor Platform accelerator (WHPX) check=0D
+if test "$whpx" !=3D "no" ; then=0D
+    if check_include "WinHvPlatform.h" && check_include "WinHvEmulation.h"=
; then=0D
+        whpx=3D"yes"=0D
+    else=0D
+        if test "$whpx" =3D "yes"; then=0D
+            feature_not_found "WinHvPlatform" "WinHvEmulation is not insta=
lled"=0D
+        fi=0D
+        whpx=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# gettext probe=0D
+if test "$gettext" !=3D "false" ; then=0D
+  if has xgettext; then=0D
+    gettext=3Dtrue=0D
+  else=0D
+    if test "$gettext" =3D "true" ; then=0D
+      feature_not_found "gettext" "Install xgettext binary"=0D
+    fi=0D
+    gettext=3Dfalse=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# Sparse probe=0D
+if test "$sparse" !=3D "no" ; then=0D
+  if has sparse; then=0D
+    sparse=3Dyes=0D
+  else=0D
+    if test "$sparse" =3D "yes" ; then=0D
+      feature_not_found "sparse" "Install sparse binary"=0D
+    fi=0D
+    sparse=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# X11 probe=0D
+if $pkg_config --exists "x11"; then=0D
+    have_x11=3Dyes=0D
+    x11_cflags=3D$($pkg_config --cflags x11)=0D
+    x11_libs=3D$($pkg_config --libs x11)=0D
+fi=0D
+=0D
+##########################################=0D
+# GTK probe=0D
+=0D
+if test "$gtk" !=3D "no"; then=0D
+    gtkpackage=3D"gtk+-3.0"=0D
+    gtkx11package=3D"gtk+-x11-3.0"=0D
+    gtkversion=3D"3.22.0"=0D
+    if $pkg_config --exists "$gtkpackage >=3D $gtkversion"; then=0D
+        gtk_cflags=3D$($pkg_config --cflags $gtkpackage)=0D
+        gtk_libs=3D$($pkg_config --libs $gtkpackage)=0D
+        gtk_version=3D$($pkg_config --modversion $gtkpackage)=0D
+        if $pkg_config --exists "$gtkx11package >=3D $gtkversion"; then=0D
+            need_x11=3Dyes=0D
+            gtk_cflags=3D"$gtk_cflags $x11_cflags"=0D
+            gtk_libs=3D"$gtk_libs $x11_libs"=0D
+        fi=0D
+        gtk=3D"yes"=0D
+    elif test "$gtk" =3D "yes"; then=0D
+        feature_not_found "gtk" "Install gtk3-devel"=0D
+    else=0D
+        gtk=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+=0D
+##########################################=0D
+# GNUTLS probe=0D
+=0D
+if test "$gnutls" !=3D "no"; then=0D
+    pass=3D"no"=0D
+    if $pkg_config --exists "gnutls >=3D 3.1.18"; then=0D
+        gnutls_cflags=3D$($pkg_config --cflags gnutls)=0D
+        gnutls_libs=3D$($pkg_config --libs gnutls)=0D
+        # Packaging for the static libraries is not always correct.=0D
+        # At least ubuntu 18.04 ships only shared libraries.=0D
+        write_c_skeleton=0D
+        if compile_prog "" "$gnutls_libs" ; then=0D
+            LIBS=3D"$gnutls_libs $LIBS"=0D
+            QEMU_CFLAGS=3D"$QEMU_CFLAGS $gnutls_cflags"=0D
+            pass=3D"yes"=0D
+        fi=0D
+    fi=0D
+    if test "$pass" =3D "no" && test "$gnutls" =3D "yes"; then=0D
+	feature_not_found "gnutls" "Install gnutls devel >=3D 3.1.18"=0D
+    else=0D
+        gnutls=3D"$pass"=0D
+    fi=0D
+fi=0D
+=0D
+=0D
+# If user didn't give a --disable/enable-gcrypt flag,=0D
+# then mark as disabled if user requested nettle=0D
+# explicitly=0D
+if test -z "$gcrypt"=0D
+then=0D
+    if test "$nettle" =3D "yes"=0D
+    then=0D
+        gcrypt=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+# If user didn't give a --disable/enable-nettle flag,=0D
+# then mark as disabled if user requested gcrypt=0D
+# explicitly=0D
+if test -z "$nettle"=0D
+then=0D
+    if test "$gcrypt" =3D "yes"=0D
+    then=0D
+        nettle=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+has_libgcrypt() {=0D
+    if ! has "libgcrypt-config"=0D
+    then=0D
+	return 1=0D
+    fi=0D
+=0D
+    if test -n "$cross_prefix"=0D
+    then=0D
+	host=3D$(libgcrypt-config --host)=0D
+	if test "$host-" !=3D $cross_prefix=0D
+	then=0D
+	    return 1=0D
+	fi=0D
+    fi=0D
+=0D
+    maj=3D`libgcrypt-config --version | awk -F . '{print $1}'`=0D
+    min=3D`libgcrypt-config --version | awk -F . '{print $2}'`=0D
+=0D
+    if test $maj !=3D 1 || test $min -lt 5=0D
+    then=0D
+       return 1=0D
+    fi=0D
+=0D
+    return 0=0D
+}=0D
+=0D
+=0D
+if test "$nettle" !=3D "no"; then=0D
+    pass=3D"no"=0D
+    if $pkg_config --exists "nettle >=3D 2.7.1"; then=0D
+        nettle_cflags=3D$($pkg_config --cflags nettle)=0D
+        nettle_libs=3D$($pkg_config --libs nettle)=0D
+        nettle_version=3D$($pkg_config --modversion nettle)=0D
+        # Link test to make sure the given libraries work (e.g for static)=
.=0D
+        write_c_skeleton=0D
+        if compile_prog "" "$nettle_libs" ; then=0D
+            LIBS=3D"$nettle_libs $LIBS"=0D
+            QEMU_CFLAGS=3D"$QEMU_CFLAGS $nettle_cflags"=0D
+            if test -z "$gcrypt"; then=0D
+               gcrypt=3D"no"=0D
+            fi=0D
+            pass=3D"yes"=0D
+        fi=0D
+    fi=0D
+    if test "$pass" =3D "yes"=0D
+    then=0D
+        cat > $TMPC << EOF=0D
+#include <nettle/xts.h>=0D
+int main(void) {=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        if compile_prog "$nettle_cflags" "$nettle_libs" ; then=0D
+            nettle_xts=3Dyes=0D
+            qemu_private_xts=3Dno=0D
+        fi=0D
+    fi=0D
+    if test "$pass" =3D "no" && test "$nettle" =3D "yes"; then=0D
+        feature_not_found "nettle" "Install nettle devel >=3D 2.7.1"=0D
+    else=0D
+        nettle=3D"$pass"=0D
+    fi=0D
+fi=0D
+=0D
+if test "$gcrypt" !=3D "no"; then=0D
+    pass=3D"no"=0D
+    if has_libgcrypt; then=0D
+        gcrypt_cflags=3D$(libgcrypt-config --cflags)=0D
+        gcrypt_libs=3D$(libgcrypt-config --libs)=0D
+        # Debian has removed -lgpg-error from libgcrypt-config=0D
+        # as it "spreads unnecessary dependencies" which in=0D
+        # turn breaks static builds...=0D
+        if test "$static" =3D "yes"=0D
+        then=0D
+            gcrypt_libs=3D"$gcrypt_libs -lgpg-error"=0D
+        fi=0D
+=0D
+        # Link test to make sure the given libraries work (e.g for static)=
.=0D
+        write_c_skeleton=0D
+        if compile_prog "" "$gcrypt_libs" ; then=0D
+            LIBS=3D"$gcrypt_libs $LIBS"=0D
+            QEMU_CFLAGS=3D"$QEMU_CFLAGS $gcrypt_cflags"=0D
+            pass=3D"yes"=0D
+        fi=0D
+    fi=0D
+    if test "$pass" =3D "yes"; then=0D
+        gcrypt=3D"yes"=0D
+        cat > $TMPC << EOF=0D
+#include <gcrypt.h>=0D
+int main(void) {=0D
+  gcry_mac_hd_t handle;=0D
+  gcry_mac_open(&handle, GCRY_MAC_HMAC_MD5,=0D
+                GCRY_MAC_FLAG_SECURE, NULL);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then=0D
+            gcrypt_hmac=3Dyes=0D
+        fi=0D
+        cat > $TMPC << EOF=0D
+#include <gcrypt.h>=0D
+int main(void) {=0D
+  gcry_cipher_hd_t handle;=0D
+  gcry_cipher_open(&handle, GCRY_CIPHER_AES, GCRY_CIPHER_MODE_XTS, 0);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+        if compile_prog "$gcrypt_cflags" "$gcrypt_libs" ; then=0D
+            gcrypt_xts=3Dyes=0D
+            qemu_private_xts=3Dno=0D
+        fi=0D
+    elif test "$gcrypt" =3D "yes"; then=0D
+        feature_not_found "gcrypt" "Install gcrypt devel >=3D 1.5.0"=0D
+    else=0D
+        gcrypt=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+=0D
+if test "$gcrypt" =3D "yes" && test "$nettle" =3D "yes"=0D
+then=0D
+    error_exit "Only one of gcrypt & nettle can be enabled"=0D
+fi=0D
+=0D
+##########################################=0D
+# libtasn1 - only for the TLS creds/session test suite=0D
+=0D
+tasn1=3Dyes=0D
+tasn1_cflags=3D""=0D
+tasn1_libs=3D""=0D
+if $pkg_config --exists "libtasn1"; then=0D
+    tasn1_cflags=3D$($pkg_config --cflags libtasn1)=0D
+    tasn1_libs=3D$($pkg_config --libs libtasn1)=0D
+else=0D
+    tasn1=3Dno=0D
+fi=0D
+=0D
+=0D
+##########################################=0D
+# PAM probe=0D
+=0D
+if test "$auth_pam" !=3D "no"; then=0D
+    cat > $TMPC <<EOF=0D
+#include <security/pam_appl.h>=0D
+#include <stdio.h>=0D
+int main(void) {=0D
+   const char *service_name =3D "qemu";=0D
+   const char *user =3D "frank";=0D
+   const struct pam_conv pam_conv =3D { 0 };=0D
+   pam_handle_t *pamh =3D NULL;=0D
+   pam_start(service_name, user, &pam_conv, &pamh);=0D
+   return 0;=0D
+}=0D
+EOF=0D
+    if compile_prog "" "-lpam" ; then=0D
+        auth_pam=3Dyes=0D
+    else=0D
+        if test "$auth_pam" =3D "yes"; then=0D
+            feature_not_found "PAM" "Install PAM development package"=0D
+        else=0D
+            auth_pam=3Dno=0D
+        fi=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# getifaddrs (for tests/test-io-channel-socket )=0D
+=0D
+have_ifaddrs_h=3Dyes=0D
+if ! check_include "ifaddrs.h" ; then=0D
+  have_ifaddrs_h=3Dno=0D
+fi=0D
+=0D
+#########################################=0D
+# libdrm check=0D
+have_drm_h=3Dno=0D
+if check_include "libdrm/drm.h" ; then=0D
+    have_drm_h=3Dyes=0D
+fi=0D
+=0D
+#########################################=0D
+# sys/signal.h check=0D
+have_sys_signal_h=3Dno=0D
+if check_include "sys/signal.h" ; then=0D
+  have_sys_signal_h=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# VTE probe=0D
+=0D
+if test "$vte" !=3D "no"; then=0D
+    vteminversion=3D"0.32.0"=0D
+    if $pkg_config --exists "vte-2.91"; then=0D
+      vtepackage=3D"vte-2.91"=0D
+    else=0D
+      vtepackage=3D"vte-2.90"=0D
+    fi=0D
+    if $pkg_config --exists "$vtepackage >=3D $vteminversion"; then=0D
+        vte_cflags=3D$($pkg_config --cflags $vtepackage)=0D
+        vte_libs=3D$($pkg_config --libs $vtepackage)=0D
+        vteversion=3D$($pkg_config --modversion $vtepackage)=0D
+        vte=3D"yes"=0D
+    elif test "$vte" =3D "yes"; then=0D
+        feature_not_found "vte" "Install libvte-2.90/2.91 devel"=0D
+    else=0D
+        vte=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# RDMA needs OpenFabrics libraries=0D
+if test "$rdma" !=3D "no" ; then=0D
+  cat > $TMPC <<EOF=0D
+#include <rdma/rdma_cma.h>=0D
+int main(void) { return 0; }=0D
+EOF=0D
+  rdma_libs=3D"-lrdmacm -libverbs -libumad"=0D
+  if compile_prog "" "$rdma_libs" ; then=0D
+    rdma=3D"yes"=0D
+  else=0D
+    if test "$rdma" =3D "yes" ; then=0D
+        error_exit \=0D
+            " OpenFabrics librdmacm/libibverbs/libibumad not present." \=0D
+            " Your options:" \=0D
+            "  (1) Fast: Install infiniband packages (devel) from your dis=
tro." \=0D
+            "  (2) Cleanest: Install libraries from www.openfabrics.org" \=
=0D
+            "  (3) Also: Install softiwarp if you don't have RDMA hardware=
"=0D
+    fi=0D
+    rdma=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# PVRDMA detection=0D
+=0D
+cat > $TMPC <<EOF &&=0D
+#include <sys/mman.h>=0D
+=0D
+int=0D
+main(void)=0D
+{=0D
+    char buf =3D 0;=0D
+    void *addr =3D &buf;=0D
+    addr =3D mremap(addr, 0, 1, MREMAP_MAYMOVE | MREMAP_FIXED);=0D
+=0D
+    return 0;=0D
+}=0D
+EOF=0D
+=0D
+if test "$rdma" =3D "yes" ; then=0D
+    case "$pvrdma" in=0D
+    "")=0D
+        if compile_prog "" ""; then=0D
+            pvrdma=3D"yes"=0D
+        else=0D
+            pvrdma=3D"no"=0D
+        fi=0D
+        ;;=0D
+    "yes")=0D
+        if ! compile_prog "" ""; then=0D
+            error_exit "PVRDMA is not supported since mremap is not implem=
ented"=0D
+        fi=0D
+        pvrdma=3D"yes"=0D
+        ;;=0D
+    "no")=0D
+        pvrdma=3D"no"=0D
+        ;;=0D
+    esac=0D
+else=0D
+    if test "$pvrdma" =3D "yes" ; then=0D
+        error_exit "PVRDMA requires rdma suppport"=0D
+    fi=0D
+    pvrdma=3D"no"=0D
+fi=0D
+=0D
+# Let's see if enhanced reg_mr is supported=0D
+if test "$pvrdma" =3D "yes" ; then=0D
+=0D
+cat > $TMPC <<EOF &&=0D
+#include <infiniband/verbs.h>=0D
+=0D
+int=0D
+main(void)=0D
+{=0D
+    struct ibv_mr *mr;=0D
+    struct ibv_pd *pd =3D NULL;=0D
+    size_t length =3D 10;=0D
+    uint64_t iova =3D 0;=0D
+    int access =3D 0;=0D
+    void *addr =3D NULL;=0D
+=0D
+    mr =3D ibv_reg_mr_iova(pd, addr, length, iova, access);=0D
+=0D
+    ibv_dereg_mr(mr);=0D
+=0D
+    return 0;=0D
+}=0D
+EOF=0D
+    if ! compile_prog "" "-libverbs"; then=0D
+        QEMU_CFLAGS=3D"$QEMU_CFLAGS -DLEGACY_RDMA_REG_MR"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# xfsctl() probe, used for file-posix.c=0D
+if test "$xfs" !=3D "no" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <stddef.h>  /* NULL */=0D
+#include <xfs/xfs.h>=0D
+int main(void)=0D
+{=0D
+    xfsctl(NULL, 0, 0, NULL);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    xfs=3D"yes"=0D
+  else=0D
+    if test "$xfs" =3D "yes" ; then=0D
+      feature_not_found "xfs" "Instal xfsprogs/xfslibs devel"=0D
+    fi=0D
+    xfs=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# vde libraries probe=0D
+if test "$vde" !=3D "no" ; then=0D
+  vde_libs=3D"-lvdeplug"=0D
+  cat > $TMPC << EOF=0D
+#include <libvdeplug.h>=0D
+int main(void)=0D
+{=0D
+    struct vde_open_args a =3D {0, 0, 0};=0D
+    char s[] =3D "";=0D
+    vde_open(s, s, &a);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "" "$vde_libs" ; then=0D
+    vde=3Dyes=0D
+  else=0D
+    if test "$vde" =3D "yes" ; then=0D
+      feature_not_found "vde" "Install vde (Virtual Distributed Ethernet) =
devel"=0D
+    fi=0D
+    vde=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# netmap support probe=0D
+# Apart from looking for netmap headers, we make sure that the host API ve=
rsion=0D
+# supports the netmap backend (>=3D11). The upper bound (15) is meant to s=
imulate=0D
+# a minor/major version number. Minor new features will be marked with val=
ues up=0D
+# to 15, and if something happens that requires a change to the backend we=
 will=0D
+# move above 15, submit the backend fixes and modify this two bounds.=0D
+if test "$netmap" !=3D "no" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <inttypes.h>=0D
+#include <net/if.h>=0D
+#include <net/netmap.h>=0D
+#include <net/netmap_user.h>=0D
+#if (NETMAP_API < 11) || (NETMAP_API > 15)=0D
+#error=0D
+#endif=0D
+int main(void) { return 0; }=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    netmap=3Dyes=0D
+  else=0D
+    if test "$netmap" =3D "yes" ; then=0D
+      feature_not_found "netmap"=0D
+    fi=0D
+    netmap=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# libcap-ng library probe=0D
+if test "$cap_ng" !=3D "no" ; then=0D
+  cap_libs=3D"-lcap-ng"=0D
+  cat > $TMPC << EOF=0D
+#include <cap-ng.h>=0D
+int main(void)=0D
+{=0D
+    capng_capability_to_name(CAPNG_EFFECTIVE);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "" "$cap_libs" ; then=0D
+    cap_ng=3Dyes=0D
+  else=0D
+    if test "$cap_ng" =3D "yes" ; then=0D
+      feature_not_found "cap_ng" "Install libcap-ng devel"=0D
+    fi=0D
+    cap_ng=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# Sound support libraries probe=0D
+=0D
+audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/,/ /g')=0D
+for drv in $audio_drv_list; do=0D
+    case $drv in=0D
+    alsa | try-alsa)=0D
+    if $pkg_config alsa --exists; then=0D
+        alsa_libs=3D$($pkg_config alsa --libs)=0D
+        alsa_cflags=3D$($pkg_config alsa --cflags)=0D
+        alsa=3Dyes=0D
+        if test "$drv" =3D "try-alsa"; then=0D
+            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-alsa=
/alsa/')=0D
+        fi=0D
+    else=0D
+        if test "$drv" =3D "try-alsa"; then=0D
+            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-alsa=
//')=0D
+        else=0D
+            error_exit "$drv check failed" \=0D
+                "Make sure to have the $drv libs and headers installed."=0D
+        fi=0D
+    fi=0D
+    ;;=0D
+=0D
+    pa | try-pa)=0D
+    if $pkg_config libpulse --exists; then=0D
+        libpulse=3Dyes=0D
+        pulse_libs=3D$($pkg_config libpulse --libs)=0D
+        pulse_cflags=3D$($pkg_config libpulse --cflags)=0D
+        if test "$drv" =3D "try-pa"; then=0D
+            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-pa/p=
a/')=0D
+        fi=0D
+    else=0D
+        if test "$drv" =3D "try-pa"; then=0D
+            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-pa//=
')=0D
+        else=0D
+            error_exit "$drv check failed" \=0D
+                "Make sure to have the $drv libs and headers installed."=0D
+        fi=0D
+    fi=0D
+    ;;=0D
+=0D
+    sdl)=0D
+    if test "$sdl" =3D "no"; then=0D
+        error_exit "sdl not found or disabled, can not use sdl audio drive=
r"=0D
+    fi=0D
+    ;;=0D
+=0D
+    try-sdl)=0D
+    if test "$sdl" =3D "no"; then=0D
+        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-sdl//')=
=0D
+    else=0D
+        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-sdl/sdl/=
')=0D
+    fi=0D
+    ;;=0D
+=0D
+    coreaudio)=0D
+      coreaudio_libs=3D"-framework CoreAudio"=0D
+    ;;=0D
+=0D
+    dsound)=0D
+      dsound_libs=3D"-lole32 -ldxguid"=0D
+      audio_win_int=3D"yes"=0D
+    ;;=0D
+=0D
+    oss)=0D
+      oss_libs=3D"$oss_lib"=0D
+    ;;=0D
+=0D
+    jack | try-jack)=0D
+    if $pkg_config jack --exists; then=0D
+        libjack=3Dyes=0D
+        jack_libs=3D$($pkg_config jack --libs)=0D
+        if test "$drv" =3D "try-jack"; then=0D
+            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-jack=
/jack/')=0D
+        fi=0D
+    else=0D
+        if test "$drv" =3D "try-jack"; then=0D
+            audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/try-jack=
//')=0D
+        else=0D
+            error_exit "$drv check failed" \=0D
+                "Make sure to have the $drv libs and headers installed."=0D
+        fi=0D
+    fi=0D
+    ;;=0D
+=0D
+    *)=0D
+    echo "$audio_possible_drivers" | grep -q "\<$drv\>" || {=0D
+        error_exit "Unknown driver '$drv' selected" \=0D
+            "Possible drivers are: $audio_possible_drivers"=0D
+    }=0D
+    ;;=0D
+    esac=0D
+done=0D
+=0D
+##########################################=0D
+# BrlAPI probe=0D
+=0D
+if test "$brlapi" !=3D "no" ; then=0D
+  brlapi_libs=3D"-lbrlapi"=0D
+  cat > $TMPC << EOF=0D
+#include <brlapi.h>=0D
+#include <stddef.h>=0D
+int main( void ) { return brlapi__openConnection (NULL, NULL, NULL); }=0D
+EOF=0D
+  if compile_prog "" "$brlapi_libs" ; then=0D
+    brlapi=3Dyes=0D
+  else=0D
+    if test "$brlapi" =3D "yes" ; then=0D
+      feature_not_found "brlapi" "Install brlapi devel"=0D
+    fi=0D
+    brlapi=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# iconv probe=0D
+if test "$iconv" !=3D "no" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <iconv.h>=0D
+int main(void) {=0D
+  iconv_t conv =3D iconv_open("WCHAR_T", "UCS-2");=0D
+  return conv !=3D (iconv_t) -1;=0D
+}=0D
+EOF=0D
+  iconv_prefix_list=3D"/usr/local:/usr"=0D
+  iconv_lib_list=3D":-liconv"=0D
+  IFS=3D:=0D
+  for iconv_prefix in $iconv_prefix_list; do=0D
+    IFS=3D:=0D
+    iconv_cflags=3D"-I$iconv_prefix/include"=0D
+    iconv_ldflags=3D"-L$iconv_prefix/lib"=0D
+    for iconv_link in $iconv_lib_list; do=0D
+      unset IFS=0D
+      iconv_lib=3D"$iconv_ldflags $iconv_link"=0D
+      echo "looking at iconv in '$iconv_cflags' '$iconv_lib'" >> config.lo=
g=0D
+      if compile_prog "$iconv_cflags" "$iconv_lib" ; then=0D
+        iconv_found=3Dyes=0D
+        break=0D
+      fi=0D
+    done=0D
+    if test "$iconv_found" =3D yes ; then=0D
+      break=0D
+    fi=0D
+  done=0D
+  if test "$iconv_found" =3D "yes" ; then=0D
+    iconv=3Dyes=0D
+  else=0D
+    if test "$iconv" =3D "yes" ; then=0D
+      feature_not_found "iconv" "Install iconv devel"=0D
+    fi=0D
+    iconv=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# curses probe=0D
+if test "$iconv" =3D "no" ; then=0D
+  # curses will need iconv=0D
+  curses=3Dno=0D
+fi=0D
+if test "$curses" !=3D "no" ; then=0D
+  if test "$mingw32" =3D "yes" ; then=0D
+    curses_inc_list=3D"$($pkg_config --cflags ncurses 2>/dev/null):"=0D
+    curses_lib_list=3D"$($pkg_config --libs ncurses 2>/dev/null):-lpdcurse=
s"=0D
+  else=0D
+    curses_inc_list=3D"$($pkg_config --cflags ncursesw 2>/dev/null):-I/usr=
/include/ncursesw:"=0D
+    curses_lib_list=3D"$($pkg_config --libs ncursesw 2>/dev/null):-lncurse=
sw:-lcursesw"=0D
+  fi=0D
+  curses_found=3Dno=0D
+  cat > $TMPC << EOF=0D
+#include <locale.h>=0D
+#include <curses.h>=0D
+#include <wchar.h>=0D
+#include <langinfo.h>=0D
+int main(void) {=0D
+  const char *codeset;=0D
+  wchar_t wch =3D L'w';=0D
+  setlocale(LC_ALL, "");=0D
+  resize_term(0, 0);=0D
+  addwstr(L"wide chars\n");=0D
+  addnwstr(&wch, 1);=0D
+  add_wch(WACS_DEGREE);=0D
+  codeset =3D nl_langinfo(CODESET);=0D
+  return codeset !=3D 0;=0D
+}=0D
+EOF=0D
+  IFS=3D:=0D
+  for curses_inc in $curses_inc_list; do=0D
+    # Make sure we get the wide character prototypes=0D
+    curses_inc=3D"-DNCURSES_WIDECHAR $curses_inc"=0D
+    IFS=3D:=0D
+    for curses_lib in $curses_lib_list; do=0D
+      unset IFS=0D
+      if compile_prog "$curses_inc" "$curses_lib" ; then=0D
+        curses_found=3Dyes=0D
+        break=0D
+      fi=0D
+    done=0D
+    if test "$curses_found" =3D yes ; then=0D
+      break=0D
+    fi=0D
+  done=0D
+  unset IFS=0D
+  if test "$curses_found" =3D "yes" ; then=0D
+    curses=3Dyes=0D
+  else=0D
+    if test "$curses" =3D "yes" ; then=0D
+      feature_not_found "curses" "Install ncurses devel"=0D
+    fi=0D
+    curses=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# curl probe=0D
+if test "$curl" !=3D "no" ; then=0D
+  if $pkg_config libcurl --exists; then=0D
+    curlconfig=3D"$pkg_config libcurl"=0D
+  else=0D
+    curlconfig=3Dcurl-config=0D
+  fi=0D
+  cat > $TMPC << EOF=0D
+#include <curl/curl.h>=0D
+int main(void) { curl_easy_init(); curl_multi_setopt(0, 0, 0); return 0; }=
=0D
+EOF=0D
+  curl_cflags=3D$($curlconfig --cflags 2>/dev/null)=0D
+  curl_libs=3D$($curlconfig --libs 2>/dev/null)=0D
+  if compile_prog "$curl_cflags" "$curl_libs" ; then=0D
+    curl=3Dyes=0D
+  else=0D
+    if test "$curl" =3D "yes" ; then=0D
+      feature_not_found "curl" "Install libcurl devel"=0D
+    fi=0D
+    curl=3Dno=0D
+  fi=0D
+fi # test "$curl"=0D
+=0D
+##########################################=0D
+# glib support probe=0D
+=0D
+glib_req_ver=3D2.48=0D
+glib_modules=3Dgthread-2.0=0D
+if test "$modules" =3D yes; then=0D
+    glib_modules=3D"$glib_modules gmodule-export-2.0"=0D
+fi=0D
+if test "$plugins" =3D yes; then=0D
+    glib_modules=3D"$glib_modules gmodule-2.0"=0D
+fi=0D
+=0D
+# This workaround is required due to a bug in pkg-config file for glib as =
it=0D
+# doesn't define GLIB_STATIC_COMPILATION for pkg-config --static=0D
+=0D
+if test "$static" =3D yes && test "$mingw32" =3D yes; then=0D
+    QEMU_CFLAGS=3D"-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"=0D
+fi=0D
+=0D
+for i in $glib_modules; do=0D
+    if $pkg_config --atleast-version=3D$glib_req_ver $i; then=0D
+        glib_cflags=3D$($pkg_config --cflags $i)=0D
+        glib_libs=3D$($pkg_config --libs $i)=0D
+        QEMU_CFLAGS=3D"$glib_cflags $QEMU_CFLAGS"=0D
+        LIBS=3D"$glib_libs $LIBS"=0D
+    else=0D
+        error_exit "glib-$glib_req_ver $i is required to compile QEMU"=0D
+    fi=0D
+done=0D
+=0D
+if $pkg_config --atleast-version=3D$glib_req_ver gio-2.0; then=0D
+    gio=3Dyes=0D
+    gio_cflags=3D$($pkg_config --cflags gio-2.0)=0D
+    gio_libs=3D$($pkg_config --libs gio-2.0)=0D
+    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)=0D
+    if [ ! -x "$gdbus_codegen" ]; then=0D
+        gdbus_codegen=3D=0D
+    fi=0D
+else=0D
+    gio=3Dno=0D
+fi=0D
+=0D
+if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then=0D
+    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"=0D
+    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"=0D
+fi=0D
+=0D
+# Sanity check that the current size_t matches the=0D
+# size that glib thinks it should be. This catches=0D
+# problems on multi-arch where people try to build=0D
+# 32-bit QEMU while pointing at 64-bit glib headers=0D
+cat > $TMPC <<EOF=0D
+#include <glib.h>=0D
+#include <unistd.h>=0D
+=0D
+#define QEMU_BUILD_BUG_ON(x) \=0D
+  typedef char qemu_build_bug_on[(x)?-1:1] __attribute__((unused));=0D
+=0D
+int main(void) {=0D
+   QEMU_BUILD_BUG_ON(sizeof(size_t) !=3D GLIB_SIZEOF_SIZE_T);=0D
+   return 0;=0D
+}=0D
+EOF=0D
+=0D
+if ! compile_prog "$CFLAGS" "$LIBS" ; then=0D
+    error_exit "sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T."\=0D
+               "You probably need to set PKG_CONFIG_LIBDIR"\=0D
+	       "to point to the right pkg-config files for your"\=0D
+	       "build target"=0D
+fi=0D
+=0D
+# Silence clang 3.5.0 warnings about glib attribute __alloc_size__ usage=0D
+cat > $TMPC << EOF=0D
+#include <glib.h>=0D
+int main(void) { return 0; }=0D
+EOF=0D
+if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then=0D
+    if cc_has_warning_flag "-Wno-unknown-attributes"; then=0D
+        glib_cflags=3D"-Wno-unknown-attributes $glib_cflags"=0D
+        QEMU_CFLAGS=3D"-Wno-unknown-attributes $CFLAGS"=0D
+    fi=0D
+fi=0D
+=0D
+# Silence clang warnings triggered by glib < 2.57.2=0D
+cat > $TMPC << EOF=0D
+#include <glib.h>=0D
+typedef struct Foo {=0D
+    int i;=0D
+} Foo;=0D
+static void foo_free(Foo *f)=0D
+{=0D
+    g_free(f);=0D
+}=0D
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(Foo, foo_free);=0D
+int main(void) { return 0; }=0D
+EOF=0D
+if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then=0D
+    if cc_has_warning_flag "-Wno-unused-function"; then=0D
+        glib_cflags=3D"$glib_cflags -Wno-unused-function"=0D
+        CFLAGS=3D"$CFLAGS -Wno-unused-function"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# SHA command probe for modules=0D
+if test "$modules" =3D yes; then=0D
+    shacmd_probe=3D"sha1sum sha1 shasum"=0D
+    for c in $shacmd_probe; do=0D
+        if has $c; then=0D
+            shacmd=3D"$c"=0D
+            break=0D
+        fi=0D
+    done=0D
+    if test "$shacmd" =3D ""; then=0D
+        error_exit "one of the checksum commands is required to enable mod=
ules: $shacmd_probe"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# libmpathpersist probe=0D
+=0D
+if test "$mpath" !=3D "no" ; then=0D
+  # probe for the new API=0D
+  cat > $TMPC <<EOF=0D
+#include <libudev.h>=0D
+#include <mpath_persist.h>=0D
+unsigned mpath_mx_alloc_len =3D 1024;=0D
+int logsink;=0D
+static struct config *multipath_conf;=0D
+extern struct udev *udev;=0D
+extern struct config *get_multipath_config(void);=0D
+extern void put_multipath_config(struct config *conf);=0D
+struct udev *udev;=0D
+struct config *get_multipath_config(void) { return multipath_conf; }=0D
+void put_multipath_config(struct config *conf) { }=0D
+=0D
+int main(void) {=0D
+    udev =3D udev_new();=0D
+    multipath_conf =3D mpath_lib_init();=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then=0D
+    mpathpersist=3Dyes=0D
+    mpathpersist_new_api=3Dyes=0D
+  else=0D
+    # probe for the old API=0D
+    cat > $TMPC <<EOF=0D
+#include <libudev.h>=0D
+#include <mpath_persist.h>=0D
+unsigned mpath_mx_alloc_len =3D 1024;=0D
+int logsink;=0D
+int main(void) {=0D
+    struct udev *udev =3D udev_new();=0D
+    mpath_lib_init(udev);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+    if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then=0D
+      mpathpersist=3Dyes=0D
+      mpathpersist_new_api=3Dno=0D
+    else=0D
+      mpathpersist=3Dno=0D
+    fi=0D
+  fi=0D
+else=0D
+  mpathpersist=3Dno=0D
+fi=0D
+=0D
+##########################################=0D
+# pthread probe=0D
+PTHREADLIBS_LIST=3D"-pthread -lpthread -lpthreadGC2"=0D
+=0D
+pthread=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <pthread.h>=0D
+static void *f(void *p) { return NULL; }=0D
+int main(void) {=0D
+  pthread_t thread;=0D
+  pthread_create(&thread, 0, f, 0);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  pthread=3Dyes=0D
+else=0D
+  for pthread_lib in $PTHREADLIBS_LIST; do=0D
+    if compile_prog "" "$pthread_lib" ; then=0D
+      pthread=3Dyes=0D
+      found=3Dno=0D
+      for lib_entry in $LIBS; do=0D
+        if test "$lib_entry" =3D "$pthread_lib"; then=0D
+          found=3Dyes=0D
+          break=0D
+        fi=0D
+      done=0D
+      if test "$found" =3D "no"; then=0D
+        LIBS=3D"$pthread_lib $LIBS"=0D
+      fi=0D
+      PTHREAD_LIB=3D"$pthread_lib"=0D
+      break=0D
+    fi=0D
+  done=0D
+fi=0D
+=0D
+if test "$mingw32" !=3D yes && test "$pthread" =3D no; then=0D
+  error_exit "pthread check failed" \=0D
+      "Make sure to have the pthread libs and headers installed."=0D
+fi=0D
+=0D
+# check for pthread_setname_np with thread id=0D
+pthread_setname_np_w_tid=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <pthread.h>=0D
+=0D
+static void *f(void *p) { return NULL; }=0D
+int main(void)=0D
+{=0D
+    pthread_t thread;=0D
+    pthread_create(&thread, 0, f, 0);=0D
+    pthread_setname_np(thread, "QEMU");=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "$pthread_lib" ; then=0D
+  pthread_setname_np_w_tid=3Dyes=0D
+fi=0D
+=0D
+# check for pthread_setname_np without thread id=0D
+pthread_setname_np_wo_tid=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <pthread.h>=0D
+=0D
+static void *f(void *p) { pthread_setname_np("QEMU"); return NULL; }=0D
+int main(void)=0D
+{=0D
+    pthread_t thread;=0D
+    pthread_create(&thread, 0, f, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "$pthread_lib" ; then=0D
+  pthread_setname_np_wo_tid=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# rbd probe=0D
+if test "$rbd" !=3D "no" ; then=0D
+  cat > $TMPC <<EOF=0D
+#include <stdio.h>=0D
+#include <rbd/librbd.h>=0D
+int main(void) {=0D
+    rados_t cluster;=0D
+    rados_create(&cluster, NULL);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  rbd_libs=3D"-lrbd -lrados"=0D
+  if compile_prog "" "$rbd_libs" ; then=0D
+    rbd=3Dyes=0D
+  else=0D
+    if test "$rbd" =3D "yes" ; then=0D
+      feature_not_found "rados block device" "Install librbd/ceph devel"=0D
+    fi=0D
+    rbd=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# libssh probe=0D
+if test "$libssh" !=3D "no" ; then=0D
+  if $pkg_config --exists libssh; then=0D
+    libssh_cflags=3D$($pkg_config libssh --cflags)=0D
+    libssh_libs=3D$($pkg_config libssh --libs)=0D
+    libssh=3Dyes=0D
+  else=0D
+    if test "$libssh" =3D "yes" ; then=0D
+      error_exit "libssh required for --enable-libssh"=0D
+    fi=0D
+    libssh=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# Check for libssh 0.8=0D
+# This is done like this instead of using the LIBSSH_VERSION_* and=0D
+# SSH_VERSION_* macros because some distributions in the past shipped=0D
+# snapshots of the future 0.8 from Git, and those snapshots did not=0D
+# have updated version numbers (still referring to 0.7.0).=0D
+=0D
+if test "$libssh" =3D "yes"; then=0D
+  cat > $TMPC <<EOF=0D
+#include <libssh/libssh.h>=0D
+int main(void) { return ssh_get_server_publickey(NULL, NULL); }=0D
+EOF=0D
+  if compile_prog "$libssh_cflags" "$libssh_libs"; then=0D
+    libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# linux-aio probe=0D
+=0D
+if test "$linux_aio" !=3D "no" ; then=0D
+  cat > $TMPC <<EOF=0D
+#include <libaio.h>=0D
+#include <sys/eventfd.h>=0D
+#include <stddef.h>=0D
+int main(void) { io_setup(0, NULL); io_set_eventfd(NULL, 0); eventfd(0, 0)=
; return 0; }=0D
+EOF=0D
+  if compile_prog "" "-laio" ; then=0D
+    linux_aio=3Dyes=0D
+  else=0D
+    if test "$linux_aio" =3D "yes" ; then=0D
+      feature_not_found "linux AIO" "Install libaio devel"=0D
+    fi=0D
+    linux_aio=3Dno=0D
+  fi=0D
+fi=0D
+##########################################=0D
+# linux-io-uring probe=0D
+=0D
+if test "$linux_io_uring" !=3D "no" ; then=0D
+  if $pkg_config liburing; then=0D
+    linux_io_uring_cflags=3D$($pkg_config --cflags liburing)=0D
+    linux_io_uring_libs=3D$($pkg_config --libs liburing)=0D
+    linux_io_uring=3Dyes=0D
+=0D
+    # io_uring is used in libqemuutil.a where per-file -libs variables are=
 not=0D
+    # seen by programs linking the archive.  It's not ideal, but just add =
the=0D
+    # library dependency globally.=0D
+    LIBS=3D"$linux_io_uring_libs $LIBS"=0D
+  else=0D
+    if test "$linux_io_uring" =3D "yes" ; then=0D
+      feature_not_found "linux io_uring" "Install liburing devel"=0D
+    fi=0D
+    linux_io_uring=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# TPM emulation is only on POSIX=0D
+=0D
+if test "$tpm" =3D ""; then=0D
+  if test "$mingw32" =3D "yes"; then=0D
+    tpm=3Dno=0D
+  else=0D
+    tpm=3Dyes=0D
+  fi=0D
+elif test "$tpm" =3D "yes"; then=0D
+  if test "$mingw32" =3D "yes" ; then=0D
+    error_exit "TPM emulation only available on POSIX systems"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# attr probe=0D
+=0D
+libattr_libs=3D=0D
+if test "$attr" !=3D "no" ; then=0D
+  cat > $TMPC <<EOF=0D
+#include <stdio.h>=0D
+#include <sys/types.h>=0D
+#ifdef CONFIG_LIBATTR=0D
+#include <attr/xattr.h>=0D
+#else=0D
+#include <sys/xattr.h>=0D
+#endif=0D
+int main(void) { getxattr(NULL, NULL, NULL, 0); setxattr(NULL, NULL, NULL,=
 0, 0); return 0; }=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    attr=3Dyes=0D
+  # Older distros have <attr/xattr.h>, and need -lattr:=0D
+  elif compile_prog "-DCONFIG_LIBATTR" "-lattr" ; then=0D
+    attr=3Dyes=0D
+    libattr_libs=3D"-lattr"=0D
+    LIBS=3D"$libattr_libs $LIBS"=0D
+    libattr=3Dyes=0D
+  else=0D
+    if test "$attr" =3D "yes" ; then=0D
+      feature_not_found "ATTR" "Install libc6 or libattr devel"=0D
+    fi=0D
+    attr=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# iovec probe=0D
+cat > $TMPC <<EOF=0D
+#include <sys/types.h>=0D
+#include <sys/uio.h>=0D
+#include <unistd.h>=0D
+int main(void) { return sizeof(struct iovec); }=0D
+EOF=0D
+iovec=3Dno=0D
+if compile_prog "" "" ; then=0D
+  iovec=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# preadv probe=0D
+cat > $TMPC <<EOF=0D
+#include <sys/types.h>=0D
+#include <sys/uio.h>=0D
+#include <unistd.h>=0D
+int main(void) { return preadv(0, 0, 0, 0); }=0D
+EOF=0D
+preadv=3Dno=0D
+if compile_prog "" "" ; then=0D
+  preadv=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# fdt probe=0D
+# fdt support is mandatory for at least some target architectures,=0D
+# so insist on it if we're building those system emulators.=0D
+fdt_required=3Dno=0D
+for target in $target_list; do=0D
+  case $target in=0D
+    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64e=
l-softmmu|riscv*-softmmu|rx-softmmu)=0D
+      fdt_required=3Dyes=0D
+    ;;=0D
+  esac=0D
+done=0D
+=0D
+if test "$fdt_required" =3D "yes"; then=0D
+  if test "$fdt" =3D "no"; then=0D
+    error_exit "fdt disabled but some requested targets require it." \=0D
+      "You can turn off fdt only if you also disable all the system emulat=
ion" \=0D
+      "targets which need it (by specifying a cut down --target-list)."=0D
+  fi=0D
+  fdt=3Dyes=0D
+elif test "$fdt" !=3D "yes" ; then=0D
+  fdt=3Dno=0D
+fi=0D
+=0D
+# fdt is only required when building softmmu targets=0D
+if test -z "$fdt" -a "$softmmu" !=3D "yes" ; then=0D
+    fdt=3D"no"=0D
+fi=0D
+=0D
+if test "$fdt" !=3D "no" ; then=0D
+  fdt_libs=3D"-lfdt"=0D
+  # explicitly check for libfdt_env.h as it is missing in some stable inst=
alls=0D
+  # and test for required functions to make sure we are on a version >=3D =
1.4.2=0D
+  cat > $TMPC << EOF=0D
+#include <libfdt.h>=0D
+#include <libfdt_env.h>=0D
+int main(void) { fdt_check_full(NULL, 0); return 0; }=0D
+EOF=0D
+  if compile_prog "" "$fdt_libs" ; then=0D
+    # system DTC is good - use it=0D
+    fdt=3Dsystem=0D
+  else=0D
+      # have GIT checkout, so activate dtc submodule=0D
+      if test -e "${source_path}/.git" ; then=0D
+          git_submodules=3D"${git_submodules} dtc"=0D
+      fi=0D
+      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.g=
it" ; then=0D
+          fdt=3Dgit=0D
+          mkdir -p dtc=0D
+          fdt_cflags=3D"-I${source_path}/dtc/libfdt"=0D
+          fdt_ldflags=3D"-L${build_path}/dtc/libfdt"=0D
+          fdt_libs=3D"$fdt_libs"=0D
+      elif test "$fdt" =3D "yes" ; then=0D
+          # Not a git build & no libfdt found, prompt for system install=0D
+          error_exit "DTC (libfdt) version >=3D 1.4.2 not present." \=0D
+                     "Please install the DTC (libfdt) devel package"=0D
+      else=0D
+          # don't have and don't want=0D
+          fdt_libs=3D=0D
+          fdt=3Dno=0D
+      fi=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# opengl probe (for sdl2, gtk, milkymist-tmu2)=0D
+=0D
+gbm=3D"no"=0D
+if $pkg_config gbm; then=0D
+    gbm_cflags=3D"$($pkg_config --cflags gbm)"=0D
+    gbm_libs=3D"$($pkg_config --libs gbm)"=0D
+    gbm=3D"yes"=0D
+fi=0D
+=0D
+if test "$opengl" !=3D "no" ; then=0D
+  opengl_pkgs=3D"epoxy gbm"=0D
+  if $pkg_config $opengl_pkgs; then=0D
+    opengl_cflags=3D"$($pkg_config --cflags $opengl_pkgs)"=0D
+    opengl_libs=3D"$($pkg_config --libs $opengl_pkgs)"=0D
+    opengl=3Dyes=0D
+    if test "$gtk" =3D "yes" && $pkg_config --exists "$gtkpackage >=3D 3.1=
6"; then=0D
+        gtk_gl=3D"yes"=0D
+    fi=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS $opengl_cflags"=0D
+  else=0D
+    if test "$opengl" =3D "yes" ; then=0D
+      feature_not_found "opengl" "Please install opengl (mesa) devel pkgs:=
 $opengl_pkgs"=0D
+    fi=0D
+    opengl_cflags=3D""=0D
+    opengl_libs=3D""=0D
+    opengl=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+if test "$opengl" =3D "yes"; then=0D
+  cat > $TMPC << EOF=0D
+#include <epoxy/egl.h>=0D
+#ifndef EGL_MESA_image_dma_buf_export=0D
+# error mesa/epoxy lacks support for dmabufs (mesa 10.6+)=0D
+#endif=0D
+int main(void) { return 0; }=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    opengl_dmabuf=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+if test "$opengl" =3D "yes" && test "$have_x11" =3D "yes"; then=0D
+  for target in $target_list; do=0D
+    case $target in=0D
+      lm32-softmmu) # milkymist-tmu2 requires X11 and OpenGL=0D
+        need_x11=3Dyes=0D
+      ;;=0D
+    esac=0D
+  done=0D
+fi=0D
+=0D
+##########################################=0D
+# libxml2 probe=0D
+if test "$libxml2" !=3D "no" ; then=0D
+    if $pkg_config --exists libxml-2.0; then=0D
+        libxml2=3D"yes"=0D
+        libxml2_cflags=3D$($pkg_config --cflags libxml-2.0)=0D
+        libxml2_libs=3D$($pkg_config --libs libxml-2.0)=0D
+    else=0D
+        if test "$libxml2" =3D "yes"; then=0D
+            feature_not_found "libxml2" "Install libxml2 devel"=0D
+        fi=0D
+        libxml2=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# glusterfs probe=0D
+if test "$glusterfs" !=3D "no" ; then=0D
+  if $pkg_config --atleast-version=3D3 glusterfs-api; then=0D
+    glusterfs=3D"yes"=0D
+    glusterfs_cflags=3D$($pkg_config --cflags glusterfs-api)=0D
+    glusterfs_libs=3D$($pkg_config --libs glusterfs-api)=0D
+    if $pkg_config --atleast-version=3D4 glusterfs-api; then=0D
+      glusterfs_xlator_opt=3D"yes"=0D
+    fi=0D
+    if $pkg_config --atleast-version=3D5 glusterfs-api; then=0D
+      glusterfs_discard=3D"yes"=0D
+    fi=0D
+    if $pkg_config --atleast-version=3D6 glusterfs-api; then=0D
+      glusterfs_fallocate=3D"yes"=0D
+      glusterfs_zerofill=3D"yes"=0D
+    fi=0D
+    cat > $TMPC << EOF=0D
+#include <glusterfs/api/glfs.h>=0D
+=0D
+int=0D
+main(void)=0D
+{=0D
+	/* new glfs_ftruncate() passes two additional args */=0D
+	return glfs_ftruncate(NULL, 0, NULL, NULL);=0D
+}=0D
+EOF=0D
+    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then=0D
+      glusterfs_ftruncate_has_stat=3D"yes"=0D
+    fi=0D
+    cat > $TMPC << EOF=0D
+#include <glusterfs/api/glfs.h>=0D
+=0D
+/* new glfs_io_cbk() passes two additional glfs_stat structs */=0D
+static void=0D
+glusterfs_iocb(glfs_fd_t *fd, ssize_t ret, struct glfs_stat *prestat, stru=
ct glfs_stat *poststat, void *data)=0D
+{}=0D
+=0D
+int=0D
+main(void)=0D
+{=0D
+	glfs_io_cbk iocb =3D &glusterfs_iocb;=0D
+	iocb(NULL, 0 , NULL, NULL, NULL);=0D
+	return 0;=0D
+}=0D
+EOF=0D
+    if compile_prog "$glusterfs_cflags" "$glusterfs_libs" ; then=0D
+      glusterfs_iocb_has_stat=3D"yes"=0D
+    fi=0D
+  else=0D
+    if test "$glusterfs" =3D "yes" ; then=0D
+      feature_not_found "GlusterFS backend support" \=0D
+          "Install glusterfs-api devel >=3D 3"=0D
+    fi=0D
+    glusterfs=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+# Check for inotify functions when we are building linux-user=0D
+# emulator.  This is done because older glibc versions don't=0D
+# have syscall stubs for these implemented.  In that case we=0D
+# don't provide them even if kernel supports them.=0D
+#=0D
+inotify=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/inotify.h>=0D
+=0D
+int=0D
+main(void)=0D
+{=0D
+	/* try to start inotify */=0D
+	return inotify_init();=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  inotify=3Dyes=0D
+fi=0D
+=0D
+inotify1=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/inotify.h>=0D
+=0D
+int=0D
+main(void)=0D
+{=0D
+    /* try to start inotify */=0D
+    return inotify_init1(0);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  inotify1=3Dyes=0D
+fi=0D
+=0D
+# check if pipe2 is there=0D
+pipe2=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+#include <fcntl.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    int pipefd[2];=0D
+    return pipe2(pipefd, O_CLOEXEC);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  pipe2=3Dyes=0D
+fi=0D
+=0D
+# check if accept4 is there=0D
+accept4=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/socket.h>=0D
+#include <stddef.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    accept4(0, NULL, NULL, SOCK_CLOEXEC);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  accept4=3Dyes=0D
+fi=0D
+=0D
+# check if tee/splice is there. vmsplice was added same time.=0D
+splice=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+#include <fcntl.h>=0D
+#include <limits.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    int len, fd =3D 0;=0D
+    len =3D tee(STDIN_FILENO, STDOUT_FILENO, INT_MAX, SPLICE_F_NONBLOCK);=
=0D
+    splice(STDIN_FILENO, NULL, fd, NULL, len, SPLICE_F_MOVE);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  splice=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# libnuma probe=0D
+=0D
+if test "$numa" !=3D "no" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <numa.h>=0D
+int main(void) { return numa_available(); }=0D
+EOF=0D
+=0D
+  if compile_prog "" "-lnuma" ; then=0D
+    numa=3Dyes=0D
+    numa_libs=3D"-lnuma"=0D
+  else=0D
+    if test "$numa" =3D "yes" ; then=0D
+      feature_not_found "numa" "install numactl devel"=0D
+    fi=0D
+    numa=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+if test "$tcmalloc" =3D "yes" && test "$jemalloc" =3D "yes" ; then=0D
+    echo "ERROR: tcmalloc && jemalloc can't be used at the same time"=0D
+    exit 1=0D
+fi=0D
+=0D
+# Even if malloc_trim() is available, these non-libc memory allocators=0D
+# do not support it.=0D
+if test "$tcmalloc" =3D "yes" || test "$jemalloc" =3D "yes" ; then=0D
+    if test "$malloc_trim" =3D "yes" ; then=0D
+        echo "Disabling malloc_trim with non-libc memory allocator"=0D
+    fi=0D
+    malloc_trim=3D"no"=0D
+fi=0D
+=0D
+#######################################=0D
+# malloc_trim=0D
+=0D
+if test "$malloc_trim" !=3D "no" ; then=0D
+    cat > $TMPC << EOF=0D
+#include <malloc.h>=0D
+int main(void) { malloc_trim(0); return 0; }=0D
+EOF=0D
+    if compile_prog "" "" ; then=0D
+        malloc_trim=3D"yes"=0D
+    else=0D
+        malloc_trim=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# tcmalloc probe=0D
+=0D
+if test "$tcmalloc" =3D "yes" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <stdlib.h>=0D
+int main(void) {=0D
+    void *tmp =3D malloc(1);=0D
+    if (tmp !=3D NULL) {=0D
+        return 0;=0D
+    }=0D
+    return 1;=0D
+}=0D
+EOF=0D
+=0D
+  if compile_prog "" "-ltcmalloc" ; then=0D
+    LIBS=3D"-ltcmalloc $LIBS"=0D
+  else=0D
+    feature_not_found "tcmalloc" "install gperftools devel"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# jemalloc probe=0D
+=0D
+if test "$jemalloc" =3D "yes" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <stdlib.h>=0D
+int main(void) {=0D
+    void *tmp =3D malloc(1);=0D
+    if (tmp !=3D NULL) {=0D
+        return 0;=0D
+    }=0D
+    return 1;=0D
+}=0D
+EOF=0D
+=0D
+  if compile_prog "" "-ljemalloc" ; then=0D
+    LIBS=3D"-ljemalloc $LIBS"=0D
+  else=0D
+    feature_not_found "jemalloc" "install jemalloc devel"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# signalfd probe=0D
+signalfd=3D"no"=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+#include <sys/syscall.h>=0D
+#include <signal.h>=0D
+int main(void) { return syscall(SYS_signalfd, -1, NULL, _NSIG / 8); }=0D
+EOF=0D
+=0D
+if compile_prog "" "" ; then=0D
+  signalfd=3Dyes=0D
+fi=0D
+=0D
+# check if optreset global is declared by <getopt.h>=0D
+optreset=3D"no"=0D
+cat > $TMPC << EOF=0D
+#include <getopt.h>=0D
+int main(void) { return optreset; }=0D
+EOF=0D
+=0D
+if compile_prog "" "" ; then=0D
+  optreset=3Dyes=0D
+fi=0D
+=0D
+# check if eventfd is supported=0D
+eventfd=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/eventfd.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    return eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  eventfd=3Dyes=0D
+fi=0D
+=0D
+# check if memfd is supported=0D
+memfd=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/mman.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    return memfd_create("foo", MFD_ALLOW_SEALING);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  memfd=3Dyes=0D
+fi=0D
+=0D
+# check for usbfs=0D
+have_usbfs=3Dno=0D
+if test "$linux_user" =3D "yes"; then=0D
+  cat > $TMPC << EOF=0D
+#include <linux/usbdevice_fs.h>=0D
+=0D
+#ifndef USBDEVFS_GET_CAPABILITIES=0D
+#error "USBDEVFS_GET_CAPABILITIES undefined"=0D
+#endif=0D
+=0D
+#ifndef USBDEVFS_DISCONNECT_CLAIM=0D
+#error "USBDEVFS_DISCONNECT_CLAIM undefined"=0D
+#endif=0D
+=0D
+int main(void)=0D
+{=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "" ""; then=0D
+    have_usbfs=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+# check for fallocate=0D
+fallocate=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <fcntl.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    fallocate(0, 0, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  fallocate=3Dyes=0D
+fi=0D
+=0D
+# check for fallocate hole punching=0D
+fallocate_punch_hole=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <fcntl.h>=0D
+#include <linux/falloc.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    fallocate(0, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  fallocate_punch_hole=3Dyes=0D
+fi=0D
+=0D
+# check that fallocate supports range zeroing inside the file=0D
+fallocate_zero_range=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <fcntl.h>=0D
+#include <linux/falloc.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    fallocate(0, FALLOC_FL_ZERO_RANGE, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  fallocate_zero_range=3Dyes=0D
+fi=0D
+=0D
+# check for posix_fallocate=0D
+posix_fallocate=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <fcntl.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    posix_fallocate(0, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    posix_fallocate=3Dyes=0D
+fi=0D
+=0D
+# check for sync_file_range=0D
+sync_file_range=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <fcntl.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    sync_file_range(0, 0, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  sync_file_range=3Dyes=0D
+fi=0D
+=0D
+# check for linux/fiemap.h and FS_IOC_FIEMAP=0D
+fiemap=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/ioctl.h>=0D
+#include <linux/fs.h>=0D
+#include <linux/fiemap.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    ioctl(0, FS_IOC_FIEMAP, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  fiemap=3Dyes=0D
+fi=0D
+=0D
+# check for dup3=0D
+dup3=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    dup3(0, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  dup3=3Dyes=0D
+fi=0D
+=0D
+# check for ppoll support=0D
+ppoll=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <poll.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    struct pollfd pfd =3D { .fd =3D 0, .events =3D 0, .revents =3D 0 };=0D
+    ppoll(&pfd, 1, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  ppoll=3Dyes=0D
+fi=0D
+=0D
+# check for prctl(PR_SET_TIMERSLACK , ... ) support=0D
+prctl_pr_set_timerslack=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/prctl.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    prctl(PR_SET_TIMERSLACK, 1, 0, 0, 0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  prctl_pr_set_timerslack=3Dyes=0D
+fi=0D
+=0D
+# check for epoll support=0D
+epoll=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/epoll.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    epoll_create(0);=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  epoll=3Dyes=0D
+fi=0D
+=0D
+# epoll_create1 is a later addition=0D
+# so we must check separately for its presence=0D
+epoll_create1=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/epoll.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    /* Note that we use epoll_create1 as a value, not as=0D
+     * a function being called. This is necessary so that on=0D
+     * old SPARC glibc versions where the function was present in=0D
+     * the library but not declared in the header file we will=0D
+     * fail the configure check. (Otherwise we will get a compiler=0D
+     * warning but not an error, and will proceed to fail the=0D
+     * qemu compile where we compile with -Werror.)=0D
+     */=0D
+    return (int)(uintptr_t)&epoll_create1;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  epoll_create1=3Dyes=0D
+fi=0D
+=0D
+# check for sendfile support=0D
+sendfile=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/sendfile.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    return sendfile(0, 0, 0, 0);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  sendfile=3Dyes=0D
+fi=0D
+=0D
+# check for timerfd support (glibc 2.8 and newer)=0D
+timerfd=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/timerfd.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    return(timerfd_create(CLOCK_REALTIME, 0));=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  timerfd=3Dyes=0D
+fi=0D
+=0D
+# check for setns and unshare support=0D
+setns=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sched.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    int ret;=0D
+    ret =3D setns(0, 0);=0D
+    ret =3D unshare(0);=0D
+    return ret;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  setns=3Dyes=0D
+fi=0D
+=0D
+# clock_adjtime probe=0D
+clock_adjtime=3Dno=0D
+cat > $TMPC <<EOF=0D
+#include <time.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    return clock_adjtime(0, 0);=0D
+}=0D
+EOF=0D
+clock_adjtime=3Dno=0D
+if compile_prog "" "" ; then=0D
+  clock_adjtime=3Dyes=0D
+fi=0D
+=0D
+# syncfs probe=0D
+syncfs=3Dno=0D
+cat > $TMPC <<EOF=0D
+#include <unistd.h>=0D
+=0D
+int main(void)=0D
+{=0D
+    return syncfs(0);=0D
+}=0D
+EOF=0D
+syncfs=3Dno=0D
+if compile_prog "" "" ; then=0D
+  syncfs=3Dyes=0D
+fi=0D
+=0D
+# check for kcov support (kernel must be 4.4+, compiled with certain optio=
ns)=0D
+kcov=3Dno=0D
+if check_include sys/kcov.h ; then=0D
+    kcov=3Dyes=0D
+fi=0D
+=0D
+# If we're making warnings fatal, apply this to Sphinx runs as well=0D
+sphinx_werror=3D""=0D
+if test "$werror" =3D "yes"; then=0D
+    sphinx_werror=3D"-W"=0D
+fi=0D
+=0D
+# Check we have a new enough version of sphinx-build=0D
+has_sphinx_build() {=0D
+    # This is a bit awkward but works: create a trivial document and=0D
+    # try to run it with our configuration file (which enforces a=0D
+    # version requirement). This will fail if either=0D
+    # sphinx-build doesn't exist at all or if it is too old.=0D
+    mkdir -p "$TMPDIR1/sphinx"=0D
+    touch "$TMPDIR1/sphinx/index.rst"=0D
+    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \=0D
+                    -b html "$TMPDIR1/sphinx" \=0D
+                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1=0D
+}=0D
+=0D
+# Check if tools are available to build documentation.=0D
+if test "$docs" !=3D "no" ; then=0D
+  if has_sphinx_build; then=0D
+    sphinx_ok=3Dyes=0D
+  else=0D
+    sphinx_ok=3Dno=0D
+  fi=0D
+  if has makeinfo && has pod2man && test "$sphinx_ok" =3D "yes"; then=0D
+    docs=3Dyes=0D
+  else=0D
+    if test "$docs" =3D "yes" ; then=0D
+      if has $sphinx_build && test "$sphinx_ok" !=3D "yes"; then=0D
+        echo "Warning: $sphinx_build exists but it is either too old or us=
es too old a Python version" >&2=0D
+      fi=0D
+      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a=
 Python 3 version of python-sphinx"=0D
+    fi=0D
+    docs=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+# Search for bswap_32 function=0D
+byteswap_h=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <byteswap.h>=0D
+int main(void) { return bswap_32(0); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  byteswap_h=3Dyes=0D
+fi=0D
+=0D
+# Search for bswap32 function=0D
+bswap_h=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/endian.h>=0D
+#include <sys/types.h>=0D
+#include <machine/bswap.h>=0D
+int main(void) { return bswap32(0); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  bswap_h=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# Do we have libiscsi >=3D 1.9.0=0D
+if test "$libiscsi" !=3D "no" ; then=0D
+  if $pkg_config --atleast-version=3D1.9.0 libiscsi; then=0D
+    libiscsi=3D"yes"=0D
+    libiscsi_cflags=3D$($pkg_config --cflags libiscsi)=0D
+    libiscsi_libs=3D$($pkg_config --libs libiscsi)=0D
+  else=0D
+    if test "$libiscsi" =3D "yes" ; then=0D
+      feature_not_found "libiscsi" "Install libiscsi >=3D 1.9.0"=0D
+    fi=0D
+    libiscsi=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# Do we need libm=0D
+cat > $TMPC << EOF=0D
+#include <math.h>=0D
+int main(int argc, char **argv) { return isnan(sin((double)argc)); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  :=0D
+elif compile_prog "" "-lm" ; then=0D
+  LIBS=3D"-lm $LIBS"=0D
+else=0D
+  error_exit "libm check failed"=0D
+fi=0D
+=0D
+##########################################=0D
+# Do we need librt=0D
+# uClibc provides 2 versions of clock_gettime(), one with realtime=0D
+# support and one without. This means that the clock_gettime() don't=0D
+# need -lrt. We still need it for timer_create() so we check for this=0D
+# function in addition.=0D
+cat > $TMPC <<EOF=0D
+#include <signal.h>=0D
+#include <time.h>=0D
+int main(void) {=0D
+  timer_create(CLOCK_REALTIME, NULL, NULL);=0D
+  return clock_gettime(CLOCK_REALTIME, NULL);=0D
+}=0D
+EOF=0D
+=0D
+if compile_prog "" "" ; then=0D
+  :=0D
+# we need pthread for static linking. use previous pthread test result=0D
+elif compile_prog "" "$pthread_lib -lrt" ; then=0D
+  LIBS=3D"$LIBS -lrt"=0D
+fi=0D
+=0D
+# Check whether we need to link libutil for openpty()=0D
+cat > $TMPC << EOF=0D
+extern int openpty(int *am, int *as, char *name, void *termp, void *winp);=
=0D
+int main(void) { return openpty(0, 0, 0, 0, 0); }=0D
+EOF=0D
+=0D
+have_openpty=3D"no"=0D
+if compile_prog "" "" ; then=0D
+  have_openpty=3D"yes"=0D
+else=0D
+  if compile_prog "" "-lutil" ; then=0D
+    libs_tools=3D"-lutil $libs_tools"=0D
+    have_openpty=3D"yes"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# spice probe=0D
+if test "$spice" !=3D "no" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <spice.h>=0D
+int main(void) { spice_server_new(); return 0; }=0D
+EOF=0D
+  spice_cflags=3D$($pkg_config --cflags spice-protocol spice-server 2>/dev=
/null)=0D
+  spice_libs=3D$($pkg_config --libs spice-protocol spice-server 2>/dev/nul=
l)=0D
+  if $pkg_config --atleast-version=3D0.12.5 spice-server && \=0D
+     $pkg_config --atleast-version=3D0.12.3 spice-protocol && \=0D
+     compile_prog "$spice_cflags" "$spice_libs" ; then=0D
+    spice=3D"yes"=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS $spice_cflags"=0D
+  else=0D
+    if test "$spice" =3D "yes" ; then=0D
+      feature_not_found "spice" \=0D
+          "Install spice-server(>=3D0.12.5) and spice-protocol(>=3D0.12.3)=
 devel"=0D
+    fi=0D
+    spice=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+# check for smartcard support=0D
+if test "$smartcard" !=3D "no"; then=0D
+    if $pkg_config --atleast-version=3D2.5.1 libcacard; then=0D
+        libcacard_cflags=3D$($pkg_config --cflags libcacard)=0D
+        libcacard_libs=3D$($pkg_config --libs libcacard)=0D
+        smartcard=3D"yes"=0D
+    else=0D
+        if test "$smartcard" =3D "yes"; then=0D
+            feature_not_found "smartcard" "Install libcacard devel"=0D
+        fi=0D
+        smartcard=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+# check for libusb=0D
+if test "$libusb" !=3D "no" ; then=0D
+    if $pkg_config --atleast-version=3D1.0.13 libusb-1.0; then=0D
+        libusb=3D"yes"=0D
+        libusb_cflags=3D$($pkg_config --cflags libusb-1.0)=0D
+        libusb_libs=3D$($pkg_config --libs libusb-1.0)=0D
+    else=0D
+        if test "$libusb" =3D "yes"; then=0D
+            feature_not_found "libusb" "Install libusb devel >=3D 1.0.13"=
=0D
+        fi=0D
+        libusb=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+# check for usbredirparser for usb network redirection support=0D
+if test "$usb_redir" !=3D "no" ; then=0D
+    if $pkg_config --atleast-version=3D0.6 libusbredirparser-0.5; then=0D
+        usb_redir=3D"yes"=0D
+        usb_redir_cflags=3D$($pkg_config --cflags libusbredirparser-0.5)=0D
+        usb_redir_libs=3D$($pkg_config --libs libusbredirparser-0.5)=0D
+    else=0D
+        if test "$usb_redir" =3D "yes"; then=0D
+            feature_not_found "usb-redir" "Install usbredir devel"=0D
+        fi=0D
+        usb_redir=3D"no"=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have VSS SDK headers for win=0D
+=0D
+if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no" && \=0D
+        test "$vss_win32_sdk" !=3D "no" ; then=0D
+  case "$vss_win32_sdk" in=0D
+    "")   vss_win32_include=3D"-isystem $source_path" ;;=0D
+    *\ *) # The SDK is installed in "Program Files" by default, but we can=
not=0D
+          # handle path with spaces. So we symlink the headers into ".sdk/=
vss".=0D
+          vss_win32_include=3D"-isystem $source_path/.sdk/vss"=0D
+	  symlink "$vss_win32_sdk/inc" "$source_path/.sdk/vss/inc"=0D
+	  ;;=0D
+    *)    vss_win32_include=3D"-isystem $vss_win32_sdk"=0D
+  esac=0D
+  cat > $TMPC << EOF=0D
+#define __MIDL_user_allocate_free_DEFINED__=0D
+#include <inc/win2003/vss.h>=0D
+int main(void) { return VSS_CTX_BACKUP; }=0D
+EOF=0D
+  if compile_prog "$vss_win32_include" "" ; then=0D
+    guest_agent_with_vss=3D"yes"=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS $vss_win32_include"=0D
+    libs_qga=3D"-lole32 -loleaut32 -lshlwapi -lstdc++ -Wl,--enable-stdcall=
-fixup $libs_qga"=0D
+    qga_vss_provider=3D"qga/vss-win32/qga-vss.dll qga/vss-win32/qga-vss.tl=
b"=0D
+  else=0D
+    if test "$vss_win32_sdk" !=3D "" ; then=0D
+      echo "ERROR: Please download and install Microsoft VSS SDK:"=0D
+      echo "ERROR:   http://www.microsoft.com/en-us/download/details.aspx?=
id=3D23490"=0D
+      echo "ERROR: On POSIX-systems, you can extract the SDK headers by:"=
=0D
+      echo "ERROR:   scripts/extract-vsssdk-headers setup.exe"=0D
+      echo "ERROR: The headers are extracted in the directory \`inc'."=0D
+      feature_not_found "VSS support"=0D
+    fi=0D
+    guest_agent_with_vss=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# lookup Windows platform SDK (if not specified)=0D
+# The SDK is needed only to build .tlb (type library) file of guest agent=
=0D
+# VSS provider from the source. It is usually unnecessary because the=0D
+# pre-compiled .tlb file is included.=0D
+=0D
+if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no" && \=0D
+        test "$guest_agent_with_vss" =3D "yes" ; then=0D
+  if test -z "$win_sdk"; then=0D
+    programfiles=3D"$PROGRAMFILES"=0D
+    test -n "$PROGRAMW6432" && programfiles=3D"$PROGRAMW6432"=0D
+    if test -n "$programfiles"; then=0D
+      win_sdk=3D$(ls -d "$programfiles/Microsoft SDKs/Windows/v"* | tail -=
1) 2>/dev/null=0D
+    else=0D
+      feature_not_found "Windows SDK"=0D
+    fi=0D
+  elif test "$win_sdk" =3D "no"; then=0D
+    win_sdk=3D""=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check if mingw environment provides a recent ntddscsi.h=0D
+if test "$mingw32" =3D "yes" && test "$guest_agent" !=3D "no"; then=0D
+  cat > $TMPC << EOF=0D
+#include <windows.h>=0D
+#include <ntddscsi.h>=0D
+int main(void) {=0D
+#if !defined(IOCTL_SCSI_GET_ADDRESS)=0D
+#error Missing required ioctl definitions=0D
+#endif=0D
+  SCSI_ADDRESS addr =3D { .Lun =3D 0, .TargetId =3D 0, .PathId =3D 0 };=0D
+  return addr.Lun;=0D
+}=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    guest_agent_ntddscsi=3Dyes=0D
+    libs_qga=3D"-lsetupapi -lcfgmgr32 $libs_qga"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# virgl renderer probe=0D
+=0D
+if test "$virglrenderer" !=3D "no" ; then=0D
+  cat > $TMPC << EOF=0D
+#include <virglrenderer.h>=0D
+int main(void) { virgl_renderer_poll(); return 0; }=0D
+EOF=0D
+  virgl_cflags=3D$($pkg_config --cflags virglrenderer 2>/dev/null)=0D
+  virgl_libs=3D$($pkg_config --libs virglrenderer 2>/dev/null)=0D
+  virgl_version=3D$($pkg_config --modversion virglrenderer 2>/dev/null)=0D
+  if $pkg_config virglrenderer >/dev/null 2>&1 && \=0D
+     compile_prog "$virgl_cflags" "$virgl_libs" ; then=0D
+    virglrenderer=3D"yes"=0D
+  else=0D
+    if test "$virglrenderer" =3D "yes" ; then=0D
+      feature_not_found "virglrenderer"=0D
+    fi=0D
+    virglrenderer=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# capstone=0D
+=0D
+case "$capstone" in=0D
+  "" | yes)=0D
+    if $pkg_config capstone; then=0D
+      capstone=3Dsystem=0D
+    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; the=
n=0D
+      capstone=3Dgit=0D
+    elif test -e "${source_path}/capstone/Makefile" ; then=0D
+      capstone=3Dinternal=0D
+    elif test -z "$capstone" ; then=0D
+      capstone=3Dno=0D
+    else=0D
+      feature_not_found "capstone" "Install capstone devel or git submodul=
e"=0D
+    fi=0D
+    ;;=0D
+=0D
+  system)=0D
+    if ! $pkg_config capstone; then=0D
+      feature_not_found "capstone" "Install capstone devel"=0D
+    fi=0D
+    ;;=0D
+esac=0D
+=0D
+case "$capstone" in=0D
+  git | internal)=0D
+    if test "$capstone" =3D git; then=0D
+      git_submodules=3D"${git_submodules} capstone"=0D
+    fi=0D
+    mkdir -p capstone=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS -I${source_path}/capstone/include -I${sour=
ce_path}/capstone/include/capstone"=0D
+    if test "$mingw32" =3D "yes"; then=0D
+      LIBCAPSTONE=3Dcapstone.lib=0D
+    else=0D
+      LIBCAPSTONE=3Dlibcapstone.a=0D
+    fi=0D
+    capstone_libs=3D"-L${build_path}/capstone -lcapstone"=0D
+    capstone_cflags=3D"-I${source_path}/capstone/include -I${source_path}/=
capstone/include/capstone"=0D
+    ;;=0D
+=0D
+  system)=0D
+    capstone_libs=3D"$($pkg_config --libs capstone)"=0D
+    capstone_cflags=3D"$($pkg_config --cflags capstone)"=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags capstone)"=0D
+    ;;=0D
+=0D
+  no)=0D
+    ;;=0D
+  *)=0D
+    error_exit "Unknown state for capstone: $capstone"=0D
+    ;;=0D
+esac=0D
+=0D
+##########################################=0D
+# check if we have fdatasync=0D
+=0D
+fdatasync=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+int main(void) {=0D
+#if defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0=0D
+return fdatasync(0);=0D
+#else=0D
+#error Not supported=0D
+#endif=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    fdatasync=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have madvise=0D
+=0D
+madvise=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/types.h>=0D
+#include <sys/mman.h>=0D
+#include <stddef.h>=0D
+int main(void) { return madvise(NULL, 0, MADV_DONTNEED); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    madvise=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have posix_madvise=0D
+=0D
+posix_madvise=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/mman.h>=0D
+#include <stddef.h>=0D
+int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    posix_madvise=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have posix_memalign()=0D
+=0D
+posix_memalign=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <stdlib.h>=0D
+int main(void) {=0D
+    void *p;=0D
+    return posix_memalign(&p, 8, 8);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    posix_memalign=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have posix_syslog=0D
+=0D
+posix_syslog=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <syslog.h>=0D
+int main(void) { openlog("qemu", LOG_PID, LOG_DAEMON); syslog(LOG_INFO, "c=
onfigure"); return 0; }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    posix_syslog=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have sem_timedwait=0D
+=0D
+sem_timedwait=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <semaphore.h>=0D
+int main(void) { sem_t s; struct timespec t =3D {0}; return sem_timedwait(=
&s, &t); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    sem_timedwait=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have strchrnul=0D
+=0D
+strchrnul=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <string.h>=0D
+int main(void);=0D
+// Use a haystack that the compiler shouldn't be able to constant fold=0D
+char *haystack =3D (char*)&main;=0D
+int main(void) { return strchrnul(haystack, 'x') !=3D &haystack[6]; }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    strchrnul=3Dyes=0D
+fi=0D
+=0D
+#########################################=0D
+# check if we have st_atim=0D
+=0D
+st_atim=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/stat.h>=0D
+#include <stddef.h>=0D
+int main(void) { return offsetof(struct stat, st_atim); }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    st_atim=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if trace backend exists=0D
+=0D
+$python "$source_path/scripts/tracetool.py" "--backends=3D$trace_backends"=
 --check-backends  > /dev/null 2> /dev/null=0D
+if test "$?" -ne 0 ; then=0D
+  error_exit "invalid trace backends" \=0D
+      "Please choose supported trace backends."=0D
+fi=0D
+=0D
+##########################################=0D
+# For 'ust' backend, test if ust headers are present=0D
+if have_backend "ust"; then=0D
+  cat > $TMPC << EOF=0D
+#include <lttng/tracepoint.h>=0D
+int main(void) { return 0; }=0D
+EOF=0D
+  if compile_prog "" "-Wl,--no-as-needed -ldl" ; then=0D
+    if $pkg_config lttng-ust --exists; then=0D
+      lttng_ust_libs=3D$($pkg_config --libs lttng-ust)=0D
+    else=0D
+      lttng_ust_libs=3D"-llttng-ust -ldl"=0D
+    fi=0D
+    if $pkg_config liburcu-bp --exists; then=0D
+      urcu_bp_libs=3D$($pkg_config --libs liburcu-bp)=0D
+    else=0D
+      urcu_bp_libs=3D"-lurcu-bp"=0D
+    fi=0D
+=0D
+    LIBS=3D"$lttng_ust_libs $urcu_bp_libs $LIBS"=0D
+  else=0D
+    error_exit "Trace backend 'ust' missing lttng-ust header files"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# For 'dtrace' backend, test if 'dtrace' command is present=0D
+if have_backend "dtrace"; then=0D
+  if ! has 'dtrace' ; then=0D
+    error_exit "dtrace command is not found in PATH $PATH"=0D
+  fi=0D
+  trace_backend_stap=3D"no"=0D
+  if has 'stap' ; then=0D
+    trace_backend_stap=3D"yes"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check and set a backend for coroutine=0D
+=0D
+# We prefer ucontext, but it's not always possible. The fallback=0D
+# is sigcontext. On Windows the only valid backend is the Windows=0D
+# specific one.=0D
+=0D
+ucontext_works=3Dno=0D
+if test "$darwin" !=3D "yes"; then=0D
+  cat > $TMPC << EOF=0D
+#include <ucontext.h>=0D
+#ifdef __stub_makecontext=0D
+#error Ignoring glibc stub makecontext which will always fail=0D
+#endif=0D
+int main(void) { makecontext(0, 0, 0); return 0; }=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    ucontext_works=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+if test "$coroutine" =3D ""; then=0D
+  if test "$mingw32" =3D "yes"; then=0D
+    coroutine=3Dwin32=0D
+  elif test "$ucontext_works" =3D "yes"; then=0D
+    coroutine=3Ducontext=0D
+  else=0D
+    coroutine=3Dsigaltstack=0D
+  fi=0D
+else=0D
+  case $coroutine in=0D
+  windows)=0D
+    if test "$mingw32" !=3D "yes"; then=0D
+      error_exit "'windows' coroutine backend only valid for Windows"=0D
+    fi=0D
+    # Unfortunately the user visible backend name doesn't match the=0D
+    # coroutine-*.c filename for this case, so we have to adjust it here.=
=0D
+    coroutine=3Dwin32=0D
+    ;;=0D
+  ucontext)=0D
+    if test "$ucontext_works" !=3D "yes"; then=0D
+      feature_not_found "ucontext"=0D
+    fi=0D
+    ;;=0D
+  sigaltstack)=0D
+    if test "$mingw32" =3D "yes"; then=0D
+      error_exit "only the 'windows' coroutine backend is valid for Window=
s"=0D
+    fi=0D
+    ;;=0D
+  *)=0D
+    error_exit "unknown coroutine backend $coroutine"=0D
+    ;;=0D
+  esac=0D
+fi=0D
+=0D
+if test "$coroutine_pool" =3D ""; then=0D
+  coroutine_pool=3Dyes=0D
+fi=0D
+=0D
+if test "$debug_stack_usage" =3D "yes"; then=0D
+  if test "$coroutine_pool" =3D "yes"; then=0D
+    echo "WARN: disabling coroutine pool for stack usage debugging"=0D
+    coroutine_pool=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+##################################################=0D
+# SafeStack=0D
+=0D
+=0D
+if test "$safe_stack" =3D "yes"; then=0D
+cat > $TMPC << EOF=0D
+int main(int argc, char *argv[])=0D
+{=0D
+#if ! __has_feature(safe_stack)=0D
+#error SafeStack Disabled=0D
+#endif=0D
+    return 0;=0D
+}=0D
+EOF=0D
+  flag=3D"-fsanitize=3Dsafe-stack"=0D
+  # Check that safe-stack is supported and enabled.=0D
+  if compile_prog "-Werror $flag" "$flag"; then=0D
+    # Flag needed both at compilation and at linking=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"=0D
+    QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $flag"=0D
+  else=0D
+    error_exit "SafeStack not supported by your compiler"=0D
+  fi=0D
+  if test "$coroutine" !=3D "ucontext"; then=0D
+    error_exit "SafeStack is only supported by the coroutine backend ucont=
ext"=0D
+  fi=0D
+else=0D
+cat > $TMPC << EOF=0D
+int main(int argc, char *argv[])=0D
+{=0D
+#if defined(__has_feature)=0D
+#if __has_feature(safe_stack)=0D
+#error SafeStack Enabled=0D
+#endif=0D
+#endif=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if test "$safe_stack" =3D "no"; then=0D
+  # Make sure that safe-stack is disabled=0D
+  if ! compile_prog "-Werror" ""; then=0D
+    # SafeStack was already enabled, try to explicitly remove the feature=
=0D
+    flag=3D"-fno-sanitize=3Dsafe-stack"=0D
+    if ! compile_prog "-Werror $flag" "$flag"; then=0D
+      error_exit "Configure cannot disable SafeStack"=0D
+    fi=0D
+    QEMU_CFLAGS=3D"$QEMU_CFLAGS $flag"=0D
+    QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $flag"=0D
+  fi=0D
+else # "$safe_stack" =3D ""=0D
+  # Set safe_stack to yes or no based on pre-existing flags=0D
+  if compile_prog "-Werror" ""; then=0D
+    safe_stack=3D"no"=0D
+  else=0D
+    safe_stack=3D"yes"=0D
+    if test "$coroutine" !=3D "ucontext"; then=0D
+      error_exit "SafeStack is only supported by the coroutine backend uco=
ntext"=0D
+    fi=0D
+  fi=0D
+fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check if we have open_by_handle_at=0D
+=0D
+open_by_handle_at=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <fcntl.h>=0D
+#if !defined(AT_EMPTY_PATH)=0D
+# error missing definition=0D
+#else=0D
+int main(void) { struct file_handle fh; return open_by_handle_at(0, &fh, 0=
); }=0D
+#endif=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    open_by_handle_at=3Dyes=0D
+fi=0D
+=0D
+########################################=0D
+# check if we have linux/magic.h=0D
+=0D
+linux_magic_h=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <linux/magic.h>=0D
+int main(void) {=0D
+  return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    linux_magic_h=3Dyes=0D
+fi=0D
+=0D
+########################################=0D
+# check if we have valgrind/valgrind.h=0D
+=0D
+valgrind_h=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <valgrind/valgrind.h>=0D
+int main(void) {=0D
+  return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    valgrind_h=3Dyes=0D
+fi=0D
+=0D
+########################################=0D
+# check if environ is declared=0D
+=0D
+has_environ=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+int main(void) {=0D
+    environ =3D 0;=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    has_environ=3Dyes=0D
+fi=0D
+=0D
+########################################=0D
+# check if cpuid.h is usable.=0D
+=0D
+cat > $TMPC << EOF=0D
+#include <cpuid.h>=0D
+int main(void) {=0D
+    unsigned a, b, c, d;=0D
+    int max =3D __get_cpuid_max(0, 0);=0D
+=0D
+    if (max >=3D 1) {=0D
+        __cpuid(1, a, b, c, d);=0D
+    }=0D
+=0D
+    if (max >=3D 7) {=0D
+        __cpuid_count(7, 0, a, b, c, d);=0D
+    }=0D
+=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    cpuid_h=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# avx2 optimization requirement check=0D
+#=0D
+# There is no point enabling this if cpuid.h is not usable,=0D
+# since we won't be able to select the new routines.=0D
+=0D
+if test "$cpuid_h" =3D "yes" && test "$avx2_opt" !=3D "no"; then=0D
+  cat > $TMPC << EOF=0D
+#pragma GCC push_options=0D
+#pragma GCC target("avx2")=0D
+#include <cpuid.h>=0D
+#include <immintrin.h>=0D
+static int bar(void *a) {=0D
+    __m256i x =3D *(__m256i *)a;=0D
+    return _mm256_testz_si256(x, x);=0D
+}=0D
+int main(int argc, char *argv[]) { return bar(argv[0]); }=0D
+EOF=0D
+  if compile_object "" ; then=0D
+    avx2_opt=3D"yes"=0D
+  else=0D
+    avx2_opt=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# avx512f optimization requirement check=0D
+#=0D
+# There is no point enabling this if cpuid.h is not usable,=0D
+# since we won't be able to select the new routines.=0D
+# by default, it is turned off.=0D
+# if user explicitly want to enable it, check environment=0D
+=0D
+if test "$cpuid_h" =3D "yes" && test "$avx512f_opt" =3D "yes"; then=0D
+  cat > $TMPC << EOF=0D
+#pragma GCC push_options=0D
+#pragma GCC target("avx512f")=0D
+#include <cpuid.h>=0D
+#include <immintrin.h>=0D
+static int bar(void *a) {=0D
+    __m512i x =3D *(__m512i *)a;=0D
+    return _mm512_test_epi64_mask(x, x);=0D
+}=0D
+int main(int argc, char *argv[])=0D
+{=0D
+	return bar(argv[0]);=0D
+}=0D
+EOF=0D
+  if ! compile_object "" ; then=0D
+    avx512f_opt=3D"no"=0D
+  fi=0D
+else=0D
+  avx512f_opt=3D"no"=0D
+fi=0D
+=0D
+########################################=0D
+# check if __[u]int128_t is usable.=0D
+=0D
+int128=3Dno=0D
+cat > $TMPC << EOF=0D
+__int128_t a;=0D
+__uint128_t b;=0D
+int main (void) {=0D
+  a =3D a + b;=0D
+  b =3D a * b;=0D
+  a =3D a * a;=0D
+  return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    int128=3Dyes=0D
+fi=0D
+=0D
+#########################################=0D
+# See if 128-bit atomic operations are supported.=0D
+=0D
+atomic128=3Dno=0D
+if test "$int128" =3D "yes"; then=0D
+  cat > $TMPC << EOF=0D
+int main(void)=0D
+{=0D
+  unsigned __int128 x =3D 0, y =3D 0;=0D
+  y =3D __atomic_load_16(&x, 0);=0D
+  __atomic_store_16(&x, y, 0);=0D
+  __atomic_compare_exchange_16(&x, &y, x, 0, 0, 0);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    atomic128=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+cmpxchg128=3Dno=0D
+if test "$int128" =3D yes && test "$atomic128" =3D no; then=0D
+  cat > $TMPC << EOF=0D
+int main(void)=0D
+{=0D
+  unsigned __int128 x =3D 0, y =3D 0;=0D
+  __sync_val_compare_and_swap_16(&x, y, x);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "" "" ; then=0D
+    cmpxchg128=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+#########################################=0D
+# See if 64-bit atomic operations are supported.=0D
+# Note that without __atomic builtins, we can only=0D
+# assume atomic loads/stores max at pointer size.=0D
+=0D
+cat > $TMPC << EOF=0D
+#include <stdint.h>=0D
+int main(void)=0D
+{=0D
+  uint64_t x =3D 0, y =3D 0;=0D
+#ifdef __ATOMIC_RELAXED=0D
+  y =3D __atomic_load_8(&x, 0);=0D
+  __atomic_store_8(&x, y, 0);=0D
+  __atomic_compare_exchange_8(&x, &y, x, 0, 0, 0);=0D
+  __atomic_exchange_8(&x, y, 0);=0D
+  __atomic_fetch_add_8(&x, y, 0);=0D
+#else=0D
+  typedef char is_host64[sizeof(void *) >=3D sizeof(uint64_t) ? 1 : -1];=0D
+  __sync_lock_test_and_set(&x, y);=0D
+  __sync_val_compare_and_swap(&x, y, 0);=0D
+  __sync_fetch_and_add(&x, y);=0D
+#endif=0D
+  return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+  atomic64=3Dyes=0D
+fi=0D
+=0D
+#########################################=0D
+# See if --dynamic-list is supported by the linker=0D
+ld_dynamic_list=3D"no"=0D
+if test "$static" =3D "no" ; then=0D
+    cat > $TMPTXT <<EOF=0D
+{=0D
+  foo;=0D
+};=0D
+EOF=0D
+=0D
+    cat > $TMPC <<EOF=0D
+#include <stdio.h>=0D
+void foo(void);=0D
+=0D
+void foo(void)=0D
+{=0D
+  printf("foo\n");=0D
+}=0D
+=0D
+int main(void)=0D
+{=0D
+  foo();=0D
+  return 0;=0D
+}=0D
+EOF=0D
+=0D
+    if compile_prog "" "-Wl,--dynamic-list=3D$TMPTXT" ; then=0D
+        ld_dynamic_list=3D"yes"=0D
+    fi=0D
+fi=0D
+=0D
+#########################################=0D
+# See if -exported_symbols_list is supported by the linker=0D
+=0D
+ld_exported_symbols_list=3D"no"=0D
+if test "$static" =3D "no" ; then=0D
+    cat > $TMPTXT <<EOF=0D
+  _foo=0D
+EOF=0D
+=0D
+    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then=0D
+        ld_exported_symbols_list=3D"yes"=0D
+    fi=0D
+fi=0D
+=0D
+if  test "$plugins" =3D "yes" &&=0D
+    test "$ld_dynamic_list" =3D "no" &&=0D
+    test "$ld_exported_symbols_list" =3D "no" ; then=0D
+  error_exit \=0D
+      "Plugin support requires dynamic linking and specifying a set of sym=
bols " \=0D
+      "that are exported to plugins. Unfortunately your linker doesn't " \=
=0D
+      "support the flag (--dynamic-list or -exported_symbols_list) used " =
\=0D
+      "for this purpose. You can't build with --static."=0D
+fi=0D
+=0D
+########################################=0D
+# See if __attribute__((alias)) is supported.=0D
+# This false for Xcode 9, but has been remedied for Xcode 10.=0D
+# Unfortunately, travis uses Xcode 9 by default.=0D
+=0D
+attralias=3Dno=0D
+cat > $TMPC << EOF=0D
+int x =3D 1;=0D
+extern const int y __attribute__((alias("x")));=0D
+int main(void) { return 0; }=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    attralias=3Dyes=0D
+fi=0D
+=0D
+########################################=0D
+# check if getauxval is available.=0D
+=0D
+getauxval=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/auxv.h>=0D
+int main(void) {=0D
+  return getauxval(AT_HWCAP) =3D=3D 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    getauxval=3Dyes=0D
+fi=0D
+=0D
+########################################=0D
+# check if ccache is interfering with=0D
+# semantic analysis of macros=0D
+=0D
+unset CCACHE_CPP2=0D
+ccache_cpp2=3Dno=0D
+cat > $TMPC << EOF=0D
+static const int Z =3D 1;=0D
+#define fn() ({ Z; })=0D
+#define TAUT(X) ((X) =3D=3D Z)=0D
+#define PAREN(X, Y) (X =3D=3D Y)=0D
+#define ID(X) (X)=0D
+int main(int argc, char *argv[])=0D
+{=0D
+    int x =3D 0, y =3D 0;=0D
+    x =3D ID(x);=0D
+    x =3D fn();=0D
+    fn();=0D
+    if (PAREN(x, y)) return 0;=0D
+    if (TAUT(Z)) return 0;=0D
+    return 0;=0D
+}=0D
+EOF=0D
+=0D
+if ! compile_object "-Werror"; then=0D
+    ccache_cpp2=3Dyes=0D
+fi=0D
+=0D
+#################################################=0D
+# clang does not support glibc + FORTIFY_SOURCE.=0D
+=0D
+if test "$fortify_source" !=3D "no"; then=0D
+  if echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then=0D
+    fortify_source=3D"no";=0D
+  elif test -n "$cxx" && has $cxx &&=0D
+       echo | $cxx -dM -E - | grep __clang__ >/dev/null 2>&1 ; then=0D
+    fortify_source=3D"no";=0D
+  else=0D
+    fortify_source=3D"yes"=0D
+  fi=0D
+fi=0D
+=0D
+###############################################=0D
+# Check if copy_file_range is provided by glibc=0D
+have_copy_file_range=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <unistd.h>=0D
+int main(void) {=0D
+  copy_file_range(0, NULL, 0, NULL, 0, 0);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_copy_file_range=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check if struct fsxattr is available via linux/fs.h=0D
+=0D
+have_fsxattr=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <linux/fs.h>=0D
+struct fsxattr foo;=0D
+int main(void) {=0D
+  return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_fsxattr=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check for usable membarrier system call=0D
+if test "$membarrier" =3D "yes"; then=0D
+    have_membarrier=3Dno=0D
+    if test "$mingw32" =3D "yes" ; then=0D
+        have_membarrier=3Dyes=0D
+    elif test "$linux" =3D "yes" ; then=0D
+        cat > $TMPC << EOF=0D
+    #include <linux/membarrier.h>=0D
+    #include <sys/syscall.h>=0D
+    #include <unistd.h>=0D
+    #include <stdlib.h>=0D
+    int main(void) {=0D
+        syscall(__NR_membarrier, MEMBARRIER_CMD_QUERY, 0);=0D
+        syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0);=0D
+	exit(0);=0D
+    }=0D
+EOF=0D
+        if compile_prog "" "" ; then=0D
+            have_membarrier=3Dyes=0D
+        fi=0D
+    fi=0D
+    if test "$have_membarrier" =3D "no"; then=0D
+      feature_not_found "membarrier" "membarrier system call not available=
"=0D
+    fi=0D
+else=0D
+    # Do not enable it by default even for Mingw32, because it doesn't=0D
+    # work on Wine.=0D
+    membarrier=3Dno=0D
+fi=0D
+=0D
+##########################################=0D
+# check if rtnetlink.h exists and is useful=0D
+have_rtnetlink=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <linux/rtnetlink.h>=0D
+int main(void) {=0D
+  return IFLA_PROTO_DOWN;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_rtnetlink=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check for usable AF_VSOCK environment=0D
+have_af_vsock=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <errno.h>=0D
+#include <sys/types.h>=0D
+#include <sys/socket.h>=0D
+#if !defined(AF_VSOCK)=0D
+# error missing AF_VSOCK flag=0D
+#endif=0D
+#include <linux/vm_sockets.h>=0D
+int main(void) {=0D
+    int sock, ret;=0D
+    struct sockaddr_vm svm;=0D
+    socklen_t len =3D sizeof(svm);=0D
+    sock =3D socket(AF_VSOCK, SOCK_STREAM, 0);=0D
+    ret =3D getpeername(sock, (struct sockaddr *)&svm, &len);=0D
+    if ((ret =3D=3D -1) && (errno =3D=3D ENOTCONN)) {=0D
+        return 0;=0D
+    }=0D
+    return -1;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_af_vsock=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check for usable AF_ALG environment=0D
+have_afalg=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <errno.h>=0D
+#include <sys/types.h>=0D
+#include <sys/socket.h>=0D
+#include <linux/if_alg.h>=0D
+int main(void) {=0D
+    int sock;=0D
+    sock =3D socket(AF_ALG, SOCK_SEQPACKET, 0);=0D
+    return sock;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_afalg=3Dyes=0D
+fi=0D
+if test "$crypto_afalg" =3D "yes"=0D
+then=0D
+    if test "$have_afalg" !=3D "yes"=0D
+    then=0D
+	error_exit "AF_ALG requested but could not be detected"=0D
+    fi=0D
+fi=0D
+=0D
+=0D
+#################################################=0D
+# Check to see if we have the Hypervisor framework=0D
+if [ "$darwin" =3D "yes" ] ; then=0D
+  cat > $TMPC << EOF=0D
+#include <Hypervisor/hv.h>=0D
+int main() { return 0;}=0D
+EOF=0D
+  if ! compile_object ""; then=0D
+    hvf=3D'no'=0D
+  else=0D
+    hvf=3D'yes'=0D
+    QEMU_LDFLAGS=3D"-framework Hypervisor $QEMU_LDFLAGS"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check for sysmacros.h=0D
+=0D
+have_sysmacros=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/sysmacros.h>=0D
+int main(void) {=0D
+    return makedev(0, 0);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_sysmacros=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check for _Static_assert()=0D
+=0D
+have_static_assert=3Dno=0D
+cat > $TMPC << EOF=0D
+_Static_assert(1, "success");=0D
+int main(void) {=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_static_assert=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check for utmpx.h, it is missing e.g. on OpenBSD=0D
+=0D
+have_utmpx=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <utmpx.h>=0D
+struct utmpx user_info;=0D
+int main(void) {=0D
+    return 0;=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_utmpx=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# check for getrandom()=0D
+=0D
+have_getrandom=3Dno=0D
+cat > $TMPC << EOF=0D
+#include <sys/random.h>=0D
+int main(void) {=0D
+    return getrandom(0, 0, GRND_NONBLOCK);=0D
+}=0D
+EOF=0D
+if compile_prog "" "" ; then=0D
+    have_getrandom=3Dyes=0D
+fi=0D
+=0D
+##########################################=0D
+# checks for sanitizers=0D
+=0D
+have_asan=3Dno=0D
+have_ubsan=3Dno=0D
+have_asan_iface_h=3Dno=0D
+have_asan_iface_fiber=3Dno=0D
+=0D
+if test "$sanitizers" =3D "yes" ; then=0D
+  write_c_skeleton=0D
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then=0D
+      have_asan=3Dyes=0D
+  fi=0D
+=0D
+  # we could use a simple skeleton for flags checks, but this also=0D
+  # detect the static linking issue of ubsan, see also:=0D
+  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84285=0D
+  cat > $TMPC << EOF=0D
+#include <stdlib.h>=0D
+int main(void) {=0D
+    void *tmp =3D malloc(10);=0D
+    if (tmp !=3D NULL) {=0D
+        return *(int *)(tmp + 2);=0D
+    }=0D
+    return 1;=0D
+}=0D
+EOF=0D
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dundefined" ""; then=0D
+      have_ubsan=3Dyes=0D
+  fi=0D
+=0D
+  if check_include "sanitizer/asan_interface.h" ; then=0D
+      have_asan_iface_h=3Dyes=0D
+  fi=0D
+=0D
+  cat > $TMPC << EOF=0D
+#include <sanitizer/asan_interface.h>=0D
+int main(void) {=0D
+  __sanitizer_start_switch_fiber(0, 0, 0);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" "" ; then=0D
+      have_asan_iface_fiber=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# checks for fuzzer=0D
+if test "$fuzzing" =3D "yes" ; then=0D
+  write_c_fuzzer_skeleton=0D
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dfuzzer" ""; then=0D
+    have_fuzzer=3Dyes=0D
+  else=0D
+    error_exit "Your compiler doesn't support -fsanitize=3Dfuzzer"=0D
+    exit 1=0D
+  fi=0D
+fi=0D
+=0D
+# Thread sanitizer is, for now, much noisier than the other sanitizers;=0D
+# keep it separate until that is not the case.=0D
+if test "$tsan" =3D "yes" && test "$sanitizers" =3D "yes"; then=0D
+  error_exit "TSAN is not supported with other sanitiziers."=0D
+fi=0D
+have_tsan=3Dno=0D
+have_tsan_iface_fiber=3Dno=0D
+if test "$tsan" =3D "yes" ; then=0D
+  write_c_skeleton=0D
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dthread" "" ; then=0D
+      have_tsan=3Dyes=0D
+  fi=0D
+  cat > $TMPC << EOF=0D
+#include <sanitizer/tsan_interface.h>=0D
+int main(void) {=0D
+  __tsan_create_fiber(0);=0D
+  return 0;=0D
+}=0D
+EOF=0D
+  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dthread" "" ; then=0D
+      have_tsan_iface_fiber=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check for libpmem=0D
+=0D
+if test "$libpmem" !=3D "no"; then=0D
+	if $pkg_config --exists "libpmem"; then=0D
+		libpmem=3D"yes"=0D
+		libpmem_libs=3D$($pkg_config --libs libpmem)=0D
+		libpmem_cflags=3D$($pkg_config --cflags libpmem)=0D
+		QEMU_CFLAGS=3D"$QEMU_CFLAGS $libpmem_cflags"=0D
+	else=0D
+		if test "$libpmem" =3D "yes" ; then=0D
+			feature_not_found "libpmem" "Install nvml or pmdk"=0D
+		fi=0D
+		libpmem=3D"no"=0D
+	fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check for libdaxctl=0D
+=0D
+if test "$libdaxctl" !=3D "no"; then=0D
+	if $pkg_config --atleast-version=3D57 "libdaxctl"; then=0D
+		libdaxctl=3D"yes"=0D
+		libdaxctl_libs=3D$($pkg_config --libs libdaxctl)=0D
+		libdaxctl_cflags=3D$($pkg_config --cflags libdaxctl)=0D
+		QEMU_CFLAGS=3D"$QEMU_CFLAGS $libdaxctl_cflags"=0D
+	else=0D
+		if test "$libdaxctl" =3D "yes" ; then=0D
+			feature_not_found "libdaxctl" "Install libdaxctl"=0D
+		fi=0D
+		libdaxctl=3D"no"=0D
+	fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check for slirp=0D
+=0D
+# slirp is only required when building softmmu targets=0D
+if test -z "$slirp" -a "$softmmu" !=3D "yes" ; then=0D
+    slirp=3D"no"=0D
+fi=0D
+=0D
+case "$slirp" in=0D
+  "" | yes)=0D
+    if $pkg_config slirp; then=0D
+      slirp=3Dsystem=0D
+    elif test -e "${source_path}/.git" && test $git_update =3D 'yes' ; the=
n=0D
+      slirp=3Dgit=0D
+    elif test -e "${source_path}/slirp/Makefile" ; then=0D
+      slirp=3Dinternal=0D
+    elif test -z "$slirp" ; then=0D
+      slirp=3Dno=0D
+    else=0D
+      feature_not_found "slirp" "Install slirp devel or git submodule"=0D
+    fi=0D
+    ;;=0D
+=0D
+  system)=0D
+    if ! $pkg_config slirp; then=0D
+      feature_not_found "slirp" "Install slirp devel"=0D
+    fi=0D
+    ;;=0D
+esac=0D
+=0D
+case "$slirp" in=0D
+  git | internal)=0D
+    if test "$slirp" =3D git; then=0D
+      git_submodules=3D"${git_submodules} slirp"=0D
+    fi=0D
+    mkdir -p slirp=0D
+    slirp_cflags=3D"-I${source_path}/slirp/src -I${build_path}/slirp/src"=
=0D
+    slirp_libs=3D"-L${build_path}/slirp -lslirp"=0D
+    if test "$mingw32" =3D "yes" ; then=0D
+      slirp_libs=3D"$slirp_libs -lws2_32 -liphlpapi"=0D
+    fi=0D
+    ;;=0D
+=0D
+  system)=0D
+    slirp_version=3D$($pkg_config --modversion slirp 2>/dev/null)=0D
+    slirp_cflags=3D$($pkg_config --cflags slirp 2>/dev/null)=0D
+    slirp_libs=3D$($pkg_config --libs slirp 2>/dev/null)=0D
+    ;;=0D
+=0D
+  no)=0D
+    ;;=0D
+  *)=0D
+    error_exit "Unknown state for slirp: $slirp"=0D
+    ;;=0D
+esac=0D
+=0D
+##########################################=0D
+# check for usable __NR_keyctl syscall=0D
+=0D
+if test "$linux" =3D "yes" ; then=0D
+=0D
+    have_keyring=3Dno=0D
+    cat > $TMPC << EOF=0D
+#include <errno.h>=0D
+#include <asm/unistd.h>=0D
+#include <linux/keyctl.h>=0D
+#include <unistd.h>=0D
+int main(void) {=0D
+    return syscall(__NR_keyctl, KEYCTL_READ, 0, NULL, NULL, 0);=0D
+}=0D
+EOF=0D
+    if compile_prog "" "" ; then=0D
+        have_keyring=3Dyes=0D
+    fi=0D
+fi=0D
+if test "$secret_keyring" !=3D "no"=0D
+then=0D
+    if test "$have_keyring" =3D "yes"=0D
+    then=0D
+	secret_keyring=3Dyes=0D
+    else=0D
+	if test "$secret_keyring" =3D "yes"=0D
+	then=0D
+	    error_exit "syscall __NR_keyctl requested, \=0D
+but not implemented on your system"=0D
+	else=0D
+	    secret_keyring=3Dno=0D
+	fi=0D
+    fi=0D
+fi=0D
+=0D
+##########################################=0D
+# check for usable keyutils.h=0D
+=0D
+if test "$linux" =3D "yes" ; then=0D
+=0D
+    have_keyutils=3Dno=0D
+    cat > $TMPC << EOF=0D
+#include <errno.h>=0D
+#include <asm/unistd.h>=0D
+#include <unistd.h>=0D
+#include <sys/types.h>=0D
+#include <keyutils.h>=0D
+int main(void) {=0D
+    return request_key("user", NULL, NULL, 0);=0D
+}=0D
+EOF=0D
+    if compile_prog "" "-lkeyutils"; then=0D
+        have_keyutils=3Dyes=0D
+    fi=0D
+fi=0D
+=0D
+=0D
+##########################################=0D
+# End of CC checks=0D
+# After here, no more $cc or $ld runs=0D
+=0D
+write_c_skeleton=0D
+=0D
+if test "$gcov" =3D "yes" ; then=0D
+  :=0D
+elif test "$fortify_source" =3D "yes" ; then=0D
+  QEMU_CFLAGS=3D"-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $QEMU_CFLAGS"=0D
+  debug=3Dno=0D
+fi=0D
+if test "$debug_info" =3D "yes"; then=0D
+  CFLAGS=3D"-g $CFLAGS"=0D
+  LDFLAGS=3D"-g $LDFLAGS"=0D
+fi=0D
+if test "$debug" =3D "no"; then=0D
+  CFLAGS=3D"-O2 $CFLAGS"=0D
+fi=0D
+=0D
+case "$ARCH" in=0D
+alpha)=0D
+  # Ensure there's only a single GP=0D
+  QEMU_CFLAGS=3D"-msmall-data $QEMU_CFLAGS"=0D
+;;=0D
+esac=0D
+=0D
+if test "$gprof" =3D "yes" ; then=0D
+  QEMU_CFLAGS=3D"-p $QEMU_CFLAGS"=0D
+  QEMU_LDFLAGS=3D"-p $QEMU_LDFLAGS"=0D
+fi=0D
+=0D
+if test "$have_asan" =3D "yes"; then=0D
+  QEMU_CFLAGS=3D"-fsanitize=3Daddress $QEMU_CFLAGS"=0D
+  QEMU_LDFLAGS=3D"-fsanitize=3Daddress $QEMU_LDFLAGS"=0D
+  if test "$have_asan_iface_h" =3D "no" ; then=0D
+      echo "ASAN build enabled, but ASAN header missing." \=0D
+           "Without code annotation, the report may be inferior."=0D
+  elif test "$have_asan_iface_fiber" =3D "no" ; then=0D
+      echo "ASAN build enabled, but ASAN header is too old." \=0D
+           "Without code annotation, the report may be inferior."=0D
+  fi=0D
+fi=0D
+if test "$have_tsan" =3D "yes" ; then=0D
+  if test "$have_tsan_iface_fiber" =3D "yes" ; then=0D
+    QEMU_CFLAGS=3D"-fsanitize=3Dthread $QEMU_CFLAGS"=0D
+    QEMU_LDFLAGS=3D"-fsanitize=3Dthread $QEMU_LDFLAGS"=0D
+  else=0D
+    error_exit "Cannot enable TSAN due to missing fiber annotation interfa=
ce."=0D
+  fi=0D
+elif test "$tsan" =3D "yes" ; then=0D
+  error_exit "Cannot enable TSAN due to missing sanitize thread interface.=
"=0D
+fi=0D
+if test "$have_ubsan" =3D "yes"; then=0D
+  QEMU_CFLAGS=3D"-fsanitize=3Dundefined $QEMU_CFLAGS"=0D
+  QEMU_LDFLAGS=3D"-fsanitize=3Dundefined $QEMU_LDFLAGS"=0D
+fi=0D
+=0D
+##########################################=0D
+# Do we have libnfs=0D
+if test "$libnfs" !=3D "no" ; then=0D
+  if $pkg_config --atleast-version=3D1.9.3 libnfs; then=0D
+    libnfs=3D"yes"=0D
+    libnfs_libs=3D$($pkg_config --libs libnfs)=0D
+  else=0D
+    if test "$libnfs" =3D "yes" ; then=0D
+      feature_not_found "libnfs" "Install libnfs devel >=3D 1.9.3"=0D
+    fi=0D
+    libnfs=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+##########################################=0D
+# Do we have libudev=0D
+if test "$libudev" !=3D "no" ; then=0D
+  if $pkg_config libudev && test "$static" !=3D "yes"; then=0D
+    libudev=3D"yes"=0D
+    libudev_libs=3D$($pkg_config --libs libudev)=0D
+  else=0D
+    libudev=3D"no"=0D
+  fi=0D
+fi=0D
+=0D
+# Now we've finished running tests it's OK to add -Werror to the compiler =
flags=0D
+if test "$werror" =3D "yes"; then=0D
+    QEMU_CFLAGS=3D"-Werror $QEMU_CFLAGS"=0D
+fi=0D
+=0D
+# Exclude --warn-common with TSan to suppress warnings from the TSan libra=
ries.=0D
+if test "$solaris" =3D "no" && test "$tsan" =3D "no"; then=0D
+    if $ld --version 2>/dev/null | grep "GNU ld" >/dev/null 2>/dev/null ; =
then=0D
+        QEMU_LDFLAGS=3D"-Wl,--warn-common $QEMU_LDFLAGS"=0D
+    fi=0D
+fi=0D
+=0D
+# test if pod2man has --utf8 option=0D
+if pod2man --help | grep -q utf8; then=0D
+    POD2MAN=3D"pod2man --utf8"=0D
+else=0D
+    POD2MAN=3D"pod2man"=0D
+fi=0D
+=0D
+# Use ASLR, no-SEH and DEP if available=0D
+if test "$mingw32" =3D "yes" ; then=0D
+    for flag in --dynamicbase --no-seh --nxcompat; do=0D
+        if ld_has $flag ; then=0D
+            QEMU_LDFLAGS=3D"-Wl,$flag $QEMU_LDFLAGS"=0D
+        fi=0D
+    done=0D
+fi=0D
+=0D
+# Disable OpenBSD W^X if available=0D
+if test "$tcg" =3D "yes" && test "$targetos" =3D "OpenBSD"; then=0D
+    cat > $TMPC <<EOF=0D
+    int main(void) { return 0; }=0D
+EOF=0D
+    wx_ldflags=3D"-Wl,-z,wxneeded"=0D
+    if compile_prog "" "$wx_ldflags"; then=0D
+        QEMU_LDFLAGS=3D"$QEMU_LDFLAGS $wx_ldflags"=0D
+    fi=0D
+fi=0D
+=0D
+qemu_confdir=3D"$sysconfdir/$qemu_suffix"=0D
+qemu_moddir=3D"$libdir/$qemu_suffix"=0D
+qemu_datadir=3D"$datadir/$qemu_suffix"=0D
+qemu_docdir=3D"$docdir/$qemu_suffix"=0D
+qemu_localedir=3D"$datadir/locale"=0D
+qemu_icondir=3D"$datadir/icons"=0D
+qemu_desktopdir=3D"$datadir/applications"=0D
+=0D
+# We can only support ivshmem if we have eventfd=0D
+if [ "$eventfd" =3D "yes" ]; then=0D
+  ivshmem=3Dyes=0D
+fi=0D
+=0D
+if test "$softmmu" =3D yes ; then=0D
+  if test "$linux" =3D yes; then=0D
+    if test "$virtfs" !=3D no && test "$cap_ng" =3D yes && test "$attr" =
=3D yes ; then=0D
+      virtfs=3Dyes=0D
+    else=0D
+      if test "$virtfs" =3D yes; then=0D
+        error_exit "VirtFS requires libcap-ng devel and libattr devel"=0D
+      fi=0D
+      virtfs=3Dno=0D
+    fi=0D
+    if test "$mpath" !=3D no && test "$mpathpersist" =3D yes ; then=0D
+      mpath=3Dyes=0D
+    else=0D
+      if test "$mpath" =3D yes; then=0D
+        error_exit "Multipath requires libmpathpersist devel"=0D
+      fi=0D
+      mpath=3Dno=0D
+    fi=0D
+  else=0D
+    if test "$virtfs" =3D yes; then=0D
+      error_exit "VirtFS is supported only on Linux"=0D
+    fi=0D
+    virtfs=3Dno=0D
+    if test "$mpath" =3D yes; then=0D
+      error_exit "Multipath is supported only on Linux"=0D
+    fi=0D
+    mpath=3Dno=0D
+  fi=0D
+fi=0D
+=0D
+# Probe for guest agent support/options=0D
+=0D
+if [ "$guest_agent" !=3D "no" ]; then=0D
+  if [ "$softmmu" =3D no -a "$want_tools" =3D no ] ; then=0D
+      guest_agent=3Dno=0D
+  elif [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" -o=
 "$mingw32" =3D "yes" ] ; then=0D
+      guest_agent=3Dyes=0D
+  elif [ "$guest_agent" !=3D yes ]; then=0D
+      guest_agent=3Dno=0D
+  else=0D
+      error_exit "Guest agent is not supported on this platform"=0D
+  fi=0D
+fi=0D
+=0D
+# Guest agent Window MSI  package=0D
+=0D
+if test "$guest_agent" !=3D yes; then=0D
+  if test "$guest_agent_msi" =3D yes; then=0D
+    error_exit "MSI guest agent package requires guest agent enabled"=0D
+  fi=0D
+  guest_agent_msi=3Dno=0D
+elif test "$mingw32" !=3D "yes"; then=0D
+  if test "$guest_agent_msi" =3D "yes"; then=0D
+    error_exit "MSI guest agent package is available only for MinGW Window=
s cross-compilation"=0D
+  fi=0D
+  guest_agent_msi=3Dno=0D
+elif ! has wixl; then=0D
+  if test "$guest_agent_msi" =3D "yes"; then=0D
+    error_exit "MSI guest agent package requires wixl tool installed ( usu=
ally from msitools package )"=0D
+  fi=0D
+  guest_agent_msi=3Dno=0D
+else=0D
+  # we support qemu-ga, mingw32, and wixl: default to MSI enabled if it wa=
sn't=0D
+  # disabled explicitly=0D
+  if test "$guest_agent_msi" !=3D "no"; then=0D
+    guest_agent_msi=3Dyes=0D
+  fi=0D
+fi=0D
+=0D
+if test "$guest_agent_msi" =3D "yes"; then=0D
+  if test "$guest_agent_with_vss" =3D "yes"; then=0D
+    QEMU_GA_MSI_WITH_VSS=3D"-D InstallVss"=0D
+  fi=0D
+=0D
+  if test "$QEMU_GA_MANUFACTURER" =3D ""; then=0D
+    QEMU_GA_MANUFACTURER=3DQEMU=0D
+  fi=0D
+=0D
+  if test "$QEMU_GA_DISTRO" =3D ""; then=0D
+    QEMU_GA_DISTRO=3DLinux=0D
+  fi=0D
+=0D
+  if test "$QEMU_GA_VERSION" =3D ""; then=0D
+      QEMU_GA_VERSION=3D$(cat $source_path/VERSION)=0D
+  fi=0D
+=0D
+  QEMU_GA_MSI_MINGW_DLL_PATH=3D"-D Mingw_dlls=3D$($pkg_config --variable=
=3Dprefix glib-2.0)/bin"=0D
+=0D
+  case "$cpu" in=0D
+  x86_64)=0D
+    QEMU_GA_MSI_ARCH=3D"-a x64 -D Arch=3D64"=0D
+    ;;=0D
+  i386)=0D
+    QEMU_GA_MSI_ARCH=3D"-D Arch=3D32"=0D
+    ;;=0D
+  *)=0D
+    error_exit "CPU $cpu not supported for building installation package"=
=0D
+    ;;=0D
+  esac=0D
+fi=0D
+=0D
+# Mac OS X ships with a broken assembler=0D
+roms=3D=0D
+if { test "$cpu" =3D "i386" || test "$cpu" =3D "x86_64"; } && \=0D
+        test "$targetos" !=3D "Darwin" && test "$targetos" !=3D "SunOS" &&=
 \=0D
+        test "$softmmu" =3D yes ; then=0D
+    # Different host OS linkers have different ideas about the name of the=
 ELF=0D
+    # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses the =
_fbsd=0D
+    # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i386p=
e.=0D
+    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do=0D
+        if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$";=
 then=0D
+            ld_i386_emulation=3D"$emu"=0D
+            roms=3D"optionrom"=0D
+            break=0D
+        fi=0D
+    done=0D
+fi=0D
+=0D
+# Only build s390-ccw bios if we're on s390x and the compiler has -march=
=3Dz900=0D
+if test "$cpu" =3D "s390x" ; then=0D
+  write_c_skeleton=0D
+  if compile_prog "-march=3Dz900" ""; then=0D
+    roms=3D"$roms s390-ccw"=0D
+    # SLOF is required for building the s390-ccw firmware on s390x,=0D
+    # since it is using the libnet code from SLOF for network booting.=0D
+    if test -e "${source_path}/.git" ; then=0D
+      git_submodules=3D"${git_submodules} roms/SLOF"=0D
+    fi=0D
+  fi=0D
+fi=0D
+=0D
+if test $git_update =3D 'yes' ; then=0D
+    (cd "${source_path}" && GIT=3D"$git" "./scripts/git-submodule.sh" upda=
te "$git_submodules")=0D
+=0D
+    if test "$fdt" =3D "git" ; then=0D
+        if [ "$pwd_is_source_path" !=3D "y" ] ; then=0D
+            symlink "$source_path/dtc/Makefile" "dtc/Makefile"=0D
+        fi=0D
+    fi=0D
+fi=0D
+=0D
+# Check that the C++ compiler exists and works with the C compiler.=0D
+# All the QEMU_CXXFLAGS are based on QEMU_CFLAGS. Keep this at the end to =
don't miss any other that could be added.=0D
+if has $cxx; then=0D
+    cat > $TMPC <<EOF=0D
+int c_function(void);=0D
+int main(void) { return c_function(); }=0D
+EOF=0D
+=0D
+    compile_object=0D
+=0D
+    cat > $TMPCXX <<EOF=0D
+extern "C" {=0D
+   int c_function(void);=0D
+}=0D
+int c_function(void) { return 42; }=0D
+EOF=0D
+=0D
+    update_cxxflags=0D
+=0D
+    if do_cxx $CXXFLAGS $QEMU_CXXFLAGS -o $TMPE $TMPCXX $TMPO $QEMU_LDFLAG=
S; then=0D
+        # C++ compiler $cxx works ok with C compiler $cc=0D
+        :=0D
+    else=0D
+        echo "C++ compiler $cxx does not work with C compiler $cc"=0D
+        echo "Disabling C++ specific optional code"=0D
+        cxx=3D=0D
+    fi=0D
+else=0D
+    echo "No C++ compiler available; disabling C++ specific optional code"=
=0D
+    cxx=3D=0D
+fi=0D
+=0D
+echo_version() {=0D
+    if test "$1" =3D "yes" ; then=0D
+        echo "($2)"=0D
+    fi=0D
+}=0D
+=0D
+# prepend ftd flags after all config tests are done=0D
+QEMU_CFLAGS=3D"$fdt_cflags $QEMU_CFLAGS"=0D
+QEMU_LDFLAGS=3D"$fdt_ldflags $QEMU_LDFLAGS"=0D
+=0D
+config_host_mak=3D"config-host.mak"=0D
+=0D
+echo "# Automatically generated by configure - do not modify" >config-all-=
disas.mak=0D
+=0D
+echo "# Automatically generated by configure - do not modify" > $config_ho=
st_mak=0D
+echo >> $config_host_mak=0D
+=0D
+echo all: >> $config_host_mak=0D
+echo "prefix=3D$prefix" >> $config_host_mak=0D
+echo "bindir=3D$bindir" >> $config_host_mak=0D
+echo "libdir=3D$libdir" >> $config_host_mak=0D
+echo "libexecdir=3D$libexecdir" >> $config_host_mak=0D
+echo "includedir=3D$includedir" >> $config_host_mak=0D
+echo "sysconfdir=3D$sysconfdir" >> $config_host_mak=0D
+echo "qemu_confdir=3D$qemu_confdir" >> $config_host_mak=0D
+echo "qemu_datadir=3D$qemu_datadir" >> $config_host_mak=0D
+echo "qemu_firmwarepath=3D$firmwarepath" >> $config_host_mak=0D
+echo "qemu_moddir=3D$qemu_moddir" >> $config_host_mak=0D
+if test "$mingw32" =3D "no" ; then=0D
+  echo "qemu_localstatedir=3D$local_statedir" >> $config_host_mak=0D
+fi=0D
+echo "qemu_helperdir=3D$libexecdir" >> $config_host_mak=0D
+echo "qemu_localedir=3D$qemu_localedir" >> $config_host_mak=0D
+echo "qemu_icondir=3D$qemu_icondir" >> $config_host_mak=0D
+echo "qemu_desktopdir=3D$qemu_desktopdir" >> $config_host_mak=0D
+echo "GIT=3D$git" >> $config_host_mak=0D
+echo "GIT_SUBMODULES=3D$git_submodules" >> $config_host_mak=0D
+echo "GIT_UPDATE=3D$git_update" >> $config_host_mak=0D
+=0D
+echo "ARCH=3D$ARCH" >> $config_host_mak=0D
+=0D
+if test "$default_devices" =3D "yes" ; then=0D
+  echo "CONFIG_MINIKCONF_MODE=3D--defconfig" >> $config_host_mak=0D
+else=0D
+  echo "CONFIG_MINIKCONF_MODE=3D--allnoconfig" >> $config_host_mak=0D
+fi=0D
+if test "$debug_tcg" =3D "yes" ; then=0D
+  echo "CONFIG_DEBUG_TCG=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$strip_opt" =3D "yes" ; then=0D
+  echo "STRIP=3D${strip}" >> $config_host_mak=0D
+fi=0D
+if test "$bigendian" =3D "yes" ; then=0D
+  echo "HOST_WORDS_BIGENDIAN=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$mingw32" =3D "yes" ; then=0D
+  echo "CONFIG_WIN32=3Dy" >> $config_host_mak=0D
+  rc_version=3D$(cat $source_path/VERSION)=0D
+  version_major=3D${rc_version%%.*}=0D
+  rc_version=3D${rc_version#*.}=0D
+  version_minor=3D${rc_version%%.*}=0D
+  rc_version=3D${rc_version#*.}=0D
+  version_subminor=3D${rc_version%%.*}=0D
+  version_micro=3D0=0D
+  echo "CONFIG_FILEVERSION=3D$version_major,$version_minor,$version_submin=
or,$version_micro" >> $config_host_mak=0D
+  echo "CONFIG_PRODUCTVERSION=3D$version_major,$version_minor,$version_sub=
minor,$version_micro" >> $config_host_mak=0D
+  if test "$guest_agent_with_vss" =3D "yes" ; then=0D
+    echo "CONFIG_QGA_VSS=3Dy" >> $config_host_mak=0D
+    echo "QGA_VSS_PROVIDER=3D$qga_vss_provider" >> $config_host_mak=0D
+    echo "WIN_SDK=3D\"$win_sdk\"" >> $config_host_mak=0D
+  fi=0D
+  if test "$guest_agent_ntddscsi" =3D "yes" ; then=0D
+    echo "CONFIG_QGA_NTDDSCSI=3Dy" >> $config_host_mak=0D
+  fi=0D
+  if test "$guest_agent_msi" =3D "yes"; then=0D
+    echo "QEMU_GA_MSI_ENABLED=3Dyes" >> $config_host_mak=0D
+    echo "QEMU_GA_MSI_MINGW_DLL_PATH=3D${QEMU_GA_MSI_MINGW_DLL_PATH}" >> $=
config_host_mak=0D
+    echo "QEMU_GA_MSI_WITH_VSS=3D${QEMU_GA_MSI_WITH_VSS}" >> $config_host_=
mak=0D
+    echo "QEMU_GA_MSI_ARCH=3D${QEMU_GA_MSI_ARCH}" >> $config_host_mak=0D
+    echo "QEMU_GA_MANUFACTURER=3D${QEMU_GA_MANUFACTURER}" >> $config_host_=
mak=0D
+    echo "QEMU_GA_DISTRO=3D${QEMU_GA_DISTRO}" >> $config_host_mak=0D
+    echo "QEMU_GA_VERSION=3D${QEMU_GA_VERSION}" >> $config_host_mak=0D
+  fi=0D
+else=0D
+  echo "CONFIG_POSIX=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$linux" =3D "yes" ; then=0D
+  echo "CONFIG_LINUX=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$darwin" =3D "yes" ; then=0D
+  echo "CONFIG_DARWIN=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$solaris" =3D "yes" ; then=0D
+  echo "CONFIG_SOLARIS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$haiku" =3D "yes" ; then=0D
+  echo "CONFIG_HAIKU=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$static" =3D "yes" ; then=0D
+  echo "CONFIG_STATIC=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$profiler" =3D "yes" ; then=0D
+  echo "CONFIG_PROFILER=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$want_tools" =3D "yes" ; then=0D
+  echo "CONFIG_TOOLS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$guest_agent" =3D "yes" ; then=0D
+  echo "CONFIG_GUEST_AGENT=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$slirp" !=3D "no"; then=0D
+  echo "CONFIG_SLIRP=3Dy" >> $config_host_mak=0D
+  echo "CONFIG_SMBD_COMMAND=3D\"$smbd\"" >> $config_host_mak=0D
+  echo "SLIRP_CFLAGS=3D$slirp_cflags" >> $config_host_mak=0D
+  echo "SLIRP_LIBS=3D$slirp_libs" >> $config_host_mak=0D
+fi=0D
+subdirs=3D=0D
+if [ "$slirp" =3D "git" -o "$slirp" =3D "internal" ]; then=0D
+  subdirs=3D"$subdirs slirp"=0D
+fi=0D
+if test "$vde" =3D "yes" ; then=0D
+  echo "CONFIG_VDE=3Dy" >> $config_host_mak=0D
+  echo "VDE_LIBS=3D$vde_libs" >> $config_host_mak=0D
+fi=0D
+if test "$netmap" =3D "yes" ; then=0D
+  echo "CONFIG_NETMAP=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$l2tpv3" =3D "yes" ; then=0D
+  echo "CONFIG_L2TPV3=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$gprof" =3D "yes" ; then=0D
+  echo "CONFIG_GPROF=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$cap_ng" =3D "yes" ; then=0D
+  echo "CONFIG_LIBCAP_NG=3Dy" >> $config_host_mak=0D
+  echo "LIBCAP_NG_LIBS=3D$cap_libs" >> $config_host_mak=0D
+fi=0D
+echo "CONFIG_AUDIO_DRIVERS=3D$audio_drv_list" >> $config_host_mak=0D
+for drv in $audio_drv_list; do=0D
+    def=3DCONFIG_AUDIO_$(echo $drv | LC_ALL=3DC tr '[a-z]' '[A-Z]')=0D
+    echo "$def=3Dy" >> $config_host_mak=0D
+done=0D
+if test "$alsa" =3D "yes" ; then=0D
+    echo "CONFIG_ALSA=3Dy" >> $config_host_mak=0D
+fi=0D
+echo "ALSA_LIBS=3D$alsa_libs" >> $config_host_mak=0D
+echo "ALSA_CFLAGS=3D$alsa_cflags" >> $config_host_mak=0D
+if test "$libpulse" =3D "yes" ; then=0D
+    echo "CONFIG_LIBPULSE=3Dy" >> $config_host_mak=0D
+fi=0D
+echo "PULSE_LIBS=3D$pulse_libs" >> $config_host_mak=0D
+echo "PULSE_CFLAGS=3D$pulse_cflags" >> $config_host_mak=0D
+echo "COREAUDIO_LIBS=3D$coreaudio_libs" >> $config_host_mak=0D
+echo "DSOUND_LIBS=3D$dsound_libs" >> $config_host_mak=0D
+echo "OSS_LIBS=3D$oss_libs" >> $config_host_mak=0D
+if test "$libjack" =3D "yes" ; then=0D
+    echo "CONFIG_LIBJACK=3Dy" >> $config_host_mak=0D
+fi=0D
+echo "JACK_LIBS=3D$jack_libs" >> $config_host_mak=0D
+if test "$audio_win_int" =3D "yes" ; then=0D
+  echo "CONFIG_AUDIO_WIN_INT=3Dy" >> $config_host_mak=0D
+fi=0D
+echo "CONFIG_BDRV_RW_WHITELIST=3D$block_drv_rw_whitelist" >> $config_host_=
mak=0D
+echo "CONFIG_BDRV_RO_WHITELIST=3D$block_drv_ro_whitelist" >> $config_host_=
mak=0D
+if test "$xfs" =3D "yes" ; then=0D
+  echo "CONFIG_XFS=3Dy" >> $config_host_mak=0D
+fi=0D
+qemu_version=3D$(head $source_path/VERSION)=0D
+echo "PKGVERSION=3D$pkgversion" >>$config_host_mak=0D
+echo "SRC_PATH=3D$source_path" >> $config_host_mak=0D
+echo "TARGET_DIRS=3D$target_list" >> $config_host_mak=0D
+if [ "$docs" =3D "yes" ] ; then=0D
+  echo "BUILD_DOCS=3Dyes" >> $config_host_mak=0D
+fi=0D
+if test "$modules" =3D "yes"; then=0D
+  # $shacmd can generate a hash started with digit, which the compiler doe=
sn't=0D
+  # like as an symbol. So prefix it with an underscore=0D
+  echo "CONFIG_STAMP=3D_$( (echo $qemu_version; echo $pkgversion; cat $0) =
| $shacmd - | cut -f1 -d\ )" >> $config_host_mak=0D
+  echo "CONFIG_MODULES=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$module_upgrades" =3D "yes"; then=0D
+  echo "CONFIG_MODULE_UPGRADES=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_x11" =3D "yes" && test "$need_x11" =3D "yes"; then=0D
+  echo "CONFIG_X11=3Dy" >> $config_host_mak=0D
+  echo "X11_CFLAGS=3D$x11_cflags" >> $config_host_mak=0D
+  echo "X11_LIBS=3D$x11_libs" >> $config_host_mak=0D
+fi=0D
+if test "$cocoa" =3D "yes" ; then=0D
+  echo "CONFIG_COCOA=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$iconv" =3D "yes" ; then=0D
+  echo "CONFIG_ICONV=3Dy" >> $config_host_mak=0D
+  echo "ICONV_CFLAGS=3D$iconv_cflags" >> $config_host_mak=0D
+  echo "ICONV_LIBS=3D$iconv_lib" >> $config_host_mak=0D
+fi=0D
+if test "$curses" =3D "yes" ; then=0D
+  echo "CONFIG_CURSES=3Dy" >> $config_host_mak=0D
+  echo "CURSES_CFLAGS=3D$curses_inc" >> $config_host_mak=0D
+  echo "CURSES_LIBS=3D$curses_lib" >> $config_host_mak=0D
+fi=0D
+if test "$pipe2" =3D "yes" ; then=0D
+  echo "CONFIG_PIPE2=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$accept4" =3D "yes" ; then=0D
+  echo "CONFIG_ACCEPT4=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$splice" =3D "yes" ; then=0D
+  echo "CONFIG_SPLICE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$eventfd" =3D "yes" ; then=0D
+  echo "CONFIG_EVENTFD=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$memfd" =3D "yes" ; then=0D
+  echo "CONFIG_MEMFD=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_usbfs" =3D "yes" ; then=0D
+  echo "CONFIG_USBFS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$fallocate" =3D "yes" ; then=0D
+  echo "CONFIG_FALLOCATE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$fallocate_punch_hole" =3D "yes" ; then=0D
+  echo "CONFIG_FALLOCATE_PUNCH_HOLE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$fallocate_zero_range" =3D "yes" ; then=0D
+  echo "CONFIG_FALLOCATE_ZERO_RANGE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$posix_fallocate" =3D "yes" ; then=0D
+  echo "CONFIG_POSIX_FALLOCATE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$sync_file_range" =3D "yes" ; then=0D
+  echo "CONFIG_SYNC_FILE_RANGE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$fiemap" =3D "yes" ; then=0D
+  echo "CONFIG_FIEMAP=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$dup3" =3D "yes" ; then=0D
+  echo "CONFIG_DUP3=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$ppoll" =3D "yes" ; then=0D
+  echo "CONFIG_PPOLL=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$prctl_pr_set_timerslack" =3D "yes" ; then=0D
+  echo "CONFIG_PRCTL_PR_SET_TIMERSLACK=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$epoll" =3D "yes" ; then=0D
+  echo "CONFIG_EPOLL=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$epoll_create1" =3D "yes" ; then=0D
+  echo "CONFIG_EPOLL_CREATE1=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$sendfile" =3D "yes" ; then=0D
+  echo "CONFIG_SENDFILE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$timerfd" =3D "yes" ; then=0D
+  echo "CONFIG_TIMERFD=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$setns" =3D "yes" ; then=0D
+  echo "CONFIG_SETNS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$clock_adjtime" =3D "yes" ; then=0D
+  echo "CONFIG_CLOCK_ADJTIME=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$syncfs" =3D "yes" ; then=0D
+  echo "CONFIG_SYNCFS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$kcov" =3D "yes" ; then=0D
+  echo "CONFIG_KCOV=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$inotify" =3D "yes" ; then=0D
+  echo "CONFIG_INOTIFY=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$inotify1" =3D "yes" ; then=0D
+  echo "CONFIG_INOTIFY1=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$sem_timedwait" =3D "yes" ; then=0D
+  echo "CONFIG_SEM_TIMEDWAIT=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$strchrnul" =3D "yes" ; then=0D
+  echo "HAVE_STRCHRNUL=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$st_atim" =3D "yes" ; then=0D
+  echo "HAVE_STRUCT_STAT_ST_ATIM=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$byteswap_h" =3D "yes" ; then=0D
+  echo "CONFIG_BYTESWAP_H=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$bswap_h" =3D "yes" ; then=0D
+  echo "CONFIG_MACHINE_BSWAP_H=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$curl" =3D "yes" ; then=0D
+  echo "CONFIG_CURL=3Dy" >> $config_host_mak=0D
+  echo "CURL_CFLAGS=3D$curl_cflags" >> $config_host_mak=0D
+  echo "CURL_LIBS=3D$curl_libs" >> $config_host_mak=0D
+fi=0D
+if test "$brlapi" =3D "yes" ; then=0D
+  echo "CONFIG_BRLAPI=3Dy" >> $config_host_mak=0D
+  echo "BRLAPI_LIBS=3D$brlapi_libs" >> $config_host_mak=0D
+fi=0D
+if test "$gtk" =3D "yes" ; then=0D
+  echo "CONFIG_GTK=3Dy" >> $config_host_mak=0D
+  echo "GTK_CFLAGS=3D$gtk_cflags" >> $config_host_mak=0D
+  echo "GTK_LIBS=3D$gtk_libs" >> $config_host_mak=0D
+  if test "$gtk_gl" =3D "yes" ; then=0D
+    echo "CONFIG_GTK_GL=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+if test "$gio" =3D "yes" ; then=0D
+    echo "CONFIG_GIO=3Dy" >> $config_host_mak=0D
+    echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak=0D
+    echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak=0D
+    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak=0D
+fi=0D
+echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak=0D
+if test "$gnutls" =3D "yes" ; then=0D
+  echo "CONFIG_GNUTLS=3Dy" >> $config_host_mak=0D
+  echo "GNUTLS_CFLAGS=3D$gnutls_cflags" >> $config_host_mak=0D
+  echo "GNUTLS_LIBS=3D$gnutls_libs" >> $config_host_mak=0D
+fi=0D
+if test "$gcrypt" =3D "yes" ; then=0D
+  echo "CONFIG_GCRYPT=3Dy" >> $config_host_mak=0D
+  if test "$gcrypt_hmac" =3D "yes" ; then=0D
+    echo "CONFIG_GCRYPT_HMAC=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+if test "$nettle" =3D "yes" ; then=0D
+  echo "CONFIG_NETTLE=3Dy" >> $config_host_mak=0D
+  echo "CONFIG_NETTLE_VERSION_MAJOR=3D${nettle_version%%.*}" >> $config_ho=
st_mak=0D
+  echo "NETTLE_CFLAGS=3D$nettle_cflags" >> $config_host_mak=0D
+  echo "NETTLE_LIBS=3D$nettle_libs" >> $config_host_mak=0D
+fi=0D
+if test "$qemu_private_xts" =3D "yes" ; then=0D
+  echo "CONFIG_QEMU_PRIVATE_XTS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$tasn1" =3D "yes" ; then=0D
+  echo "CONFIG_TASN1=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$auth_pam" =3D "yes" ; then=0D
+    echo "CONFIG_AUTH_PAM=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_ifaddrs_h" =3D "yes" ; then=0D
+    echo "HAVE_IFADDRS_H=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_drm_h" =3D "yes" ; then=0D
+  echo "HAVE_DRM_H=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_broken_size_max" =3D "yes" ; then=0D
+    echo "HAVE_BROKEN_SIZE_MAX=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_openpty" =3D "yes" ; then=0D
+    echo "HAVE_OPENPTY=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_sys_signal_h" =3D "yes" ; then=0D
+    echo "HAVE_SYS_SIGNAL_H=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+# Work around a system header bug with some kernel/XFS header=0D
+# versions where they both try to define 'struct fsxattr':=0D
+# xfs headers will not try to redefine structs from linux headers=0D
+# if this macro is set.=0D
+if test "$have_fsxattr" =3D "yes" ; then=0D
+    echo "HAVE_FSXATTR=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_copy_file_range" =3D "yes" ; then=0D
+    echo "HAVE_COPY_FILE_RANGE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vte" =3D "yes" ; then=0D
+  echo "CONFIG_VTE=3Dy" >> $config_host_mak=0D
+  echo "VTE_CFLAGS=3D$vte_cflags" >> $config_host_mak=0D
+  echo "VTE_LIBS=3D$vte_libs" >> $config_host_mak=0D
+fi=0D
+if test "$virglrenderer" =3D "yes" ; then=0D
+  echo "CONFIG_VIRGL=3Dy" >> $config_host_mak=0D
+  echo "VIRGL_CFLAGS=3D$virgl_cflags" >> $config_host_mak=0D
+  echo "VIRGL_LIBS=3D$virgl_libs" >> $config_host_mak=0D
+fi=0D
+if test "$xen" =3D "yes" ; then=0D
+  echo "CONFIG_XEN_BACKEND=3Dy" >> $config_host_mak=0D
+  echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=3D$xen_ctrl_version" >> $config_=
host_mak=0D
+  echo "XEN_CFLAGS=3D$xen_cflags" >> $config_host_mak=0D
+  echo "XEN_LIBS=3D$xen_libs" >> $config_host_mak=0D
+fi=0D
+if test "$linux_aio" =3D "yes" ; then=0D
+  echo "CONFIG_LINUX_AIO=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$linux_io_uring" =3D "yes" ; then=0D
+  echo "CONFIG_LINUX_IO_URING=3Dy" >> $config_host_mak=0D
+  echo "LINUX_IO_URING_CFLAGS=3D$linux_io_uring_cflags" >> $config_host_ma=
k=0D
+  echo "LINUX_IO_URING_LIBS=3D$linux_io_uring_libs" >> $config_host_mak=0D
+fi=0D
+if test "$attr" =3D "yes" ; then=0D
+  echo "CONFIG_ATTR=3Dy" >> $config_host_mak=0D
+  echo "LIBATTR_LIBS=3D$libattr_libs" >> $config_host_mak=0D
+fi=0D
+if test "$libattr" =3D "yes" ; then=0D
+  echo "CONFIG_LIBATTR=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$virtfs" =3D "yes" ; then=0D
+  echo "CONFIG_VIRTFS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$mpath" =3D "yes" ; then=0D
+  echo "CONFIG_MPATH=3Dy" >> $config_host_mak=0D
+  if test "$mpathpersist_new_api" =3D "yes"; then=0D
+    echo "CONFIG_MPATH_NEW_API=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+if test "$vhost_scsi" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_SCSI=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_net" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_NET=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_net_user" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_NET_USER=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_net_vdpa" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_NET_VDPA=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_crypto" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_CRYPTO=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_vsock" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_VSOCK=3Dy" >> $config_host_mak=0D
+  if test "$vhost_user" =3D "yes" ; then=0D
+    echo "CONFIG_VHOST_USER_VSOCK=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+if test "$vhost_kernel" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_KERNEL=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_user" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_USER=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_vdpa" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_VDPA=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vhost_user_fs" =3D "yes" ; then=0D
+  echo "CONFIG_VHOST_USER_FS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$blobs" =3D "yes" ; then=0D
+  echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak=0D
+fi=0D
+if test "$iovec" =3D "yes" ; then=0D
+  echo "CONFIG_IOVEC=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$preadv" =3D "yes" ; then=0D
+  echo "CONFIG_PREADV=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$fdt" !=3D "no" ; then=0D
+  echo "CONFIG_FDT=3Dy" >> $config_host_mak=0D
+  echo "FDT_CFLAGS=3D$fdt_cflags" >> $config_host_mak=0D
+  echo "FDT_LIBS=3D$fdt_ldflags $fdt_libs" >> $config_host_mak=0D
+fi=0D
+if test "$membarrier" =3D "yes" ; then=0D
+  echo "CONFIG_MEMBARRIER=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$signalfd" =3D "yes" ; then=0D
+  echo "CONFIG_SIGNALFD=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$optreset" =3D "yes" ; then=0D
+  echo "HAVE_OPTRESET=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$tcg" =3D "yes"; then=0D
+  echo "CONFIG_TCG=3Dy" >> $config_host_mak=0D
+  if test "$tcg_interpreter" =3D "yes" ; then=0D
+    echo "CONFIG_TCG_INTERPRETER=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+if test "$fdatasync" =3D "yes" ; then=0D
+  echo "CONFIG_FDATASYNC=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$madvise" =3D "yes" ; then=0D
+  echo "CONFIG_MADVISE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$posix_madvise" =3D "yes" ; then=0D
+  echo "CONFIG_POSIX_MADVISE=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$posix_memalign" =3D "yes" ; then=0D
+  echo "CONFIG_POSIX_MEMALIGN=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$spice" =3D "yes" ; then=0D
+  echo "CONFIG_SPICE=3Dy" >> $config_host_mak=0D
+  echo "SPICE_CFLAGS=3D$spice_cflags" >> $config_host_mak=0D
+  echo "SPICE_LIBS=3D$spice_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$smartcard" =3D "yes" ; then=0D
+  echo "CONFIG_SMARTCARD=3Dy" >> $config_host_mak=0D
+  echo "SMARTCARD_CFLAGS=3D$libcacard_cflags" >> $config_host_mak=0D
+  echo "SMARTCARD_LIBS=3D$libcacard_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libusb" =3D "yes" ; then=0D
+  echo "CONFIG_USB_LIBUSB=3Dy" >> $config_host_mak=0D
+  echo "LIBUSB_CFLAGS=3D$libusb_cflags" >> $config_host_mak=0D
+  echo "LIBUSB_LIBS=3D$libusb_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$usb_redir" =3D "yes" ; then=0D
+  echo "CONFIG_USB_REDIR=3Dy" >> $config_host_mak=0D
+  echo "USB_REDIR_CFLAGS=3D$usb_redir_cflags" >> $config_host_mak=0D
+  echo "USB_REDIR_LIBS=3D$usb_redir_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$opengl" =3D "yes" ; then=0D
+  echo "CONFIG_OPENGL=3Dy" >> $config_host_mak=0D
+  echo "OPENGL_LIBS=3D$opengl_libs" >> $config_host_mak=0D
+  if test "$opengl_dmabuf" =3D "yes" ; then=0D
+    echo "CONFIG_OPENGL_DMABUF=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+=0D
+if test "$gbm" =3D "yes" ; then=0D
+    echo "CONFIG_GBM=3Dy" >> $config_host_mak=0D
+    echo "GBM_LIBS=3D$gbm_libs" >> $config_host_mak=0D
+    echo "GBM_CFLAGS=3D$gbm_cflags" >> $config_host_mak=0D
+fi=0D
+=0D
+=0D
+if test "$malloc_trim" =3D "yes" ; then=0D
+  echo "CONFIG_MALLOC_TRIM=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$avx2_opt" =3D "yes" ; then=0D
+  echo "CONFIG_AVX2_OPT=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$avx512f_opt" =3D "yes" ; then=0D
+  echo "CONFIG_AVX512F_OPT=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$lzo" =3D "yes" ; then=0D
+  echo "CONFIG_LZO=3Dy" >> $config_host_mak=0D
+  echo "LZO_LIBS=3D$lzo_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$snappy" =3D "yes" ; then=0D
+  echo "CONFIG_SNAPPY=3Dy" >> $config_host_mak=0D
+  echo "SNAPPY_LIBS=3D$snappy_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$bzip2" =3D "yes" ; then=0D
+  echo "CONFIG_BZIP2=3Dy" >> $config_host_mak=0D
+  echo "BZIP2_LIBS=3D-lbz2" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$lzfse" =3D "yes" ; then=0D
+  echo "CONFIG_LZFSE=3Dy" >> $config_host_mak=0D
+  echo "LZFSE_LIBS=3D-llzfse" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$zstd" =3D "yes" ; then=0D
+  echo "CONFIG_ZSTD=3Dy" >> $config_host_mak=0D
+  echo "ZSTD_CFLAGS=3D$zstd_cflags" >> $config_host_mak=0D
+  echo "ZSTD_LIBS=3D$zstd_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libiscsi" =3D "yes" ; then=0D
+  echo "CONFIG_LIBISCSI=3Dy" >> $config_host_mak=0D
+  echo "LIBISCSI_CFLAGS=3D$libiscsi_cflags" >> $config_host_mak=0D
+  echo "LIBISCSI_LIBS=3D$libiscsi_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libnfs" =3D "yes" ; then=0D
+  echo "CONFIG_LIBNFS=3Dy" >> $config_host_mak=0D
+  echo "LIBNFS_LIBS=3D$libnfs_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$seccomp" =3D "yes"; then=0D
+  echo "CONFIG_SECCOMP=3Dy" >> $config_host_mak=0D
+  echo "SECCOMP_CFLAGS=3D$seccomp_cflags" >> $config_host_mak=0D
+  echo "SECCOMP_LIBS=3D$seccomp_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+# XXX: suppress that=0D
+if [ "$bsd" =3D "yes" ] ; then=0D
+  echo "CONFIG_BSD=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$localtime_r" =3D "yes" ; then=0D
+  echo "CONFIG_LOCALTIME_R=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$qom_cast_debug" =3D "yes" ; then=0D
+  echo "CONFIG_QOM_CAST_DEBUG=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$rbd" =3D "yes" ; then=0D
+  echo "CONFIG_RBD=3Dy" >> $config_host_mak=0D
+  echo "RBD_LIBS=3D$rbd_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+echo "CONFIG_COROUTINE_BACKEND=3D$coroutine" >> $config_host_mak=0D
+if test "$coroutine_pool" =3D "yes" ; then=0D
+  echo "CONFIG_COROUTINE_POOL=3D1" >> $config_host_mak=0D
+else=0D
+  echo "CONFIG_COROUTINE_POOL=3D0" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$debug_stack_usage" =3D "yes" ; then=0D
+  echo "CONFIG_DEBUG_STACK_USAGE=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$crypto_afalg" =3D "yes" ; then=0D
+  echo "CONFIG_AF_ALG=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$open_by_handle_at" =3D "yes" ; then=0D
+  echo "CONFIG_OPEN_BY_HANDLE=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$linux_magic_h" =3D "yes" ; then=0D
+  echo "CONFIG_LINUX_MAGIC_H=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$valgrind_h" =3D "yes" ; then=0D
+  echo "CONFIG_VALGRIND_H=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$have_asan_iface_fiber" =3D "yes" ; then=0D
+    echo "CONFIG_ASAN_IFACE_FIBER=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$have_tsan" =3D "yes" && test "$have_tsan_iface_fiber" =3D "yes" =
; then=0D
+    echo "CONFIG_TSAN=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$has_environ" =3D "yes" ; then=0D
+  echo "CONFIG_HAS_ENVIRON=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$cpuid_h" =3D "yes" ; then=0D
+  echo "CONFIG_CPUID_H=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$int128" =3D "yes" ; then=0D
+  echo "CONFIG_INT128=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$atomic128" =3D "yes" ; then=0D
+  echo "CONFIG_ATOMIC128=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$cmpxchg128" =3D "yes" ; then=0D
+  echo "CONFIG_CMPXCHG128=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$atomic64" =3D "yes" ; then=0D
+  echo "CONFIG_ATOMIC64=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$attralias" =3D "yes" ; then=0D
+  echo "CONFIG_ATTRIBUTE_ALIAS=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$getauxval" =3D "yes" ; then=0D
+  echo "CONFIG_GETAUXVAL=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$glusterfs" =3D "yes" ; then=0D
+  echo "CONFIG_GLUSTERFS=3Dy" >> $config_host_mak=0D
+  echo "GLUSTERFS_CFLAGS=3D$glusterfs_cflags" >> $config_host_mak=0D
+  echo "GLUSTERFS_LIBS=3D$glusterfs_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$glusterfs_xlator_opt" =3D "yes" ; then=0D
+  echo "CONFIG_GLUSTERFS_XLATOR_OPT=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$glusterfs_discard" =3D "yes" ; then=0D
+  echo "CONFIG_GLUSTERFS_DISCARD=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$glusterfs_fallocate" =3D "yes" ; then=0D
+  echo "CONFIG_GLUSTERFS_FALLOCATE=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$glusterfs_zerofill" =3D "yes" ; then=0D
+  echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$glusterfs_ftruncate_has_stat" =3D "yes" ; then=0D
+  echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$glusterfs_iocb_has_stat" =3D "yes" ; then=0D
+  echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libssh" =3D "yes" ; then=0D
+  echo "CONFIG_LIBSSH=3Dy" >> $config_host_mak=0D
+  echo "LIBSSH_CFLAGS=3D$libssh_cflags" >> $config_host_mak=0D
+  echo "LIBSSH_LIBS=3D$libssh_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$live_block_migration" =3D "yes" ; then=0D
+  echo "CONFIG_LIVE_BLOCK_MIGRATION=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$tpm" =3D "yes"; then=0D
+  echo 'CONFIG_TPM=3Dy' >> $config_host_mak=0D
+fi=0D
+=0D
+echo "TRACE_BACKENDS=3D$trace_backends" >> $config_host_mak=0D
+if have_backend "nop"; then=0D
+  echo "CONFIG_TRACE_NOP=3Dy" >> $config_host_mak=0D
+fi=0D
+if have_backend "simple"; then=0D
+  echo "CONFIG_TRACE_SIMPLE=3Dy" >> $config_host_mak=0D
+  # Set the appropriate trace file.=0D
+  trace_file=3D"\"$trace_file-\" FMT_pid"=0D
+fi=0D
+if have_backend "log"; then=0D
+  echo "CONFIG_TRACE_LOG=3Dy" >> $config_host_mak=0D
+fi=0D
+if have_backend "ust"; then=0D
+  echo "CONFIG_TRACE_UST=3Dy" >> $config_host_mak=0D
+  echo "LTTNG_UST_LIBS=3D$lttng_ust_libs" >> $config_host_mak=0D
+  echo "URCU_BP_LIBS=3D$urcu_bp_libs" >> $config_host_mak=0D
+fi=0D
+if have_backend "dtrace"; then=0D
+  echo "CONFIG_TRACE_DTRACE=3Dy" >> $config_host_mak=0D
+  if test "$trace_backend_stap" =3D "yes" ; then=0D
+    echo "CONFIG_TRACE_SYSTEMTAP=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+if have_backend "ftrace"; then=0D
+  if test "$linux" =3D "yes" ; then=0D
+    echo "CONFIG_TRACE_FTRACE=3Dy" >> $config_host_mak=0D
+  else=0D
+    feature_not_found "ftrace(trace backend)" "ftrace requires Linux"=0D
+  fi=0D
+fi=0D
+if have_backend "syslog"; then=0D
+  if test "$posix_syslog" =3D "yes" ; then=0D
+    echo "CONFIG_TRACE_SYSLOG=3Dy" >> $config_host_mak=0D
+  else=0D
+    feature_not_found "syslog(trace backend)" "syslog not available"=0D
+  fi=0D
+fi=0D
+echo "CONFIG_TRACE_FILE=3D$trace_file" >> $config_host_mak=0D
+=0D
+if test "$rdma" =3D "yes" ; then=0D
+  echo "CONFIG_RDMA=3Dy" >> $config_host_mak=0D
+  echo "RDMA_LIBS=3D$rdma_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$pvrdma" =3D "yes" ; then=0D
+  echo "CONFIG_PVRDMA=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$have_rtnetlink" =3D "yes" ; then=0D
+  echo "CONFIG_RTNETLINK=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libxml2" =3D "yes" ; then=0D
+  echo "CONFIG_LIBXML2=3Dy" >> $config_host_mak=0D
+  echo "LIBXML2_CFLAGS=3D$libxml2_cflags" >> $config_host_mak=0D
+  echo "LIBXML2_LIBS=3D$libxml2_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$replication" =3D "yes" ; then=0D
+  echo "CONFIG_REPLICATION=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$have_af_vsock" =3D "yes" ; then=0D
+  echo "CONFIG_AF_VSOCK=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$have_sysmacros" =3D "yes" ; then=0D
+  echo "CONFIG_SYSMACROS=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$have_static_assert" =3D "yes" ; then=0D
+  echo "CONFIG_STATIC_ASSERT=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$have_utmpx" =3D "yes" ; then=0D
+  echo "HAVE_UTMPX=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_getrandom" =3D "yes" ; then=0D
+  echo "CONFIG_GETRANDOM=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$ivshmem" =3D "yes" ; then=0D
+  echo "CONFIG_IVSHMEM=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$capstone" !=3D "no" ; then=0D
+  echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak=0D
+  echo "CAPSTONE_CFLAGS=3D$capstone_cflags" >> $config_host_mak=0D
+  echo "CAPSTONE_LIBS=3D$capstone_libs" >> $config_host_mak=0D
+fi=0D
+if test "$debug_mutex" =3D "yes" ; then=0D
+  echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+# Hold two types of flag:=0D
+#   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name =
on=0D
+#                                     a thread we have a handle to=0D
+#   CONFIG_PTHREAD_SETNAME_NP_W_TID - A way of doing it on a particular=0D
+#                                     platform=0D
+if test "$pthread_setname_np_w_tid" =3D "yes" ; then=0D
+  echo "CONFIG_THREAD_SETNAME_BYTHREAD=3Dy" >> $config_host_mak=0D
+  echo "CONFIG_PTHREAD_SETNAME_NP_W_TID=3Dy" >> $config_host_mak=0D
+elif test "$pthread_setname_np_wo_tid" =3D "yes" ; then=0D
+  echo "CONFIG_THREAD_SETNAME_BYTHREAD=3Dy" >> $config_host_mak=0D
+  echo "CONFIG_PTHREAD_SETNAME_NP_WO_TID=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libpmem" =3D "yes" ; then=0D
+  echo "CONFIG_LIBPMEM=3Dy" >> $config_host_mak=0D
+  echo "LIBPMEM_LIBS=3D$libpmem_libs" >> $config_host_mak=0D
+  echo "LIBPMEM_CFLAGS=3D$libpmem_cflags" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libdaxctl" =3D "yes" ; then=0D
+  echo "CONFIG_LIBDAXCTL=3Dy" >> $config_host_mak=0D
+  echo "LIBDAXCTL_LIBS=3D$libdaxctl_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$bochs" =3D "yes" ; then=0D
+  echo "CONFIG_BOCHS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$cloop" =3D "yes" ; then=0D
+  echo "CONFIG_CLOOP=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$dmg" =3D "yes" ; then=0D
+  echo "CONFIG_DMG=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$qcow1" =3D "yes" ; then=0D
+  echo "CONFIG_QCOW1=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vdi" =3D "yes" ; then=0D
+  echo "CONFIG_VDI=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$vvfat" =3D "yes" ; then=0D
+  echo "CONFIG_VVFAT=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$qed" =3D "yes" ; then=0D
+  echo "CONFIG_QED=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$parallels" =3D "yes" ; then=0D
+  echo "CONFIG_PARALLELS=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$sheepdog" =3D "yes" ; then=0D
+  echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$pty_h" =3D "yes" ; then=0D
+  echo "HAVE_PTY_H=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$have_mlockall" =3D "yes" ; then=0D
+  echo "HAVE_MLOCKALL=3Dy" >> $config_host_mak=0D
+fi=0D
+if test "$fuzzing" =3D "yes" ; then=0D
+  QEMU_CFLAGS=3D"$QEMU_CFLAGS -fsanitize=3Dfuzzer-no-link"=0D
+fi=0D
+=0D
+if test "$plugins" =3D "yes" ; then=0D
+    echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak=0D
+    LIBS=3D"-ldl $LIBS"=0D
+    # Copy the export object list to the build dir=0D
+    if test "$ld_dynamic_list" =3D "yes" ; then=0D
+	echo "CONFIG_HAS_LD_DYNAMIC_LIST=3Dyes" >> $config_host_mak=0D
+	ld_symbols=3Dqemu-plugins-ld.symbols=0D
+	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols=0D
+    elif test "$ld_exported_symbols_list" =3D "yes" ; then=0D
+	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=3Dyes" >> $config_host_mak=0D
+	ld64_symbols=3Dqemu-plugins-ld64.symbols=0D
+	echo "# Automatically generated by configure - do not modify" > $ld64_sym=
bols=0D
+	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g' |=
 \=0D
+	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols=0D
+    else=0D
+	error_exit \=0D
+	    "If \$plugins=3Dyes, either \$ld_dynamic_list or " \=0D
+	    "\$ld_exported_symbols_list should have been set to 'yes'."=0D
+    fi=0D
+fi=0D
+=0D
+if test -n "$gdb_bin" ; then=0D
+    echo "HAVE_GDB_BIN=3D$gdb_bin" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$secret_keyring" =3D "yes" ; then=0D
+  echo "CONFIG_SECRET_KEYRING=3Dy" >> $config_host_mak=0D
+  if test "$have_keyutils" =3D "yes" ; then=0D
+    echo "CONFIG_TEST_SECRET_KEYRING=3Dy" >> $config_host_mak=0D
+  fi=0D
+fi=0D
+=0D
+if test "$tcg_interpreter" =3D "yes"; then=0D
+  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/tci $QEMU_INCLUDES"=0D
+elif test "$ARCH" =3D "sparc64" ; then=0D
+  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/sparc $QEMU_INCLUDES"=0D
+elif test "$ARCH" =3D "s390x" ; then=0D
+  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/s390 $QEMU_INCLUDES"=0D
+elif test "$ARCH" =3D "x86_64" || test "$ARCH" =3D "x32" ; then=0D
+  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/i386 $QEMU_INCLUDES"=0D
+elif test "$ARCH" =3D "ppc64" ; then=0D
+  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/ppc $QEMU_INCLUDES"=0D
+elif test "$ARCH" =3D "riscv32" || test "$ARCH" =3D "riscv64" ; then=0D
+  QEMU_INCLUDES=3D"-I${source_path}/tcg/riscv $QEMU_INCLUDES"=0D
+else=0D
+  QEMU_INCLUDES=3D"-iquote ${source_path}/tcg/${ARCH} $QEMU_INCLUDES"=0D
+fi=0D
+=0D
+echo "ROMS=3D$roms" >> $config_host_mak=0D
+echo "MAKE=3D$make" >> $config_host_mak=0D
+echo "INSTALL=3D$install" >> $config_host_mak=0D
+echo "INSTALL_DIR=3D$install -d -m 0755" >> $config_host_mak=0D
+echo "INSTALL_DATA=3D$install -c -m 0644" >> $config_host_mak=0D
+echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak=0D
+echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak=0D
+echo "PYTHON=3D$python" >> $config_host_mak=0D
+echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak=0D
+echo "GENISOIMAGE=3D$genisoimage" >> $config_host_mak=0D
+echo "MESON=3D$meson" >> $config_host_mak=0D
+echo "CC=3D$cc" >> $config_host_mak=0D
+if $iasl -h > /dev/null 2>&1; then=0D
+  echo "CONFIG_IASL=3D$iasl" >> $config_host_mak=0D
+fi=0D
+echo "CXX=3D$cxx" >> $config_host_mak=0D
+echo "OBJCC=3D$objcc" >> $config_host_mak=0D
+echo "AR=3D$ar" >> $config_host_mak=0D
+echo "ARFLAGS=3D$ARFLAGS" >> $config_host_mak=0D
+echo "AS=3D$as" >> $config_host_mak=0D
+echo "CCAS=3D$ccas" >> $config_host_mak=0D
+echo "CPP=3D$cpp" >> $config_host_mak=0D
+echo "OBJCOPY=3D$objcopy" >> $config_host_mak=0D
+echo "LD=3D$ld" >> $config_host_mak=0D
+echo "RANLIB=3D$ranlib" >> $config_host_mak=0D
+echo "NM=3D$nm" >> $config_host_mak=0D
+echo "PKG_CONFIG=3D$pkg_config_exe" >> $config_host_mak=0D
+echo "WINDRES=3D$windres" >> $config_host_mak=0D
+echo "CFLAGS=3D$CFLAGS" >> $config_host_mak=0D
+echo "CXXFLAGS=3D$CXXFLAGS" >> $config_host_mak=0D
+echo "CFLAGS_NOPIE=3D$CFLAGS_NOPIE" >> $config_host_mak=0D
+echo "QEMU_CFLAGS=3D$QEMU_CFLAGS" >> $config_host_mak=0D
+echo "QEMU_CXXFLAGS=3D$QEMU_CXXFLAGS" >> $config_host_mak=0D
+echo "QEMU_INCLUDES=3D$QEMU_INCLUDES" >> $config_host_mak=0D
+echo "GLIB_CFLAGS=3D$glib_cflags" >> $config_host_mak=0D
+echo "GLIB_LIBS=3D$glib_libs" >> $config_host_mak=0D
+if test "$sparse" =3D "yes" ; then=0D
+  echo "SPARSE_CFLAGS =3D -Wbitwise -Wno-transparent-union -Wno-old-initia=
lizer -Wno-non-pointer-null" >> $config_host_mak=0D
+fi=0D
+echo "QEMU_LDFLAGS=3D$QEMU_LDFLAGS" >> $config_host_mak=0D
+echo "LDFLAGS_NOPIE=3D$LDFLAGS_NOPIE" >> $config_host_mak=0D
+echo "LD_REL_FLAGS=3D$LD_REL_FLAGS" >> $config_host_mak=0D
+echo "LD_I386_EMULATION=3D$ld_i386_emulation" >> $config_host_mak=0D
+echo "LIBS+=3D$LIBS" >> $config_host_mak=0D
+echo "LIBS_TOOLS+=3D$libs_tools" >> $config_host_mak=0D
+echo "PTHREAD_LIB=3D$PTHREAD_LIB" >> $config_host_mak=0D
+echo "EXESUF=3D$EXESUF" >> $config_host_mak=0D
+echo "HOST_DSOSUF=3D$HOST_DSOSUF" >> $config_host_mak=0D
+echo "LDFLAGS_SHARED=3D$LDFLAGS_SHARED" >> $config_host_mak=0D
+echo "LIBS_QGA=3D$libs_qga" >> $config_host_mak=0D
+echo "TASN1_LIBS=3D$tasn1_libs" >> $config_host_mak=0D
+echo "TASN1_CFLAGS=3D$tasn1_cflags" >> $config_host_mak=0D
+echo "POD2MAN=3D$POD2MAN" >> $config_host_mak=0D
+if test "$gcov" =3D "yes" ; then=0D
+  echo "CONFIG_GCOV=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$libudev" !=3D "no"; then=0D
+    echo "CONFIG_LIBUDEV=3Dy" >> $config_host_mak=0D
+    echo "LIBUDEV_LIBS=3D$libudev_libs" >> $config_host_mak=0D
+fi=0D
+if test "$fuzzing" !=3D "no"; then=0D
+    echo "CONFIG_FUZZ=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$edk2_blobs" =3D "yes" ; then=0D
+  echo "DECOMPRESS_EDK2_BLOBS=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$rng_none" =3D "yes"; then=0D
+  echo "CONFIG_RNG_NONE=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+# use included Linux headers=0D
+if test "$linux" =3D "yes" ; then=0D
+  mkdir -p linux-headers=0D
+  case "$cpu" in=0D
+  i386|x86_64|x32)=0D
+    linux_arch=3Dx86=0D
+    ;;=0D
+  ppc|ppc64|ppc64le)=0D
+    linux_arch=3Dpowerpc=0D
+    ;;=0D
+  s390x)=0D
+    linux_arch=3Ds390=0D
+    ;;=0D
+  aarch64)=0D
+    linux_arch=3Darm64=0D
+    ;;=0D
+  mips64)=0D
+    linux_arch=3Dmips=0D
+    ;;=0D
+  *)=0D
+    # For most CPUs the kernel architecture name and QEMU CPU name match.=
=0D
+    linux_arch=3D"$cpu"=0D
+    ;;=0D
+  esac=0D
+    # For non-KVM architectures we will not have asm headers=0D
+    if [ -e "$source_path/linux-headers/asm-$linux_arch" ]; then=0D
+      symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/a=
sm=0D
+    fi=0D
+fi=0D
+=0D
+for target in $target_list; do=0D
+target_dir=3D"$target"=0D
+config_target_mak=3D$target_dir/config-target.mak=0D
+target_name=3D$(echo $target | cut -d '-' -f 1)=0D
+target_aligned_only=3D"no"=0D
+case "$target_name" in=0D
+  alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc=
|sparc64|sparc32plus|xtensa|xtensaeb)=0D
+  target_aligned_only=3D"yes"=0D
+  ;;=0D
+esac=0D
+target_bigendian=3D"no"=0D
+case "$target_name" in=0D
+  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1=
k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)=0D
+  target_bigendian=3D"yes"=0D
+  ;;=0D
+esac=0D
+target_softmmu=3D"no"=0D
+target_user_only=3D"no"=0D
+target_linux_user=3D"no"=0D
+target_bsd_user=3D"no"=0D
+case "$target" in=0D
+  ${target_name}-softmmu)=0D
+    target_softmmu=3D"yes"=0D
+    ;;=0D
+  ${target_name}-linux-user)=0D
+    target_user_only=3D"yes"=0D
+    target_linux_user=3D"yes"=0D
+    ;;=0D
+  ${target_name}-bsd-user)=0D
+    target_user_only=3D"yes"=0D
+    target_bsd_user=3D"yes"=0D
+    ;;=0D
+  *)=0D
+    error_exit "Target '$target' not recognised"=0D
+    exit 1=0D
+    ;;=0D
+esac=0D
+=0D
+mkdir -p $target_dir=0D
+echo "# Automatically generated by configure - do not modify" > $config_ta=
rget_mak=0D
+=0D
+bflt=3D"no"=0D
+mttcg=3D"no"=0D
+interp_prefix1=3D$(echo "$interp_prefix" | sed "s/%M/$target_name/g")=0D
+gdb_xml_files=3D""=0D
+=0D
+TARGET_ARCH=3D"$target_name"=0D
+TARGET_BASE_ARCH=3D""=0D
+TARGET_ABI_DIR=3D""=0D
+TARGET_SYSTBL_ABI=3D""=0D
+TARGET_SYSTBL=3D""=0D
+=0D
+case "$target_name" in=0D
+  i386)=0D
+    mttcg=3D"yes"=0D
+	gdb_xml_files=3D"i386-32bit.xml"=0D
+    TARGET_SYSTBL_ABI=3Di386=0D
+    TARGET_SYSTBL=3Dsyscall_32.tbl=0D
+  ;;=0D
+  x86_64)=0D
+    TARGET_BASE_ARCH=3Di386=0D
+    TARGET_SYSTBL_ABI=3Dcommon,64=0D
+    TARGET_SYSTBL=3Dsyscall_64.tbl=0D
+    mttcg=3D"yes"=0D
+    gdb_xml_files=3D"i386-64bit.xml"=0D
+  ;;=0D
+  alpha)=0D
+    mttcg=3D"yes"=0D
+    TARGET_SYSTBL_ABI=3Dcommon=0D
+  ;;=0D
+  arm|armeb)=0D
+    TARGET_ARCH=3Darm=0D
+    TARGET_SYSTBL_ABI=3Dcommon,oabi=0D
+    bflt=3D"yes"=0D
+    mttcg=3D"yes"=0D
+    gdb_xml_files=3D"arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml ar=
m-m-profile.xml"=0D
+  ;;=0D
+  aarch64|aarch64_be)=0D
+    TARGET_ARCH=3Daarch64=0D
+    TARGET_BASE_ARCH=3Darm=0D
+    bflt=3D"yes"=0D
+    mttcg=3D"yes"=0D
+    gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp=
.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"=0D
+  ;;=0D
+  avr)=0D
+    gdb_xml_files=3D"avr-cpu.xml"=0D
+    target_compiler=3D$cross_cc_avr=0D
+  ;;=0D
+  cris)=0D
+  ;;=0D
+  hppa)=0D
+    mttcg=3D"yes"=0D
+    TARGET_SYSTBL_ABI=3Dcommon,32=0D
+  ;;=0D
+  lm32)=0D
+  ;;=0D
+  m68k)=0D
+    bflt=3D"yes"=0D
+    gdb_xml_files=3D"cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"=0D
+    TARGET_SYSTBL_ABI=3Dcommon=0D
+  ;;=0D
+  microblaze|microblazeel)=0D
+    TARGET_ARCH=3Dmicroblaze=0D
+    TARGET_SYSTBL_ABI=3Dcommon=0D
+    mttcg=3D"yes"=0D
+    bflt=3D"yes"=0D
+    echo "TARGET_ABI32=3Dy" >> $config_target_mak=0D
+  ;;=0D
+  mips|mipsel)=0D
+    mttcg=3D"yes"=0D
+    TARGET_ARCH=3Dmips=0D
+    echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak=0D
+    TARGET_SYSTBL_ABI=3Do32=0D
+    TARGET_SYSTBL=3Dsyscall_o32.tbl=0D
+  ;;=0D
+  mipsn32|mipsn32el)=0D
+    mttcg=3D"yes"=0D
+    TARGET_ARCH=3Dmips64=0D
+    TARGET_BASE_ARCH=3Dmips=0D
+    echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak=0D
+    echo "TARGET_ABI32=3Dy" >> $config_target_mak=0D
+    TARGET_SYSTBL_ABI=3Dn32=0D
+    TARGET_SYSTBL=3Dsyscall_n32.tbl=0D
+  ;;=0D
+  mips64|mips64el)=0D
+    mttcg=3D"no"=0D
+    TARGET_ARCH=3Dmips64=0D
+    TARGET_BASE_ARCH=3Dmips=0D
+    echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak=0D
+    TARGET_SYSTBL_ABI=3Dn64=0D
+    TARGET_SYSTBL=3Dsyscall_n64.tbl=0D
+  ;;=0D
+  moxie)=0D
+  ;;=0D
+  nios2)=0D
+  ;;=0D
+  or1k)=0D
+    TARGET_ARCH=3Dopenrisc=0D
+    TARGET_BASE_ARCH=3Dopenrisc=0D
+  ;;=0D
+  ppc)=0D
+    gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml power-=
spe.xml"=0D
+    TARGET_SYSTBL_ABI=3Dcommon,nospu,32=0D
+  ;;=0D
+  ppc64)=0D
+    TARGET_BASE_ARCH=3Dppc=0D
+    TARGET_ABI_DIR=3Dppc=0D
+    TARGET_SYSTBL_ABI=3Dcommon,nospu,64=0D
+    mttcg=3Dyes=0D
+    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml power-vsx.xml"=0D
+  ;;=0D
+  ppc64le)=0D
+    TARGET_ARCH=3Dppc64=0D
+    TARGET_BASE_ARCH=3Dppc=0D
+    TARGET_ABI_DIR=3Dppc=0D
+    TARGET_SYSTBL_ABI=3Dcommon,nospu,64=0D
+    mttcg=3Dyes=0D
+    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml power-vsx.xml"=0D
+  ;;=0D
+  ppc64abi32)=0D
+    TARGET_ARCH=3Dppc64=0D
+    TARGET_BASE_ARCH=3Dppc=0D
+    TARGET_ABI_DIR=3Dppc=0D
+    TARGET_SYSTBL_ABI=3Dcommon,nospu,32=0D
+    echo "TARGET_ABI32=3Dy" >> $config_target_mak=0D
+    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml power-vsx.xml"=0D
+  ;;=0D
+  riscv32)=0D
+    TARGET_BASE_ARCH=3Driscv=0D
+    TARGET_ABI_DIR=3Driscv=0D
+    mttcg=3Dyes=0D
+    gdb_xml_files=3D"riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-f=
pu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"=0D
+  ;;=0D
+  riscv64)=0D
+    TARGET_BASE_ARCH=3Driscv=0D
+    TARGET_ABI_DIR=3Driscv=0D
+    mttcg=3Dyes=0D
+    gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-f=
pu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"=0D
+  ;;=0D
+  rx)=0D
+    TARGET_ARCH=3Drx=0D
+    bflt=3D"yes"=0D
+    target_compiler=3D$cross_cc_rx=0D
+    gdb_xml_files=3D"rx-core.xml"=0D
+  ;;=0D
+  sh4|sh4eb)=0D
+    TARGET_ARCH=3Dsh4=0D
+    TARGET_SYSTBL_ABI=3Dcommon=0D
+    bflt=3D"yes"=0D
+  ;;=0D
+  sparc)=0D
+    TARGET_SYSTBL_ABI=3Dcommon,32=0D
+  ;;=0D
+  sparc64)=0D
+    TARGET_BASE_ARCH=3Dsparc=0D
+    TARGET_SYSTBL_ABI=3Dcommon,64=0D
+  ;;=0D
+  sparc32plus)=0D
+    TARGET_ARCH=3Dsparc64=0D
+    TARGET_BASE_ARCH=3Dsparc=0D
+    TARGET_ABI_DIR=3Dsparc=0D
+    TARGET_SYSTBL_ABI=3Dcommon,32=0D
+    echo "TARGET_ABI32=3Dy" >> $config_target_mak=0D
+  ;;=0D
+  s390x)=0D
+    TARGET_SYSTBL_ABI=3Dcommon,64=0D
+    mttcg=3Dyes=0D
+    gdb_xml_files=3D"s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xm=
l s390-cr.xml s390-virt.xml s390-gs.xml"=0D
+  ;;=0D
+  tilegx)=0D
+  ;;=0D
+  tricore)=0D
+  ;;=0D
+  unicore32)=0D
+  ;;=0D
+  xtensa|xtensaeb)=0D
+    TARGET_ARCH=3Dxtensa=0D
+    TARGET_SYSTBL_ABI=3Dcommon=0D
+    bflt=3D"yes"=0D
+    mttcg=3D"yes"=0D
+  ;;=0D
+  *)=0D
+    error_exit "Unsupported target CPU"=0D
+  ;;=0D
+esac=0D
+# TARGET_BASE_ARCH needs to be defined after TARGET_ARCH=0D
+if [ "$TARGET_BASE_ARCH" =3D "" ]; then=0D
+  TARGET_BASE_ARCH=3D$TARGET_ARCH=0D
+fi=0D
+if [ "$TARGET_SYSTBL_ABI" !=3D "" ] && [ "$TARGET_SYSTBL" =3D "" ]; then=0D
+  TARGET_SYSTBL=3Dsyscall.tbl=0D
+fi=0D
+=0D
+upper() {=0D
+    echo "$@"| LC_ALL=3DC tr '[a-z]' '[A-Z]'=0D
+}=0D
+=0D
+target_arch_name=3D"$(upper $TARGET_ARCH)"=0D
+echo "TARGET_$target_arch_name=3Dy" >> $config_target_mak=0D
+echo "TARGET_NAME=3D$target_name" >> $config_target_mak=0D
+echo "TARGET_BASE_ARCH=3D$TARGET_BASE_ARCH" >> $config_target_mak=0D
+if [ "$TARGET_ABI_DIR" =3D "" ]; then=0D
+  TARGET_ABI_DIR=3D$TARGET_ARCH=0D
+fi=0D
+echo "TARGET_ABI_DIR=3D$TARGET_ABI_DIR" >> $config_target_mak=0D
+if [ "$HOST_VARIANT_DIR" !=3D "" ]; then=0D
+    echo "HOST_VARIANT_DIR=3D$HOST_VARIANT_DIR" >> $config_target_mak=0D
+fi=0D
+if [ "$TARGET_SYSTBL_ABI" !=3D "" ]; then=0D
+    echo "TARGET_SYSTBL_ABI=3D$TARGET_SYSTBL_ABI" >> $config_target_mak=0D
+    echo "TARGET_SYSTBL=3D$TARGET_SYSTBL" >> $config_target_mak=0D
+fi=0D
+=0D
+if supported_xen_target $target; then=0D
+    echo "CONFIG_XEN=3Dy" >> $config_target_mak=0D
+    if test "$xen_pci_passthrough" =3D yes; then=0D
+        echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_mak"=0D
+    fi=0D
+fi=0D
+if supported_kvm_target $target; then=0D
+    echo "CONFIG_KVM=3Dy" >> $config_target_mak=0D
+fi=0D
+if supported_hax_target $target; then=0D
+    echo "CONFIG_HAX=3Dy" >> $config_target_mak=0D
+fi=0D
+if supported_hvf_target $target; then=0D
+    echo "CONFIG_HVF=3Dy" >> $config_target_mak=0D
+fi=0D
+if supported_whpx_target $target; then=0D
+    echo "CONFIG_WHPX=3Dy" >> $config_target_mak=0D
+fi=0D
+if test "$target_aligned_only" =3D "yes" ; then=0D
+  echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak=0D
+fi=0D
+if test "$target_bigendian" =3D "yes" ; then=0D
+  echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak=0D
+fi=0D
+if test "$target_softmmu" =3D "yes" ; then=0D
+  echo "CONFIG_SOFTMMU=3Dy" >> $config_target_mak=0D
+  if test "$mttcg" =3D "yes" ; then=0D
+    echo "TARGET_SUPPORTS_MTTCG=3Dy" >> $config_target_mak=0D
+  fi=0D
+fi=0D
+if test "$target_user_only" =3D "yes" ; then=0D
+  echo "CONFIG_USER_ONLY=3Dy" >> $config_target_mak=0D
+  echo "CONFIG_QEMU_INTERP_PREFIX=3D\"$interp_prefix1\"" >> $config_target=
_mak=0D
+  symlink "../qemu-$target_name" "$target_dir/qemu-$target_name"=0D
+else=0D
+  symlink "../qemu-system-$target_name" "$target_dir/qemu-system-$target_n=
ame"=0D
+fi=0D
+if test "$target_linux_user" =3D "yes" ; then=0D
+  echo "CONFIG_LINUX_USER=3Dy" >> $config_target_mak=0D
+fi=0D
+list=3D""=0D
+if test ! -z "$gdb_xml_files" ; then=0D
+  for x in $gdb_xml_files; do=0D
+    list=3D"$list gdb-xml/$x"=0D
+  done=0D
+  echo "TARGET_XML_FILES=3D$list" >> $config_target_mak=0D
+fi=0D
+=0D
+if test "$target_user_only" =3D "yes" && test "$bflt" =3D "yes"; then=0D
+  echo "TARGET_HAS_BFLT=3Dy" >> $config_target_mak=0D
+fi=0D
+if test "$target_bsd_user" =3D "yes" ; then=0D
+  echo "CONFIG_BSD_USER=3Dy" >> $config_target_mak=0D
+fi=0D
+=0D
+=0D
+# generate QEMU_CFLAGS/QEMU_LDFLAGS for targets=0D
+=0D
+disas_config() {=0D
+  echo "CONFIG_${1}_DIS=3Dy" >> $config_target_mak=0D
+  echo "CONFIG_${1}_DIS=3Dy" >> config-all-disas.mak=0D
+}=0D
+=0D
+for i in $ARCH $TARGET_BASE_ARCH ; do=0D
+  case "$i" in=0D
+  alpha)=0D
+    disas_config "ALPHA"=0D
+  ;;=0D
+  aarch64)=0D
+    if test -n "${cxx}"; then=0D
+      disas_config "ARM_A64"=0D
+    fi=0D
+  ;;=0D
+  arm)=0D
+    disas_config "ARM"=0D
+    if test -n "${cxx}"; then=0D
+      disas_config "ARM_A64"=0D
+    fi=0D
+  ;;=0D
+  avr)=0D
+    disas_config "AVR"=0D
+  ;;=0D
+  cris)=0D
+    disas_config "CRIS"=0D
+  ;;=0D
+  hppa)=0D
+    disas_config "HPPA"=0D
+  ;;=0D
+  i386|x86_64|x32)=0D
+    disas_config "I386"=0D
+  ;;=0D
+  lm32)=0D
+    disas_config "LM32"=0D
+  ;;=0D
+  m68k)=0D
+    disas_config "M68K"=0D
+  ;;=0D
+  microblaze*)=0D
+    disas_config "MICROBLAZE"=0D
+  ;;=0D
+  mips*)=0D
+    disas_config "MIPS"=0D
+    if test -n "${cxx}"; then=0D
+      disas_config "NANOMIPS"=0D
+    fi=0D
+  ;;=0D
+  moxie*)=0D
+    disas_config "MOXIE"=0D
+  ;;=0D
+  nios2)=0D
+    disas_config "NIOS2"=0D
+  ;;=0D
+  or1k)=0D
+    disas_config "OPENRISC"=0D
+  ;;=0D
+  ppc*)=0D
+    disas_config "PPC"=0D
+  ;;=0D
+  riscv*)=0D
+    disas_config "RISCV"=0D
+  ;;=0D
+  rx)=0D
+    disas_config "RX"=0D
+  ;;=0D
+  s390*)=0D
+    disas_config "S390"=0D
+  ;;=0D
+  sh4)=0D
+    disas_config "SH4"=0D
+  ;;=0D
+  sparc*)=0D
+    disas_config "SPARC"=0D
+  ;;=0D
+  xtensa*)=0D
+    disas_config "XTENSA"=0D
+  ;;=0D
+  esac=0D
+done=0D
+if test "$tcg_interpreter" =3D "yes" ; then=0D
+  disas_config "TCI"=0D
+fi=0D
+=0D
+done # for target in $targets=0D
+=0D
+if [ "$fdt" =3D "git" ]; then=0D
+  subdirs=3D"$subdirs dtc"=0D
+fi=0D
+if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then=0D
+  subdirs=3D"$subdirs capstone"=0D
+fi=0D
+echo "SUBDIRS=3D$subdirs" >> $config_host_mak=0D
+if test -n "$LIBCAPSTONE"; then=0D
+  echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$numa" =3D "yes"; then=0D
+  echo "CONFIG_NUMA=3Dy" >> $config_host_mak=0D
+  echo "NUMA_LIBS=3D$numa_libs" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$ccache_cpp2" =3D "yes"; then=0D
+  echo "export CCACHE_CPP2=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+if test "$safe_stack" =3D "yes"; then=0D
+  echo "CONFIG_SAFESTACK=3Dy" >> $config_host_mak=0D
+fi=0D
+=0D
+# If we're using a separate build tree, set it up now.=0D
+# DIRS are directories which we simply mkdir in the build tree;=0D
+# LINKS are things to symlink back into the source tree=0D
+# (these can be both files and directories).=0D
+# Caution: do not add files or directories here using wildcards. This=0D
+# will result in problems later if a new file matching the wildcard is=0D
+# added to the source tree -- nothing will cause configure to be rerun=0D
+# so the build tree will be missing the link back to the new file, and=0D
+# tests might fail. Prefer to keep the relevant files in their own=0D
+# directory and symlink the directory instead.=0D
+DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/qapi-schema tests/qtest/libqo=
s"=0D
+DIRS=3D"$DIRS tests/qtest tests/qemu-iotests tests/vm tests/fp tests/qgrap=
h"=0D
+DIRS=3D"$DIRS docs docs/interop fsdev scsi"=0D
+DIRS=3D"$DIRS pc-bios/optionrom pc-bios/s390-ccw"=0D
+DIRS=3D"$DIRS roms/seabios"=0D
+LINKS=3D"Makefile"=0D
+LINKS=3D"$LINKS tests/tcg/lm32/Makefile"=0D
+LINKS=3D"$LINKS tests/tcg/Makefile.target"=0D
+LINKS=3D"$LINKS pc-bios/optionrom/Makefile"=0D
+LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"=0D
+LINKS=3D"$LINKS roms/seabios/Makefile"=0D
+LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"=0D
+LINKS=3D"$LINKS .gdbinit scripts" # scripts needed by relative path in .gd=
binit=0D
+LINKS=3D"$LINKS tests/acceptance tests/data"=0D
+LINKS=3D"$LINKS tests/qemu-iotests/check"=0D
+LINKS=3D"$LINKS python"=0D
+for bios_file in \=0D
+    $source_path/pc-bios/*.bin \=0D
+    $source_path/pc-bios/*.elf \=0D
+    $source_path/pc-bios/*.lid \=0D
+    $source_path/pc-bios/*.rom \=0D
+    $source_path/pc-bios/*.dtb \=0D
+    $source_path/pc-bios/*.img \=0D
+    $source_path/pc-bios/openbios-* \=0D
+    $source_path/pc-bios/u-boot.* \=0D
+    $source_path/pc-bios/edk2-*.fd.bz2 \=0D
+    $source_path/pc-bios/palcode-*=0D
+do=0D
+    LINKS=3D"$LINKS pc-bios/$(basename $bios_file)"=0D
+done=0D
+mkdir -p $DIRS=0D
+for f in $LINKS ; do=0D
+    if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" !=3D "y" ]; the=
n=0D
+        symlink "$source_path/$f" "$f"=0D
+    fi=0D
+done=0D
+=0D
+(for i in $cross_cc_vars; do=0D
+  export $i=0D
+done=0D
+export target_list source_path use_containers=0D
+$source_path/tests/tcg/configure.sh)=0D
+=0D
+# temporary config to build submodules=0D
+for rom in seabios; do=0D
+    config_mak=3Droms/$rom/config.mak=0D
+    echo "# Automatically generated by configure - do not modify" > $confi=
g_mak=0D
+    echo "SRC_PATH=3D$source_path/roms/$rom" >> $config_mak=0D
+    echo "AS=3D$as" >> $config_mak=0D
+    echo "CCAS=3D$ccas" >> $config_mak=0D
+    echo "CC=3D$cc" >> $config_mak=0D
+    echo "BCC=3Dbcc" >> $config_mak=0D
+    echo "CPP=3D$cpp" >> $config_mak=0D
+    echo "OBJCOPY=3Dobjcopy" >> $config_mak=0D
+    echo "IASL=3D$iasl" >> $config_mak=0D
+    echo "LD=3D$ld" >> $config_mak=0D
+    echo "RANLIB=3D$ranlib" >> $config_mak=0D
+done=0D
+=0D
+# set up qemu-iotests in this build directory=0D
+iotests_common_env=3D"tests/qemu-iotests/common.env"=0D
+=0D
+echo "# Automatically generated by configure - do not modify" > "$iotests_=
common_env"=0D
+echo >> "$iotests_common_env"=0D
+echo "export PYTHON=3D'$python'" >> "$iotests_common_env"=0D
+=0D
+if test "$skip_meson" =3D no; then=0D
+cross=3D"config-meson.cross.new"=0D
+meson_quote() {=0D
+    echo "['$(echo $* | sed "s/ /','/g")']"=0D
+}=0D
+=0D
+echo "# Automatically generated by configure - do not modify" > $cross=0D
+echo "[properties]" >> $cross=0D
+test -z "$cxx" && echo "link_language =3D 'c'" >> $cross=0D
+echo "[binaries]" >> $cross=0D
+echo "c =3D $(meson_quote $cc)" >> $cross=0D
+test -n "$cxx" && echo "cpp =3D $(meson_quote $cxx)" >> $cross=0D
+echo "ar =3D $(meson_quote $ar)" >> $cross=0D
+echo "nm =3D $(meson_quote $nm)" >> $cross=0D
+echo "pkgconfig =3D $(meson_quote $pkg_config_exe)" >> $cross=0D
+echo "ranlib =3D $(meson_quote $ranlib)" >> $cross=0D
+echo "strip =3D $(meson_quote $strip)" >> $cross=0D
+echo "windres =3D $(meson_quote $windres)" >> $cross=0D
+if test -n "$cross_prefix"; then=0D
+    cross_arg=3D"--cross-file config-meson.cross"=0D
+    # Hack: Meson expects an absolute path for the *build* machine=0D
+    # for the prefix, so add a slash in front of a Windows path that=0D
+    # includes a drive letter.=0D
+    #=0D
+    # See https://github.com/mesonbuild/meson/issues/7577.=0D
+    echo "[host_machine]" >> $cross=0D
+    if test "$mingw32" =3D "yes" ; then=0D
+        echo "system =3D 'windows'" >> $cross=0D
+        case $prefix in=0D
+            ?:*) pre_prefix=3D/ ;;=0D
+        esac=0D
+    fi=0D
+    case "$ARCH" in=0D
+        i386|x86_64)=0D
+            echo "cpu_family =3D 'x86'" >> $cross=0D
+            ;;=0D
+        ppc64le)=0D
+            echo "cpu_family =3D 'ppc64'" >> $cross=0D
+            ;;=0D
+        *)=0D
+            echo "cpu_family =3D '$ARCH'" >> $cross=0D
+            ;;=0D
+    esac=0D
+    echo "cpu =3D '$cpu'" >> $cross=0D
+    if test "$bigendian" =3D "yes" ; then=0D
+        echo "endian =3D 'big'" >> $cross=0D
+    else=0D
+        echo "endian =3D 'little'" >> $cross=0D
+    fi=0D
+else=0D
+    cross_arg=3D"--native-file config-meson.cross"=0D
+fi=0D
+mv $cross config-meson.cross=0D
+=0D
+rm -rf meson-private meson-info meson-logs=0D
+NINJA=3D${ninja:-${build_path}/ninjatool} $meson setup \=0D
+        --prefix "${pre_prefix}$prefix" \=0D
+        --libdir "${pre_prefix}$libdir" \=0D
+        --libexecdir "${pre_prefix}$libexecdir" \=0D
+        --bindir "${pre_prefix}$bindir" \=0D
+        --includedir "${pre_prefix}$includedir" \=0D
+        --datadir "${pre_prefix}$datadir" \=0D
+        --mandir "${pre_prefix}$mandir" \=0D
+        --sysconfdir "${pre_prefix}$sysconfdir" \=0D
+        --localstatedir "${pre_prefix}$local_statedir" \=0D
+        -Ddocdir=3D"${pre_prefix}$docdir" \=0D
+        -Dqemu_suffix=3D"$qemu_suffix" \=0D
+        -Doptimization=3D$(if test "$debug" =3D yes; then echo 0; else ech=
o 2; fi) \=0D
+        -Ddebug=3D$(if test "$debug_info" =3D yes; then echo true; else ec=
ho false; fi) \=0D
+        -Dwerror=3D$(if test "$werror" =3D yes; then echo true; else echo =
false; fi) \=0D
+        -Dstrip=3D$(if test "$strip_opt" =3D yes; then echo true; else ech=
o false; fi) \=0D
+        -Db_pie=3D$(if test "$pie" =3D yes; then echo true; else echo fals=
e; fi) \=0D
+        -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; else ech=
o false; fi) \=0D
+	-Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \=0D
+	-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D$v=
nc_png \=0D
+	-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\=0D
+        $cross_arg \=0D
+        "$build_path" "$source_path"=0D
+=0D
+if test "$?" -ne 0 ; then=0D
+    error_exit "meson setup failed"=0D
+fi=0D
+touch ninjatool.stamp=0D
+fi=0D
+=0D
+# Save the configure command line for later reuse.=0D
+cat <<EOD >config.status=0D
+#!/bin/sh=0D
+# Generated by configure.=0D
+# Run this file to recreate the current configuration.=0D
+# Compiler output produced by configure, useful for debugging=0D
+# configure, is in config.log if it exists.=0D
+EOD=0D
+=0D
+preserve_env() {=0D
+    envname=3D$1=0D
+=0D
+    eval envval=3D\$$envname=0D
+=0D
+    if test -n "$envval"=0D
+    then=0D
+	echo "$envname=3D'$envval'" >> config.status=0D
+	echo "export $envname" >> config.status=0D
+    else=0D
+	echo "unset $envname" >> config.status=0D
+    fi=0D
+}=0D
+=0D
+# Preserve various env variables that influence what=0D
+# features/build target configure will detect=0D
+preserve_env AR=0D
+preserve_env AS=0D
+preserve_env CC=0D
+preserve_env CPP=0D
+preserve_env CXX=0D
+preserve_env INSTALL=0D
+preserve_env LD=0D
+preserve_env LD_LIBRARY_PATH=0D
+preserve_env LIBTOOL=0D
+preserve_env MAKE=0D
+preserve_env NM=0D
+preserve_env OBJCOPY=0D
+preserve_env PATH=0D
+preserve_env PKG_CONFIG=0D
+preserve_env PKG_CONFIG_LIBDIR=0D
+preserve_env PKG_CONFIG_PATH=0D
+preserve_env PYTHON=0D
+preserve_env SDL2_CONFIG=0D
+preserve_env SMBD=0D
+preserve_env STRIP=0D
+preserve_env WINDRES=0D
+=0D
+printf "exec" >>config.status=0D
+for i in "$0" "$@"; do=0D
+  test "$i" =3D --skip-meson || printf " '%s'" "$i" >>config.status=0D
+done=0D
+echo ' "$@"' >>config.status=0D
+chmod +x config.status=0D
+=0D
+rm -r "$TMPDIR1"=0D
--=20
2.28.0.windows.1


