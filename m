Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE46C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA6020692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuzsxxqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA6020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCuq-0001ag-J8
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrR-0004qX-Pr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrM-0000ts-IP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:05 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipCrM-0000tP-Bf
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:03:00 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so3754292wru.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=13ZcuAVLK0Aa+lF09oRhBPxRKXVMthPAmhqkjcYOQ/g=;
 b=zuzsxxqFB4aKSiv+LnHFe36HHixGaqv3x9Wb4+Ksbh5vwWynzsIrjSpYlKY1H1Tcqx
 eBwJVYg7NJdgCVUUWnrWafeHMvZvYZLoR1U6/QpnIlmCSTUPtLs/zHzdr5JMPrMlspGF
 jNGnG5MaSfqz0bv7rel88RsSPUrZyRWZ0J5bBQ2R2FqiqzoIC6BDgn6ipPCi4U60iKg/
 K18W8kl0eMaliO8q+bQ08G27yCwL4nVUpIQoS+0ijquAdHJ+oRpFt8XWEnINtGeqSiZd
 Q/eXxA2xHurWBLzXkngLYE1Mcv28/mSqbi0lJ3Fgyn0rMyi/gNiBo7Xp5rBChUyqTkLr
 l0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=13ZcuAVLK0Aa+lF09oRhBPxRKXVMthPAmhqkjcYOQ/g=;
 b=K9Ejss/jssa4LfGV7lgDrk1rrD3tBdRStIpovKQLCPsUi+ukLdMytLQCKhKgZKKz1N
 RU65LvukI5La0PnWkFrce8H71F8hg1lPiGIEZrGJldZKxofSJdnFR0WnxEiaqkwgemnY
 8LV7BJ3J3CLwjWDXfV6Rf60QXRbJy54ZH09fn/+qFVSGvACyuSkuF1SbaGkbHt1ykcku
 l+w6RfrglIGk/n90i7RUJIwa6JfWIYieg6mKAgWDGcdSvasU6d9Lc201flPNCEreny3b
 Vpe/NZCs+/JF4E/0c8LnDIST6qeWL2Yu4XbPRaYUte8bAv8BkSAbIR6a+nIekJp4sNCU
 63kg==
X-Gm-Message-State: APjAAAXtb2grsfjQi/pGStTV0+gg84iB+3bkP4X65TD2naKZ5JmlrFB2
 H6ntzomPLJbk3oVSDKPR/pu0+Q==
X-Google-Smtp-Source: APXvYqzc9qLhYYEsmRj0hPKOqOU2axnOqgIUCSUcew2ds5sbIClQg3D+LwkcDEH1ryP3LLG8vOPRyQ==
X-Received: by 2002:adf:e984:: with SMTP id h4mr4917895wrm.275.1578495779318; 
 Wed, 08 Jan 2020 07:02:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c4sm4108167wml.7.2020.01.08.07.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 07:02:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FCF41FF92;
 Wed,  8 Jan 2020 15:02:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/6] tests/tcg: extract __semi_call into a header and expand
Date: Wed,  8 Jan 2020 15:02:51 +0000
Message-Id: <20200108150252.6216-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108150252.6216-1-alex.bennee@linaro.org>
References: <20200108150252.6216-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are two types of ARM semicall - lets test them both. Putting the
logic in a header will make re-using the functions easier later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/semicall.h      | 35 +++++++++++++++++++++++++++++++++++
 tests/tcg/arm/semihosting.c   | 21 +--------------------
 tests/tcg/arm/Makefile.target |  9 +++++++++
 3 files changed, 45 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/arm/semicall.h

diff --git a/tests/tcg/arm/semicall.h b/tests/tcg/arm/semicall.h
new file mode 100644
index 00000000000..d4f6818192d
--- /dev/null
+++ b/tests/tcg/arm/semicall.h
@@ -0,0 +1,35 @@
+/*
+ * Semihosting Tests
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#define SYS_WRITE0      0x04
+#define SYS_READC       0x07
+#define SYS_REPORTEXC   0x18
+
+uintptr_t __semi_call(uintptr_t type, uintptr_t arg0)
+{
+#if defined(__arm__)
+    register uintptr_t t asm("r0") = type;
+    register uintptr_t a0 asm("r1") = arg0;
+#ifdef __thumb__
+#  define SVC  "svc 0xab"
+#else
+#  define SVC  "svc 0x123456"
+#endif
+    asm(SVC : "=r" (t)
+        : "r" (t), "r" (a0));
+#else
+    register uintptr_t t asm("x0") = type;
+    register uintptr_t a0 asm("x1") = arg0;
+    asm("hlt 0xf000"
+        : "=r" (t)
+        : "r" (t), "r" (a0));
+#endif
+
+    return t;
+}
diff --git a/tests/tcg/arm/semihosting.c b/tests/tcg/arm/semihosting.c
index 09c89cb481a..33faac9916e 100644
--- a/tests/tcg/arm/semihosting.c
+++ b/tests/tcg/arm/semihosting.c
@@ -8,26 +8,7 @@
  */
 
 #include <stdint.h>
-
-#define SYS_WRITE0      0x04
-#define SYS_REPORTEXC   0x18
-
-void __semi_call(uintptr_t type, uintptr_t arg0)
-{
-#if defined(__arm__)
-    register uintptr_t t asm("r0") = type;
-    register uintptr_t a0 asm("r1") = arg0;
-    asm("svc 0xab"
-        : /* no return */
-        : "r" (t), "r" (a0));
-#else
-    register uintptr_t t asm("x0") = type;
-    register uintptr_t a0 asm("x1") = arg0;
-    asm("hlt 0xf000"
-        : /* no return */
-        : "r" (t), "r" (a0));
-#endif
-}
+#include "semicall.h"
 
 int main(int argc, char *argv[argc])
 {
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 0765f37ff04..41aa26f4e17 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -31,9 +31,18 @@ run-fcvt: fcvt
 
 # Semihosting smoke test for linux-user
 ARM_TESTS += semihosting
+semihosting: CFLAGS += -mthumb
 run-semihosting: semihosting
 	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
 
+ARM_TESTS += semihosting-arm
+semihosting-arm: CFLAGS += -marm
+semihosting-arm: semihosting.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+run-semihosting-arm: semihosting-arm
+	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
+
 run-plugin-semihosting-with-%:
 	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
 		-plugin $(PLUGIN_DIR)/$(call extract-plugin,$@) \
-- 
2.20.1


