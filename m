Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CDC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C992074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxgOmX8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C992074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDtf-0000Rg-Jf
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEDqm-0005Mg-St
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:42:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:47000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEDqk-0006xJ-T2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:42:04 -0400
Received: by mail-wr1-x435.google.com with SMTP id o5so7141238wrn.13
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=z19lhYlJYs3eXeWM3NbccxsHJZHVss+dp0q20xSXXDY=;
 b=YxgOmX8ZVr/3DHqOeT3KNB+DUh5oLVm88qVZ6PxDi47rqFjx0oQ+YL0CMAITEPAJZm
 BOZRZEAJh9DEuxkkL3DVPxAbmdb7XQ4PW9NaGQAKiG7/iq/Xx4ix6KHxMjiTW2W2S5Rh
 VlpcbpVijUQGyNwhDrBHc0kUi0Jnz5NMNgZK23l7i4ZqbhrYLH7e7YnjF4TQJ7J1QO4p
 Am4+DY5z8xJatVrxBFGKUJJiU+BCLVeS2J4mw0KNiaI5D0BXpl33hquR5NgbUeHrDRcW
 sA5UNtYDLbnywGc/kyw0wg42Aa72YJeVOXyWXdoTOMOx6tQrJVSzkztHN0zfnUIHHsD+
 xJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z19lhYlJYs3eXeWM3NbccxsHJZHVss+dp0q20xSXXDY=;
 b=SRv8cvOG+RD+Let2U3PLPcE+ystkaAZls3GE5XqoTanZGBfjUOSiIr5X62YXRXmgoE
 Hf4Rt1tWQ9OkpPImL+7GMXiDoSDB3+xRoWZttA84aOn/C49GP14FjbEoDpg/u6xmqxBW
 S8I7BribKSwzRWx/eA6Z6KDHxisHUb32MIwy9W0mkPPer6sodTNjL6ypVBExkSroKav4
 Mn/cduP+wVyVJt4Sp7XbH1TeAkUYvvhjwlR3HXNry8GgXMtpMNhT1popFpj4UmpjgzhO
 yNikLErcC/YeIbHT2tHuqMjZird6Msq5E9upBDKAsApoxnPFU8AKIVLXcTkaNqzqL96N
 LN9Q==
X-Gm-Message-State: AOAM5311SFqDkbqXxBTGpxmqiL+d8UdFOj1zA0J1HDatbn4HESWHlFia
 8y5TyRC/r4eTbVcpKZMrUg0UVl+FK3EbsW7s
X-Google-Smtp-Source: ABdhPJxvKb4/JCxPd5JCc7S49vf8lzXFKmN3kyNsIIHs/aji11wF7IBaJCqU4+y/QJCmI4HTm9F2OQ==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr8481271wrw.324.1599234121257; 
 Fri, 04 Sep 2020 08:42:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f14sm12723743wrv.72.2020.09.04.08.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:42:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/arm: Remove no-longer-reachable 32-bit KVM code
Date: Fri,  4 Sep 2020 16:41:56 +0100
Message-Id: <20200904154156.31943-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904154156.31943-1-peter.maydell@linaro.org>
References: <20200904154156.31943-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
---
 target/arm/kvm-consts.h |   7 ---
 target/arm/kvm_arm.h    |   6 ---
 target/arm/cpu.c        | 100 ++++++++++++++++++----------------------
 target/arm/kvm.c        |   7 ---
 4 files changed, 46 insertions(+), 74 deletions(-)

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
index c179e0752da..cb1fa2a35c3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2099,72 +2099,68 @@ static void cortex_a15_initfn(Object *obj)
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
+    /* We don't set these in system emulation mode for the moment,
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
 
@@ -2269,11 +2265,7 @@ static void arm_host_initfn(Object *obj)
 
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


