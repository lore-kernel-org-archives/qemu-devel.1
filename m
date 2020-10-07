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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D24DC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C547D2076B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKsQUtbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C547D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQF9Z-0003Yq-EE
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQF8W-0002NT-TY; Wed, 07 Oct 2020 15:30:04 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:46527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQF8U-00086Q-9e; Wed, 07 Oct 2020 15:30:04 -0400
Received: by mail-pg1-x532.google.com with SMTP id 34so2076230pgo.13;
 Wed, 07 Oct 2020 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Irdtj8q1RD0LQlLWbA57KSRDKqcckx9crXDBvCEWy6o=;
 b=lKsQUtbZK/DO0Z3wVfDs8Btysz/qTPzOxk68evJw/G+V9OaSSZzRfRc6Q9fTbepWVN
 cX6iD7s+G4noHFIb/hcprSPuLmJW6S7923H/Ea2VZqARoVCxspV10TOVENAcEsJj6zCK
 c90vt1Vet8YQjutaSMvL/jVHS5kmp30A69s1Nzungt2G2XoHJNlPvKbPE8bdCsLbPFy/
 qq7gCwHO0JvAXVZxv63Q/c3r1I9eV/ZtYX4ThXCVzBOjrwAwm8cALuWTDh4BQs05iQDM
 SPRYjM+tbaCDPEp8kwdfgk2DFwVUJzDhNxRABW9GnWSOuVlQ1xPEqdpl1AAblkdLviKl
 mW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Irdtj8q1RD0LQlLWbA57KSRDKqcckx9crXDBvCEWy6o=;
 b=bbkcu7R2h6XEbuCWM9AyCd3MpX7IzSWg6INkI53GngsP5GoBsJK0Kbx6IEOxlmjhHt
 PJJG6hWcLO4tm+0z/2bC4e39t70z3Elfc/hQpUTZbZHFWJzQwy3pMSz/m/YESWeZ3e2r
 mItPXOT1TFqterBBz6v4fnIu4qQ2stdp30/wyc2f4bopU9itOsha4wr7Xtbvn2YhAkgc
 zN5CzfdLgWNijNEGk1TOmwnaeFuGHJjiBR6j71f97qzEcrkFE4JRWQ7+gwDZVTkBxS3H
 u939utKoXMVvuTeOwsx6oXfTXyyreWvn+A/fWj29ttc93cCga3BrboK/c0CpoO38/EpZ
 //hQ==
X-Gm-Message-State: AOAM532SMsGc8D1Hhe9JthR+0n3fEUNMUwdqtbP3t+/ef07lHMWOUcSo
 kt3jBPtwV5F8SMDGlpv5NMVZCy+vet4LAQ==
X-Google-Smtp-Source: ABdhPJzbDrktx04Y6h0y8NbnZLEe2lUBZrYMVhJA5Q5axeh5ucEvy3oGPYkqVkWe3GTU26PrtqWu3A==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr4466327pgv.271.1602098999458; 
 Wed, 07 Oct 2020 12:29:59 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id q15sm4397797pgr.27.2020.10.07.12.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 12:29:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7] scripts: Convert qemu-version.sh to qemu-version.py
Date: Thu,  8 Oct 2020 03:29:40 +0800
Message-Id: <20201007192940.280-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x532.google.com
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
Using --match=v* instead of --match 'v*' for speed up the git version
retrieve, and also resolve the Windows wildcard match problem. only when the
.git parallel folder have filenames start with --match=v such as --match=v123
would cause issue, and that's rare.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201006112139.700-1-luoyonggang@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build             |  2 +-
 scripts/qemu-version.py | 33 +++++++++++++++++++++++++++++++++
 scripts/qemu-version.sh | 25 -------------------------
 3 files changed, 34 insertions(+), 26 deletions(-)
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
index 0000000000..52b23ceb01
--- /dev/null
+++ b/scripts/qemu-version.py
@@ -0,0 +1,33 @@
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
+        pc = subprocess.run(['git', 'describe', '--match=v*', '--always'],
+                            stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, encoding='utf8', shell=False)
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


