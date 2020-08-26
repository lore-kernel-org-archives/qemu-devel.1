Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862D9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561152078A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiCEUSwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561152078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxad-0001R3-Lu
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxYL-0007bF-Jf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:41:33 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:43787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxYJ-00089L-Id
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:41:33 -0400
Received: by mail-pg1-x52e.google.com with SMTP id d19so1209568pgl.10
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hAIHaNoFAufwAGE6KbRmUZ0ExbibwWjhonjd/BMqxdQ=;
 b=tiCEUSwTb4lutc380xrVVsX/NF8y1hyMUMDKq8YSjm51dVaL6Q9SbRFBZbYSpGfyD6
 qVkEErxJEA3WoR0JC9LyB3rhN2EZW76oslYSmVtXocIr/uc0SNtuosOKw0WH/F2Bp2Sm
 ve3QQ8nVdTbn+vk3BrXHDw2KDu5p+T0IYWR1VHSrjfd1OfGcOchEzDZ2m0kvxwuoFbfX
 MoYRGVPcKWKN90DyEIrvad/DFaU8ZIZpcM7GDdToJH2BO6XBUhxMHeVRMOzVlpxZ4brC
 VpCZzOJKuVjKs7+JVzgS4Den7orfBFwPFgwIGKtJorWx2An/OEjEPdWU+TxA9chyW5/Q
 rDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hAIHaNoFAufwAGE6KbRmUZ0ExbibwWjhonjd/BMqxdQ=;
 b=DQyGKaf1dop2yGlWJnqpbUWROAiWLZb421sqqu/rzjuuX97iF9qM09UpeTxDs3dFBX
 oBcr3w8R6kU1Ece2s+iEmJo38aX7brfaPQraYY+agujMLRFB+vIaCxuuAKqTqai8nter
 7iXk9QCCvobTQA3mJ/B4Dh6JCwR+EqL0ddAfYLoGZ+8lUlPYmviF43getJV/JOtTFGfV
 Z1yTURDZfSuRJ2Co9Dk/lh0lSo08IDncBaMHrleXGSI1cDC99i693N9KHsJ1YW1h4zXP
 Dy4eydaFXB52zYb/dsS9f7x0hOUr3r/Qeo9odmu7mh0IchtnaiIo1u6oKq3qLjyNGLhe
 VjDQ==
X-Gm-Message-State: AOAM532huO2s8huAJ1MRcdk+iyWC5lSCkiCYNVAetCeqRV9NaRq4NCRJ
 X8gxDnjVbxcBMu1j4g79K+YZDyk8fQv4dK6h
X-Google-Smtp-Source: ABdhPJzIQc4KgF5IJxSHtpIYJrurwn7TSN4LWeJWdrP1wKIw0RbxLKmUQ/Ime+coOEnmn1EImk6V4A==
X-Received: by 2002:a63:ea41:: with SMTP id l1mr11279578pgk.419.1598456489276; 
 Wed, 26 Aug 2020 08:41:29 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 u21sm2566987pjn.27.2020.08.26.08.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 08:41:28 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6] meson: Convert undefsym.sh to undefsym.py
Date: Wed, 26 Aug 2020 23:41:04 +0800
Message-Id: <20200826154104.1636-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

undefsym.sh are not msys2 compatible, convert it to python script

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build         |  2 +-
 scripts/undefsym.py | 57 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/undefsym.sh | 20 ----------------
 3 files changed, 58 insertions(+), 21 deletions(-)
 create mode 100644 scripts/undefsym.py
 delete mode 100755 scripts/undefsym.sh

diff --git a/meson.build b/meson.build
index 1644bbd83c..d6e3bcea7e 100644
--- a/meson.build
+++ b/meson.build
@@ -845,7 +845,7 @@ foreach d, list : modules
 endforeach
 
 nm = find_program('nm')
-undefsym = find_program('scripts/undefsym.sh')
+undefsym = find_program('scripts/undefsym.py')
 block_syms = custom_target('block.syms', output: 'block.syms',
                              input: [libqemuutil, block_mods],
                              capture: true,
diff --git a/scripts/undefsym.py b/scripts/undefsym.py
new file mode 100644
index 0000000000..c690f88c7a
--- /dev/null
+++ b/scripts/undefsym.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+# Before a shared module's DSO is produced, a static library is built for it
+# and passed to this script.  The script generates -Wl,-u options to force
+# the inclusion of symbol from libqemuutil.a if the shared modules need them,
+# This is necessary because the modules may use functions not needed by the
+# executable itself, which would cause the function to not be linked in.
+# Then the DSO loading would fail because of the missing symbol.
+
+
+"""
+Compare the static library with the shared module for compute the symbol duplication
+"""
+
+import sys
+import subprocess
+
+def filter_lines_set(stdout, is_static = True):
+    linesSet = set()
+    for line in stdout.splitlines():
+        tokens = line.split(b' ')
+        if len(tokens) >= 1:
+            if len(tokens) > 1:
+                if is_static and tokens[1] == b'U':
+                    continue
+                if not is_static and tokens[1] != b'U':
+                    continue
+            new_line = b'-Wl,-u,' + tokens[0]
+            if not new_line in linesSet:
+                linesSet.add(new_line)
+    return linesSet
+
+def main(args):
+    if len(args) <= 3:
+        sys.exit(0)
+
+    nm = args[1]
+    staticlib = args[2]
+    pc = subprocess.run([nm, "-P", "-g", staticlib], stdout=subprocess.PIPE)
+    if pc.returncode != 0:
+        sys.exit(-1)
+    lines_set_left = filter_lines_set(pc.stdout)
+
+    shared_modules = args[3:]
+    pc = subprocess.run([nm, "-P", "-g"] + shared_modules, stdout=subprocess.PIPE)
+    if pc.returncode != 0:
+        sys.exit(-1)
+    lines_set_right = filter_lines_set(pc.stdout, False)
+    lines = []
+    for line in sorted(list(lines_set_right)):
+        if line in lines_set_left:
+            lines.append(line)
+    sys.stdout.write(b'\n'.join(lines).decode())
+
+if __name__ == "__main__":
+    main(sys.argv)
diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
deleted file mode 100755
index b9ec332e95..0000000000
--- a/scripts/undefsym.sh
+++ /dev/null
@@ -1,20 +0,0 @@
-#! /usr/bin/env bash
-
-# Before a shared module's DSO is produced, a static library is built for it
-# and passed to this script.  The script generates -Wl,-u options to force
-# the inclusion of symbol from libqemuutil.a if the shared modules need them,
-# This is necessary because the modules may use functions not needed by the
-# executable itself, which would cause the function to not be linked in.
-# Then the DSO loading would fail because of the missing symbol.
-
-if test $# -le 2; then
-  exit 0
-fi
-
-NM=$1
-staticlib=$2
-shift 2
-# Find symbols defined in static libraries and undefined in shared modules
-comm -12 \
-  <( $NM -P -g $staticlib | awk '$2!="U"{print "-Wl,-u," $1}' | sort -u) \
-  <( $NM -P -g "$@" | awk '$2=="U"{print "-Wl,-u," $1}' | sort -u)
-- 
2.27.0.windows.1


