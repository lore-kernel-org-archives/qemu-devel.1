Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C97C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A51C20878
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A51C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTWb0-0000rO-A7
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 16:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddstreet@canonical.com>)
 id 1kTWXz-0008Pd-3b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 16:41:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43251)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <ddstreet@canonical.com>)
 id 1kTWW5-0001BV-AZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 16:41:54 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <ddstreet@canonical.com>) id 1kTWVo-00011s-LJ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 20:39:40 +0000
Received: by mail-qv1-f71.google.com with SMTP id c6so2259006qvo.8
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 13:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cvYMUlfxtiZQTXTAEJe3NO/fl4eYL1sWQtijJC8homo=;
 b=lB/9vq9kBnC/xV0LVAapcQ/UG8XbuFvUfjvXqGudx9kYNMqKeXQlhrmwKEpOgL6sZV
 xXsvaBnWh2blmzyFFBPMZGhu8tDQ2WsIPb49d35J7SDNQxlOHm3XoO/EIQR+z8hPdfBp
 E0OMTL54tvHXQ1MR5qdvNo+iejxNjTTPyjA56DFYAreGHgNSU0hBtGWz/Y/timE+6gXh
 NZ7ErCnDF1eYVUJKs0oG3/+yyRcmCmTQnfB5IsGxPt2sV6ZkHyb9/kkAes7+0gfoSy3o
 h3CvvfkjXJ8ZZvqqgZhcbfL+VGDeoFu2B1l97BF4gnyhbfcH0d7eAla2aHINHBq72aNU
 ofjQ==
X-Gm-Message-State: AOAM530llfzmvfxo8GWP+RYFPUiegiRAUvmDIDZaPHXEMmpm4+HQx3oU
 kW50cXa3NunCYNCtL5qQ6Soc+Pg6rNHrdfBvHv5HsSeDsUIG5zshg1JYDBokm7o5Xs+hb8BIChQ
 odQQAVY26Mhad7Y2V/r3L46vyxFJMkNMR
X-Received: by 2002:a05:6214:16d0:: with SMTP id
 d16mr6091115qvz.38.1602880779017; 
 Fri, 16 Oct 2020 13:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrdakcIZtUWk0N3UgoZuyEcbIZBZ7SkMh36G+dbvolPSfRZYVE85hag3LY5LYEusk/dwTm5Q==
X-Received: by 2002:a05:6214:16d0:: with SMTP id
 d16mr6091082qvz.38.1602880778587; 
 Fri, 16 Oct 2020 13:39:38 -0700 (PDT)
Received: from thorin.shire (45-27-90-188.lightspeed.rlghnc.sbcglobal.net.
 [45.27.90.188])
 by smtp.gmail.com with ESMTPSA id q5sm1445485qtn.60.2020.10.16.13.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 13:39:37 -0700 (PDT)
From: Dan Streetman <ddstreet@canonical.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: replace --enable/disable-git-update with
 --with-git-submodules
Date: Fri, 16 Oct 2020 16:38:57 -0400
Message-Id: <20201016203857.62572-1-ddstreet@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=ddstreet@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 16:39:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Dan Streetman <ddstreet@canonical.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the --enable-git-update and --disable-git-update configure params
with the param --with-git-submodules=(update|validate|ignore) to
allow 3 options for building from a git repo.

This is needed because downstream packagers, e.g. Debian, Ubuntu, etc,
also keep the source code in git, but do not want to enable the
'git_update' mode; with the current code, that's not possible even
if the downstream package specifies --disable-git-update.

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
---
 Makefile                 | 26 ++-----------------
 configure                | 55 +++++++++++++++++++++++++---------------
 scripts/git-submodule.sh | 34 +++++++++++++++++++------
 3 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/Makefile b/Makefile
index c37e513431..033455dc8f 100644
--- a/Makefile
+++ b/Makefile
@@ -34,33 +34,11 @@ ifneq ($(wildcard config-host.mak),)
 all:
 include config-host.mak
 
-git-submodule-update:
-
 .PHONY: git-submodule-update
-
-git_module_status := $(shell \
-  cd '$(SRC_PATH)' && \
-  GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
-  echo $$?; \
-)
-
-ifeq (1,$(git_module_status))
-ifeq (no,$(GIT_UPDATE))
 git-submodule-update:
 	$(call quiet-command, \
-            echo && \
-            echo "GIT submodule checkout is out of date. Please run" && \
-            echo "  scripts/git-submodule.sh update $(GIT_SUBMODULES)" && \
-            echo "from the source directory checkout $(SRC_PATH)" && \
-            echo && \
-            exit 1)
-else
-git-submodule-update:
-	$(call quiet-command, \
-          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
-          "GIT","$(GIT_SUBMODULES)")
-endif
-endif
+		(GIT="$(GIT)" "$(SRC_PATH)/scripts/git-submodule.sh" $(GIT_SUBMODULES_ACTION) $(GIT_SUBMODULES)), \
+		"GIT","$(GIT_SUBMODULES)")
 
 export NINJA=./ninjatool
 
diff --git a/configure b/configure
index f839c2a557..c5df778790 100755
--- a/configure
+++ b/configure
@@ -249,12 +249,12 @@ gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 
 if test -e "$source_path/.git"
 then
-    git_update=yes
+    git_submodules_action="update"
     git_submodules="ui/keycodemapdb"
     git_submodules="$git_submodules tests/fp/berkeley-testfloat-3"
     git_submodules="$git_submodules tests/fp/berkeley-softfloat-3"
 else
-    git_update=no
+    git_submodules_action="ignore"
     git_submodules=""
 
     if ! test -f "$source_path/ui/keycodemapdb/README"
@@ -1478,9 +1478,16 @@ for opt do
   ;;
   --with-git=*) git="$optarg"
   ;;
-  --enable-git-update) git_update=yes
+  --enable-git-update)
+      git_submodules_action="update"
+      echo "--enable-git-update deprecated, use --with-git-submodules=update"
   ;;
-  --disable-git-update) git_update=no
+  --disable-git-update)
+      git_submodules_action="validate"
+      echo "--disable-git-update deprecated, use --with-git-submodules=validate"
+  ;;
+  --with-git-submodules=*)
+      git_submodules_action="$optarg"
   ;;
   --enable-debug-mutex) debug_mutex=yes
   ;;
@@ -1528,6 +1535,20 @@ for opt do
   esac
 done
 
+case $git_submodules_action in
+    update|validate)
+        if test ! -e "$source_path/.git"; then
+            echo "ERROR: cannot $git_submodules_action git submodules without .git"
+            exit 1
+        fi
+    ;;
+    ignore) ;;
+    *)
+        echo "ERROR: invalid --with-git-submodules= value '$git_submodules_action'"
+        exit 1
+    ;;
+esac
+
 firmwarepath="${firmwarepath:-$prefix/share/qemu-firmware}"
 libdir="${libdir:-$prefix/lib}"
 libexecdir="${libexecdir:-$prefix/libexec}"
@@ -1868,7 +1889,7 @@ python="$python -B"
 if test -z "$meson"; then
     if test "$explicit_python" = no && has meson && version_ge "$(meson --version)" 0.55.1; then
         meson=meson
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+    elif test $git_submodules_action != 'ignore' ; then
         meson=git
     elif test -e "${source_path}/meson/meson.py" ; then
         meson=internal
@@ -1936,7 +1957,7 @@ fi
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-    if test -e "$source_path/.git" && \
+    if test "$git_submodules_action" != "ignore" && \
         { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
         werror="yes"
     else
@@ -3824,9 +3845,7 @@ fi
 case "$fdt" in
   auto | enabled | internal)
     # Simpler to always update submodule, even if not needed.
-    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
-      git_submodules="${git_submodules} dtc"
-    fi
+    git_submodules="${git_submodules} dtc"
     ;;
 esac
 
@@ -4696,9 +4715,7 @@ fi
 case "$capstone" in
   auto | enabled | internal)
     # Simpler to always update submodule, even if not needed.
-    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
-      git_submodules="${git_submodules} capstone"
-    fi
+    git_submodules="${git_submodules} capstone"
     ;;
 esac
 
@@ -5636,9 +5653,7 @@ fi
 case "$slirp" in
   auto | enabled | internal)
     # Simpler to always update submodule, even if not needed.
-    if test -e "${source_path}/.git" && test $git_update = 'yes' ; then
-      git_submodules="${git_submodules} slirp"
-    fi
+    git_submodules="${git_submodules} slirp"
     ;;
 esac
 
@@ -5893,9 +5908,7 @@ if test "$cpu" = "s390x" ; then
     roms="$roms s390-ccw"
     # SLOF is required for building the s390-ccw firmware on s390x,
     # since it is using the libnet code from SLOF for network booting.
-    if test -e "${source_path}/.git" ; then
-      git_submodules="${git_submodules} roms/SLOF"
-    fi
+    git_submodules="${git_submodules} roms/SLOF"
   fi
 fi
 
@@ -5931,8 +5944,8 @@ else
     cxx=
 fi
 
-if test $git_update = 'yes' ; then
-    (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update "$git_submodules")
+if !(GIT="$git" "$source_path/scripts/git-submodule.sh" "$git_submodules_action" "$git_submodules"); then
+    exit 1
 fi
 
 config_host_mak="config-host.mak"
@@ -5960,7 +5973,7 @@ echo "qemu_icondir=$qemu_icondir" >> $config_host_mak
 echo "qemu_desktopdir=$qemu_desktopdir" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
 echo "GIT_SUBMODULES=$git_submodules" >> $config_host_mak
-echo "GIT_UPDATE=$git_update" >> $config_host_mak
+echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 65ed877aef..e225d3a963 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -9,9 +9,14 @@ command=$1
 shift
 maybe_modules="$@"
 
+# if --with-git-submodules=ignore, do nothing
+test "$command" = "ignore" && exit 0
+
 test -z "$GIT" && GIT=git
 
-error() {
+cd "$(dirname "$0")/.."
+
+update_error() {
     echo "$0: $*"
     echo
     echo "Unable to automatically checkout GIT submodules '$modules'."
@@ -24,7 +29,7 @@ error() {
     echo "Alternatively you may disable automatic GIT submodule checkout"
     echo "with:"
     echo
-    echo " $ ./configure --disable-git-update"
+    echo " $ ./configure --with-git-submodules=validate"
     echo
     echo "and then manually update submodules prior to running make, with:"
     echo
@@ -33,6 +38,19 @@ error() {
     exit 1
 }
 
+validate_error() {
+    if test "$1" = "validate"; then
+        echo "GIT submodules checkout is out of date, and submodules"
+        echo "configured for validate only. Please run"
+        echo "  scripts/git-submodule.sh update $maybe_modules"
+        echo "from the source directory or call configure with"
+        echo "  --with-git-submodules=update"
+        echo "To disable GIT submodules validation, use"
+        echo "  --with-git-submodules=ignore"
+    fi
+    exit 1
+}
+
 modules=""
 for m in $maybe_modules
 do
@@ -52,18 +70,18 @@ then
 fi
 
 case "$command" in
-status)
+status|validate)
     if test -z "$maybe_modules"
     then
-         test -s ${substat} && exit 1 || exit 0
+         test -s ${substat} && validate_error "$command" || exit 0
     fi
 
-    test -f "$substat" || exit 1
+    test -f "$substat" || validate_error "$command"
     for module in $modules; do
         CURSTATUS=$($GIT submodule status $module)
         OLDSTATUS=$(cat $substat | grep $module)
         if test "$CURSTATUS" != "$OLDSTATUS"; then
-            exit 1
+            validate_error "$command"
         fi
     done
     exit 0
@@ -76,10 +94,10 @@ update)
     fi
 
     $GIT submodule update --init $modules 1>/dev/null
-    test $? -ne 0 && error "failed to update modules"
+    test $? -ne 0 && update_error "failed to update modules"
 
     $GIT submodule status $modules > "${substat}"
-    test $? -ne 0 && error "failed to save git submodule status" >&2
+    test $? -ne 0 && update_error "failed to save git submodule status" >&2
     ;;
 esac
 
-- 
2.25.1


