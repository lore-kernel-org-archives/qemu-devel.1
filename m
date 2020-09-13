Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF638C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DCE2158C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DCE2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHXEg-0004SU-7C
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddstreet@canonical.com>)
 id 1kHXCn-0001S6-LJ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 14:58:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <ddstreet@canonical.com>)
 id 1kHXCl-0004f5-DB
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 14:58:29 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <ddstreet@canonical.com>) id 1kHXCi-0003IH-Mj
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 18:58:24 +0000
Received: by mail-qt1-f199.google.com with SMTP id 7so10395007qtp.18
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 11:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WhWjLVJoveAo+HAvTRl7IUPrEpnDXFj7bLJc41F5zJY=;
 b=mdP2V/EERIll/3SdnvW5cUkGUhrZ/UxbulwEhfO1I/piF6AIU8pBbw5kKz2UTJ0CBA
 WdtjBteMhRxLtjNYDvxhIVp/eK3R2VKeV8L+s2kkKVREOFkSMO0Uok1GqAV8CxL40FWx
 JGwCua0Qcn6AfPXyH0DdOeue5GQzpfF3xHAVJW9Lmu2jfIPLL5TZPzm2/5BYVCHx0mgz
 6nVTRn4W0dN+7Kzv6R/qZkwOeQ4/yohSciovWZ7BMA8IdgE3ssXmJ0I9o02n5STeAXnB
 0J0WyBlkILKQM55WGbHuWbP37uQsI6nHsib8wPKDY/dj0CHL3TJQNDXefDxqC11VykON
 NF9A==
X-Gm-Message-State: AOAM531ttABnFNqfdBd/TRxUVqCQC8dDaOSt3nwzardntv41yxfxkrWX
 k7afZsR8R9lbqmTOD/OxfwIA+Z+gfITD3jjYUAqSqAkPUPUtH0ed9d9OolPM4dbd6sijwmYJtH1
 McIvcOgJHrIprJn1VbQdOFV1H4xqFaRLv
X-Received: by 2002:a37:be02:: with SMTP id o2mr10283753qkf.482.1600023503457; 
 Sun, 13 Sep 2020 11:58:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPl7WlVFNEvxbYSroCfPNiDbcQithYqWWNsR8GnYpkwo3Byv+YGxuwCIM1YI4CyzDskIU9LQ==
X-Received: by 2002:a37:be02:: with SMTP id o2mr10283742qkf.482.1600023503134; 
 Sun, 13 Sep 2020 11:58:23 -0700 (PDT)
Received: from thorin.shire (45-27-90-188.lightspeed.rlghnc.sbcglobal.net.
 [45.27.90.188])
 by smtp.gmail.com with ESMTPSA id c13sm11315724qtq.5.2020.09.13.11.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 11:58:22 -0700 (PDT)
From: Dan Streetman <ddstreet@canonical.com>
To: qemu-devel@nongnu.org
Subject: [PATCH resend] configure: actually disable 'git_update' mode with
 --disable-git-update
Date: Sun, 13 Sep 2020 14:57:08 -0400
Message-Id: <20200913185708.1681279-1-ddstreet@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729195829.1335082-1-ddstreet@canonical.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=ddstreet@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 14:58:25
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Dan Streetman <ddstreet@canonical.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The --disable-git-update configure param sets git_update=no, but
some later checks only look for the .git dir. This changes the
--enable-git-update to set git_update=yes but also fail if it
does not find a .git dir. Then all the later checks for the .git
dir can just be changed to a check for $git_update = "yes".

Also update the Makefile to skip the 'git_update' checks if it has
been disabled.

This is needed because downstream packagers, e.g. Debian, Ubuntu, etc,
also keep the source code in git, but do not want to enable the
'git_update' mode; with the current code, that's not possible even
if the downstream package specifies --disable-git-update.

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
---
Resend; this was sent twice before:
https://lists.nongnu.org/archive/html/qemu-trivial/2020-07/msg00180.html
https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg08243.html

Makefile  | 15 +++++++++------
 configure | 23 ++++++++++++++---------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 2ed19310cf7..712aaf8b53b 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,8 @@ git-submodule-update:
 
 .PHONY: git-submodule-update
 
+# If --disable-git-update specified, skip these git checks
+ifneq (no,$(GIT_UPDATE))
 git_module_status := $(shell \
   cd '$(SRC_PATH)' && \
   GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
@@ -45,7 +47,12 @@ git_module_status := $(shell \
 )
 
 ifeq (1,$(git_module_status))
-ifeq (no,$(GIT_UPDATE))
+ifeq (yes,$(GIT_UPDATE))
+git-submodule-update:
+	$(call quiet-command, \
+          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
+          "GIT","$(GIT_SUBMODULES)")
+else
 git-submodule-update:
 	$(call quiet-command, \
             echo && \
@@ -54,11 +61,7 @@ git-submodule-update:
             echo "from the source directory checkout $(SRC_PATH)" && \
             echo && \
             exit 1)
-else
-git-submodule-update:
-	$(call quiet-command, \
-          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
-          "GIT","$(GIT_SUBMODULES)")
+endif
 endif
 endif
 
diff --git a/configure b/configure
index 4231d56bcc0..2e0e2adc587 100755
--- a/configure
+++ b/configure
@@ -346,7 +346,7 @@ then
     git_submodules="$git_submodules tests/fp/berkeley-testfloat-3"
     git_submodules="$git_submodules tests/fp/berkeley-softfloat-3"
 else
-    git_update=no
+    git_update=""
     git_submodules=""
 
     if ! test -f "$source_path/ui/keycodemapdb/README"
@@ -1577,7 +1577,12 @@ for opt do
   ;;
   --with-git=*) git="$optarg"
   ;;
-  --enable-git-update) git_update=yes
+  --enable-git-update)
+      git_update=yes
+      if test ! -e "$source_path/.git"; then
+          echo "ERROR: cannot --enable-git-update without .git"
+          exit 1
+      fi
   ;;
   --disable-git-update) git_update=no
   ;;
@@ -1974,7 +1979,7 @@ python="$python -B"
 if test -z "$meson"; then
     if test "$explicit_python" = no && has meson && version_ge "$(meson --version)" 0.55.1; then
         meson=meson
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+    elif test $git_update = 'yes' ; then
         meson=git
     elif test -e "${source_path}/meson/meson.py" ; then
         meson=internal
@@ -2052,7 +2057,7 @@ fi
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-    if test -e "$source_path/.git" && \
+    if test "$git_update" = "yes" && \
         { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
         werror="yes"
     else
@@ -4175,10 +4180,10 @@ EOF
     fdt=system
   else
       # have GIT checkout, so activate dtc submodule
-      if test -e "${source_path}/.git" ; then
+      if test "$git_update" = "yes" ; then
           git_submodules="${git_submodules} dtc"
       fi
-      if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
+      if test -d "${source_path}/dtc/libfdt" || test "$git_update" = "yes" ; then
           fdt=git
           mkdir -p dtc
           fdt_cflags="-I${source_path}/dtc/libfdt"
@@ -5126,7 +5131,7 @@ case "$capstone" in
   "" | yes)
     if $pkg_config capstone; then
       capstone=system
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+    elif test "$git_update" = "yes" ; then
       capstone=git
     elif test -e "${source_path}/capstone/Makefile" ; then
       capstone=internal
@@ -6126,7 +6131,7 @@ case "$slirp" in
   "" | yes)
     if $pkg_config slirp; then
       slirp=system
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+    elif test "$git_update" = "yes" ; then
       slirp=git
     elif test -e "${source_path}/slirp/Makefile" ; then
       slirp=internal
@@ -6460,7 +6465,7 @@ if test "$cpu" = "s390x" ; then
     roms="$roms s390-ccw"
     # SLOF is required for building the s390-ccw firmware on s390x,
     # since it is using the libnet code from SLOF for network booting.
-    if test -e "${source_path}/.git" ; then
+    if test "$git_update" = "yes" ; then
       git_submodules="${git_submodules} roms/SLOF"
     fi
   fi
-- 
2.25.1


