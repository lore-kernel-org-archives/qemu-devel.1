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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8BFC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A1620789
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmGxAOHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A1620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPl7g-0002QU-Rg
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPl2d-0005CQ-L4; Tue, 06 Oct 2020 07:21:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:36841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPl2b-0006TG-C7; Tue, 06 Oct 2020 07:21:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id s19so1061949plp.3;
 Tue, 06 Oct 2020 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IVrvxOUsYiShuvVwfOqOW7Y32dz8mgeWzYfDdIYjZq4=;
 b=kmGxAOHvW3lkdEe5GatiS1wOBBP7Mg0YbBl8vbCwjjxpPUYjEGvPFuKxFywFHYamYO
 quVhymddOnJQiH3fLQbQbRteoB49qWx3aXG9qIvOoRrEG/t5VQgC9A4q2mnVlrOeXZ2V
 XOvq3WV8Vkiz9tAJV2QHNI/Rxp2p8oqO4GiIcb1IhCg3AyvKk2gJK7BmAkKJ44iq85gU
 QSK461GkPwpf8xdUpURcE4BuhpPElMbev8KOcJ/nqikzZ3XwTd5/83i64/WkOu7EOQyD
 P0q1sD98E9gx11h2XYj/pLrmyieb03pSfZB7OkYzfh3TronbU6Q8qZ95TgTuUdSp4lrC
 5mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IVrvxOUsYiShuvVwfOqOW7Y32dz8mgeWzYfDdIYjZq4=;
 b=aeNFazSHenBvXIvAOrTtxextS8FBaB34EVibeGdMGa5K8ibXk40gd4PAiZ6ykwIb9d
 x4ydSjK5jeM8r+sjPI4qhyDIarLQmguvUh/v8NUPnXajxchHy9g7NxUSFOpXhfkZIuhW
 iVrr/lJzXkeY7uxVhXv/TVyV+Td3wil9BSLhnvZL8UxlKeUZCi0i35hOM225+U6+7/va
 rPUxhTrK0lM45tpumrhi5YS7ol8JRs4jivT1+NhdttNfQpm/kOjMsuy9v6unhksaPo1B
 yf4YTXOzhWo+ni1PFX/6PCUbsArQ5Xdgeya0hF/ySNtW5a6TYnIUj24QGVvep5csklJX
 9PXQ==
X-Gm-Message-State: AOAM530LUetE84RKXeaIr57uFn2Ph5ti8MB5DbfOYFWA8AFoQyFakCfn
 kwzqWJLdZT0UQzvmZ7FUTUXe6mELxMqxyQ==
X-Google-Smtp-Source: ABdhPJyQK737y3aJY3hIYbB0NQfhrTDNoMRVyK229Faidi+31li38fTPgdQZ/AWX4xWc2fFSvVoPuQ==
X-Received: by 2002:a17:90a:128d:: with SMTP id
 g13mr3779868pja.35.1601983314940; 
 Tue, 06 Oct 2020 04:21:54 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x3sm2941386pgg.54.2020.10.06.04.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:21:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] scripts: Convert qemu-version.sh to qemu-version.py
Date: Tue,  6 Oct 2020 19:21:39 +0800
Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62e.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=E8=8C=85?= <f4bug@amsat.org>,
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
index 0000000000..e6eb548220
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
+    print('#define QEMU_FULL_VERSION "%s"' % fullversion)
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


