Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7EBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368372074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jic+duIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368372074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedD8-0007gi-6n
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jedCC-0005tD-E0
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:29:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jedCB-00039x-HI
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:29:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id f185so3052140wmf.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=w+6NOaFlFls8D3nC9x1kOlTsYMd9p22EFlaMUHLZshs=;
 b=jic+duIigQwwbK4619IzvSh0AiA4B4QQuCTNSUVJqvRrkTMqxUsjgsjVq3+sNaiBns
 Nsoua4KhSuyAv52cF03WJU1gJySRhKXrZ3pAA6foREVs/8YeqpX7CF3sYuBNMWcv5Xo/
 5mshbrqUubhrADQMkWLp6rQ8i5nGxiF7yFsSDf5FwJyXKhYrSoQF7mUeSXaHAXuE56NJ
 q1BRLnys3aLaXrTIWH75KAdjGO1z5ZEhO7RCgsPyYr+mjRDFAsPo9RTTdPHvIr0soln0
 U+BgwnPPPHGAIm1bBh5ZRCuquSei+fOodIf5HEvamQTB4zC0RdJfgLqyzft4j+t1FuOz
 61xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=w+6NOaFlFls8D3nC9x1kOlTsYMd9p22EFlaMUHLZshs=;
 b=KaHRYPWwrRPWFyFCVs3xW9CA4OEca+KDYtaon+5ukvyYb7w4QnJ9APMYCEzT13Fbeh
 zR7MT2tnBvTBCUn6RL29lrgy/X9POWrT2HjMc9ToeRCy4GdLNTljIMaVkOnt1wxTxSom
 AO/bkAEr99emILrQoouBYgwmn/k/v+Oly1zKmRyybaWS+3k9pNYveWya1+A7+Bnfzwqg
 lYj3Gr9hKCQnVvwGZ8VYpR/WwhidIK/RCNR1EDfdv00m6oqlnQ3LhWL89lzdeZ6iRYJq
 6MmtTNP7lvo0nFK+oIdlvSBDfhg/G1A8b/yh2+4KUJF2Jknw0LTGgrSiWQ6Iqc0NQjw3
 nNNw==
X-Gm-Message-State: AOAM53166qHX6yj5ClhyEu0iKcZWLfshwEtLw8j+F6IixLVUo6gjbqpi
 GGHuCb2zqw/Bu2Ef3Zi5Z3RCd4n+UsKJ/g==
X-Google-Smtp-Source: ABdhPJyubJqDbMs+wipORBgijIIIt2sWn3Mm075mQ3uI7kGXwETWgXmwBPJ/cggXokP5CeZDDAn22Q==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr8657607wmg.52.1590751741702; 
 Fri, 29 May 2020 04:29:01 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-151-121-39.range86-151.btcentralplus.com. [86.151.121.39])
 by smtp.gmail.com with ESMTPSA id h188sm6449053wmh.2.2020.05.29.04.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 04:29:01 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/2] target/arm: kvm: Handle DABT with no valid ISS
Date: Fri, 29 May 2020 12:27:56 +0100
Message-Id: <20200529112757.32235-2-beata.michalska@linaro.org>
In-Reply-To: <20200529112757.32235-1-beata.michalska@linaro.org>
References: <20200529112757.32235-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=beata.michalska@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate those instruction which is one of the
(many) reasons why KVM will not even try to do so.

Add support for handling those by requesting KVM to inject external
dabt into the quest.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm_arm.h | 11 +++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 677584e..3702f21 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -570,6 +570,8 @@ typedef struct CPUARMState {
         uint64_t esr;
     } serror;
 
+    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
+
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4bdbe6d..bf84224 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
+static bool cap_has_inject_ext_dabt;
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
@@ -244,6 +245,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
+            error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
+        } else {
+            /* Set status for supporting the external dabt injection */
+            cap_has_inject_ext_dabt = kvm_check_extension(s,
+                                    KVM_CAP_ARM_INJECT_EXT_DABT);
+        }
+    }
+
     return ret;
 }
 
@@ -703,9 +714,16 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
         events.exception.serror_esr = env->serror.esr;
     }
 
+    if (cap_has_inject_ext_dabt) {
+        events.exception.ext_dabt_pending = env->ext_dabt_pending;
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
     if (ret) {
         error_report("failed to put vcpu events");
+    } else {
+        /* Clear instantly if the call was successful */
+        env->ext_dabt_pending = 0;
     }
 
     return ret;
@@ -819,7 +837,12 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
-    default:
+    case KVM_EXIT_ARM_NISV:
+        /* External DABT with no valid iss to decode */
+        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+                                       run->arm_nisv.fault_ipa);
+        break;
+     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
         break;
@@ -955,3 +978,42 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+   /*
+    * ISS [23:14] is invalid so there is a limited info
+    * on what has just happened so the only *useful* thing that can
+    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
+    * might be less of a value as well)
+    */
+
+    /*
+     * Request KVM to inject the external data abort into the guest
+     * by setting a pending exception on the affected vcpu.
+     */
+    if (cap_has_inject_ext_dabt) {
+        /* Set pending exception */
+        env->ext_dabt_pending = 1;
+        /*
+         * Even though at this point, the vcpu regs are out of sync,
+         * directly calling the KVM_SET_VCPU_EVENTS ioctl without
+         * explicitly synchronizing those, is enough and it also avoids
+         * overwriting changes done by KVM.
+         * The vcpu is not being marked as 'dirty' as all the changes
+         * needed to inject the abort are being handled by KVM only
+         * and there is no need for syncing either way
+         */
+        return kvm_put_vcpu_events(cpu);
+    } else {
+        error_report("Data abort exception triggered by guest memory access "
+                     "at physical address: 0x"  TARGET_FMT_lx,
+                     (target_ulong)fault_ipa);
+        error_printf("KVM unable to emulate faulting instruction.\n");
+        return -1;
+    }
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 48bf5e1..e939e51 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -453,6 +453,17 @@ struct kvm_guest_debug_arch;
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
 /**
+ * kvm_arm_handle_dabt_nisv:
+ * @cs: CPUState
+ * @esr_iss: ISS encoding (limited) for the exception from Data Abort
+ *           ISV bit set to '0b0' -> no valid instruction syndrome
+ * @fault_ipa: faulting address for the synch data abort
+ *
+ * Returns: 0 if the exception has been handled, < 0 otherwise
+ */
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                            uint64_t fault_ipa);
+/**
  * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
-- 
2.7.4


