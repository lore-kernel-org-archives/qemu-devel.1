Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FFC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F214122CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkI8cpgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F214122CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31Lu-0000r1-TH
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i31CH-0007mO-RW
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i31CE-000108-0K
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i31CA-0000sK-3O
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so526336wro.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IKUnc62WPCnJEius0PuJ3RtShM/DcMqSkoHnSUf3aGs=;
 b=OkI8cpgyQWYVIcR1qSNOPUNK2TnHo5UYwOiNCuJs6A8w//3e/P8iOnC3lWUYadpNnG
 xT5nhOZ/Ig/pg/SiEkAUwvh+lta2PVPcseAgCPIAGM509Gok/gLqr41iSznXfJxQNvoJ
 bjE+1iC0c+CuSUJgS+E40YD8deF9CbY6obeyQJY0PrF68/E1JpW7imdC6+8SPHGkRPiu
 +2Fp4GMawkC3E06GC7y0fIkYQvT0zvP1IM2drX781ED2qxPQGq4QEiK7bxSnIRw5KAZo
 QoQ+zCXdIyMOiggvG6dspkKm8aM2L8oadBFgl0MnBcPFDdvNPBJGhEimbhvdxFCim8SP
 mptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IKUnc62WPCnJEius0PuJ3RtShM/DcMqSkoHnSUf3aGs=;
 b=l+JcnGtqYky3V8roms1oYCMbZsdehn5VmcYonqT733ppLCYnUct0PWBX9+s+xB5aLt
 GtVE3jGq23E7jp8QOzX5cLNH+f4c03g5ZybcsaksIByUT03dmUAG/Zn6zk+/GRTS+HkS
 vEz0OBgenMZmRpKY2Z17dlPnwl8M8oGxpK84JUSAVh3hNrm5KYgFRepq+cO+a6GZjvIS
 XhSoYQLHaMYAN0jyj/XHWtCB7DIK+qG4RpdW99Ji/ZIsdags3aM0Gw+TrkQASlCkGPnT
 1c316ic6gZ+e/EMd3aQDDuUSLXq3C5+twJoFq65XR4pWVPKI2xKDMW7lfsjrEpQLFNAZ
 T2jQ==
X-Gm-Message-State: APjAAAWO+0Pakn7UxqwJnEKY06/OlJwA2cz4tJjKAAfyolQwFO5YMBUu
 hUV/yPS8d6n/S2vcCod0/QOPiA==
X-Google-Smtp-Source: APXvYqxOOKvYgA5Eweac2Let+uu4KalP8i6AZrEXkpY05mu+14kHjaLgAS95BC9HGbGP+gLW79Zf/Q==
X-Received: by 2002:a5d:658b:: with SMTP id q11mr5538897wru.211.1567011192599; 
 Wed, 28 Aug 2019 09:53:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o2sm3717448wmh.9.2019.08.28.09.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:53:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B7F2F1FF91;
 Wed, 28 Aug 2019 17:53:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 17:53:02 +0100
Message-Id: <20190828165307.18321-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
References: <20190828165307.18321-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v1 4/9] target/arm: remove run time semihosting
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we do all our checking and use a common EXCP_SEMIHOST for
semihosting operations we can make helper code a lot simpler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
index 7e0d5398ab8..c54d4768e1d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8262,88 +8262,32 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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
@@ -8374,13 +8318,17 @@ void arm_cpu_do_interrupt(CPUState *cs)
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


