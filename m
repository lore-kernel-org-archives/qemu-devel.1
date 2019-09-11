Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15732C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F7B20838
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 16:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ff+00vDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F7B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i85qw-0000Jr-J6
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 12:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i85ol-0006Wb-Lp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i85ok-0004AU-67
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i85oj-00049a-Rz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 12:50:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id q18so4306269wmq.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AP1T2XSjOl2lJh+/fDSQgEAsr5iAzl9ejFzzWbjY7Ww=;
 b=Ff+00vDxm782CQz2NYha0vGGnSqPvqMC1mrq5f3BS497P9RqA0L6hs3rFIs6J2A3z5
 kwXN5pdHvH7xeLNOcuo+oQ+4lZApbgi2KqaB674LAq/FC7MZqQLetoG2u6JFjLAJegzJ
 bN3BEdt7K/dk7Pc3TuWVfBBMc19/52AFUZnKVS+sk/cOtCj+2QoWcr/hb+TJng0Qj/o4
 p9DYSwmUaOEVZsVD3pSZwTt7KJ4nryBWHr6NklmmJPjpqUrSntWLS8zAHKxa8Ce/CDO5
 JpFzCKug0mCtyNsu1FbHc92g7kLTRDtDn1RPukSG2rBfWFHSQAg6Cggwbdo9vviAcS/x
 OUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AP1T2XSjOl2lJh+/fDSQgEAsr5iAzl9ejFzzWbjY7Ww=;
 b=b3SeBKUonriVF32AGoo6/XIu7y0k05GnwtVcg2S/gVVwBUUQGsNNbjD0eGt3YQKbYQ
 MgcgZ+JkGfYWL3kWwpakFVidJ8CYIwd9DwtjQKKc5ihfQ8Q9TMn3ePxChRlYs8EI1URJ
 VX3TpV3zoxi+XepYb/m8JEAIYGet1EEMxAcfEbHAgaHmg3QxaanCPNjDqdgIAW/Pegcb
 e0NRiEC/xM2+Hqn1H7NjTeRJd2sYfxsD3Qa5pRTKXvG55H8s5vvvZxcI8IlAcqz6BDMg
 F7B/zBTXw+BSaNdcZ1FyIIXKCkSi6/Lt8Zc0gLKXMlCWu7Sps4kSfu1neo1pf4XZvQYL
 VSLg==
X-Gm-Message-State: APjAAAV2KRSH9DA47G9wBxnPM2iOhu4oNMhJrmq+x6SbA+Yv0FTwnra9
 2VYm2pTSzGfDbg0tD0K4dy2nqrBzjD0=
X-Google-Smtp-Source: APXvYqyeRSp9TG3FBnrSHlHbwtYm2DADlMAwRSpogk19p0AskfsfA1BN2+cFgthP1wjiBpbsquthCw==
X-Received: by 2002:a05:600c:293:: with SMTP id
 19mr4466815wmk.37.1568220604685; 
 Wed, 11 Sep 2019 09:50:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a7sm25915726wra.43.2019.09.11.09.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 09:50:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D3B691FF92;
 Wed, 11 Sep 2019 17:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 11 Sep 2019 17:49:59 +0100
Message-Id: <20190911164959.11003-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190911164959.11003-1-alex.bennee@linaro.org>
References: <20190911164959.11003-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v5 5/5] target/arm: remove run-time semihosting
 checks for linux-user
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we do all our checking at translate time we can make cpu_loop a
little bit simpler. We also introduce a simple linux-user semihosting
test case to defend the functionality. The out-of-tree softmmu based
semihosting tests are still more comprehensive.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/arm/cpu_loop.c         |  3 ---
 linux-user/arm/target_syscall.h   |  3 ---
 tests/tcg/aarch64/Makefile.target |  5 ++++
 tests/tcg/arm/Makefile.target     |  5 ++++
 tests/tcg/arm/semihosting.c       | 45 +++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/arm/semihosting.c

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 8d65de5b9f4..e28c45cd4ab 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -325,9 +325,6 @@ void cpu_loop(CPUARMState *env)
 
                 if (n == ARM_NR_cacheflush) {
                     /* nop */
-                } else if (n == ARM_NR_semihosting
-                           || n == ARM_NR_thumb_semihosting) {
-                    env->regs[0] = do_arm_semihosting (env);
                 } else if (n == 0 || n >= ARM_SYSCALL_BASE || env->thumb) {
                     /* linux syscall */
                     if (env->thumb || n == 0) {
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index afc0772e194..f85cbdaf56f 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -18,9 +18,6 @@ struct target_pt_regs {
 #define ARM_NR_set_tls	  (ARM_NR_BASE + 5)
 #define ARM_NR_get_tls    (ARM_NR_BASE + 6)
 
-#define ARM_NR_semihosting	  0x123456
-#define ARM_NR_thumb_semihosting  0xAB
-
 #if defined(TARGET_WORDS_BIGENDIAN)
 #define UNAME_MACHINE "armv5teb"
 #else
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


