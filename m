Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD084C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0CC20789
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPbhtChi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0CC20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPl2z-0005Bz-4m
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPl1F-0003T0-Dv; Tue, 06 Oct 2020 07:20:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:45654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPl0r-0006Bd-B8; Tue, 06 Oct 2020 07:20:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id y20so1060309pll.12;
 Tue, 06 Oct 2020 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ireCJYo+5bCBzUR1jS15CkZt6OPS1jT+teHIMYat7dE=;
 b=UPbhtChiqhUqHsbV5OcSf6Cu/LKWwVkYWrZWiUpyRWGmU6zP8pXWYYQJ41ysb+R1e7
 JfS/qPzaMu3BgVdpF6O9prGc7YSlPO26ev0usm1bKioM7fWLishzaQvsLM8kiuAJCDNv
 XPJ506hw7419GAeLHHBPrVPewUBa9p1FoM+7cMgPEdYqsgSzCr9bybKiv5u5IDE51v0N
 R5lCBqLd9DpaxHDPiu2wJLz2ALDAgefJXE9JK8JSqyUNTgMkrBabM9UwCPjkhzIcNXbp
 FpHEp783AM9AlXmPn+/5c91uAUemG5raWJp2mEcaojKrAJzQpaaQC7mizgZcLwR3q8/v
 hzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ireCJYo+5bCBzUR1jS15CkZt6OPS1jT+teHIMYat7dE=;
 b=YQ2J8jfDnoYEBzn+s0iFpc/lPc0gFAdY5bI7kLikLQWmZ2RHqyj/6/9TdIv35278sr
 vOdPo0v9MWZ4fA/11u0mkpCXgS4cHAgmuE8cg/s186i9HKffnfMqqtT3hofbMETJBiHz
 WnzOucGVLvORDrkUVlUip+b9ltsDkjQ7XjKLUZpt+zVsy5oyUMxh/oCNYqBLXmzQzyNd
 VtuAaf7Ft00A0IF4txsLDbYk51ALSm8c79tX1XhERbYCW4CpdIbrQ9+HKZNhUfteqt02
 lTLQBRr2DMxpjPZca2mtw1G1d7i9UvA5HimcMABcFf3OxR57XipmWHWhvP3riob2k0Os
 eIPw==
X-Gm-Message-State: AOAM531XwHkKh6Jl4U3wEHnRG2YMFY62xGV7xaKlFcq0pWXJaSOURkrB
 WapPUg35dvYDiRBSzeyrBi2G88fVIeOE9Q==
X-Google-Smtp-Source: ABdhPJwrmisqF/6pZTr5tLYgEk5c5pdecz2VycWogSUA3CrdSu61WDxXj7jOcj1DYXaxQmETBDkyBw==
X-Received: by 2002:a17:90a:7486:: with SMTP id
 p6mr3955965pjk.162.1601983207110; 
 Tue, 06 Oct 2020 04:20:07 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j4sm2988116pfj.143.2020.10.06.04.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:20:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] scripts: Convert qemu-version.sh to qemu-version.py
Date: Tue,  6 Oct 2020 19:19:50 +0800
Message-Id: <20201006111950.875-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x636.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sh script are harder to maintain for compatible different
xsh environment so convert it to python script
Also incorporate the fixes in
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/

Testing args length and if not enough, setting pkgversion and version to ''

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build             |  2 +-
 scripts/qemu-version.py | 31 +++++++++++++++++++++++++++++++
 scripts/qemu-version.sh | 25 -------------------------
 3 files changed, 32 insertions(+), 26 deletions(-)
 create mode 100644 scripts/qemu-version.py
 delete mode 100755 scripts/qemu-version.sh

diff --git a/meson.build b/meson.build
index 95a532bd29..20f653b6eb 100644
--- a/meson.build
+++ b/meson.build
@@ -1072,7 +1072,7 @@ tracetool = [
    '--backend=' + config_host['TRACE_BACKENDS']
 ]
 
-qemu_version_cmd = [find_program('scripts/qemu-version.sh'),
+qemu_version_cmd = [find_program('scripts/qemu-version.py'),
                     meson.current_source_dir(),
                     config_host['PKGVERSION'], meson.project_version()]
 qemu_version = custom_target('qemu-version.h',
diff --git a/scripts/qemu-version.py b/scripts/qemu-version.py
new file mode 100644
index 0000000000..04a68b7612
--- /dev/null
+++ b/scripts/qemu-version.py
@@ -0,0 +1,31 @@
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
+
+def main(_program, dir, pkgversion, version, *unused):
+    if len(pkgversion) == 0:
+        pc = subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty', '--always'],
+                            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, cwd=dir)
+        if pc.returncode == 0:
+            pkgversion = pc.stdout.decode('utf8').strip()
+
+    fullversion = version
+    if pkgversion:
+        fullversion = "{} ({})".format(version, pkgversion)
+
+    print('#define QEMU_PKGVERSION "%s"' % pkgversion)
+    print('#define QEMU_FULLVERSION "%s"' % fullversion)
+
+if __name__ == "__main__":
+    main(*sys.argv)
diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
deleted file mode 100755
index 03128c56a2..0000000000
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
-        pkgversion=$(git describe --match 'v*' --dirty | echo "")
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


