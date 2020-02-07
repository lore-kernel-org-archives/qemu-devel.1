Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEAAC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0831020720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQObNINx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0831020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04yb-0003V8-6u
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iF-0001Jb-68
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iD-0003SV-B9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:31 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iD-0003Rx-2Y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id a5so2837863wmb.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MXq+90aki7wHPW6kiVThA2vqsU7tMxi7hhFXp80t7QE=;
 b=EQObNINxvdAi2/S6HEVAuAkjCKudWlnxyEdgdiCUm9PHpoNxioVqPPewZzeY0LTc8p
 5jLIq+V+7H1ImJUWIZH1X+UlxgRKtAkAR5iygOs50Aa9cvgUTjyn4BA6GaK7xecudlEB
 JBpESkA0pWFJF8caq7la71PExyazClzfuUeC3cIi1lWM1Aj09S+E5MLF9s00pSpDLJuZ
 HbpP0NTWzociNyTuTAKleUcVy/RF7tzX6siaMqTi/Zqa/XnSW/nKCp+VUZolCUMW+KVV
 F74QVNL5tRNEGKCmREuQWpPuSMNjc68uHGMoG3i2u8zRILbnrM89hduc+ndpb9QD/T+w
 4AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MXq+90aki7wHPW6kiVThA2vqsU7tMxi7hhFXp80t7QE=;
 b=Lefeni0dWWvpezzS4HgS+et1gWEUQEbWA7T+RrnQbNs9Q3CHzHo1gyhXv35a3XqTOO
 /6y364+WRGnq/tuCWX6FRkwTZ0izYcgf0iOJYrquFieuD1sB4LWWht8KAE3/I1ub6SuX
 mWE62AK/v3g1dvyolAm6MCmjiRWBrqiq9YiiKiBW5hK+F7E97EISDySlGHvgCMlGJsEs
 ht0EZP4vH2B4hJO+J+as7mfvryk0/ZVNo6o8uPqUbHXW9wFyVQZp3v+kGGXHfnCiFc5W
 SYyUsHFCf+J2X5MP8D/36cpY46N+yN/AOQUXnI0aVP1skfgiOLU9jagOvCHj4BgvBZyw
 sAqg==
X-Gm-Message-State: APjAAAX8/khJ+EeJAqF8A1KkRjxcNUthHDHc6TuV/8weHXaLvW/2bCVH
 SNmUUHN6SbQ4ighQdG1jXtupsaoF/RU=
X-Google-Smtp-Source: APXvYqxc1LL6bFbeUC2y14+mJXeygG/ZguDKHeW8K43Fy+TnBTaliq/Jmn/Zkw/IadYvJEbMH1n8tw==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr4703625wmj.74.1581086067652;
 Fri, 07 Feb 2020 06:34:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/48] target/arm: Move arm_excp_unmasked to cpu.c
Date: Fri,  7 Feb 2020 14:33:34 +0000
Message-Id: <20200207143343.30322-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

From: Richard Henderson <richard.henderson@linaro.org>

This inline function has one user in cpu.c, and need not be exposed
otherwise.  Code movement only, with fixups for checkpatch.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-39-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 111 -------------------------------------------
 target/arm/cpu.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2ed2667a170..0b3036c484f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2709,117 +2709,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
-static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
-                                     unsigned int target_el)
-{
-    CPUARMState *env = cs->env_ptr;
-    unsigned int cur_el = arm_current_el(env);
-    bool secure = arm_is_secure(env);
-    bool pstate_unmasked;
-    int8_t unmasked = 0;
-    uint64_t hcr_el2;
-
-    /* Don't take exceptions if they target a lower EL.
-     * This check should catch any exceptions that would not be taken but left
-     * pending.
-     */
-    if (cur_el > target_el) {
-        return false;
-    }
-
-    hcr_el2 = arm_hcr_el2_eff(env);
-
-    switch (excp_idx) {
-    case EXCP_FIQ:
-        pstate_unmasked = !(env->daif & PSTATE_F);
-        break;
-
-    case EXCP_IRQ:
-        pstate_unmasked = !(env->daif & PSTATE_I);
-        break;
-
-    case EXCP_VFIQ:
-        if (secure || !(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
-            /* VFIQs are only taken when hypervized and non-secure.  */
-            return false;
-        }
-        return !(env->daif & PSTATE_F);
-    case EXCP_VIRQ:
-        if (secure || !(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
-            /* VIRQs are only taken when hypervized and non-secure.  */
-            return false;
-        }
-        return !(env->daif & PSTATE_I);
-    default:
-        g_assert_not_reached();
-    }
-
-    /* Use the target EL, current execution state and SCR/HCR settings to
-     * determine whether the corresponding CPSR bit is used to mask the
-     * interrupt.
-     */
-    if ((target_el > cur_el) && (target_el != 1)) {
-        /* Exceptions targeting a higher EL may not be maskable */
-        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-            /* 64-bit masking rules are simple: exceptions to EL3
-             * can't be masked, and exceptions to EL2 can only be
-             * masked from Secure state. The HCR and SCR settings
-             * don't affect the masking logic, only the interrupt routing.
-             */
-            if (target_el == 3 || !secure) {
-                unmasked = 1;
-            }
-        } else {
-            /* The old 32-bit-only environment has a more complicated
-             * masking setup. HCR and SCR bits not only affect interrupt
-             * routing but also change the behaviour of masking.
-             */
-            bool hcr, scr;
-
-            switch (excp_idx) {
-            case EXCP_FIQ:
-                /* If FIQs are routed to EL3 or EL2 then there are cases where
-                 * we override the CPSR.F in determining if the exception is
-                 * masked or not. If neither of these are set then we fall back
-                 * to the CPSR.F setting otherwise we further assess the state
-                 * below.
-                 */
-                hcr = hcr_el2 & HCR_FMO;
-                scr = (env->cp15.scr_el3 & SCR_FIQ);
-
-                /* When EL3 is 32-bit, the SCR.FW bit controls whether the
-                 * CPSR.F bit masks FIQ interrupts when taken in non-secure
-                 * state. If SCR.FW is set then FIQs can be masked by CPSR.F
-                 * when non-secure but only when FIQs are only routed to EL3.
-                 */
-                scr = scr && !((env->cp15.scr_el3 & SCR_FW) && !hcr);
-                break;
-            case EXCP_IRQ:
-                /* When EL3 execution state is 32-bit, if HCR.IMO is set then
-                 * we may override the CPSR.I masking when in non-secure state.
-                 * The SCR.IRQ setting has already been taken into consideration
-                 * when setting the target EL, so it does not have a further
-                 * affect here.
-                 */
-                hcr = hcr_el2 & HCR_IMO;
-                scr = false;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-
-            if ((scr || hcr) && !secure) {
-                unmasked = 1;
-            }
-        }
-    }
-
-    /* The PSTATE bits only mask the interrupt if we have not overriden the
-     * ability above.
-     */
-    return unmasked || pstate_unmasked;
-}
-
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1ecf2adb6a9..b81ed44bd2b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -410,6 +410,125 @@ static void arm_cpu_reset(CPUState *s)
     arm_rebuild_hflags(env);
 }
 
+static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
+                                     unsigned int target_el)
+{
+    CPUARMState *env = cs->env_ptr;
+    unsigned int cur_el = arm_current_el(env);
+    bool secure = arm_is_secure(env);
+    bool pstate_unmasked;
+    int8_t unmasked = 0;
+    uint64_t hcr_el2;
+
+    /*
+     * Don't take exceptions if they target a lower EL.
+     * This check should catch any exceptions that would not be taken
+     * but left pending.
+     */
+    if (cur_el > target_el) {
+        return false;
+    }
+
+    hcr_el2 = arm_hcr_el2_eff(env);
+
+    switch (excp_idx) {
+    case EXCP_FIQ:
+        pstate_unmasked = !(env->daif & PSTATE_F);
+        break;
+
+    case EXCP_IRQ:
+        pstate_unmasked = !(env->daif & PSTATE_I);
+        break;
+
+    case EXCP_VFIQ:
+        if (secure || !(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
+            /* VFIQs are only taken when hypervized and non-secure.  */
+            return false;
+        }
+        return !(env->daif & PSTATE_F);
+    case EXCP_VIRQ:
+        if (secure || !(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
+            /* VIRQs are only taken when hypervized and non-secure.  */
+            return false;
+        }
+        return !(env->daif & PSTATE_I);
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * Use the target EL, current execution state and SCR/HCR settings to
+     * determine whether the corresponding CPSR bit is used to mask the
+     * interrupt.
+     */
+    if ((target_el > cur_el) && (target_el != 1)) {
+        /* Exceptions targeting a higher EL may not be maskable */
+        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+            /*
+             * 64-bit masking rules are simple: exceptions to EL3
+             * can't be masked, and exceptions to EL2 can only be
+             * masked from Secure state. The HCR and SCR settings
+             * don't affect the masking logic, only the interrupt routing.
+             */
+            if (target_el == 3 || !secure) {
+                unmasked = 1;
+            }
+        } else {
+            /*
+             * The old 32-bit-only environment has a more complicated
+             * masking setup. HCR and SCR bits not only affect interrupt
+             * routing but also change the behaviour of masking.
+             */
+            bool hcr, scr;
+
+            switch (excp_idx) {
+            case EXCP_FIQ:
+                /*
+                 * If FIQs are routed to EL3 or EL2 then there are cases where
+                 * we override the CPSR.F in determining if the exception is
+                 * masked or not. If neither of these are set then we fall back
+                 * to the CPSR.F setting otherwise we further assess the state
+                 * below.
+                 */
+                hcr = hcr_el2 & HCR_FMO;
+                scr = (env->cp15.scr_el3 & SCR_FIQ);
+
+                /*
+                 * When EL3 is 32-bit, the SCR.FW bit controls whether the
+                 * CPSR.F bit masks FIQ interrupts when taken in non-secure
+                 * state. If SCR.FW is set then FIQs can be masked by CPSR.F
+                 * when non-secure but only when FIQs are only routed to EL3.
+                 */
+                scr = scr && !((env->cp15.scr_el3 & SCR_FW) && !hcr);
+                break;
+            case EXCP_IRQ:
+                /*
+                 * When EL3 execution state is 32-bit, if HCR.IMO is set then
+                 * we may override the CPSR.I masking when in non-secure state.
+                 * The SCR.IRQ setting has already been taken into consideration
+                 * when setting the target EL, so it does not have a further
+                 * affect here.
+                 */
+                hcr = hcr_el2 & HCR_IMO;
+                scr = false;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            if ((scr || hcr) && !secure) {
+                unmasked = 1;
+            }
+        }
+    }
+
+    /*
+     * The PSTATE bits only mask the interrupt if we have not overriden the
+     * ability above.
+     */
+    return unmasked || pstate_unmasked;
+}
+
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
-- 
2.20.1


