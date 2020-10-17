Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33712C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7286A2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmpYMd59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7286A2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTpKN-0002KB-B7
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 12:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTpJ6-0001uy-IM
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:43:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:41400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTpJ4-0004Ij-D0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 12:43:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id w11so2841913pll.8
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 09:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9yI7/LlbDAFFvP6gBE686fZhI+Iflhk7DmdsIj+ZQfM=;
 b=JmpYMd59Be3iGqo8puX1OemPl0sHLeStN7fmooR5DDUhMKu0YhmKTz3e/UmgqsEZAS
 ZnWM2FYFXEqF8J5GawMn465JhE8L4RaLQsGW3CoyKEfYQi3m47GfW+YvtHEZtZbHUF0t
 8llmHmr5WVTx/FA4GTuKAQvgM2cKSiVYPbbpP8qMnSizPWiqCu892+6ycQIDeO5IzQGY
 ejAd3IKRd3CJtDJbshUfoUPiCNl5lP37ieY8IF2b0iKfSYZ530YYTxPOWSuGFaBVHprV
 FWizDRtAGpWoia4K856vg3RqAy9+uLua99TWfNHZzZtcUcmocOUqM84g0fAfOMURJArD
 hJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9yI7/LlbDAFFvP6gBE686fZhI+Iflhk7DmdsIj+ZQfM=;
 b=B18wPfv5kbfa3j1SwxeBj46nzGNSctIumtxFBk8SRybpZ8GTL8VXTeAHZWEsm5nz6C
 7fx24WmP/phQbIjwB9/qHyZQh/Yb2NmTFZhu4RIUDC75tTSovpu8QIFQ+jTZ9mo1rq0S
 MusSMmL4oqhu+Vk7s0w3uUjFTeF0gDzOpz39M4yylln0e4aRZ2SRvedXgfbt8duxtxCF
 8VIKJ5Kx6rq4sRaGm1p8Xgapc8XL5hnMpMMrvfp6Kw7qyLi84FZgGAm4U4DUk15e/8gh
 z6rKdZDSTzPf0vz35th6fi4U0AzkrWA1uV63bWtGli4aoifNhnUMtIixO18ud/kGl0PN
 OnPQ==
X-Gm-Message-State: AOAM5315S1/7lkzsjEp+ZxokUdHFKqV0Ptj8+BTyDfB2OwFBlRj7YLX9
 Zi44c9Rjte2xk/CrIZpIFrI5UL/PBORhTQ==
X-Google-Smtp-Source: ABdhPJxTHjGDwqw38KzKB4ejVweLZqsUPb97id1NB+toXTnWs3pysxUq0dBSIEH0mA/u94piQEpiag==
X-Received: by 2002:a17:902:ee52:b029:d5:b156:3ff8 with SMTP id
 18-20020a170902ee52b02900d5b1563ff8mr9518240plo.85.1602953024416; 
 Sat, 17 Oct 2020 09:43:44 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id s20sm5785676pfu.112.2020.10.17.09.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 09:43:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11] scripts: Convert qemu-version.sh to qemu-version.py
Date: Sun, 18 Oct 2020 00:43:29 +0800
Message-Id: <20201017164329.1634-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x635.google.com
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

The sh script are harder to maintain for compatible different
xsh environment so convert it to python script
Also incorporate the fixes in
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/

According to https://github.com/msys2/MSYS2-packages/issues/2176
We need use CYGWIN=noglob and MSYS=noglob in the environment variable
for disable wildcard expanding in msys or cygwin git, and setting the shell=False

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build             |  2 +-
 scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++
 scripts/qemu-version.sh | 25 -------------------------
 3 files changed, 38 insertions(+), 26 deletions(-)
 create mode 100644 scripts/qemu-version.py
 delete mode 100755 scripts/qemu-version.sh

diff --git a/meson.build b/meson.build
index 05fb59a00b..b100b6d7be 100644
--- a/meson.build
+++ b/meson.build
@@ -1240,7 +1240,7 @@ tracetool = [
    '--backend=' + config_host['TRACE_BACKENDS']
 ]
 
-qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
+qemu_version_cmd = [find_program('scripts/qemu-version.py'),
                     meson.current_source_dir(),
                     config_host['PKGVERSION'], meson.project_version()]
 qemu_version = custom_target('qemu-version.h',
diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
new file mode 100644
index 0000000000..cf97b2bbb5
--- /dev/null
+++ b/scripts/qemu-version.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+
+#
+# Script for retrieve qemu git version information
+#
+# Authors:
+#  Yonggang Luo <luoyonggang@gmail.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or, at your option, any later version.  See the COPYING file in
+# the top-level directory.
+
+import sys
+import subprocess
+import os
+import os.path
+
+def main(_program, dir, pkgversion, version, *unused):
+    os.chdir(dir)
+    if not pkgversion and os.path.exists('.git'):
+        pc = subprocess.run(
+            ['git', 'describe', '--match', 'v*', '--dirty', '--always'],
+            env=dict(os.environ, CYGWIN="noglob", MSYS='noglob'),
+            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
+            encoding='utf8', shell=False)
+        if pc.returncode == 0:
+            pkgversion = pc.stdout.strip()
+
+    fullversion = version
+    if pkgversion:
+        fullversion = "{} ({})".format(version, pkgversion)
+
+    print('#define QEMU_PKGVERSION "%s"' % pkgversion)
+    print('#define QEMU_FULL_VERSION "%s"' % fullversion)
+
+if __name__ == "__main__":
+    main(*sys.argv)
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
deleted file mode 100755
index 3f6e7e6d41..0000000000
--- a/scripts/qemu-version.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/sh
-
-set -eu
-
-dir="$1"
-pkgversion="$2"
-version="$3"
-
-if [ -z "$pkgversion" ]; then
-    cd "$dir"
-    if [ -e .git ]; then
-        pkgversion=$(git describe --match 'v*' --dirty) || :
-    fi
-fi
-
-if [ -n "$pkgversion" ]; then
-    fullversion="$version ($pkgversion)"
-else
-    fullversion="$version"
-fi
-
-cat <<EOF
-#define QEMU_PKGVERSION "$pkgversion"
-#define QEMU_FULL_VERSION "$fullversion"
-EOF
-- 
2.28.0.windows.1


