Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F7C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8554206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 20:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJHVnI6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8554206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiOt4-0006Uk-1M
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 15:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iiOs4-0005Mx-G0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iiOs2-0001Rg-K6
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:27:36 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iiOs2-0001Oc-9B
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 15:27:34 -0500
Received: by mail-lf1-x142.google.com with SMTP id v201so7953215lfa.11
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cRpSiBbQozDmyYgJRa0I9YSzeC8XG/jZayq+30fJx3E=;
 b=WJHVnI6L78/ZVkBh0jEK/DmML47DTl/cF+Sp7lG64oOvpW615FqzqSl3V5bg1d1Lu0
 wMSnkJLmd1wyrqhX1SsYXGEkr2kAxGVZUt31ORKQbx6adTNJg2t2pPaLLzmDZjs/i9kn
 OozMmQ46BBOKwCBAIuUAWqqNQpW0lv8wwCP4BxGN/vSE16El7BWr7Ku47Qmn0xOa+Cf+
 26ImWFIOJM0gyhGkNp0AG3scipjDlwv7q9Ks8wa9aQkNlwApFeUXzDft2ThAXl4Txv09
 n5RX5TkOi/8OXwgC35Aff4cIfAF6HbPhU/szAQWDXjcovVxDKoiOSBzvfy10KSCHxNj1
 UjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cRpSiBbQozDmyYgJRa0I9YSzeC8XG/jZayq+30fJx3E=;
 b=d5cafqthMvFiS2MkcZLQYBvgal1S5ROlHduXt5CQevR8s1m54ram7gPTCirGqodu5k
 0Yxh/kVjuHlCUbglGpq9i+MqQBVkGKaLnwaLH5Kx+HfZ5wjPs9cc85/XJhYG3lbfY5Fu
 jZ8BlUDufAM925mod7kHys5hDsbRPIyYrFwq71pztFuXyCxnp8SsovZe/BXSRzIuID54
 Uv7UIngHParEyG5tnV20h2yXl6usUev2jC/pDek+T34uCMRptVPvslpQoXFWn4NDGUsL
 SlGq6Da0pI159IQqGWfMFzIy+dYkvtYB8QAHvEmU1o5extIndRXlPjZAcHANsjK/zc2U
 JSAg==
X-Gm-Message-State: APjAAAVSL4oBXTrgYN7V9IIiVno0NFsvQh+B4a/Mp6ZQDKeRNWHZ7x45
 Sp75CSfWtkEntaO+vyc4bZVnEp0i9Af0tw==
X-Google-Smtp-Source: APXvYqw1rEQ4Qf2bq7sRNo/PD3v4StFCkIUoDTB/R6Iy7iyQTYfklYncyaY8xeEsy6o01ed7sCh9Tg==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr9689410lfp.162.1576873652736; 
 Fri, 20 Dec 2019 12:27:32 -0800 (PST)
Received: from moi-limbo-9350.arm.com (user44-177.satfilm.com.pl.
 [77.91.44.177])
 by smtp.gmail.com with ESMTPSA id g27sm4482353lfj.49.2019.12.20.12.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 12:27:32 -0800 (PST)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/1] target/arm: kvm: Handle DABT with no valid ISS
Date: Fri, 20 Dec 2019 20:27:07 +0000
Message-Id: <20191220202707.30641-2-beata.michalska@linaro.org>
In-Reply-To: <20191220202707.30641-1-beata.michalska@linaro.org>
References: <20191220202707.30641-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Christoffer.Dall@arm.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate those instruction which is one of the
(many) reasons why KVM will not even try to do so.

Add suport for handling those by requesting KVM to inject external
dabt into the quest.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 accel/kvm/kvm-all.c    | 15 +++++++
 accel/stubs/kvm-stub.c |  4 ++
 include/sysemu/kvm.h   |  1 +
 target/arm/cpu.h       |  3 +-
 target/arm/kvm.c       | 95 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c     |  3 ++
 target/arm/kvm64.c     |  3 ++
 target/arm/kvm_arm.h   | 19 +++++++++
 8 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ca00daa2f5..a3ee038142 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2174,6 +2174,14 @@ static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
     }
 }
 
+static void do_kvm_cpu_synchronize_state_force(CPUState *cpu,
+                                               run_on_cpu_data arg)
+{
+    kvm_arch_get_registers(cpu);
+    cpu->vcpu_dirty = true;
+}
+
+
 void kvm_cpu_synchronize_state(CPUState *cpu)
 {
     if (!cpu->vcpu_dirty) {
@@ -2181,6 +2189,13 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
     }
 }
 
+void kvm_cpu_synchronize_state_force(CPUState *cpu)
+{
+    /* Force the sync */
+    run_on_cpu(cpu, do_kvm_cpu_synchronize_state_force, RUN_ON_CPU_NULL);
+}
+
+
 static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
 {
     kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE);
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 82f118d2df..e917d1d55e 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -58,6 +58,10 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
 {
 }
 
+void kvm_cpu_synchronize_state_force(CPUState *cpu)
+{
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     abort();
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9fe233b9bf..0cacc61d8a 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -483,6 +483,7 @@ void kvm_cpu_synchronize_state(CPUState *cpu);
 void kvm_cpu_synchronize_post_reset(CPUState *cpu);
 void kvm_cpu_synchronize_post_init(CPUState *cpu);
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
+void kvm_cpu_synchronize_state_force(CPUState *cpu);
 
 void kvm_init_cpu_signals(CPUState *cpu);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5f70e9e043..e11b5e7438 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -558,7 +558,8 @@ typedef struct CPUARMState {
         uint8_t has_esr;
         uint64_t esr;
     } serror;
-
+    /* Status field for pending extarnal dabt */
+    uint8_t ext_dabt_pending;
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5b82cefef6..10fe739c2d 100644
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
@@ -218,6 +225,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER))
+        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
+            warn_report("Failed to enable DABT NISV cap");
+        }
+
     return ret;
 }
 
@@ -600,6 +612,10 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
         events.exception.serror_esr = env->serror.esr;
     }
 
+    if (cap_has_inject_ext_dabt) {
+        events.exception.ext_dabt_pending = env->ext_dabt_pending;
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
     if (ret) {
         error_report("failed to put vcpu events");
@@ -629,6 +645,8 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
     env->serror.has_esr = events.exception.serror_has_esr;
     env->serror.esr = events.exception.serror_esr;
 
+    env->ext_dabt_pending = events.exception.ext_dabt_pending;
+
     return 0;
 }
 
@@ -701,6 +719,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
+    case KVM_EXIT_ARM_NISV:
+        /* External DAB with no valid iss to decode */
+        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+                                 run->arm_nisv.fault_ipa);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
@@ -835,3 +858,75 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                              uint64_t fault_ipa)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    hwaddr xlat, len;
+    AddressSpace *as = cs->as ? cs->as : &address_space_memory;
+    int store_ins = ((esr_iss >> 6) & 1); /* WnR bit */
+    int ret;
+
+    /*
+     * Note: The ioctl for SET_EVENTS will be triggered before next
+     * KVM_RUN call though the vcpu regs need to be updated before hand
+     * so to not to overwrite changes done by KVM upon injecting the abort.
+     * This sadly requires running sync twice - shame ...
+     */
+    kvm_cpu_synchronize_state(cs);
+   /*
+    * ISS [23:14] is invalid so there is a limited info
+    * on what has just happened so the only *useful* thing that can
+    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
+    * might be less of a value as well)
+    */
+    /* Verify whether the memory being accessed is even recognisable */
+    if (!address_space_translate(as, fault_ipa, &xlat, &len,
+                                 store_ins, MEMTXATTRS_UNSPECIFIED)) {
+        error_report("An attemp to access memory outside of the boundries"
+                     "at 0x" TARGET_FMT_lx, (target_ulong) fault_ipa);
+    } else {
+        uint32_t ins;
+        uint8_t ins_fetched;
+
+        /*
+         * Get current PC before it will get updated to except vector entry
+         */
+        target_ulong ins_addr = is_a64(env) ? env->pc
+                                /* AArch32 mode vs T32 aka Thumb mode */
+                                : env->regs[15] - (env->thumb ? 4 : 8);
+
+        /*
+         * Get the faulting instruction
+         * Instructions have a fixed length of 32 bits
+         * and are always little-endian
+         */
+        ins_fetched = !cpu_memory_rw_debug(cs, ins_addr, (uint8_t *) &ins,
+                                           sizeof(uint32_t), store_ins) ;
+
+        error_report("Data abort exception with no valid ISS generated by "
+                     "memory access at 0x" TARGET_FMT_lx,
+                     (target_ulong)fault_ipa);
+        error_report(ins_fetched ? "%s: 0x%" PRIx32 " (encoded)" : "%s",
+                     "Unable to emulate memory instruction",
+                     (!ins_fetched ? 0 : ldl_le_p(&ins)));
+
+        error_report("Faulting instruction at 0x" TARGET_FMT_lx, ins_addr);
+    }
+    /*
+     * Set pending ext dabt amd trigger SET_EVENTS so that
+     * KVM can inject the abort
+     */
+    env->ext_dabt_pending = 1;
+
+    ret = kvm_put_vcpu_events(cpu);
+
+    /* Get the most up-tp-date state */
+    if (!ret) {
+        /* Hacky but the sync needs to be forced */
+        kvm_cpu_synchronize_state_force(cs);
+    }
+    return ret;
+}
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 32bf8d6757..5539c3a3f2 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -240,6 +240,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     /* Check whether userspace can specify guest syndrome value */
     kvm_arm_init_serror_injection(cs);
 
+    /* Set status for supporting the extarnal dabt injection */
+    kvm_arm_init_ext_dabt_injection(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 876184b8fe..3da4e2e70e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -792,6 +792,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
     /* Check whether user space can specify guest syndrome value */
     kvm_arm_init_serror_injection(cs);
 
+    /* Set status for supporting the extarnal dabt injection */
+    kvm_arm_init_ext_dabt_injection(cs);
+
     return kvm_arm_init_cpreg_list(cpu);
 }
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 8e14d400e8..fe019f2fc9 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -143,6 +143,14 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu);
  */
 void kvm_arm_init_serror_injection(CPUState *cs);
 
+/**
+ * kvm_arm_init_ext_dabt_injection
+ * @cs: CPUState
+ *
+ * Set status for KVM support for Ext DABT injection
+ */
+void kvm_arm_init_ext_dabt_injection(CPUState *cs);
+
 /**
  * kvm_get_vcpu_events:
  * @cpu: ARMCPU
@@ -371,6 +379,17 @@ static inline const char *gicv3_class_name(void)
  */
 bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
 
+/**
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
 /**
  * kvm_arm_hw_debug_active:
  * @cs: CPU State
-- 
2.17.1


