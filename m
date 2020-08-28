Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CCAC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC9F2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDTVkwow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC9F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBf63-0002qO-VO
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBf5P-0001y8-W0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:10:36 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:55904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBf5O-0003mk-3s
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:10:35 -0400
Received: by mail-pj1-x102f.google.com with SMTP id 2so544917pjx.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6qCNOdMxmqe+iIT4o+pq/rSQOvYLdMUa0vzVTaAuPpI=;
 b=pDTVkwowmCYqetBbzWXTFR1BKIWwUkISZHGefXKu5aXjC+EG1YE8BYr7gXMZ1zI9A4
 ZsJkq6+N/xUz40uYIhOEDZkGtb6zzt9ygNRmtDgE8i4x3MI3GvLG/kJvK7IOrF1pQcQ/
 80diAY2vBjVs+T78dFwMtCxXbsO04pCs5disFjDPG/Zydgsowl9q9/VCEnzgzHr6zZQ2
 s9KDpb3QASymuvanzZDGJj+Prz+n0bCTURGV4OQ/NgaJxr8MA6bqCRYM7zPZ7WDABlQi
 ehf8Ce4Y9BNVVxG/+tIkIH2sajbjGqHIyHFoaAWGfM+QBDGFznWFkTS0Jfx6SdFvVojP
 FcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6qCNOdMxmqe+iIT4o+pq/rSQOvYLdMUa0vzVTaAuPpI=;
 b=mw55eoJC+f7D0I6SwhF001VBf+srSf1Pcp59su/JdJBlCmxJtXPlYmFLQP6GqBi49/
 Ru/mQDLrVWuldHidAsYq+KTWq9YgLvSTkvhCvYheygI+UQcc5bSnFYUxlGjdchvXM9ru
 kExg7prFXeuEvgcneX+hPxI0a+rw/ThlXq/kTAHkk9NqEpbmpDNuB4JSQuh4qZRHet4I
 FXtxUtqGzsv5lY2/H8xRz1B1FP53Gf4yCWjRiSeC2Ab2N/LorGSEg/AtOXNxpHw+QVuu
 3qdIzGLokNjmytAWfi+vPhaHbZVFlKyrMxgOjPF8O+RNKOez2eZUA59dV5bT+EB0RDCJ
 ruTw==
X-Gm-Message-State: AOAM532U0dvuTvAUYve/yKT+vMdgdIRTm/7IkaYahhN3w7ZEfW4ag7bg
 6HyGmj8EjJtagR/qCsO49f+A4kEP9sgw+g==
X-Google-Smtp-Source: ABdhPJzjBww1eWnWc4et25Z/IMKRoZa5UceczcQWniKdgrZcxVQl+WFTrA9+ZFVmekhPWMOHgZg3fw==
X-Received: by 2002:a17:90a:13c4:: with SMTP id
 s4mr1366041pjf.141.1598623831985; 
 Fri, 28 Aug 2020 07:10:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id w28sm1953440pfj.161.2020.08.28.07.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:10:31 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Convert undefsym.sh to undefsym.py
Date: Fri, 28 Aug 2020 22:10:11 +0800
Message-Id: <20200828141011.1434-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102f.google.com
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


