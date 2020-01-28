Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C872C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB772173E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF6MfdOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB772173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVEa-0003g2-VN
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV42-0006Cw-Qo
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV40-0007qZ-Fg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV40-0007oi-6N
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id c9so17098378wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=06judu2RvAPY7E+oo72Ez5WIdcyz5/kIJkHMqmuH7Ss=;
 b=eF6MfdOYmVoXYscF5zKFdwOZ7M/aBPv2/BH1/KqgfDL7yd64lpJUJi3XvYWUjY2pHK
 PkXFl5Mzsqtfa0DJ7hxg8aPYbaQGiwqPaxvMl+zSc3UGhjYU+alkRXjF5XQ2Ivx/KAb2
 DJUnVGTR6Y5vXRaErzBeCPoCxLmfh7H3d9iKIPisdr0m5btLq0bpAoIUfeNoFhcgQbUf
 3gtg6xYGzyVEmtNdBWMIwM/gUC0sxbNNnVmS7/XsKckv8+r/aYMW2mM1jzp5kd/KClkj
 EP+1B8lipbdAALkvpJkB5hff3QhBQCOshG22gk9ytZ1TnCRuLky5bjfSKRq8SsSSeZ0l
 qcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=06judu2RvAPY7E+oo72Ez5WIdcyz5/kIJkHMqmuH7Ss=;
 b=KZ5S3Uc0ajoPlGpnWR74eG6ULSCHApLNrw9fgbyBoY/UcRpSbzzQA6VZjOMg5MlUx/
 ZYJ+4vTTZpRJtvbf2Nw4QXthNo4FUPqqWh3BGhkt7tTo+YHZYQ471AZb2D5r01QrPI/h
 mSzpBKZB5WJEzS2BdAA0uhx6flNEPQ+qh//P31Vmrpi1Tu3o3Gee+U9xYkQ1x0x+Vdg5
 dnzBiMv/bSxOeiddFJBOLfv5CrvAyNaRmyWV+NBwU8SzQ66wjHBQCPS21NMdQ6ez6YSM
 /J5TR2Bv5H1lfN9biQYgoCUjis7qMHPQzfqlO9zjOW62SfA6I8fGMJtkDP3mCcBF+kro
 vTcQ==
X-Gm-Message-State: APjAAAXYxSjdwZHLzBn61wvuVnPlSTNWPvZqNez2M6vDFKMULlJ4TJQZ
 LgJQYyWU+yu9RwDHisRaV/SlxruZ
X-Google-Smtp-Source: APXvYqxF2attYOKTt6nmP4krbfW7CGZ4XSLmSRSDCUAwSCGPaGsdNczM6mIDzoO7DsjmLhY+s2imcQ==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr31193485wrw.255.1580234050876; 
 Tue, 28 Jan 2020 09:54:10 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 009/142] build-sys: add meson submodule
Date: Tue, 28 Jan 2020 18:51:29 +0100
Message-Id: <20200128175342.9066-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .gitmodules               |  3 +++
 configure                 | 45 +++++++++++++++++++++++++++++++++++----
 meson                     |  1 +
 scripts/archive-source.sh |  3 ++-
 4 files changed, 47 insertions(+), 5 deletions(-)
 create mode 160000 meson

diff --git a/.gitmodules b/.gitmodules
index 19792c9a11..9ddb25695d 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -61,3 +61,6 @@
 [submodule "roms/qboot"]
 	path = roms/qboot
 	url = https://github.com/bonzini/qboot
+[submodule "meson"]
+	path = meson
+	url = https://github.com/mesonbuild/meson/
diff --git a/configure b/configure
index cdc71631e0..b4f36820da 100755
--- a/configure
+++ b/configure
@@ -172,6 +172,25 @@ path_of() {
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
@@ -495,7 +514,6 @@ debug_mutex="no"
 libpmem=""
 default_devices="yes"
 plugins="no"
-meson=meson
 
 supported_cpu="no"
 supported_os="no"
@@ -1849,9 +1867,28 @@ then
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
index 0000000000..5031f4981d
--- /dev/null
+++ b/meson
@@ -0,0 +1 @@
+Subproject commit 5031f4981d4fcf6eb0bc950669a0a77a7df22939
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index fb5d6b3918..c6169db69f 100755
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
2.21.0



