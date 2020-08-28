Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B4DC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B0120848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/A5vw4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B0120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBh0w-0002Hh-OM
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBh0S-0001rc-6j
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:13:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:35316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBh0Q-00057L-6A
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:13:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id a8so722578plm.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oZaeswpJOkAYWW64CE00h0yyCcwswmAdqZ+vJSz4/Oo=;
 b=t/A5vw4gfPmKMtfADq9fEnXMvdvvk4fxH2UX0jO4+gGDH1sBTtLTcgiawFWRB+FqAG
 mQy6yWewwMOip08/KiRLhN179BIQGc5lIea+bXF294CO0aePWZLPYn1BeUYlJXt3Wljb
 NMrYCuDqfXRk5ht/AdmEKruKQROdBUPcXkpRwZTlxrutVNf5JBchgJLPB6Gj/FSXRKnN
 C1Zsos4GRnGakQPA8gvGm8MoJo80tsOKMdbgFnYi126FYXZfqSY/SC86UxCZfAFAvx7V
 5aIloSycjMsL6ZDrENcqVm0c3jcULRWzw6ywgulhw1ULHBnwzHjbulXYXCrSP7QuUTdX
 t7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oZaeswpJOkAYWW64CE00h0yyCcwswmAdqZ+vJSz4/Oo=;
 b=Oj/QWIa36pf+v1JiqRZRCiF4PKdXLgCn6Tzg41nfDM+yp89ngTZj46bmWYTRET0gSP
 CBNBkZbuIch7WkkEzeedJ35nzzBXPK1FMNv4+oNDW9Yx2HD67xGlNJGYxRiIrezFIeRF
 LngCngZ4pt5vyeVu9vHgrChhck3qAI9mLTwAjEPFXWKsuH1jqEFN7ohVJ5kJ1MXpW4JJ
 nbX2MHitU+7QV604o+wdi8fWYcTCs88nmodAFY9J+1iUBmfHf16e6TcjL76muyBS24Mr
 ezKaRbJ9L0T+npcYSNQLNGSO83IbsdWeBtrZ6dhqpavIQX75lf5UpvXQmjdKcwkm5SFH
 Qp+Q==
X-Gm-Message-State: AOAM530F0aoyTf8nhJZJb5gQu5Gb8YKqp/QWM/iPdi4rS7AMDNhUnP01
 uY1BtbwPyQNn+XdjP+ETroXP7lKaERkiCcJS
X-Google-Smtp-Source: ABdhPJxwDdgwM5fQWm6pGPspLKvdxgOHmiGSE8aoSAnU1Or/9bHgJRHqosu+tzHkLnXLv3F536msWA==
X-Received: by 2002:a17:90b:3113:: with SMTP id
 gc19mr2009178pjb.120.1598631212195; 
 Fri, 28 Aug 2020 09:13:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 u123sm2208498pfb.209.2020.08.28.09.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 09:13:31 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] meson: Convert undefsym.sh to undefsym.py
Date: Sat, 29 Aug 2020 00:13:15 +0800
Message-Id: <20200828161315.193-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x631.google.com
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

undefsym.sh are not msys2 compatible, convert it to python script

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build         |  2 +-
 scripts/undefsym.py | 70 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/undefsym.sh | 20 -------------
 3 files changed, 71 insertions(+), 21 deletions(-)
 create mode 100644 scripts/undefsym.py
 delete mode 100755 scripts/undefsym.sh

diff --git a/meson.build b/meson.build
index 74f8ea0c2e..9d8419bf82 100644
--- a/meson.build
+++ b/meson.build
@@ -859,7 +859,7 @@ foreach d, list : modules
 endforeach
 
 nm = find_program('nm')
-undefsym = find_program('scripts/undefsym.sh')
+undefsym = find_program('scripts/undefsym.py')
 block_syms = custom_target('block.syms', output: 'block.syms',
                              input: [libqemuutil, block_mods],
                              capture: true,
diff --git a/scripts/undefsym.py b/scripts/undefsym.py
new file mode 100644
index 0000000000..90ee31ab69
--- /dev/null
+++ b/scripts/undefsym.py
@@ -0,0 +1,70 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+#
+# Static library and shared library compare utility
+#
+# Authors:
+#  Yonggang Luo <luoyonggang@gmail.com>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+import sys
+import subprocess
+
+# Before a shared module's DSO is produced, a static library is built for it
+# and passed to this script.  The script generates -Wl,-u options to force
+# the inclusion of symbol from libqemuutil.a if the shared modules need them,
+# This is necessary because the modules may use functions not needed by the
+# executable itself, which would cause the function to not be linked in.
+# Then the DSO loading would fail because of the missing symbol.
+
+def filter_lines_set(stdout, is_static = True):
+    lines_set = set()
+    for line in stdout.splitlines():
+        tokens = line.split(b' ')
+        if len(tokens) >= 1:
+            if len(tokens) > 1:
+                if is_static and tokens[1] == b'U':
+                    continue
+                if not is_static and tokens[1] != b'U':
+                    continue
+            new_line = b'-Wl,-u,' + tokens[0]
+            if not new_line in lines_set:
+                lines_set.add(new_line)
+    return lines_set
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


