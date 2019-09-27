Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04FFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A14217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDfRd8td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A14217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtfl-0002BM-Ko
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSb-0002UT-VN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDrSZ-00088g-VS
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDrSX-00087a-Tg
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:43:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id o18so3092039wrv.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BR1l/kb7RCqMIzZS6liikc0EeB/atePwZNIFCHsVMo4=;
 b=IDfRd8tdXDE/PeflYl46dK3AJGVjDZrcZdPI4PZpSy80Qt3uLq+lILw1xVh95CIV3p
 yuwtp+GoLSdCSEl1oud8sfqvPgPqfYKHWjMnZY3ZrSp3rOWOO14Q6H++sW5gZA2vI/K8
 MQZOjgq7zXD7Dwjj5QhXCudYzn1jaDRYjP14RUzzCEcB69jCznMpbVtaOnWwEt6sRNyn
 XPfhMpt/tMzhk41eau0w7a0Mi9WgaKSBa2n8fHlgOBfjttV5NQaHC/7m/uVnx9iPP0tx
 TlnI771jRB5ce14K+RuvAZ6baNFJIRq9uHWxObieo+qD5qVY1/Znse8KvCvi5lAxriJ/
 n4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BR1l/kb7RCqMIzZS6liikc0EeB/atePwZNIFCHsVMo4=;
 b=H82vr6/0dDQqZ+DkCp94TYKzBLfQDQcglXvcEhF72hrTAjtvlufiRurClmUavTpkmC
 s834R1R65qsv62uhHVOpsV0zOkEoU3Yrfz41OC3wE6Gl0NIsDAfluUbniQ4OucswM4ht
 SKV7xog4wAr66nTFWsTav6QcT2BtjeFfclhWa5zfxUJx5X9Fuh8CgwpIvsF4ToFDDKuk
 bBISaPvyFM4efyiMDcHkGPRfqEJMQZC4VNzwKo3wLcz6xgLi5zu7Blbu/y5560udenZf
 p0cJcJYd54JGltvIqwv0rmrNEpAnD5OxYYAIX32QBkVOnwNZxjBO9m4aMhGWVy21viy8
 BMGg==
X-Gm-Message-State: APjAAAV3A3dZWFlh2+Ko8a9/9S88o8Vqndycoz5nYGi5o/yYyf80HVIn
 NH8T/hvXsv31xJXS3tpNYDTRgeoVgvf1lA==
X-Google-Smtp-Source: APXvYqwjE4lrmU2e9aIAKjYtEPcxW+q7o6NZzz2CHbi3MU0+Cx/lQYthuwSOmqNwcFVKRG/gkb/Uxg==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr7469172wmi.151.1569595378567; 
 Fri, 27 Sep 2019 07:42:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y12sm2874539wrn.74.2019.09.27.07.42.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 07:42:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] tests/tcg: add linux-user semihosting smoke test for ARM
Date: Fri, 27 Sep 2019 15:42:47 +0100
Message-Id: <20190927144249.29999-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927144249.29999-1-peter.maydell@linaro.org>
References: <20190927144249.29999-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

We already use semihosting for the system stuff so this is a simple
smoke test to ensure we are working OK on linux-user.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190913151845.12582-7-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  5 ++++
 tests/tcg/arm/Makefile.target     |  5 ++++
 tests/tcg/arm/semihosting.c       | 45 +++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 tests/tcg/arm/semihosting.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 9758f89f905..509f1afa93d 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -21,4 +21,9 @@ run-fcvt: fcvt
 AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU_OPTS += -cpu max
 
+# Semihosting smoke test for linux-user
+AARCH64_TESTS += semihosting
+run-semihosting: semihosting
+	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
+
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 7347d3d0adb..3b7fc9a64be 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -27,6 +27,11 @@ run-fcvt: fcvt
 	$(call run-test,fcvt,$(QEMU) $<,"$< on $(TARGET_NAME)")
 	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
 
+# Semihosting smoke test for linux-user
+ARM_TESTS += semihosting
+run-semihosting: semihosting
+	$(call run-test,$<,$(QEMU) $< 2> $<.err, "$< on $(TARGET_NAME)")
+
 TESTS += $(ARM_TESTS)
 
 # On ARM Linux only supports 4k pages
diff --git a/tests/tcg/arm/semihosting.c b/tests/tcg/arm/semihosting.c
new file mode 100644
index 00000000000..09c89cb481a
--- /dev/null
+++ b/tests/tcg/arm/semihosting.c
@@ -0,0 +1,45 @@
+/*
+ * linux-user semihosting checks
+ *
+ * Copyright (c) 2019
+ * Written by Alex Bennée <alex.bennee@linaro.org>
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#include <stdint.h>
+
+#define SYS_WRITE0      0x04
+#define SYS_REPORTEXC   0x18
+
+void __semi_call(uintptr_t type, uintptr_t arg0)
+{
+#if defined(__arm__)
+    register uintptr_t t asm("r0") = type;
+    register uintptr_t a0 asm("r1") = arg0;
+    asm("svc 0xab"
+        : /* no return */
+        : "r" (t), "r" (a0));
+#else
+    register uintptr_t t asm("x0") = type;
+    register uintptr_t a0 asm("x1") = arg0;
+    asm("hlt 0xf000"
+        : /* no return */
+        : "r" (t), "r" (a0));
+#endif
+}
+
+int main(int argc, char *argv[argc])
+{
+#if defined(__arm__)
+    uintptr_t exit_code = 0x20026;
+#else
+    uintptr_t exit_block[2] = {0x20026, 0};
+    uintptr_t exit_code = (uintptr_t) &exit_block;
+#endif
+
+    __semi_call(SYS_WRITE0, (uintptr_t) "Hello World");
+    __semi_call(SYS_REPORTEXC, exit_code);
+    /* if we get here we failed */
+    return -1;
+}
-- 
2.20.1


