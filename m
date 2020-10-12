Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540D4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C851D2076D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+ScMeME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C851D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS7QQ-0004gm-SZ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OJ-0002tI-HG; Mon, 12 Oct 2020 19:38:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:46674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OH-000738-I9; Mon, 12 Oct 2020 19:38:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id y14so15227234pfp.13;
 Mon, 12 Oct 2020 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zIq5Sy+gMMi2e/JhMz5LQuAYUsiRKE1wPRc6NTkJBrI=;
 b=b+ScMeMEFWcKJjtjIQksxJjmWKeo6FU9JLdg5gI3/1t6vTDoBituk8wgEJkm6eswOk
 qmlT+hkqIviwsB2F5Ji2W8nB1jlrGeGRMAjBheoArU41wHoHhawNQIxXIcBNtKzZeM2O
 cYjHlFrlv6LZHz7mHJ/KbsP/C6PNccWDIpcG7kMdhzhQrg8VSo263em1DZ7Eugsl1XrF
 IqiIB0kTPyDmJJU0w7TSMpASVHZ1V5HAbUMiVG4xFBrVCznC927ICzVDuc9VXjLUKENQ
 PUIQnDd6pC9mDHXcWvWDT87OWOsjz7f1kICWQycUspy1M3ZD+g14VdLcK1AsN6QvIg5q
 43EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zIq5Sy+gMMi2e/JhMz5LQuAYUsiRKE1wPRc6NTkJBrI=;
 b=F2YKjZg3kugCUvaKiYbfQV2wZzXYNBaZ5ZW1HoZeBqtDP8TRe2eKjqtmiJU4OxUOUK
 gcSat7CkYDI56U7dRyYAEK+hrNnZqA5On5lthGFgsAWa3WSwF8TggeTGSpzsSITQeLhY
 0svsplEMDDWHmrfdUA9dUAv16TqsFMMbaBdonW5Ueh8Mv+K9M16DDjc48Pur+A7ILYaB
 RGjZuBmS5dEyiksdo+FpO5ngC5Lp2WUifd2T2yyiUlO4TtYGnRgswXnhri48P2MKdQbA
 p6goIV7UVrC0J1tF2/rCrLvSsfqbk2SpxaWunchjxASOM4qIIO9yKPav/MTOf5lFn6l/
 5oAA==
X-Gm-Message-State: AOAM530Ex+PCEjHryGXeNGMHE7Gvqia/YuwdZdTx6Uxsui6cCGIb15L6
 1nLv1rygAAY9FTCCkKcOwx+P2VI3MCtPeQ==
X-Google-Smtp-Source: ABdhPJz7pOVrqmrv1rOjN4BcLriXvvbdZummVhlZPm6O8xpDvJsZWQ91id7XiUh7F06U+AwcoRziIQ==
X-Received: by 2002:a17:90a:cb92:: with SMTP id
 a18mr22251931pju.136.1602545883295; 
 Mon, 12 Oct 2020 16:38:03 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 x12sm21975783pfr.156.2020.10.12.16.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 16:38:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 1/4] scripts: Convert qemu-version.sh to qemu-version.py
Date: Tue, 13 Oct 2020 07:37:37 +0800
Message-Id: <20201012233740.190-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201012233740.190-1-luoyonggang@gmail.com>
References: <20201012233740.190-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x436.google.com
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
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index 17c89c87c6..c23167c61b 100644
--- a/meson.build
+++ b/meson.build
@@ -1132,7 +1132,7 @@ tracetool = [
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


