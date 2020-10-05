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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D289C46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9885320665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MINESJGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9885320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUCx-0005oO-EQ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPUAz-0003mq-Uk; Mon, 05 Oct 2020 13:21:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:38167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPUAy-0005F1-78; Mon, 05 Oct 2020 13:21:29 -0400
Received: by mail-pj1-x1032.google.com with SMTP id u3so176554pjr.3;
 Mon, 05 Oct 2020 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DMzT9/M4Np2e322VJODPD0jmCf59vaILNBz2t+4KVPQ=;
 b=MINESJGOBPltgqEaqlqw0DFICGb3RCDnMPSgjHYdj7eXifWfvAa/J80C8taCdsjX4A
 pK/E/3jKeJkVuoIwUnht5UJS29vaR7XSYjvFqDKOK3YOtjhxxXWtdAmcoAzz9/+k8Qi2
 KAFokcXNTwKhIm/hkrsmYqGzMbLzbj2249GYqqv8vMSkSOn6kwf0jheetEp3cHEL4aY7
 +YlQFmO0QSBvFzHWq/4YFyHdjxBPpHYn+211F06aXlLHXN68aRzEKuEGbCqAYZ04RbRA
 bXmBk95Y0y22V6f6kvS7HWw0+wb0XUC3bo8YUQixwyWszaEvT3NUzrQ49FmV7lpDC4HU
 iL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DMzT9/M4Np2e322VJODPD0jmCf59vaILNBz2t+4KVPQ=;
 b=a6WQKyQ0skiffyfUJgRRgJen78y35yg+Mmn9/I/E1gK5FVQRViigTJf9S/FhcM+bG0
 ICZiaFee+JgSkSD2dcWT2Y1td26HyrmJ4r+O2K1VX8k16BOp13ZuUpQ9Yc8Wai0vvzB6
 o27WKsZwXmBsMfa+DEPIyi+laXQwlak8K9wVBUGY5PqM/FO2pE1oa+bcBEGHBonLIPcI
 3CRrcQDybZyzQ4IXA5LrXF8xAd96Hy5iRNaau9nVLIYGn20Au/ujTz+UBg236WkDjor+
 eQPMZ23AP7q1HyeBhcfRMG1will1C4WZleBs0tdBcH4SC8qe8af0HzF47CuOU7tMpuea
 QrXw==
X-Gm-Message-State: AOAM531flS9KOBLGlZQdS0axm0Aku0xG5WnMG53+t/gAKurKAjeLu8Ql
 /spJ05OZPHIe8msjMh5rr7FpiF3/1mgngg==
X-Google-Smtp-Source: ABdhPJyFbXvZMiGsEvrQBm36HkkWms2svmu86NlD0Z7xq8hUkkp/wAnKC8wLIrVjwT/rWZaT4sEaHA==
X-Received: by 2002:a17:90a:448a:: with SMTP id
 t10mr456749pjg.19.1601918485841; 
 Mon, 05 Oct 2020 10:21:25 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id c187sm555867pfc.0.2020.10.05.10.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 10:21:24 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] scripts: Convert qemu-version.sh to qemu-version.py
Date: Tue,  6 Oct 2020 01:21:09 +0800
Message-Id: <20201005172109.416-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1032.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sh script are harder to maintain for compatible different
xsh environment

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build             |  2 +-
 scripts/qemu-version.py | 30 ++++++++++++++++++++++++++++++
 scripts/qemu-version.sh | 25 -------------------------
 3 files changed, 31 insertions(+), 26 deletions(-)
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
index 0000000000..384c54027d
--- /dev/null
+++ b/scripts/qemu-version.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+
+# Script for retrieve qemu git version information
+# and output to stdout as QEMU_PKGVERSION and QEMU_FULL_VERSION header
+# Author: Yonggang Luo <luoyonggang@gmail.com>
+
+import sys
+import subprocess
+
+def main(args):
+    if len(args) <= 3:
+        sys.exit(0)
+
+    dir = args[1]
+    pkgversion = args[2]
+    version = args[3]
+    pc = subprocess.run(['git', 'describe', '--match', "'v*'", '--dirty', '--always'],
+        stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, cwd=dir)
+    if pc.returncode == 0:
+        pkgversion = pc.stdout.decode('utf8').strip()
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


