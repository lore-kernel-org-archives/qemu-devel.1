Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF2FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980162077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upUIWPI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980162077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO5V-0003SK-TF
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxr-0002gq-88
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxp-0005hx-RO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:07 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:42359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxp-0005gM-Jf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id q6so2581135wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V9NM3FbIChOvvJW2t/FWXrIIPwk25T+7dF1biBLa1ws=;
 b=upUIWPI9kOWOIA3rUJmV7BUl7gJ30asVYi26sQWcv/rJhDxCsO9DOSOw/ZTcijJaYL
 TrP8DhvJe3w3rK9bEWRpXFxlywdb38Eum6Kiu0FPPZsF1PrdIszh9B2njtceQDmdXejy
 8tMhM90eN71+xF2wDIz7AoGy6pFdk3ZWZuvRZK1AhlPWvAIE/MvtdgrvDUZ+RNER3Fyu
 BacAnIuYoN+bBdu+6kYCLsaAtGRekBc753wQp2mKLmVWJc0F2CGj4+j1IJVINPEQjEdx
 3yJZLevQYvqJKs7amv7tKeV2sj9reI9hz2qC0ygPOo/dIbB6aoqVygsN+CQYwrYvo6BA
 BurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=V9NM3FbIChOvvJW2t/FWXrIIPwk25T+7dF1biBLa1ws=;
 b=mdD5ibbK4eF8uoiAeF0JuYJXNkBgkHMDwCqM67SC2NpL7aoi4jZAhYCdKRpg94pZ3y
 JscMhfJcJy2nWiGbBbpbxlb5G+1oEC0QR4fp2WCrlHZa8caoXr2jG4E/nPL1FV4N+UaF
 AazBSHHcRPzz4aEbv+ZoXmZ96ljB9p84i9+0JH31JL+zhptdI4e7yCj1hDZ+EflHjxUq
 LX1FvQDJ5wxhwHwXMnDkNFF6BTGK/zHVgbRrfUDPIyyAnqD9lJazVZ962IATAi1mb549
 3Kibt9aH/xCsnrtBXKLSEfES+fRw2CH7TZW1xrkrwBXY/yNHrzip8zX/lC9Ppls/oMdR
 3NbA==
X-Gm-Message-State: APjAAAV8+Vlf/rRbl/RtQJWvVG4kreL4IK3YnCMKTA+rlzbMvr875N23
 /prdduorZ9PucgQDEOHXPR2JNLQu
X-Google-Smtp-Source: APXvYqxa2iToLqHwd09nBgILHNzp2+uKvRIzv3VJcmRTEkaH46jbwB4H6IeIa0j4yILYhHdaAwY/hQ==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr5993041wrt.208.1576155184325; 
 Thu, 12 Dec 2019 04:53:04 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 006/132] build-sys: add meson submodule
Date: Thu, 12 Dec 2019 13:50:50 +0100
Message-Id: <1576155176-2464-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .gitmodules               |  3 +++
 configure                 | 45 +++++++++++++++++++++++++++++++++++++++++----
 meson                     |  1 +
 scripts/archive-source.sh |  3 ++-
 4 files changed, 47 insertions(+), 5 deletions(-)
 create mode 160000 meson

diff --git a/.gitmodules b/.gitmodules
index c5c4741..67f4ed8 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -58,3 +58,6 @@
 [submodule "roms/opensbi"]
 	path = roms/opensbi
 	url = 	https://git.qemu.org/git/opensbi.git
+[submodule "meson"]
+	path = meson
+	url = https://github.com/mesonbuild/meson/
diff --git a/configure b/configure
index 2f3e231..0eb3d70 100755
--- a/configure
+++ b/configure
@@ -171,6 +171,25 @@ path_of() {
     return 1
 }
 
+version_ge () {
+    local_ver1=`echo $1 | tr . ' '`
+    local_ver2=`echo $2 | tr . ' '`
+    while true; do
+        set x $local_ver1
+        local_first=${2-0}
+        # shift 2 does nothing if there are less than 2 arguments
+        shift; shift
+        local_ver1=$*
+        set x $local_ver2
+        # the second argument finished, the first must be greater or equal
+        test $# = 1 && return 0
+        test $local_first -lt $2 && return 1
+        test $local_first -gt $2 && return 0
+        shift; shift
+        local_ver2=$*
+    done
+}
+
 have_backend () {
     echo "$trace_backends" | grep "$1" >/dev/null
 }
@@ -489,7 +508,6 @@ libxml2=""
 debug_mutex="no"
 libpmem=""
 default_devices="yes"
-meson=meson
 
 supported_cpu="no"
 supported_os="no"
@@ -1827,9 +1845,28 @@ then
     error_exit "Python not found. Use --python=/path/to/python"
 fi
 
-if ! has "$meson"
-then
-    error_exit "Meson not found. Use --meson=/path/to/meson"
+if test -z "$meson" ; then
+    if has meson && version_ge "$(meson --version)" 0.53.0; then
+        meson=meson
+    elif test -e "${source_path}/.git" && test $git_update = 'yes' ; then
+        meson=git
+    elif test -e "${source_path}/meson/meson.py" ; then
+        meson=internal
+    fi
+fi
+
+case "$meson" in
+    git | internal)
+        if test "$meson" = git; then
+            git_submodules="${git_submodules} meson"
+            (cd "${source_path}" && GIT="$git" "./scripts/git-submodule.sh" update meson)
+        fi
+        meson="${source_path}/meson/meson.py"
+        ;;
+esac
+
+if ! has "$meson" ; then
+    error_exit "Meson not found. Use --meson=/path/to/meson|git|internal"
 fi
 meson=$(command -v $meson)
 
diff --git a/meson b/meson
new file mode 160000
index 0000000..5031f49
--- /dev/null
+++ b/meson
@@ -0,0 +1 @@
+Subproject commit 5031f4981d4fcf6eb0bc950669a0a77a7df22939
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index fb5d6b3..c6169db 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,8 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc slirp ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
+submodules="dtc slirp meson ui/keycodemapdb"
+submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
 function cleanup() {
-- 
1.8.3.1



