Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14479C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79EF208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fm44GeyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79EF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP4p-0001B9-3V
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxC-0004kM-0y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx9-0005fb-VP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so32631466wmj.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NlF2IvGuyP8tAoSGk+B5CfV3b2rxriv6aHG+5Yn8DI4=;
 b=Fm44GeyIpKUPL/4dWhfE3ndfVC8mr3y5qY3t7gHW96Y0XITpymKASBlg64Yjxl/Vnk
 KiSbdUOTnuIjnNIv3QKLdbCkeCF7ibmkMYCVe8jOm4Phf7BYTZQma0HWfgo/EZqNgu9N
 n5+k0zuTFzSYwt5bP/s3QzKBYnEY0tSKSu9BHIwTypH4sia8QSCw5METqFOhqghoSHUr
 1chuvCye+/x4SzaEcoOAampHXyZCFU6R3Gweali3uJPVISaiSPK8f5gJbme+DBL3O05Y
 xikw0lvg/qn1ETtICMT0rjwu1soV3j+AFJ1PsKaE6fDO8Ceqy8xta5ZbZZCJDJ2ARZOe
 u+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NlF2IvGuyP8tAoSGk+B5CfV3b2rxriv6aHG+5Yn8DI4=;
 b=E/T4PniWujWh4uAIVsK//6u5CO/kbI/5oW4yoS99ll23gjOc7WG3BrAbOqtnjdBpd0
 S6ObB6UYi7OrhvGalQXBhlRxLDom+c6vlmRVst+Q+DlaHv6N3uaqMEuq4Pc2Bb6qPCzo
 cuTnxVY84k61CWmS7mUa2qLRBz9IMTTednxS/WTsaZT1nEh099OHbWwpXd+pE1WOybX6
 3zhBrbQp1r0qAJQofjOLha0pgn6oTCwguUXrjpXsSwYkPT4Rixhhd2V2FiB2coovTC9J
 KhMmr3+2RaM6ufCHRjBqzPvKSguceJzcZg0IRi1oQlHtw1sQSfqnfKzHKvRxjvAlh2Jo
 nNfA==
X-Gm-Message-State: AOAM532u7NaD+bF5PVC66YaSmzDXTkDErbnPzyQ8jB2xWQ/6pZSA3s4A
 k0intiAB+gXc9c7bALffukX4qsR/mRSoyw==
X-Google-Smtp-Source: ABdhPJzLQ9b988ift5hxuGKOJGnEy0dKwdZx5RyYla4Hf3QsRpTfry4NpyKgtsQdUB8mpD4EDuW6BA==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr23042995wmj.67.1593795258239; 
 Fri, 03 Jul 2020 09:54:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/34] target/arm: kvm: Handle misconfigured dabt injection
Date: Fri,  3 Jul 2020 17:53:41 +0100
Message-Id: <20200703165405.17672-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Beata Michalska <beata.michalska@linaro.org>

Injecting external data abort through KVM might trigger
an issue on kernels that do not get updated to include the KVM fix.
For those and aarch32 guests, the injected abort gets misconfigured
to be an implementation defined exception. This leads to the guest
repeatedly re-running the faulting instruction.

Add support for handling that case.

[
  Fixed-by: 018f22f95e8a
	('KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests')
  Fixed-by: 21aecdbd7f3a
	('KVM: arm: Make inject_abt32() inject an external abort instead')
]

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Acked-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200629114110.30723-3-beata.michalska@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  2 ++
 target/arm/kvm_arm.h | 10 +++++++++
 target/arm/kvm.c     | 30 ++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 34 ++++++++++++++++++++++++++++++
 target/arm/kvm64.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cf99dcca9f3..9e8ed423ea1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -573,6 +573,8 @@ typedef struct CPUARMState {
         uint64_t esr;
     } serror;
 
+    uint8_t ext_dabt_raised; /* Tracking/verifying injection of ext DABT */
+
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index a4ce4fd93db..adb38514bf2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -449,6 +449,16 @@ bool kvm_arm_hw_debug_active(CPUState *cs);
 struct kvm_guest_debug_arch;
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
+/**
+ * kvm_arm_verify_ext_dabt_pending:
+ * @cs: CPUState
+ *
+ * Verify the fault status code wrt the Ext DABT injection
+ *
+ * Returns: true if the fault status code is as expected, false otherwise
+ */
+bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);
+
 /**
  * its_class_name:
  *
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3a46f54f1fd..8bb7318378b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -749,6 +749,29 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
 
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    if (unlikely(env->ext_dabt_raised)) {
+        /*
+         * Verifying that the ext DABT has been properly injected,
+         * otherwise risking indefinitely re-running the faulting instruction
+         * Covering a very narrow case for kernels 5.5..5.5.4
+         * when injected abort was misconfigured to be
+         * an IMPLEMENTATION DEFINED exception (for 32-bit EL1)
+         */
+        if (!arm_feature(env, ARM_FEATURE_AARCH64) &&
+            unlikely(!kvm_arm_verify_ext_dabt_pending(cs))) {
+
+            error_report("Data abort exception with no valid ISS generated by "
+                   "guest memory access. KVM unable to emulate faulting "
+                   "instruction. Failed to inject an external data abort "
+                   "into the guest.");
+            abort();
+       }
+       /* Clear the status */
+       env->ext_dabt_raised = 0;
+    }
 }
 
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
@@ -833,6 +856,8 @@ void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
 static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
                                     uint64_t fault_ipa)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     /*
      * Request KVM to inject the external data abort into the guest
      */
@@ -847,7 +872,10 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
          */
         events.exception.ext_dabt_pending = 1;
         /* KVM_CAP_ARM_INJECT_EXT_DABT implies KVM_CAP_VCPU_EVENTS */
-        return kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
+        if (!kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events)) {
+            env->ext_dabt_raised = 1;
+            return 0;
+        }
     } else {
         error_report("Data abort exception triggered by guest memory access "
                      "at physical address: 0x"  TARGET_FMT_lx,
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 7b3a19e9aef..0af46b41c84 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -559,3 +559,37 @@ void kvm_arm_pmu_init(CPUState *cs)
 {
     qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
 }
+
+#define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
+#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
+/*
+ *DFSR:
+ *      TTBCR.EAE == 0
+ *          FS[4]   - DFSR[10]
+ *          FS[3:0] - DFSR[3:0]
+ *      TTBCR.EAE == 1
+ *          FS, bits [5:0]
+ */
+#define DFSR_FSC(lpae, v) \
+    ((lpae) ? ((v) & 0x3F) : (((v) >> 6) | ((v) & 0x1F)))
+
+#define DFSC_EXTABT(lpae) ((lpae) ? 0x10 : 0x08)
+
+bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+{
+    uint32_t dfsr_val;
+
+    if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &dfsr_val)) {
+        ARMCPU *cpu = ARM_CPU(cs);
+        CPUARMState *env = &cpu->env;
+        uint32_t ttbcr;
+        int lpae = 0;
+
+        if (!kvm_get_one_reg(cs, ARM_REG_TTBCR, &ttbcr)) {
+            lpae = arm_feature(env, ARM_FEATURE_LPAE) && (ttbcr & TTBCR_EAE);
+        }
+        /* The verification is based on FS filed of the DFSR reg only*/
+        return (DFSR_FSC(lpae, dfsr_val) == DFSC_EXTABT(lpae));
+    }
+    return false;
+}
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3dc494aaa7e..11692379055 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1493,3 +1493,52 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 
     return false;
 }
+
+#define ARM64_REG_ESR_EL1 ARM64_SYS_REG(3, 0, 5, 2, 0)
+#define ARM64_REG_TCR_EL1 ARM64_SYS_REG(3, 0, 2, 0, 2)
+
+/*
+ * ESR_EL1
+ * ISS encoding
+ * AARCH64: DFSC,   bits [5:0]
+ * AARCH32:
+ *      TTBCR.EAE == 0
+ *          FS[4]   - DFSR[10]
+ *          FS[3:0] - DFSR[3:0]
+ *      TTBCR.EAE == 1
+ *          FS, bits [5:0]
+ */
+#define ESR_DFSC(aarch64, lpae, v)        \
+    ((aarch64 || (lpae)) ? ((v) & 0x3F)   \
+               : (((v) >> 6) | ((v) & 0x1F)))
+
+#define ESR_DFSC_EXTABT(aarch64, lpae) \
+    ((aarch64) ? 0x10 : (lpae) ? 0x10 : 0x8)
+
+bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+{
+    uint64_t dfsr_val;
+
+    if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
+        ARMCPU *cpu = ARM_CPU(cs);
+        CPUARMState *env = &cpu->env;
+        int aarch64_mode = arm_feature(env, ARM_FEATURE_AARCH64);
+        int lpae = 0;
+
+        if (!aarch64_mode) {
+            uint64_t ttbcr;
+
+            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
+                lpae = arm_feature(env, ARM_FEATURE_LPAE)
+                        && (ttbcr & TTBCR_EAE);
+            }
+        }
+        /*
+         * The verification here is based on the DFSC bits
+         * of the ESR_EL1 reg only
+         */
+         return (ESR_DFSC(aarch64_mode, lpae, dfsr_val) ==
+                ESR_DFSC_EXTABT(aarch64_mode, lpae));
+    }
+    return false;
+}
-- 
2.20.1


