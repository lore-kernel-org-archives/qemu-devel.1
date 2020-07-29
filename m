Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA3FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E745920658
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E745920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sEu-0006lf-6E
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 15:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddstreet@canonical.com>)
 id 1k0sEC-0006Cr-Mj
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 15:59:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <ddstreet@canonical.com>)
 id 1k0sEA-0008DI-Ig
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 15:59:04 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <ddstreet@canonical.com>) id 1k0sE7-0007eg-Ro
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 19:59:00 +0000
Received: by mail-qk1-f198.google.com with SMTP id n128so16626056qke.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 12:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gyjQICibhkZQco24n3WahdlnpEV13yXaCmThCw6DPiY=;
 b=Twi6ONfmg+CjPQjryCDjoCF/uTW9+bCRRnIpUTkxwb3/24bNv3AzbNK60HfVLX+fRx
 q6D035BspQdU2liPk1zs9sOu/5ISz/rkUiGdwFP+vGq3nmNXhI6FgIyfGm6PuDiAmf+G
 TQJhJusYNWSGLeo9Ky5+CA5RoZfAns+vyM7DGQWObp7xTeWN9JcSKQNnHK8piE0iCDeN
 gZ9arv7jZn7a+Tel+y5CSZyPh8aFhOFP31bi8j3sR+pNxSq0AS6AJd2z+uwyRRxqAY8U
 wiwR2vm6x5oqQAKsIn+Rjehpl6mbW7X07WS+VWcmiI5gZMiguPsfSMRnaFjU6jcp4eF3
 Vjpw==
X-Gm-Message-State: AOAM532NYXUomkYXdEwCiGJazoGtNjdO4U7lbE/13avPsYOxHHEIfJXO
 Pf2Mxr8At2+MpvTNsvRE+wg5hwnTUH2Cn0zkMpPCVd5BvlydFUTq/X+Mnf+Io/KODPxWSh0dDLd
 kvEPZ5vO76hFkZRqFYudc1ejhtpCsaF+f
X-Received: by 2002:ac8:729a:: with SMTP id v26mr35580qto.362.1596052738690;
 Wed, 29 Jul 2020 12:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsFmxNCStm67ivSTUuSKuEMIF7hq6akYjjzkQT4lMEkwvI1VWU5PSRI6iSrBfYd6VBYYiwbQ==
X-Received: by 2002:ac8:729a:: with SMTP id v26mr35561qto.362.1596052738312;
 Wed, 29 Jul 2020 12:58:58 -0700 (PDT)
Received: from thorin.shire (45-27-90-188.lightspeed.rlghnc.sbcglobal.net.
 [45.27.90.188])
 by smtp.gmail.com with ESMTPSA id x67sm2428199qke.136.2020.07.29.12.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 12:58:57 -0700 (PDT)
From: Dan Streetman <ddstreet@canonical.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: actually disable 'git_update' mode with
 --disable-git-update
Date: Wed, 29 Jul 2020 15:58:29 -0400
Message-Id: <20200729195829.1335082-1-ddstreet@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
References: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=ddstreet@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 15:59:00
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Note this is a rebased resend of a previous email to qemu-trivial:
https://lists.nongnu.org/archive/html/qemu-trivial/2020-07/msg00180.html

 Makefile  | 15 +++++++++------
 configure | 21 +++++++++++++--------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index c2120d8d48..42550ae086 100644
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,8 @@ git-submodule-update:
 
 .PHONY: git-submodule-update
 
+# If --disable-git-update specified, skip these git checks
+ifneq (no,$(GIT_UPDATE))
 git_module_status := $(shell \
   cd '$(SRC_PATH)' && \
   GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
@@ -32,7 +34,12 @@ git_module_status := $(shell \
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
@@ -41,11 +48,7 @@ git-submodule-update:
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
index 2acc4d1465..e7a241e971 100755
--- a/configure
+++ b/configure
@@ -318,7 +318,7 @@ then
     git_submodules="$git_submodules tests/fp/berkeley-testfloat-3"
     git_submodules="$git_submodules tests/fp/berkeley-softfloat-3"
 else
-    git_update=no
+    git_update=""
     git_submodules=""
 
     if ! test -f "$source_path/ui/keycodemapdb/README"
@@ -1598,7 +1598,12 @@ for opt do
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
@@ -2011,7 +2016,7 @@ fi
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-    if test -e "$source_path/.git" && \
+    if test "$git_update" = "yes" && \
         { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
         werror="yes"
     else
@@ -4412,10 +4417,10 @@ EOF
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
           if [ "$pwd_is_source_path" != "y" ] ; then
@@ -5385,7 +5390,7 @@ case "$capstone" in
   "" | yes)
     if $pkg_config capstone; then
       capstone=system
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+    elif test "$git_update" = "yes" ; then
       capstone=git
     elif test -e "${source_path}/capstone/Makefile" ; then
       capstone=internal
@@ -6414,7 +6419,7 @@ case "$slirp" in
   "" | yes)
     if $pkg_config slirp; then
       slirp=system
-    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+    elif test "$git_update" = "yes" ; then
       slirp=git
     elif test -e "${source_path}/slirp/Makefile" ; then
       slirp=internal
@@ -6776,7 +6781,7 @@ if test "$cpu" = "s390x" ; then
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


