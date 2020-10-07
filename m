Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A836C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA39206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5grEhYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA39206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCX8-0000UI-Rq
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQCCZ-0002B2-Ud; Wed, 07 Oct 2020 12:22:03 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:32912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQCCX-0005WQ-De; Wed, 07 Oct 2020 12:22:03 -0400
Received: by mail-pg1-x52e.google.com with SMTP id o25so1703494pgm.0;
 Wed, 07 Oct 2020 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSsDnCu2xfO7roPjdDMghbRXhd6/t/v6INO/sWdZhMs=;
 b=Q5grEhYmho5ZZoCZ2KWdZGDsHc79ZJ+GHZSlkfL9Y8+wQ9ckBJKNZHc9BDdhofXAtp
 Eu4krlgI7yvuM2Y99hvBMaKlavwhbBb6s+6NTeHtcq3ey9RCpu2QnBolAXc+ky3IbB/1
 XYJnElM3YMkxjCVvi5KHOJ7gMY0Az/6ZPGjtfHJzNIFADZqXTTNVPmy9cdl3Ai3J9tcN
 OxBHaydqHyF8RDEuy9KN5aixOjkocGmP/ViZg0lG56vLRB6lo56V6pxbg1o7B9AjMI9m
 UhXPHzyCWvkYJOI2m4G+M67Nw8gJxDJsTqsvCWEhHEBmWmqiEpWmkRIAiBR3rO662Frn
 A/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSsDnCu2xfO7roPjdDMghbRXhd6/t/v6INO/sWdZhMs=;
 b=n3IDbFOWYs5ccuzXv/IvKwt9isG7/BIqRh9ccp0gTGPqqgARSC3Q/wY0Yo5gUqaExZ
 Rzz/lXO5YMRhSS4EvwJL6JlCaVu8iyd9TJHcZuYC3fEr73no68saPjTGqB9gx6iiAhog
 akHjVahmMd3tcw4GtYn0B/2vQhMjOe4MGajAoz8J79VGQXt7s+EpAPJfHcyzQlOfJQ6e
 VdERftsNEJPZGNk8W12wm0H0zYCmR+z82I1j2HrvYlj1RowPH6fw+fhan40t22mumJCO
 kZxrRJBk2S192xtJMm+YczCv1kxe6rN1lr1sytz1eBpyFN0nMz4e/6vM1SsPPKHWuwBF
 mf4A==
X-Gm-Message-State: AOAM532z7kjtuQ7JKheTqs4If7stVYxcqE0ezSMmyzwsrzWsx0Bv8JZ4
 537bCQYwuhvuHasQ1sFeSnK7vagsohclBg==
X-Google-Smtp-Source: ABdhPJzkq89oSb5m9tDu2iBDhB4My26rW5lAFMTI+k0hY/xxhbiInyXmHtdj01aAxe6YT91wQqv5Vw==
X-Received: by 2002:aa7:9712:0:b029:152:69ab:b507 with SMTP id
 a18-20020aa797120000b029015269abb507mr3731651pfg.30.1602087718039; 
 Wed, 07 Oct 2020 09:21:58 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v10sm2974021pjf.34.2020.10.07.09.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:21:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6] scripts: Convert qemu-version.sh to qemu-version.py
Date: Thu,  8 Oct 2020 00:21:38 +0800
Message-Id: <20201007162138.425-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52e.google.com
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

The quote of v* should preserve, otherwise git command would fail

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build             |  2 +-
 scripts/qemu-version.py | 34 ++++++++++++++++++++++++++++++++++
 scripts/qemu-version.sh | 25 -------------------------
 3 files changed, 35 insertions(+), 26 deletions(-)
 create mode 100644 scripts/qemu-version.py
 delete mode 100755 scripts/qemu-version.sh

diff --git a/meson.build b/meson.build
index 26230614ba..1d3bb25bc6 100644
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
index 0000000000..019911b270
--- /dev/null
+++ b/scripts/qemu-version.py
@@ -0,0 +1,34 @@
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
+import os, os.path
+
+def main(_program, dir, pkgversion, version, *unused):
+    os.chdir(dir)
+    if not pkgversion and os.path.exists('.git'):
+        # The quote of v* should preserve, otherwise git command would fail
+        pc = subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty', '--always'],
+                            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, encoding='utf8')
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


