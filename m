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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07069C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A146F2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhSvQxkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A146F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfuN-0001iJ-LK
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 11:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBftR-0001CX-L9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 11:02:17 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:55198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBftP-0002qZ-Js
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 11:02:17 -0400
Received: by mail-pj1-x102a.google.com with SMTP id mt12so611208pjb.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Raiid8L9PZEfLlzIJU5tjNJVrqSN1E40mgcYWH4rHNI=;
 b=NhSvQxkKmq02Qd3cwLzzSbb48z+ZF17uIZsXLGg0LX8v32iGpWqxzhtWZkO54jAvcQ
 UY96OwMSQo/o0kyms+v524o9cjy54J4S21EpFu9EIqY7fZP286Wnkpl01o+3xhQveORo
 H90nwwgIbZQ2Ex4Teq74iKd1/ClLrU8nOsZC5Llrvxb4J8DtwmD8pta5amWRT9VM/REK
 5B3FAECY/r0H3PQH6wC9nuObG8O6OiWHZfyj6zNWQO3l6Juw58fkAxWofbkcX8t4z4Zl
 LXVBYqM4CUhGQXrAeK2oKQNVZY8BjPfayRigJKAErffCAy9CYKzAWOV+hcMz4eZ/KuGG
 /sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Raiid8L9PZEfLlzIJU5tjNJVrqSN1E40mgcYWH4rHNI=;
 b=s5zN7RgHb92ZcgaGGXlnrBgYY0ggQ6uGqNHYr8A7StenYXFFqQ+920DLVqsspNFCZ5
 DtdIdUM5FxNFCd+AwA+K+g2Lp1br/lj2v3ov84TDsI2plV/Wo6g+SCtBPLKAy0sAbLH/
 CGT2CvXBqmRVM2NmgI0r5yT+uQx58es0XPMDzQjCk+CpisGcgl34rAJjLM7qTzY0K6vL
 YgiLL7eqQuU8fYkWnvw6dIxl8g7nnjKTbp3L1aC9Gr5OZRouFf0GH2VX9WoTTCzuqYp0
 hz9roZrxzrz4hQ697oRjCZPI8mtAeBXT0gPq6AL9hroHsAKnK/a+xpbw+J3s7kbUfUmJ
 6AJQ==
X-Gm-Message-State: AOAM533kmWoJzK1YSRTPmLM+4mfhshNSQlEXJv8f6o23/C5OJlkIND9v
 5UzpMUvFNly37JOqQzY4nG3+ubm+Oyco3A==
X-Google-Smtp-Source: ABdhPJxeifnkUd2ixJc7UtDVCp3HfpGCQspgp5KhDtKC+c1SKJHXzdegn/cGLGX3L4nvhh+JpH2swQ==
X-Received: by 2002:a17:902:c24a:: with SMTP id
 10mr1646753plg.83.1598626932568; 
 Fri, 28 Aug 2020 08:02:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 k5sm1508330pjl.3.2020.08.28.08.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 08:02:11 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Convert undefsym.sh to undefsym.py
Date: Fri, 28 Aug 2020 23:01:49 +0800
Message-Id: <20200828150149.1620-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Yonggang Luo <luoyonggang@gmail.com>

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


