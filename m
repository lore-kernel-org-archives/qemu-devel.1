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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB77FC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D5320659
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 20:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiVwMWDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D5320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQFd1-0000eo-4A
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 16:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQFbR-0008Sf-Rf; Wed, 07 Oct 2020 15:59:58 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:43880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQFbP-0003nE-IH; Wed, 07 Oct 2020 15:59:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id a200so1996897pfa.10;
 Wed, 07 Oct 2020 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bs6R4CyOdWUvDM1xrED4Sm4AliKv/3oV6e1Jk9fTwxk=;
 b=PiVwMWDOCxPK27WUHh3mNZHuM3tBrzN0iygTa3p8qcLVapkSDo1H8yNqHInRLehwea
 RfAkvx/PzYsJyvQ9oNSwAMR4vnwlO7UAy0EJ1WyKATjuy/Ur55vTpGqa4KXTLLMQpri2
 xBvbRozb9L89cHxAycghMHqFjXSYumcMJYtoqtAmNe0P6HErligjrbiYV0KuGM7prGYo
 R+n5TW5qfbmNx777DNk6uQ20GyC+3RJqdxUugj3A8OxPc2p3vWEqvJ62Iwyk0En0js3/
 ar0ay4plsp31nayAkEyF8cjrCAxDoMkEFp9bZimihIOdL9zkjDGpr6QtxVAqRW8d/iF7
 3u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bs6R4CyOdWUvDM1xrED4Sm4AliKv/3oV6e1Jk9fTwxk=;
 b=dQ2WJpjWKGrD/RVDv1rQUrAxu5q5R6FW1e9BKLFz48NAXQhuqPEkroXrBaixAiJFxH
 w/440psqa8+8MnW4TPQ71S4lzeeqJjWRj52anmLKtrB78M2QGZu/SHaUlBDapnZKvip/
 pa02b4b2TEW14E6yeopy4FTb7b5SWLPSvU7QHRr3wtQb/7jlkLAAVDyPhIdx7NrnSDv+
 XHINWtapnLTz9jT0PtzAOYoYXLWDLx64G5YuQ96GwDCfCeypQN093pmhxky1fxj6bUT1
 9JYo0CxuiOAimKTae3/DmqLudmZ4JOnAz5y9SIfPHaIB2kLL6aOsP6wcBe0D70uaZHdJ
 fm1A==
X-Gm-Message-State: AOAM53341wnN8Ki6vAimSWyVPaej8vg/uBtrZGVHmMDSOPfucOXskRvq
 HGN6vwYdq7R7FmuPFTv542PN57yamSyWQw==
X-Google-Smtp-Source: ABdhPJydTE9dj9tSzs5TMDXQoZgpV/pj2LPc5d3bjrKiDoDefA6rG6+eaawgZQb8gyrS3slVjxonjQ==
X-Received: by 2002:a62:bd05:0:b029:142:2501:3a02 with SMTP id
 a5-20020a62bd050000b029014225013a02mr4111892pff.81.1602100792321; 
 Wed, 07 Oct 2020 12:59:52 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id r14sm4005435pgm.7.2020.10.07.12.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 12:59:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10] scripts: Convert qemu-version.sh to qemu-version.py
Date: Thu,  8 Oct 2020 03:59:34 +0800
Message-Id: <20201007195934.297-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x434.google.com
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

Using v\\* on Windows and v* on other platform for matching version.
Tested under Ubuntu/msys2/mingw.

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
index 0000000000..063b3720f7
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
+import os, os.path
+import platform
+
+def main(_program, dir, pkgversion, version, *unused):
+    os.chdir(dir)
+    if not pkgversion and os.path.exists('.git'):
+        match_expression = 'v\\*' if platform.system() == 'Windows' else 'v*'
+        pc = subprocess.run(['git', 'describe', '--match',  match_expression,
+                            '--dirty', '--always'],
+                            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
+                            encoding='utf8', shell=False)
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


