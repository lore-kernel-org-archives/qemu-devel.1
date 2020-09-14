Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77230214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+NO/wXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77230214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpBY-0008C0-5T
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8F-0002MO-Gj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:34835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8D-0007Zc-Bl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id y15so211689wmi.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2Pm0HMO2zXGIGpZaPm/owGvMJz02qx44BSYos4Dfokk=;
 b=t+NO/wXWg95yON2MqwdHg0QRP2HibN1G+cwm9+XGZnQbkFJH3Lyms6IUaBAKLpyGyF
 Otx5t7lU8LimIHpaooSVRHpDeQbEI5ePcRqBabXjWfOdT0O7RVXAN//5/txvGIkvWNVR
 nG9i87/MkaldM4FIw9fhkSne5z9784IgsifLbRGzLgFFmJPmomEZMGzzmLIbUazK3BT/
 pQUyAuvlXilswqNUqIlQVz2j1VTpvc2yOi5T4UfN4kWgJvIwOOXMrtGSflT3zqUxygkW
 gWkbdgfab8t6M/hKNXGLTGIYtVRRtiHraADk6p2MLkYvDcdg+iLgUaqaSt+u3EvjIWxZ
 VJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2Pm0HMO2zXGIGpZaPm/owGvMJz02qx44BSYos4Dfokk=;
 b=pUWsUJkuB3i0bjICc6Qu+qSOUxT7QZvVsfpJsdsEewgaRqoYjFNRy3WCijcca6fe7X
 crfIJffhGeuAm6WPtwpKYqJQuE8t+HETLH9Wf4rFOqDfnLONxa77HR1nPwim0rRbUQBb
 sBXPGC59tTBHuFtcxlcEY09fZGd9TAzLO9SrKHBZoU5nX613SFGmsrYyWrMX7bV1sJ/T
 UFC1bg+nrilg6mwqMTkIncBdsljhRujY7LlGg7i74jZG81ne9jMXiIDT0ZMWOBk9uL9Q
 edXJ9yUspJSQ4kWg3RHmQR3x3e/V5ljgbH1Z/XWgprnn2RQ6KfpirSErz0K01/pRS4Xx
 6cWQ==
X-Gm-Message-State: AOAM531E7w03WElsD6OJxH+Q+RqM/K06XWqwU0Fqb3vw/PwmIs0+2Au+
 BqBNfYs8K5Zcl9AlBYem/TDu+FpMfdTtF+GU
X-Google-Smtp-Source: ABdhPJwuJx/ruZ1revnFG+IIRHwyn4qSpBXabThyyhbemPMUBL7sXgYNKVLy9hQJhKev0OvQhA3x8w==
X-Received: by 2002:a7b:c241:: with SMTP id b1mr15154416wmj.98.1600092415593; 
 Mon, 14 Sep 2020 07:06:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/36] target/arm: Remove no-longer-reachable 32-bit KVM code
Date: Mon, 14 Sep 2020 15:06:16 +0100
Message-Id: <20200914140641.21369-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Now that 32-bit KVM host support is gone, KVM can never
be enabled unless CONFIG_AARCH64 is true, and some code
paths are no longer reachable and can be deleted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200904154156.31943-3-peter.maydell@linaro.org
---
 target/arm/kvm-consts.h |   7 ---
 target/arm/kvm_arm.h    |   6 ---
 target/arm/cpu.c        | 101 +++++++++++++++++++---------------------
 target/arm/kvm.c        |   7 ---
 4 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index aad28258a36..580f1c1fee0 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -136,16 +136,11 @@ MISMATCH_CHECK(QEMU_PSCI_RET_DISABLED, PSCI_RET_DISABLED);
  */
 #define QEMU_KVM_ARM_TARGET_NONE UINT_MAX
 
-#ifdef TARGET_AARCH64
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_AEM_V8, KVM_ARM_TARGET_AEM_V8);
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_FOUNDATION_V8, KVM_ARM_TARGET_FOUNDATION_V8);
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A57, KVM_ARM_TARGET_CORTEX_A57);
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_XGENE_POTENZA, KVM_ARM_TARGET_XGENE_POTENZA);
 MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A53, KVM_ARM_TARGET_CORTEX_A53);
-#else
-MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A15, KVM_ARM_TARGET_CORTEX_A15);
-MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A7, KVM_ARM_TARGET_CORTEX_A7);
-#endif
 
 #define CP_REG_ARM64                   0x6000000000000000ULL
 #define CP_REG_ARM_COPROC_MASK         0x000000000FFF0000
@@ -165,7 +160,6 @@ MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A7, KVM_ARM_TARGET_CORTEX_A7);
 /* No kernel define but it's useful to QEMU */
 #define CP_REG_ARM64_SYSREG_CP (CP_REG_ARM64_SYSREG >> CP_REG_ARM_COPROC_SHIFT)
 
-#ifdef TARGET_AARCH64
 MISMATCH_CHECK(CP_REG_ARM64, KVM_REG_ARM64);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_MASK, KVM_REG_ARM_COPROC_MASK);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_SHIFT, KVM_REG_ARM_COPROC_SHIFT);
@@ -180,7 +174,6 @@ MISMATCH_CHECK(CP_REG_ARM64_SYSREG_CRM_MASK, KVM_REG_ARM64_SYSREG_CRM_MASK);
 MISMATCH_CHECK(CP_REG_ARM64_SYSREG_CRM_SHIFT, KVM_REG_ARM64_SYSREG_CRM_SHIFT);
 MISMATCH_CHECK(CP_REG_ARM64_SYSREG_OP2_MASK, KVM_REG_ARM64_SYSREG_OP2_MASK);
 MISMATCH_CHECK(CP_REG_ARM64_SYSREG_OP2_SHIFT, KVM_REG_ARM64_SYSREG_OP2_SHIFT);
-#endif
 
 #undef MISMATCH_CHECK
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index adb38514bf2..bc178eeb84c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -406,13 +406,7 @@ static inline const char *gic_class_name(void)
 static inline const char *gicv3_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
-#ifdef TARGET_AARCH64
         return "kvm-arm-gicv3";
-#else
-        error_report("KVM GICv3 acceleration is not supported on this "
-                     "platform");
-        exit(1);
-#endif
     } else {
         if (kvm_enabled()) {
             error_report("Userspace GICv3 is not supported with KVM");
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6b4e708c08f..7b5ea65fab9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2098,72 +2098,69 @@ static void cortex_a15_initfn(Object *obj)
 }
 
 #ifndef TARGET_AARCH64
-/* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
- * otherwise, a CPU with as many features enabled as our emulation supports.
+/*
+ * -cpu max: a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-aarch64 is defined in cpu64.c;
- * this only needs to handle 32 bits.
+ * this only needs to handle 32 bits, and need not care about KVM.
  */
 static void arm_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    if (kvm_enabled()) {
-        kvm_arm_set_cpu_features_from_host(cpu);
-    } else {
-        cortex_a15_initfn(obj);
+    cortex_a15_initfn(obj);
 
-        /* old-style VFP short-vector support */
-        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    /* old-style VFP short-vector support */
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
 
 #ifdef CONFIG_USER_ONLY
-        /* We don't set these in system emulation mode for the moment,
-         * since we don't correctly set (all of) the ID registers to
-         * advertise them.
-         */
-        set_feature(&cpu->env, ARM_FEATURE_V8);
-        {
-            uint32_t t;
+    /*
+     * We don't set these in system emulation mode for the moment,
+     * since we don't correctly set (all of) the ID registers to
+     * advertise them.
+     */
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    {
+        uint32_t t;
 
-            t = cpu->isar.id_isar5;
-            t = FIELD_DP32(t, ID_ISAR5, AES, 2);
-            t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);
-            t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);
-            t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
-            t = FIELD_DP32(t, ID_ISAR5, RDM, 1);
-            t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);
-            cpu->isar.id_isar5 = t;
+        t = cpu->isar.id_isar5;
+        t = FIELD_DP32(t, ID_ISAR5, AES, 2);
+        t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);
+        t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);
+        t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
+        t = FIELD_DP32(t, ID_ISAR5, RDM, 1);
+        t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);
+        cpu->isar.id_isar5 = t;
 
-            t = cpu->isar.id_isar6;
-            t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
-            t = FIELD_DP32(t, ID_ISAR6, DP, 1);
-            t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
-            t = FIELD_DP32(t, ID_ISAR6, SB, 1);
-            t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
-            cpu->isar.id_isar6 = t;
+        t = cpu->isar.id_isar6;
+        t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
+        t = FIELD_DP32(t, ID_ISAR6, DP, 1);
+        t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
+        t = FIELD_DP32(t, ID_ISAR6, SB, 1);
+        t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
+        cpu->isar.id_isar6 = t;
 
-            t = cpu->isar.mvfr1;
-            t = FIELD_DP32(t, MVFR1, FPHP, 3);     /* v8.2-FP16 */
-            t = FIELD_DP32(t, MVFR1, SIMDHP, 2);   /* v8.2-FP16 */
-            cpu->isar.mvfr1 = t;
+        t = cpu->isar.mvfr1;
+        t = FIELD_DP32(t, MVFR1, FPHP, 3);     /* v8.2-FP16 */
+        t = FIELD_DP32(t, MVFR1, SIMDHP, 2);   /* v8.2-FP16 */
+        cpu->isar.mvfr1 = t;
 
-            t = cpu->isar.mvfr2;
-            t = FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
-            t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
-            cpu->isar.mvfr2 = t;
+        t = cpu->isar.mvfr2;
+        t = FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
+        t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
+        cpu->isar.mvfr2 = t;
 
-            t = cpu->isar.id_mmfr3;
-            t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
-            cpu->isar.id_mmfr3 = t;
+        t = cpu->isar.id_mmfr3;
+        t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
+        cpu->isar.id_mmfr3 = t;
 
-            t = cpu->isar.id_mmfr4;
-            t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
-            t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
-            t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
-            t = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
-            cpu->isar.id_mmfr4 = t;
-        }
-#endif
+        t = cpu->isar.id_mmfr4;
+        t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
+        t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
+        t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
+        t = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
+        cpu->isar.id_mmfr4 = t;
     }
+#endif
 }
 #endif
 
@@ -2267,11 +2264,7 @@ static void arm_host_initfn(Object *obj)
 
 static const TypeInfo host_arm_cpu_type_info = {
     .name = TYPE_ARM_HOST_CPU,
-#ifdef TARGET_AARCH64
     .parent = TYPE_AARCH64_CPU,
-#else
-    .parent = TYPE_ARM_CPU,
-#endif
     .instance_init = arm_host_initfn,
 };
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378b..2eae73315d6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -918,22 +918,15 @@ int kvm_arch_process_async_events(CPUState *cs)
     return 0;
 }
 
-/* The #ifdef protections are until 32bit headers are imported and can
- * be removed once both 32 and 64 bit reach feature parity.
- */
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
-#ifdef KVM_GUESTDBG_USE_SW_BP
     if (kvm_sw_breakpoints_active(cs)) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
     }
-#endif
-#ifdef KVM_GUESTDBG_USE_HW
     if (kvm_arm_hw_debug_active(cs)) {
         dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW;
         kvm_arm_copy_hw_debug_data(&dbg->arch);
     }
-#endif
 }
 
 void kvm_arch_init_irq_routing(KVMState *s)
-- 
2.20.1


