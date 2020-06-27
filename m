Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE3C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B612184D
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+lTXTe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B612184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpCkY-0006cB-QH
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 11:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCis-0004Jl-S3
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:26:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCiq-0007TO-CD
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:26:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id g18so12306896wrm.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=n/6jUch7mGHyEeK3tacOaSSb1YHko1j6EhQD5+qAa6A=;
 b=g+lTXTe5bhAAe4vDb1NZ7db+wwa2/yz2oQ8pEwuqKjtmq1B8+GU71Ku9eBNDWwS8CF
 eWKRe5ew5tR2Ug0G1mtMRFJjVhDzNGNDqUAMC/j+PI9HWdCFvzLNz2Zaw7Pb6O9pbeMK
 f2adRDciNW9aSFXPM2LP0r28vxNJZTQBn8LhqlU0JzBCozD25ugt6NDyF5fsTGQKG1i1
 FKIJiF1FAG4F5/7dmhp9ST81S3AUV3dkcl19+Gm6hpYLI6ZTbBrFvYqz6BnLU6cpkzuu
 reIZX4y7MDEXSjASYQpxT/Qb33+x8urCxJVw3s3cUcEIMk2yKU5q8W83sg9V/OW//ZMx
 iZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=n/6jUch7mGHyEeK3tacOaSSb1YHko1j6EhQD5+qAa6A=;
 b=uT48lzv+WuZ8cJadA7OWsZOLs6iI+PlmnY/tZcr0+ehpvjHa8F8xGnhAzXf7lnJiB4
 zP/DtrxYEt4NaOCcu2pKPT3Cd4XDUPHp6riW7ZR3Ly9YZ8/g2MHMAPTIth/8f1qFfBX4
 gUo8UR4bG+Glg/tyKg0RkWe2sYHzQWw7c50cBhA3E1LtJRQDUd3vXzBY/Zlh7xLrbYf7
 MSo5rVN9TrD7VRr+pfIUnXFyzF0k8Sey2Bb6vx/yFjItPZmw7Pye6LFhwvq0nmioY4Wg
 sQa1ZQFje/Ac59Eotf7vOu7i7MxoAmIVWmDy6p+lyFpI8iR0MCTK3wI0bEnf4xco/5hE
 78WA==
X-Gm-Message-State: AOAM532eOn1Fne+PCJ1eMP5hgZBjeQrOL25J5cq2i2TI+nKANBwf682Q
 73TL9Pl0zMn9ite8T6M3l+4Az2EYAesUpw==
X-Google-Smtp-Source: ABdhPJytR/59J4R5jKDmAp1NzkrV1ArjXZp773q1vu5Pr+Yy7tZLW3O7uFXyDBsu0bNeu3Bqjx2kGg==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr9144736wrx.203.1593271586577; 
 Sat, 27 Jun 2020 08:26:26 -0700 (PDT)
Received: from moi-limbo-9350.home (host-92-18-20-3.as13285.net. [92.18.20.3])
 by smtp.gmail.com with ESMTPSA id
 c6sm20965438wma.15.2020.06.27.08.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 08:26:26 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 2/2] target/arm: kvm: Handle misconfigured dabt injection
Date: Sat, 27 Jun 2020 16:25:56 +0100
Message-Id: <20200627152556.7391-3-beata.michalska@linaro.org>
In-Reply-To: <20200627152556.7391-1-beata.michalska@linaro.org>
References: <20200627152556.7391-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=beata.michalska@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, Christoffer.Dall@arm.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 30 +++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 34 ++++++++++++++++++++++++++++++++++
 target/arm/kvm64.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 10 ++++++++++
 5 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 677584e..ed0ff09 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -570,6 +570,8 @@ typedef struct CPUARMState {
         uint64_t esr;
     } serror;
 
+    uint8_t ext_dabt_raised; /* Tracking/verifying injection of ext DABT */
+
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3ea6f9a..66d5ee5 100644
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
@@ -851,7 +876,10 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
          */
         events.exception.ext_dabt_pending = 1;
 
-        return kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
+        if (!kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events)) {
+            env->ext_dabt_raised = 1;
+            return 0;
+        }
     } else {
         error_report("Data abort exception triggered by guest memory access "
                      "at physical address: 0x"  TARGET_FMT_lx,
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 7b3a19e..0af46b4 100644
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
index f09ed9f..88cf10c 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1497,3 +1497,52 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 
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
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 48bf5e1..471ddd1 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -453,6 +453,16 @@ struct kvm_guest_debug_arch;
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
 /**
+ * kvm_arm_verify_ext_dabt_pending:
+ * @cs: CPUState
+ *
+ * Verify the fault status code wrt the Ext DABT injection
+ *
+ * Returns: true if the fault status code is as expected, false otherwise
+ */
+bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);
+
+/**
  * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
-- 
2.7.4


