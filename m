Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F28C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AD3204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzpPnrsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AD3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPWXZ-0000pG-UV
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPWWW-0007lp-8J; Mon, 05 Oct 2020 15:51:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:44899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPWWS-00074Z-Fx; Mon, 05 Oct 2020 15:51:51 -0400
Received: by mail-pf1-x436.google.com with SMTP id n136so1682615pfd.11;
 Mon, 05 Oct 2020 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YL8KLigaBn/LrPDDLKeSFNKEGwXVc6l1Oo2NoRSVZgU=;
 b=qzpPnrsVnLMEP2XCoAPAv5lX/si084AqqjUN8VfQCrmRbgLtN8dNuQ//ZnlcuXnuER
 qwRrtJM0YVYlQbRiIW/ZJ6wef7gG5ogNftrGP670ZQz17aKIsTcLybcquUZvIysoz8uY
 VVsKzK3zuWbx1rxFrK6n92N49W2Hct3DN5O2ywX8BoYNVkMLOKMkmmh7A+11tJ/6DtlF
 XrBwo7XIojsDi5jZgSmwriYQg4wa3DZ8VtqiibzCXtkfNuwdOlUFaRzQBFdik2hEgAeU
 4G43vj1CksDTnwTWCfwoC8mnA/Mh6Bso4HRvj8NBuOTR0ekpPoRVmgFrd1em+t9DTgg9
 RVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YL8KLigaBn/LrPDDLKeSFNKEGwXVc6l1Oo2NoRSVZgU=;
 b=kAx/aVP9sOyu8TrMZ1r8jH4N+6F5ThHYijPsYl1aO+aAufVr9/S6lx4gbA42jPu2DW
 c8IawO4K5jfsT+kL1iWq/abZf6LVgnjR13hawmHXGgaThmHyE38lYNDZWvPQyi4LLp8o
 OFuld/hpbf0rEln3+l5rLAsAsLH3fiSVtm+uCMj47veGhW8W/1d+64bfDbvHBOD2OvxZ
 DYK5Q8pJSGiy1WOFqOE3pZ9pL+q6Cc4YL3fMQcmWjMXy2EE9uNK0vv4eM6s+dCRjhWP/
 pd0XosBh3Oz+xW6PBFfqg4P3GsdRG4HiDuDV2sY5qTETlF340pX6Ml1Cd9rQRoyj5C0U
 t/zQ==
X-Gm-Message-State: AOAM531nhmcstpDrWHfj3lBofc7TOIoLyUxTFQxVOiHFv/KzHbBY1Fb3
 6HaXWz2axFjdMDZWeBYWv5k1MbxiAEE0WQ==
X-Google-Smtp-Source: ABdhPJxSoHrGrcAUz0m7Jsu8LxGMaei0kZiVQwb5yKZHdMpcAvq7pztqP/R8ECm/SsZCxK2q/qoYvg==
X-Received: by 2002:a63:705c:: with SMTP id a28mr1065165pgn.266.1601927506163; 
 Mon, 05 Oct 2020 12:51:46 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id ep11sm358985pjb.55.2020.10.05.12.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 12:51:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] scripts: Convert qemu-version.sh to qemu-version.py
Date: Tue,  6 Oct 2020 03:51:29 +0800
Message-Id: <20201005195129.1507-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
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
 scripts/qemu-version.py | 37 +++++++++++++++++++++++++++++++++++++
 scripts/qemu-version.sh | 25 -------------------------
 3 files changed, 38 insertions(+), 26 deletions(-)
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
index 0000000000..fc1531ef2b
--- /dev/null
+++ b/scripts/qemu-version.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+
+#
+# Script for retrieve qemu git version information
+#
+# Author: Yonggang Luo <luoyonggang@gmail.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+#
+
+import sys
+import subprocess
+
+def main(args):
+    pkgversion = ''
+    version = ''
+    if len(args) > 3:
+        dir = args[1]
+        pkgversion = args[2]
+        version = args[3]
+        if len(pkgversion) == 0:
+            pc = subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty', '--always'],
+                                stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, cwd=dir)
+            if pc.returncode == 0:
+                pkgversion = pc.stdout.decode('utf8').strip()
+
+    fullversion = version
+    if len(pkgversion) > 0:
+        fullversion = "{} ({})".format(version, pkgversion)
+
+    version_header = '''#define QEMU_PKGVERSION "{}"
+#define QEMU_FULL_VERSION "{}"'''.format(pkgversion, fullversion)
+    sys.stdout.buffer.write(version_header.encode('utf8'))
+
+if __name__ == "__main__":
+    main(sys.argv)
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


