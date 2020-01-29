Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFCFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E289120702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 20:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNhJAHRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E289120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwtv0-0006vo-2G
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 15:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iwtts-0005TD-Ts
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iwttr-0001QK-8g
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:24 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iwttr-0001PP-2R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 15:25:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id a9so1459477wmj.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3PMJxyEZQKPRv3ChqMJ50kyAGa0z3Vg9tRNElquTZ/0=;
 b=fNhJAHRq2EN91vTVf0CAQUgHY4DtJ/A/2LLb5mhJ0E05EIlyjL4YIVwyDmEJ7NlVto
 SDscTPCbUKxTTv9/CODpREQcWCq74yLtZCsKd0AH/FgHyvEteIqm3LEm/XJ/yjxVaD9Y
 sRN412CxoXboUeIRMxQPUFcvWozunecAdBaw5qFikas7hCvZfcnx9VXG55SsKUZ9t+6j
 ro0kyF57Pbuu98dItwHupg8aK0aDD6mSyHXky9nbjUdyMDepkgMqRle+JPaVTF6pde1H
 5+tKN4c17vu8l0EMr3LHnEeWsjaqS6z3yEolmmb95g8geYSmoBOrFD30CLZc2HkqCN/l
 +B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3PMJxyEZQKPRv3ChqMJ50kyAGa0z3Vg9tRNElquTZ/0=;
 b=o3j66oCKCYBM1thiK6Mtf75HRnCx/NulPKt8RzUES+HLIaY7q8Ye5Adf7w8kcYpYM9
 QHlERC3kGz+9tItE+/Fo2fv6OWMRMDDdPZeIXVCFJy8VQnu6G78kGfE0jLNZZ0P30SEh
 YRnPddpEAT35qreCBgBFiWZlU0ZwFsyrhHpvsGY0c1attpcU6QoT5yLma3mPABZ9QXpM
 tj6vX0pUho1K/akpUwpawpuu8anPcrwE19RtvBuhmc17psyNG5u0xAgJv+WjhhuuSZ1j
 51jDNAltWMFitGF4K3vqGTkJJrBRnWlIlMqGsfriV+ve0W0623YL5KVVKI0MZ0CzfyTn
 w0Ow==
X-Gm-Message-State: APjAAAWKPmFeqV2Y6eZpSGcqnvMYPFJFbbmOlFgPRDK8QQltEb0tbbhv
 AtQjJRU78Jr/vI+yFM9rHyinZX7mWTM=
X-Google-Smtp-Source: APXvYqz0g4iA87jEhRZKDy8rnbBNpe5mS1Sq4+hRJ+aen45gH8zyb+FOKLZALrAC49Oolhj9SDrc4w==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr1013034wmf.55.1580329521606; 
 Wed, 29 Jan 2020 12:25:21 -0800 (PST)
Received: from moi-limbo-9350.home
 (host86-131-78-194.range86-131.btcentralplus.com. [86.131.78.194])
 by smtp.gmail.com with ESMTPSA id h2sm4377518wrt.45.2020.01.29.12.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 12:25:21 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] target/arm: kvm: Handle DABT with no valid ISS
Date: Wed, 29 Jan 2020 20:24:41 +0000
Message-Id: <20200129202441.12745-3-beata.michalska@linaro.org>
In-Reply-To: <20200129202441.12745-1-beata.michalska@linaro.org>
References: <20200129202441.12745-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, kvmarm@lists.cs.columbia.edu,
 Christoffer.Dall@arm.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate those instruction which is one of the
(many) reasons why KVM will not even try to do so.

Add support for handling those by requesting KVM to inject external
dabt into the quest.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   |  3 ++
 target/arm/kvm64.c   |  3 ++
 target/arm/kvm_arm.h | 19 +++++++++++
 5 files changed, 123 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c1aedbe..e04a8d3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -558,6 +558,8 @@ typedef struct CPUARMState {
         uint8_t has_esr;
         uint64_t esr;
     } serror;
+    /* Status field for pending external dabt */
+    uint8_t ext_dabt_pending;
 
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8d82889..e7bc9b7 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -37,6 +37,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
+static bool cap_has_inject_ext_dabt; /* KVM_CAP_ARM_INJECT_EXT_DABT */
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
@@ -62,6 +63,12 @@ void kvm_arm_init_serror_injection(CPUState *cs)
                                     KVM_CAP_ARM_INJECT_SERROR_ESR);
 }
 
+void kvm_arm_init_ext_dabt_injection(CPUState *cs)
+{
+    cap_has_inject_ext_dabt = kvm_check_extension(cs->kvm_state,
+                                    KVM_CAP_ARM_INJECT_EXT_DABT);
+}
+
 bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
                                       int *fdarray,
                                       struct kvm_vcpu_init *init)
@@ -216,6 +223,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER))
+        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
+            warn_report("Failed to enable DABT NISV cap");
+        }
+
     return ret;
 }
 
@@ -598,6 +610,10 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
         events.exception.serror_esr = env->serror.esr;
     }
 
+    if (cap_has_inject_ext_dabt) {
+        events.exception.ext_dabt_pending = env->ext_dabt_pending;
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
     if (ret) {
         error_report("failed to put vcpu events");
@@ -627,6 +643,8 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
     env->serror.has_esr = events.exception.serror_has_esr;
     env->serror.esr = events.exception.serror_esr;
 
+    env->ext_dabt_pending = events.exception.ext_dabt_pending;
+
     return 0;
 }
 
@@ -634,6 +652,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
 }
 
+
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu;
@@ -699,6 +718,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
+    case KVM_EXIT_ARM_NISV:
+        /* External DABT with no valid iss to decode */
+        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+                                       run->arm_nisv.fault_ipa);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
@@ -833,3 +857,75 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint32_t ins, ins_fetched;
+
+    /*
+     * Hacky workaround for kernels that for aarch32 guests, instead of expected
+     * external data abort, inject the IMPLEMENTATION DEFINED exception with the
+     * lock-down. This is actually handled by the guest which results in
+     * re-running the faulting instruction.
+     * This intends to break the vicious cycle.
+     */
+    if (!is_a64(env)) {
+        static uint8_t setback;
+
+        /*
+         * The state has not been synchronized yet, so if this is re-occurrence
+         * of the same abort triggered by guest, the status for pending external
+         * abort should not get cleared yet
+         */
+        if (unlikely(env->ext_dabt_pending)) {
+            if (setback) {
+                error_report("Most probably triggered kernel issue with"
+                             " injecting external data abort.");
+                error_printf("Giving up trying ...\n");
+                /* Here is where the fun comes to an end */
+                return -EINVAL;
+            }
+        }
+        setback = env->ext_dabt_pending;
+    }
+
+    kvm_cpu_synchronize_state(cs);
+   /*
+    * ISS [23:14] is invalid so there is a limited info
+    * on what has just happened so the only *useful* thing that can
+    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
+    * might be less of a value as well)
+    */
+
+    /*
+     * Get current PC before it will get updated to exception vector entry
+     */
+    target_ulong ins_addr = is_a64(env) ? env->pc : env->regs[15];
+
+    /*
+     * Get the faulting instruction
+     * Instructions have a fixed length of 32 bits
+     * and are always little-endian
+     */
+    ins_fetched = !cpu_memory_rw_debug(cs, ins_addr, (uint8_t *) &ins,
+                                       sizeof(uint32_t), 0);
+
+    error_report("Data abort exception with no valid ISS generated by "
+                 "guest memory access at physical address: 0x" TARGET_FMT_lx,
+                 (target_ulong)fault_ipa);
+
+    error_printf(ins_fetched ? "%s : 0x%" PRIx32 " (ins encoded)\n"  : "%s\n",
+                 "KVM unable to emulate faulting instruction",
+                 (!ins_fetched ? 0 : ldl_le_p(&ins)));
+    error_printf("Injecting a data abort exception into guest.\n");
+    /*
+     * Set pending ext dabt and trigger SET_EVENTS so that
+     * KVM can inject the abort
+     */
+    env->ext_dabt_pending = 1;
+
+    return 0;
+}
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index cf2b47f..177402e 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -240,6 +240,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     /* Check whether userspace can specify guest syndrome value */
     kvm_arm_init_serror_injection(cs);
 
+    /* Set status for supporting the external dabt injection */
+    kvm_arm_init_ext_dabt_injection(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index d06fd32..a474369 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -791,6 +791,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     /* Check whether user space can specify guest syndrome value */
     kvm_arm_init_serror_injection(cs);
 
+    /* Set status for supporting the external dabt injection */
+    kvm_arm_init_ext_dabt_injection(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8e14d40..fe019f2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -144,6 +144,14 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu);
 void kvm_arm_init_serror_injection(CPUState *cs);
 
 /**
+ * kvm_arm_init_ext_dabt_injection
+ * @cs: CPUState
+ *
+ * Set status for KVM support for Ext DABT injection
+ */
+void kvm_arm_init_ext_dabt_injection(CPUState *cs);
+
+/**
  * kvm_get_vcpu_events:
  * @cpu: ARMCPU
  *
@@ -372,6 +380,17 @@ static inline const char *gicv3_class_name(void)
 bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
 
 /**
+ * kvm_arm_handle_dabt_nisv
+ * @cs: CPUState
+ * @esr_iss: ISS encoding (limited) for the exception from Data Abort
+ *           ISV bit set to '0b0' -> no valid instruction syndrome
+ * @fault_ipa: faulting address for the synch data abort
+ *
+ * Returns: 0 if the exception has been handled
+ */
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa);
+/**
  * kvm_arm_hw_debug_active:
  * @cs: CPU State
  *
-- 
2.7.4


