Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C50C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA01D206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlZJcYWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA01D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxV5-0002SM-6B
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCm-0004ap-Dn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCk-0000Sg-LF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:08 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCk-0000QU-DK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:06 -0500
Received: by mail-pl1-x643.google.com with SMTP id a6so597156plm.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+8OtPe7bMKK2P+qrnZ6DlNuDb2jxgI/LE3YP+dF+big=;
 b=ZlZJcYWYoBhYbYmU4bgNTokd1uLwqSocrn+9T+/Wf2Qr6RStUwqYhScroT1F8cakMZ
 OWYOGwSXhwvgaYjJC1fHJfoxnTLKD+9Ask85ORJUf8o4lXz0LbJVStGzV+Db2fLnrfT+
 DVbYfo0tSH+DrwNZ/RR8u3UtG7E1RNyfms3qaNnxb9K6AXAmQ3L5Wyawe7kJfB0r4QC6
 GhnJjRen9AjFjcofp/DkWGoMNnxFpqzKUtzMFDvzsdwC1KBTFyJLtjulLu+Lq166joIr
 BQrHfPsPEUWXrAzFcXa0EQCG/j8LnazYk4G8lKo3Y9h8ln7ODgcXpsJHXXOU73oqSm1Q
 1ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+8OtPe7bMKK2P+qrnZ6DlNuDb2jxgI/LE3YP+dF+big=;
 b=kJcrAhtc6w3vJAQld5zT7x4nRF2oVnLVeLETtu16TZYUfu1SaVotAK3ttTaD/8K/Ao
 4po0Z32USsCuYTLkZS4dFsOuJFwFjXQVfSykPhH42VSY2OwNgNXVUKxnFJTOXUesAcEm
 WFIbNPIvyibntAaJAuemYWeHTqzOdQ+WG7hJHMpF9KIMqzupKxj8Ojyax2Vr/aa8q3SM
 WzQLzNqs/Ng32B50M3ImOtOC2iz4LzDi9CV7wjWSLbyZJ0Rqf/IrDdDq72vI0+RBobkK
 Y1QQ/0TIVeOth9F6vqWgLcVoS6hjD79Nv8kMTulhyQWIsJHOIo7FEILPSzSweMh8SuGo
 bbIA==
X-Gm-Message-State: APjAAAX7HKHplYmRAF8h8uxGoiTyojJ6RV0axjtoaDlDLIZ/ERZEsfDM
 W88CosG6pWMNUxdISaxVctO4Ku/Co1s=
X-Google-Smtp-Source: APXvYqxPKFwJaIjNRagUWuC46mNl6HbIFeyeaq6Z4pLlMelJ0QqyXLBhucLY1X7IWxMYHMZQEroI+g==
X-Received: by 2002:a17:90a:ec02:: with SMTP id
 l2mr2642424pjy.12.1580342224804; 
 Wed, 29 Jan 2020 15:57:04 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:57:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 38/41] target/arm: Move arm_excp_unmasked to cpu.c
Date: Wed, 29 Jan 2020 15:56:11 -0800
Message-Id: <20200129235614.29829-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This inline function has one user in cpu.c, and need not be exposed
otherwise.  Code movement only, with fixups for checkpatch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 111 -------------------------------------------
 target/arm/cpu.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fe3326aa26..78b9b4c64a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2702,117 +2702,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
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
index 0c530ffd29..114833bdba 100644
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


