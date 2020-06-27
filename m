Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D1C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA3E21852
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiLDQW9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA3E21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpCjb-0005OD-1x
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 11:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCin-0004Cw-Pn
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:26:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpCim-0007Sr-6h
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:26:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id a6so12285690wrm.4
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sywPQP4YPO8LGxojbcR8IAxntZAWNms0b4i/i1pRSn4=;
 b=SiLDQW9dcgpRB6D+KHc4ARCZLzJcBv9wbmBl4Y3XnNwMMNDquQ8xAkUMQEk4NEqz3I
 US+u4+pR37pYZkW+V+ev0Q7MSo0Zn64BTrOlt06UXkFpBxQmdAkYWi6hyCIp6IX7qecu
 LM1cZqdjmiechPF2m2IKTwf+V2pkZYu/o16dP68nrFoL/AAkEk1GF7aN5QJ4YxHr+6aL
 ZWzsmV26h+uK0gijybQkuWz1WZ6mRGFPLnjXuztj4iiJ5+jQGSfw4cuvAx1sr5tqo9VB
 KrcQljcWTBykuVNj1ecLPGi7tR1Pj+AcDivbiYcOnehl1cb6ABsHZJ9HTlVJWg3nGSKC
 DXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sywPQP4YPO8LGxojbcR8IAxntZAWNms0b4i/i1pRSn4=;
 b=scoCswDhkZ/c6Qt+CMVVPh0EJWRN/FPpihpotO8A9Qxl3s0PXXdxKogvKQA4NPv+H1
 5WcMWGeqhHIPixE9DfeJBlgiXiyF4IkFfE0sEg9armlqClQOti7GY9MplMvju0NgjVhB
 GL0Fm5V8/hAv2+e4euaFqhPS9SHLjW1GLGn0vzW5+qD8Leh+dj7Gn4hVQTYYiguVkXPq
 dEHVCHiZClECN3vAvHIDx4h3e0AzhpdHVq6FI0M00OQoZ3fvKkBpjNJKiSbbgsNKib/7
 AluVrdxtXYoV8DNejS/qIMuLdHqpxN9YH7sfYTM2n9aXQ2fBPUnwLFu1dG7Emr/R+amK
 ZZvg==
X-Gm-Message-State: AOAM531+4fW8K4oU7Abi0ICPy7xuieMBQJNS3PSJ8cWSfdKwl5IFOWz9
 UiUGSzLuSxJi4mC8bUrRqKzjk/FNOASKvA==
X-Google-Smtp-Source: ABdhPJxkoUM9UcCa/lpe3+bR7cO6H5cyDGmpNECjgEgD+ajwHt0wfs6AcwU6Nii6I2V10pX1h16kXQ==
X-Received: by 2002:adf:f388:: with SMTP id m8mr9219258wro.338.1593271582640; 
 Sat, 27 Jun 2020 08:26:22 -0700 (PDT)
Received: from moi-limbo-9350.home (host-92-18-20-3.as13285.net. [92.18.20.3])
 by smtp.gmail.com with ESMTPSA id
 c6sm20965438wma.15.2020.06.27.08.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 08:26:22 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 1/2] target/arm: kvm: Handle DABT with no valid ISS
Date: Sat, 27 Jun 2020 16:25:55 +0100
Message-Id: <20200627152556.7391-2-beata.michalska@linaro.org>
In-Reply-To: <20200627152556.7391-1-beata.michalska@linaro.org>
References: <20200627152556.7391-1-beata.michalska@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=beata.michalska@linaro.org; helo=mail-wr1-x443.google.com
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
 target/arm/kvm.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index eef3bbd..3ea6f9a 100644
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
 
@@ -810,6 +821,46 @@ void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
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
+        /*
+         * KVM_CAP_ARM_INJECT_EXT_DABT support implies one for
+         * KVM_CAP_VCPU_EVENTS
+         */
+        struct kvm_vcpu_events events = { };
+        /*
+         * The external data abort event will be handled immediately by KVM
+         * using the address fault that triggered the exit on given VCPU.
+         * Requesting injection of the external data abort does not rely
+         * on any other VCPU state. Therefore, in this particular case, the VCPU
+         * synchronization can be exceptionally skipped.
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
@@ -820,7 +871,12 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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


