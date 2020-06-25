Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04294C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C6A20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHuGizhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C6A20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joa0T-0003Hs-VC
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 18:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1joZz7-0001tw-2o
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:04:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1joZz5-0001S2-5L
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:04:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so7420630wrw.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xqBewfs0yRv9zowM52KWK7aVpkH8u64GAFft74ama6k=;
 b=aHuGizhFNXvtoOoOQkhV6AY8qTFn6eHcgpzse6Ey3DG4fVDY4YHsUhbRNJDLGMUG4G
 Jz1jOZEfCL3OmxRG/jbiRZlQGJ8rqoGfCQR/REdsdHzhW48Y6QGpXesRCZQvK8SxPDXb
 1jwpNlvba2smvhXI5ELEjVCadeLLvt1UTAwSrLe3TVkT9If0Q/7YM1vgkyZt/qb2JN++
 dVQXZnE8f0flPgJt/p4VtlWnkhtilQQ+mkEWoWaZ45Q5oRz7TZvSwaaIywHHAXJ0+fhi
 D9XjzNY7/aIwJH61OL9Hx2f+P/sEPssAJsb+O6FFbCVrEQtRwdHB0UFntkbd85Qb8LFS
 JnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xqBewfs0yRv9zowM52KWK7aVpkH8u64GAFft74ama6k=;
 b=QcNdAPY3uqsSAvKlVb5WDRJgBix2c58FvvUha3ZAHJehRuF7mHmgpTaseQ3eqZ9ZEi
 HsMvSiweD0I6XDpYEDF5mvGlSemMdWoJiGlISsyyR8xMNYfIDcQUNqpYN0CcEgxoptZO
 f98oZamHyvdrSuGW6JBTDuAlHvipHbMYW9P/jzqUMdra1oe3/ovfiqJHWljOSvmzzx+t
 5lDrTPWCKM4JcbGke9l2Edi0kxC23tHWTHFe0vQG0o1QyTQlMu1Yc72QqjtolfuBD+q6
 tFI0x2kj2dGpvGJ4gFpZAQWY1mH3kQNclw+t4tITU1mUiUxLDm3lseTkF3xV7Qme6KTA
 OR2Q==
X-Gm-Message-State: AOAM532AFTIeqoY/A4WYYz6WFl9kHpNFgMPmtTlAtGbCrLqlqb5iy9Dl
 G+Azdcpo2OhfB6fn04z9AfCOh12mferFKw==
X-Google-Smtp-Source: ABdhPJw8L9pew0i5rMwch5DPLjrGZZfv5kS7HkK14p5D0qG3cB0l5PXMDj2qRSEg7bhLPvuMm36/gg==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr335102wrs.270.1593122677110;
 Thu, 25 Jun 2020 15:04:37 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-71.range86-139.btcentralplus.com. [86.139.146.71])
 by smtp.gmail.com with ESMTPSA id l190sm13939277wml.12.2020.06.25.15.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 15:04:36 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/2] target/arm: kvm: Handle DABT with no valid ISS
Date: Thu, 25 Jun 2020 23:03:35 +0100
Message-Id: <20200625220336.10186-2-beata.michalska@linaro.org>
In-Reply-To: <20200625220336.10186-1-beata.michalska@linaro.org>
References: <20200625220336.10186-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=beata.michalska@linaro.org; helo=mail-wr1-x441.google.com
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

On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate those instruction which is one of the
(many) reasons why KVM will not even try to do so.

Add support for handling those by requesting KVM to inject external
dabt into the quest.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index eef3bbd..265c4b8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
+static bool cap_has_inject_ext_dabt;
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
@@ -245,6 +246,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
 
@@ -810,6 +821,47 @@ void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
+/**
+ * kvm_arm_handle_dabt_nisv:
+ * @cs: CPUState
+ * @esr_iss: ISS encoding (limited) for the exception from Data Abort
+ *           ISV bit set to '0b0' -> no valid instruction syndrome
+ * @fault_ipa: faulting address for the synchronous data abort
+ *
+ * Returns: 0 if the exception has been handled, < 0 otherwise
+ */
+static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa)
+{
+    /*
+     * Request KVM to inject the external data abort into the guest
+     */
+    if (cap_has_inject_ext_dabt) {
+        struct kvm_vcpu_events events;
+        /*
+         * KVM_CAP_ARM_INJECT_EXT_DABT support implies one for
+         * KVM_CAP_VCPU_EVENTS
+         */
+        memset(&events, 0, sizeof(events));
+        /*
+         * Skipping all the overhead of syncing vcpu regs back and forth
+         * and messing around with the vcpu_dirty flag to avoid
+         * overwriting changes done by KVM : directly calling
+         * the associated ioctl with the status set for external data abort,
+         * which, in turn, will be directly delivered to the affected vcpu.
+         */
+        events.exception.ext_dabt_pending = 1;
+
+        return kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
+    } else {
+        error_report("Data abort exception triggered by guest memory access "
+                     "at physical address: 0x"  TARGET_FMT_lx,
+                     (target_ulong)fault_ipa);
+        error_printf("KVM unable to emulate faulting instruction.\n");
+    }
+    return -1;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -820,7 +872,12 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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
-- 
2.7.4


