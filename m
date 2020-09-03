Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F91C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6D9205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+/m3NZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6D9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkgP-0000ql-Md
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfA-0007i5-Sr
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:46232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkf8-0001Vy-Tu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id b124so1698366pfg.13
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=khVmfuvTdyvS7QBmYXBUkXeRmJb4FrO0KFERex1f1TA=;
 b=U+/m3NZNlc1pfFZqoLNgskTiXKs1ZMecZI8gDN4POkgRjXmlTndGM+9P+DVVagEME7
 t4shwbNJqU8Tt7W2hoEBztuYQrfFrcj2WhRoYz8qDeP9qTaMm0DQqTFjeGUy7lb+KTDT
 6rlDbA6BhIlJquJzJo3kUI4ANH1q7Xkvp7JTcBNOafsu+RUtRTtlDuUuJ/PadS7F+RQb
 I8WOHxh2VZJN+PkiSBD92w7aIm0WG2vd6agC2lrc/a9voUTKFRR479NlwJaAgWmBGDwA
 WBeL05pLEEfKhcfECdD2roHkKguUhWbL1av6W73w/mEKqcl+3h3V7tLVkH6OtT2Vtsb+
 4atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=khVmfuvTdyvS7QBmYXBUkXeRmJb4FrO0KFERex1f1TA=;
 b=Kc2EXtLIuVKNIEp8KM6Ef5KRKVFiFvMl0TnVHzYKVm9/dl3xAFt6YBWHxfblHmEjo/
 GOPn0lF1NmplAx88G+k+STI9uYis1sqJGto9xEqmJ4dMRDITU98LeVxowEpev63u/XSB
 G6ksSlf+UP6XKimqHzj61g0JXsci5JWtXx2Kx2segJ6yrHQYzm1nIOukq094Yi7Gh77Y
 0XSHs4fDUnhEBingDThE+rMwNOsEc4bXBHAgPplW+gquge+98/rMQNF25RQmyHOtrFo5
 cMyBmXauTitcx+anMB5Z+ZvLnNfLhld4vJa0KuH/OT1IaXvHFa2Ve79nTF7b8M2mIi/0
 67Dw==
X-Gm-Message-State: AOAM533Vjy6tC4OpnrDaCZcoGmcLXunXCQWkbdTtZ6D4i0hk/BxWAcGd
 eSSSn1b3wo22ITJPQtDfSyDlwLcJAKGetvO/
X-Google-Smtp-Source: ABdhPJwY/tnEQnLIL6ZjcD6ACzS5uXb0RnWsMY51Lc8iOjPswnrWRhF7vOrCsBSpjh3b0RVd9Ug0uQ==
X-Received: by 2002:a17:902:bc44:: with SMTP id
 t4mr1984703plz.77.1599121924811; 
 Thu, 03 Sep 2020 01:32:04 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/12] meson: Convert undefsym.sh to undefsym.py
Date: Thu,  3 Sep 2020 16:31:37 +0800
Message-Id: <20200903083147.707-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x432.google.com
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
 scripts/undefsym.py | 57 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/undefsym.sh | 20 ----------------
 3 files changed, 58 insertions(+), 21 deletions(-)
 create mode 100644 scripts/undefsym.py
 delete mode 100755 scripts/undefsym.sh

diff --git a/meson.build b/meson.build
index 55c7d2318c..c9f5d05664 100644
--- a/meson.build
+++ b/meson.build
@@ -863,7 +863,7 @@ foreach d, list : modules
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
2.28.0.windows.1


