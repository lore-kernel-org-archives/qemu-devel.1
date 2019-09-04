Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAC4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E20023401
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeOTZqfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E20023401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5TQv-00049x-Sw
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLm-0007AG-5v
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLf-0007Gq-Fr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5TLe-0007F9-SL
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id h7so19500881wrt.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zlpCkLPxW/plsVCAFKM/m8fldNY7IYpuz4hZ7EfXmKg=;
 b=eeOTZqfhp+fZCWHGhlEfoezZW0+2kDDeDLOAbfbYc0qJYMPscW29iQViYkH0GukIFl
 q1pq0YOX74QJSER1AyzBmI/oHm8/KPigWaei/6huZzIHFoiuh4nwJkOhArcREpVw+47U
 iXcuIiR2jHvEDEvr745+tNY+sfmCoEmt4DwRewgWM17oKfR61+SU6BU9WUXNtPULeVCI
 RI/WSkXhSA8Gj8i65fpIfGHBxe2saZ4UYX5AD7vR9ELd7EPClEDDoKJ2Dob6nwF7ALSV
 RMFMl8KpZazAbiDsnRjqWrKNL1n0oeJdhujyJwURMxQLfVfO8sRdDEBkkWmzNvLTysev
 4dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zlpCkLPxW/plsVCAFKM/m8fldNY7IYpuz4hZ7EfXmKg=;
 b=pwceHJmbscCRulKwuAXn9CSi5x2G2RxsZ9qQEcPaBTcghrGwAkOwQoe5yL6ScXs9/5
 IHvD6P3BIQPRbuF3gCazHCst29En21aoypSmKnWPSrkYfuyKlnL0vbvSlcjMWVz6dK8T
 Ekc6oQ+z/Niz1f8QMPF+SVCYEanPsWcTVQsH1unrRWcNZbC2rAIL2wGppWt//BgMOnzF
 TXdv/kwzMfsbobRyhtt6pDE2KSJuBruio93/HZd94+dQ1fcSBCM7+5q5c0l+7x2GJaRI
 EQCOnxEr6aug1qIyyLpqb+PpqaQi7ookxtQreZQiiH3aQojhlJLa3ja07sG1ZilYFQAP
 UHpA==
X-Gm-Message-State: APjAAAWw+iRopJWq6Jh3dNGGcXlDITX6tIKSK8jRmPKFkFQXVVsedBon
 PfIEca+j+teoZVW5HRC77gDDAA==
X-Google-Smtp-Source: APXvYqwQVjoH8hI29Q33t64FvtyLFiDXcfbgxQ5GiHUAYsBYriWU42Hcb27Ul6ZOYQ8+oHbJMnZrgA==
X-Received: by 2002:adf:a350:: with SMTP id d16mr31194562wrb.326.1567596073675; 
 Wed, 04 Sep 2019 04:21:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y72sm5097353wmc.26.2019.09.04.04.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:21:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6781E1FF91;
 Wed,  4 Sep 2019 12:21:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:21:07 +0100
Message-Id: <20190904112108.2341-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904112108.2341-1-alex.bennee@linaro.org>
References: <20190904112108.2341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 4/5] target/arm: remove run time semihosting
 checks
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we do all our checking and use a common EXCP_SEMIHOST for
semihosting operations we can make helper code a lot simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - fix re-base conflicts
  - hoist EXCP_SEMIHOST check
  - comment cleanups
v5
  - move CONFIG_TCG ifdefs
---
 target/arm/helper.c | 96 +++++++++++----------------------------------
 1 file changed, 22 insertions(+), 74 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 507026c9154..a87ae6d46a1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8339,88 +8339,32 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
                   new_el, env->pc, pstate_read(env));
 }
 
-static inline bool check_for_semihosting(CPUState *cs)
-{
+/*
+ * Do semihosting call and set the appropriate return value. All the
+ * permission and validity checks have been done at translate time.
+ *
+ * We only see semihosting exceptions in TCG only as they are not
+ * trapped to the hypervisor in KVM.
+ */
 #ifdef CONFIG_TCG
-    /* Check whether this exception is a semihosting call; if so
-     * then handle it and return true; otherwise return false.
-     */
+static void handle_semihosting(CPUState *cs)
+{
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
     if (is_a64(env)) {
-        if (cs->exception_index == EXCP_SEMIHOST) {
-            /* This is always the 64-bit semihosting exception.
-             * The "is this usermode" and "is semihosting enabled"
-             * checks have been done at translate time.
-             */
-            qemu_log_mask(CPU_LOG_INT,
-                          "...handling as semihosting call 0x%" PRIx64 "\n",
-                          env->xregs[0]);
-            env->xregs[0] = do_arm_semihosting(env);
-            return true;
-        }
-        return false;
+        qemu_log_mask(CPU_LOG_INT,
+                      "...handling as semihosting call 0x%" PRIx64 "\n",
+                      env->xregs[0]);
+        env->xregs[0] = do_arm_semihosting(env);
     } else {
-        uint32_t imm;
-
-        /* Only intercept calls from privileged modes, to provide some
-         * semblance of security.
-         */
-        if (cs->exception_index != EXCP_SEMIHOST &&
-            (!semihosting_enabled() ||
-             ((env->uncached_cpsr & CPSR_M) == ARM_CPU_MODE_USR))) {
-            return false;
-        }
-
-        switch (cs->exception_index) {
-        case EXCP_SEMIHOST:
-            /* This is always a semihosting call; the "is this usermode"
-             * and "is semihosting enabled" checks have been done at
-             * translate time.
-             */
-            break;
-        case EXCP_SWI:
-            /* Check for semihosting interrupt.  */
-            if (env->thumb) {
-                imm = arm_lduw_code(env, env->regs[15] - 2, arm_sctlr_b(env))
-                    & 0xff;
-                if (imm == 0xab) {
-                    break;
-                }
-            } else {
-                imm = arm_ldl_code(env, env->regs[15] - 4, arm_sctlr_b(env))
-                    & 0xffffff;
-                if (imm == 0x123456) {
-                    break;
-                }
-            }
-            return false;
-        case EXCP_BKPT:
-            /* See if this is a semihosting syscall.  */
-            if (env->thumb) {
-                imm = arm_lduw_code(env, env->regs[15], arm_sctlr_b(env))
-                    & 0xff;
-                if (imm == 0xab) {
-                    env->regs[15] += 2;
-                    break;
-                }
-            }
-            return false;
-        default:
-            return false;
-        }
-
         qemu_log_mask(CPU_LOG_INT,
                       "...handling as semihosting call 0x%x\n",
                       env->regs[0]);
         env->regs[0] = do_arm_semihosting(env);
-        return true;
     }
-#else
-    return false;
-#endif
 }
+#endif
 
 /* Handle a CPU exception for A and R profile CPUs.
  * Do any appropriate logging, handle PSCI calls, and then hand off
@@ -8451,13 +8395,17 @@ void arm_cpu_do_interrupt(CPUState *cs)
         return;
     }
 
-    /* Semihosting semantics depend on the register width of the
-     * code that caused the exception, not the target exception level,
-     * so must be handled here.
+    /*
+     * Semihosting semantics depend on the register width of the code
+     * that caused the exception, not the target exception level, so
+     * must be handled here.
      */
-    if (check_for_semihosting(cs)) {
+#ifdef CONFIG_TCG
+    if (cs->exception_index == EXCP_SEMIHOST) {
+        handle_semihosting(cs);
         return;
     }
+#endif
 
     /* Hooks may change global state so BQL should be held, also the
      * BQL needs to be held for any modification of
-- 
2.20.1


