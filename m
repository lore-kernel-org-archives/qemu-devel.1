Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F1C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F227820675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uxvm9iLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F227820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9mL-0002SH-69
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:09:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eV-0004Wg-NA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eS-0006aW-BX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eM-0006P2-6o
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id h18so189058wml.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=y3JrGcL4/FAxm/wQ4j2VrgH7EZsRTdv/E48WZk0GnqA=;
	b=Uxvm9iLK4z2XES0kix8yqu6R7ilhEc0P1Ca/sSOpz1S1/nuQGg1wRwZPSUtrWAlX4V
	NdsGzHgpLnEDZ2hIKOLrxHemTcPzGUGh6u1vrQhQ6yE+dZ8JjElHv9V5gSdcjFDZLGlS
	Y+s63qNtGB0pSi5/DpnGrXlS5uXmE05pSTLpKURJYbC3ExlfkcaAYSU98wSqx/nzvrlt
	5N086C9Yq7ii5BmJqZtpnG1VIpFHMVt++CduzSg4OL8vIXjGN0pZ+0ovK9bgrqjW8RBL
	aSXIyDg/7joliPV6wZVGsQcYCP1H1oBXPR208833lYTpQ6a/kpS+LqbNcBfnlGKJmXvU
	NF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=y3JrGcL4/FAxm/wQ4j2VrgH7EZsRTdv/E48WZk0GnqA=;
	b=Npu8qOpvaNlq+rrcYDSffrDEO1b6ioVBeQ3ryITtZFNOTHKoozYbPHGt0AVsqWwTqW
	ZOCQ5s9X88eN3IsFWmsZDMv978mpZF2TtCeJAcD7RSphEOuuuy5uvU+VE7g/5wrtz7Pu
	8N6qKjGvXPdlfuNSokfvOchjnAFfBIq6SQg5RNV8hTuC8j4e638wvvS5uoHbQ9LRYEet
	wn8hu5C8XQlh9h7a90wc9+bl2zB/f0c1q4vi5wEHQnxdCp25Srwhbclybod79IyTsyT0
	649DJHfEJyOhgT9pk4gFswpRPoXzjSelFNBZqJfKZOiNfnh7VRReX6a+R6fSf/PUaUr1
	5ZQQ==
X-Gm-Message-State: APjAAAWHuVEDtoJDzv/4rl/oq+LlYxNMwzramZ5hMC5JJLDSrCHhIY0t
	JgmZFsuHDOWU2+Kc2v0VbQ2lJSS5vYc=
X-Google-Smtp-Source: APXvYqynRIhg58CJwOEz2COBMQwBrkwKWWittL2WsFb1RNBtTFX5ZclE77XivwCroRXeieuNqN2J0w==
X-Received: by 2002:a1c:5543:: with SMTP id j64mr31851wmb.37.1556557249148;
	Mon, 29 Apr 2019 10:00:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.47
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:01 +0100
Message-Id: <20190429170030.11323-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 13/42] target/arm: Handle floating point
 registers in exception entry
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429170001.Jf_dwifIS-GtrlVGWOTLjfy2AU0JWwz2W82-unSl8T8@z>

Handle floating point registers in exception entry.
This corresponds to the FP-specific parts of the pseudocode
functions ActivateException() and PushStack().

We defer the code corresponding to UpdateFPCCR() to a later patch.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-11-peter.maydell@linaro.org
---
 target/arm/helper.c | 98 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 142d301b651..6e55da5c482 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8167,6 +8167,9 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     switch_v7m_security_state(env, targets_secure);
     write_v7m_control_spsel(env, 0);
     arm_clear_exclusive(env);
+    /* Clear SFPA and FPCA (has no effect if no FPU) */
+    env->v7m.control[M_REG_S] &=
+        ~(R_V7M_CONTROL_FPCA_MASK | R_V7M_CONTROL_SFPA_MASK);
     /* Clear IT bits */
     env->condexec_bits = 0;
     env->regs[14] = lr;
@@ -8187,6 +8190,20 @@ static bool v7m_push_stack(ARMCPU *cpu)
     uint32_t xpsr = xpsr_read(env);
     uint32_t frameptr = env->regs[13];
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    uint32_t framesize;
+    bool nsacr_cp10 = extract32(env->v7m.nsacr, 10, 1);
+
+    if ((env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) &&
+        (env->v7m.secure || nsacr_cp10)) {
+        if (env->v7m.secure &&
+            env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK) {
+            framesize = 0xa8;
+        } else {
+            framesize = 0x68;
+        }
+    } else {
+        framesize = 0x20;
+    }
 
     /* Align stack pointer if the guest wants that */
     if ((frameptr & 4) &&
@@ -8195,7 +8212,13 @@ static bool v7m_push_stack(ARMCPU *cpu)
         xpsr |= XPSR_SPREALIGN;
     }
 
-    frameptr -= 0x20;
+    xpsr &= ~XPSR_SFPA;
+    if (env->v7m.secure &&
+        (env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)) {
+        xpsr |= XPSR_SFPA;
+    }
+
+    frameptr -= framesize;
 
     if (arm_feature(env, ARM_FEATURE_V8)) {
         uint32_t limit = v7m_sp_limit(env);
@@ -8239,6 +8262,73 @@ static bool v7m_push_stack(ARMCPU *cpu)
         v7m_stack_write(cpu, frameptr + 24, env->regs[15], mmu_idx, false) &&
         v7m_stack_write(cpu, frameptr + 28, xpsr, mmu_idx, false);
 
+    if (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) {
+        /* FPU is active, try to save its registers */
+        bool fpccr_s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+        bool lspact = env->v7m.fpccr[fpccr_s] & R_V7M_FPCCR_LSPACT_MASK;
+
+        if (lspact && arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+            qemu_log_mask(CPU_LOG_INT,
+                          "...SecureFault because LSPACT and FPCA both set\n");
+            env->v7m.sfsr |= R_V7M_SFSR_LSERR_MASK;
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+        } else if (!env->v7m.secure && !nsacr_cp10) {
+            qemu_log_mask(CPU_LOG_INT,
+                          "...Secure UsageFault with CFSR.NOCP because "
+                          "NSACR.CP10 prevents stacking FP regs\n");
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, M_REG_S);
+            env->v7m.cfsr[M_REG_S] |= R_V7M_CFSR_NOCP_MASK;
+        } else {
+            if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
+                /* Lazy stacking disabled, save registers now */
+                int i;
+                bool cpacr_pass = v7m_cpacr_pass(env, env->v7m.secure,
+                                                 arm_current_el(env) != 0);
+
+                if (stacked_ok && !cpacr_pass) {
+                    /*
+                     * Take UsageFault if CPACR forbids access. The pseudocode
+                     * here does a full CheckCPEnabled() but we know the NSACR
+                     * check can never fail as we have already handled that.
+                     */
+                    qemu_log_mask(CPU_LOG_INT,
+                                  "...UsageFault with CFSR.NOCP because "
+                                  "CPACR.CP10 prevents stacking FP regs\n");
+                    armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
+                                            env->v7m.secure);
+                    env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_NOCP_MASK;
+                    stacked_ok = false;
+                }
+
+                for (i = 0; i < ((framesize == 0xa8) ? 32 : 16); i += 2) {
+                    uint64_t dn = *aa32_vfp_dreg(env, i / 2);
+                    uint32_t faddr = frameptr + 0x20 + 4 * i;
+                    uint32_t slo = extract64(dn, 0, 32);
+                    uint32_t shi = extract64(dn, 32, 32);
+
+                    if (i >= 16) {
+                        faddr += 8; /* skip the slot for the FPSCR */
+                    }
+                    stacked_ok = stacked_ok &&
+                        v7m_stack_write(cpu, faddr, slo, mmu_idx, false) &&
+                        v7m_stack_write(cpu, faddr + 4, shi, mmu_idx, false);
+                }
+                stacked_ok = stacked_ok &&
+                    v7m_stack_write(cpu, frameptr + 0x60,
+                                    vfp_get_fpscr(env), mmu_idx, false);
+                if (cpacr_pass) {
+                    for (i = 0; i < ((framesize == 0xa8) ? 32 : 16); i += 2) {
+                        *aa32_vfp_dreg(env, i / 2) = 0;
+                    }
+                    vfp_set_fpscr(env, 0);
+                }
+            } else {
+                /* Lazy stacking enabled, save necessary info to stack later */
+                /* TODO : equivalent of UpdateFPCCR() pseudocode */
+            }
+        }
+    }
+
     /*
      * If we broke a stack limit then SP was already updated earlier;
      * otherwise we update SP regardless of whether any of the stack
@@ -8999,8 +9089,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     if (arm_feature(env, ARM_FEATURE_V8)) {
         lr = R_V7M_EXCRET_RES1_MASK |
-            R_V7M_EXCRET_DCRS_MASK |
-            R_V7M_EXCRET_FTYPE_MASK;
+            R_V7M_EXCRET_DCRS_MASK;
         /* The S bit indicates whether we should return to Secure
          * or NonSecure (ie our current state).
          * The ES bit indicates whether we're taking this exception
@@ -9015,6 +9104,9 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         if (env->v7m.secure) {
             lr |= R_V7M_EXCRET_S_MASK;
         }
+        if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK)) {
+            lr |= R_V7M_EXCRET_FTYPE_MASK;
+        }
     } else {
         lr = R_V7M_EXCRET_RES1_MASK |
             R_V7M_EXCRET_S_MASK |
-- 
2.20.1


