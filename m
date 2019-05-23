Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F58EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7F220645
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaFtcPSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7F220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTubo-0007PY-Fk
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:46:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZn-00061J-IA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZj-0002zt-Q7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:33 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZi-0002yQ-De
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:31 -0400
Received: by mail-yb1-xb43.google.com with SMTP id w127so923166yba.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=LLAjkendyCCLXqfpTYsTCZfUvlnmPcJC9iKwt8jzfEU=;
	b=LaFtcPSz5Z7d4hOwdFL2n/TzIHXq5p+GaPfe0yaYBUzpPybqrLR0fGjaTayr2nLlvW
	TINZmupoiZV+6nIZiUO17KB1Dn8CGx1Qt7127YWYmOPeRFh+YX7kPib3A7y+NPC9b333
	0QgEyyeVZn1bprty/7RgnBaJUWAKEe7Fr3Kg/gxW5zzqnCFg/pKgwqGxDJ2ubHwx34QC
	325eVBnyilobLuqUe7BRiqr0ZPpWdjoIGlLDxTxFdpi4Yn49uEf1eERc3FtYvoiIBUFS
	0Ebi/psNYxS+ND1dNU/kDiUbY9pokLmuu+IzmGkpfxL0ROcthVsbJ3x1UhJiyrFQMnR0
	u2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LLAjkendyCCLXqfpTYsTCZfUvlnmPcJC9iKwt8jzfEU=;
	b=U7f5O3aV3TuJAQUaWvH5m745rIm8Qu+mBDkMdNGhFiiFwqi70YM//0IdcCJch2uj1H
	kf6Lw0pVNEqJ/bLh4Jp0dPAJncqKPSC2xsv/3EvARXzl8UeYhpVC2RP78/Swbn+idCaK
	ad8SbpfBrEFgbdjgdhUN7TnMKoSjZJopWXkNe9CR3bO7eHRpJZuc2tCOfmlrO2/gnAoO
	pXEKis32hNppAqgJAwF4gxeCZBxv0B8oDfozf9Mh5bcycVJDsy9IBth8hDJ/7YlMQEkn
	4Ggt5l3kkCTl8ppHBDc/aXYzhTVvVk8rz7tXhwJiweE3ZUhbiekphTZc9d5NJY6RbSWo
	CmxQ==
X-Gm-Message-State: APjAAAW3SDlteSgXz0CTc1El1LwUV5TIAsnjkEWXpPLOPUXS6qdxEzsx
	LIq+EdQbPwFrjxX5nmoaz3FVnMbR
X-Google-Smtp-Source: APXvYqzALE5y5yGNAofxJf8PgYr8o7vfs37hmxplafbF8QNX+ay07rxUSYIj85cShjhAZ5HykEqpRw==
X-Received: by 2002:a25:cac6:: with SMTP id a189mr1069901ybg.74.1558644269385; 
	Thu, 23 May 2019 13:44:29 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:28 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:01 -0400
Message-Id: <20190523204409.21068-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RISU v3 03/11] risu_i386: move reginfo-related code
 to risu_reginfo_i386.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to build risu successfully for i386, we need files
risu_reginfo_i386.{h,c}; this patch adds the latter by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c         | 54 -----------------------------------
 risu_reginfo_i386.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 54 deletions(-)
 create mode 100644 risu_reginfo_i386.c

diff --git a/risu_i386.c b/risu_i386.c
index 6798a78..2d2f325 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -33,43 +33,6 @@ void advance_pc(void *vuc)
     uc->uc_mcontext.gregs[REG_EIP] += 2;
 }
 
-static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
-{
-    int i;
-    for (i = 0; i < NGREG; i++) {
-        switch (i) {
-        case REG_ESP:
-        case REG_UESP:
-        case REG_GS:
-        case REG_FS:
-        case REG_ES:
-        case REG_DS:
-        case REG_TRAPNO:
-        case REG_EFL:
-            /* Don't store these registers as it results in mismatches.
-             * In particular valgrind has different values for some
-             * segment registers, and they're boring anyway.
-             * We really shouldn't be ignoring EFL but valgrind doesn't
-             * seem to set it right and I don't care to investigate.
-             */
-            ri->gregs[i] = 0xDEADBEEF;
-            break;
-        case REG_EIP:
-            /* Store the offset from the start of the test image */
-            ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
-            break;
-        default:
-            ri->gregs[i] = uc->uc_mcontext.gregs[i];
-            break;
-        }
-    }
-    /* x86 insns aren't 32 bit but we're not really testing x86 so
-     * this is just to distinguish 'do compare' from 'stop'
-     */
-    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
-}
-
-
 int send_register_info(int sock, void *uc)
 {
     struct reginfo ri;
@@ -100,23 +63,6 @@ int recv_and_compare_register_info(int sock, void *uc)
     return resp;
 }
 
-static char *regname[] = {
-    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
-    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
-    "CS", "EFL", "UESP", "SS", 0
-};
-
-static void dump_reginfo(struct reginfo *ri)
-{
-    int i;
-    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
-    for (i = 0; i < NGREG; i++) {
-        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
-                ri->gregs[i]);
-    }
-}
-
-
 /* Print a useful report on the status of the last comparison
  * done in recv_and_compare_register_info(). This is called on
  * exit, so need not restrict itself to signal-safe functions.
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
new file mode 100644
index 0000000..e8d671f
--- /dev/null
+++ b/risu_reginfo_i386.c
@@ -0,0 +1,68 @@
+/*******************************************************************************
+ * Copyright (c) 2010 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Peter Maydell (Linaro) - initial implementation
+ ******************************************************************************/
+
+#include <stdio.h>
+#include <ucontext.h>
+
+#include "risu.h"
+#include "risu_reginfo_i386.h"
+
+static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
+{
+    int i;
+    for (i = 0; i < NGREG; i++) {
+        switch (i) {
+        case REG_ESP:
+        case REG_UESP:
+        case REG_GS:
+        case REG_FS:
+        case REG_ES:
+        case REG_DS:
+        case REG_TRAPNO:
+        case REG_EFL:
+            /* Don't store these registers as it results in mismatches.
+             * In particular valgrind has different values for some
+             * segment registers, and they're boring anyway.
+             * We really shouldn't be ignoring EFL but valgrind doesn't
+             * seem to set it right and I don't care to investigate.
+             */
+            ri->gregs[i] = 0xDEADBEEF;
+            break;
+        case REG_EIP:
+            /* Store the offset from the start of the test image */
+            ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
+            break;
+        default:
+            ri->gregs[i] = uc->uc_mcontext.gregs[i];
+            break;
+        }
+    }
+    /* x86 insns aren't 32 bit but we're not really testing x86 so
+     * this is just to distinguish 'do compare' from 'stop'
+     */
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
+}
+
+static char *regname[] = {
+    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
+    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
+    "CS", "EFL", "UESP", "SS", 0
+};
+
+static void dump_reginfo(struct reginfo *ri)
+{
+    int i;
+    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
+    for (i = 0; i < NGREG; i++) {
+        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
+                ri->gregs[i]);
+    }
+}
-- 
2.20.1


