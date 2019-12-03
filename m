Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C063C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284D8206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjMegFqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284D8206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyPM-0005hD-AX
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxO-0003TB-Ep
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxM-0000Jx-6w
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:30 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:33918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxL-0000Hc-Sy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:28 -0500
Received: by mail-pj1-x1041.google.com with SMTP id t21so831245pjq.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sU0Rb1lweTCsZgkiKPPPp7WxJ75dP/BQ8w48fi8QJ6s=;
 b=VjMegFqGhdkDDr/jf5XYiM6AO3uJlzF/RNLX2MBF9ayrUBfokmOe8PsPvjtXrbNZek
 KMiXIn5PqeXUUIIfrXu26FY7OdREj9YixejxPkqfeySig29JgOzZFRY2AkCDERstF8Ff
 vBerH6agj75tGYsNRCmUikGU5iwA4YOh/CUbNvHM18G1NpZ70iizWRaVkWKV18GwkCvN
 xDo/stGWabLvqCTNVXTLP664PJyX1iw4Efu7sm+XFKo2Yvho1TGRlPEkkMEiqhwgfbae
 TpdXXu4ozl7w6/5XcAUaaJG0qSq48aeGlgF2SqfserpgiKzPKoIEQf/qEINJq1J451N9
 funw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sU0Rb1lweTCsZgkiKPPPp7WxJ75dP/BQ8w48fi8QJ6s=;
 b=gkxx+SUV18fZc4Yq0EboMwyfnUPsx/k0vc0FjRCHROkuxGu5Uq8cwpfdy7X61buu76
 GJt3BhzXyBTbntGm9UuUs4iUjrfQ5eZGbdqJyPvbyLddOXwzyDI85RayJP91bZTrFhRH
 b1tcjvOagbTaRfEweMlda/dKW0EAeNECS/jvoIHmsGSa16hFkmrI/w1UGHAnkUDrjujW
 Tpyy93dQAmWB6C8d0kHbxp7SK4P9cNT/Oz+MUVF8sl5N1Otvqhmu1SdMT2M9yaZl1Irt
 0q1wb6CC08XDNnWCT0TnFLIWhTorGsnlpyYhn1uXkRT5pJaUxSy1glw8Ff7Rr4x8MtU4
 NUCg==
X-Gm-Message-State: APjAAAWDHZ8CEFGAFV6Q4KIX6jKgL2fB8VWw9lZPZFC0XnzqQ7sCNSrb
 LiR3b/D0NtXJWKGM4EefzyNK7ws9sJI=
X-Google-Smtp-Source: APXvYqxonvO1uGtm9VZPR2N2CPU4tZR/Om6po8cRD+iMM+CVYbnA1eLMDXWkjrgwi68CAVWYguPdxQ==
X-Received: by 2002:a17:902:758a:: with SMTP id
 j10mr2751609pll.29.1575340226370; 
 Mon, 02 Dec 2019 18:30:26 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 37/40] target/arm: Move arm_excp_unmasked to cpu.c
Date: Mon,  2 Dec 2019 18:29:34 -0800
Message-Id: <20191203022937.1474-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This inline function has one user in cpu.c, and need not be exposed
otherwise.  Code movement only, with fixups for checkpatch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 111 -------------------------------------------
 target/arm/cpu.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8e5aaaf415..22935e4433 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2673,117 +2673,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
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
index 81c33221f7..a36344d4c7 100644
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
2.17.1


