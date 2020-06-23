Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF8EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0633020738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCja5DE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0633020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhVd-0003ff-95
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHW-0003eU-9z
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:40:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHP-0003Te-G8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:40:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id f139so1439855wmf.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tzG6H3dx3q2JVxVlZDbfro7dUJHnE2QjtMtXPZaJA+0=;
 b=CCja5DE2ZECh2W8PuEL9w6oURea8cnznEHL4ArLGM1RCcgCsroHs352FrubyPuCboY
 3IU5WIoj26Zae/rALGUynzYGWz9+fsE9rQM5Jl+BWxDWpwmQ7mvF5VhV0kehkiRjJBWP
 G8yvSMLsNrrGks3DJMKUd9r98728oAlOQEckxUd55ESh73qaEbabIb9RMkEri2BnISiU
 2Gv8ppju3wAe5V5BEIre5fJ3U6ydcS1QPwybAjh/Oy4pm/kftTR1sq0ObVSZqihLp47Q
 9KNw5clcT0rJgT0Mnj1JYiFAeZfZ+l+ccoWofq/dJP87Paj4+HrFcIk/k0cfzyXhyzD7
 7Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tzG6H3dx3q2JVxVlZDbfro7dUJHnE2QjtMtXPZaJA+0=;
 b=mxo43njKsaosxd9eLhWcmQ2EHPMoxfZhHBjTUf68Mzz/bCMxAxhIXER/ssF9e6n8Ow
 yPCI5d0JGYwJWm9n87TsoJ5i/Ya4B0SvyWewqWU9+e3W4iqjL/ydJl94XjAIqIig19ST
 o57PcjaiCfkGFyEi91lz9oUHX2jtZXsLxyO6rWInG9S1OLhkYSNbLzhS5UorhPE3xpqv
 bkKFTISlAGKyKnP9izhd0de2JUlCH4c58q/phjWRV9d5oSnEOTIHPIuFYCvPCmYWkY/l
 pjXgPwRWIxMrnTPSFzafk1lP4QbPb+XW7UObOlezWHthQyMQ1KM0KpzCwoiUVJK1RjKE
 DHFA==
X-Gm-Message-State: AOAM531DPxub6+BVHZpl++eA9BA9tUYAH7t9Yh7jo4jj75BBvQy8+one
 kaUPTBrUuELU8Zadt2i/iQrDhnV4wYJSzg==
X-Google-Smtp-Source: ABdhPJyZoI5ZrVoGwYF8/c/WCxfeLiL5H2obw1zn3Mwi8Y8zrokUD9gI9k9jm4Q0SwkiTSoew/TMLg==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr23189153wmh.148.1592912392295; 
 Tue, 23 Jun 2020 04:39:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/42] target/arm: Check supported KVM features globally (not
 per vCPU)
Date: Tue, 23 Jun 2020 12:39:02 +0100
Message-Id: <20200623113904.28805-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit d70c996df23f, when enabling the PMU we get:

  $ qemu-system-aarch64 -cpu host,pmu=on -M virt,accel=kvm,gic-version=3
  Segmentation fault (core dumped)

  Thread 1 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
  0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
  2588        ret = ioctl(s->fd, type, arg);
  (gdb) bt
  #0  0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
  #1  0x0000aaaaaae31568 in kvm_check_extension (s=0x0, extension=126) at accel/kvm/kvm-all.c:916
  #2  0x0000aaaaaafce254 in kvm_arm_pmu_supported (cpu=0xaaaaac214ab0) at target/arm/kvm.c:213
  #3  0x0000aaaaaafc0f94 in arm_set_pmu (obj=0xaaaaac214ab0, value=true, errp=0xffffffffe438) at target/arm/cpu.c:1111
  #4  0x0000aaaaab5533ac in property_set_bool (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", opaque=0xaaaaac222730, errp=0xffffffffe438) at qom/object.c:2170
  #5  0x0000aaaaab5512f0 in object_property_set (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1328
  #6  0x0000aaaaab551e10 in object_property_parse (obj=0xaaaaac214ab0, string=0xaaaaac11b4c0 "on", name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1561
  #7  0x0000aaaaab54ee8c in object_apply_global_props (obj=0xaaaaac214ab0, props=0xaaaaac018e20, errp=0xaaaaabd6fd88 <error_fatal>) at qom/object.c:407
  #8  0x0000aaaaab1dd5a4 in qdev_prop_set_globals (dev=0xaaaaac214ab0) at hw/core/qdev-properties.c:1218
  #9  0x0000aaaaab1d9fac in device_post_init (obj=0xaaaaac214ab0) at hw/core/qdev.c:1050
  ...
  #15 0x0000aaaaab54f310 in object_initialize_with_type (obj=0xaaaaac214ab0, size=52208, type=0xaaaaabe237f0) at qom/object.c:512
  #16 0x0000aaaaab54fa24 in object_new_with_type (type=0xaaaaabe237f0) at qom/object.c:687
  #17 0x0000aaaaab54fa80 in object_new (typename=0xaaaaabe23970 "host-arm-cpu") at qom/object.c:702
  #18 0x0000aaaaaaf04a74 in machvirt_init (machine=0xaaaaac0a8550) at hw/arm/virt.c:1770
  #19 0x0000aaaaab1e8720 in machine_run_board_init (machine=0xaaaaac0a8550) at hw/core/machine.c:1138
  #20 0x0000aaaaaaf95394 in qemu_init (argc=5, argv=0xffffffffea58, envp=0xffffffffea88) at softmmu/vl.c:4348
  #21 0x0000aaaaaada3f74 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at softmmu/main.c:48

This is because in frame #2, cpu->kvm_state is still NULL
(the vCPU is not yet realized).

KVM has a hard requirement of all cores supporting the same
feature set. We only need to check if the accelerator supports
a feature, not each vCPU individually.

Fix by removing the 'CPUState *cpu' argument from the
kvm_arm_<FEATURE>_supported() functions.

Fixes: d70c996df23f ('Use CPUState::kvm_state in kvm_arm_pmu_supported')
Reported-by: Haibo Xu <haibo.xu@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 21 +++++++++------------
 target/arm/cpu.c     |  2 +-
 target/arm/cpu64.c   | 10 +++++-----
 target/arm/kvm.c     |  4 ++--
 target/arm/kvm64.c   | 14 +++++---------
 5 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 48bf5e16d58..a4ce4fd93db 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -269,29 +269,26 @@ void kvm_arm_add_vcpu_properties(Object *obj);
 
 /**
  * kvm_arm_aarch32_supported:
- * @cs: CPUState
  *
- * Returns: true if the KVM VCPU can enable AArch32 mode
+ * Returns: true if KVM can enable AArch32 mode
  * and false otherwise.
  */
-bool kvm_arm_aarch32_supported(CPUState *cs);
+bool kvm_arm_aarch32_supported(void);
 
 /**
  * kvm_arm_pmu_supported:
- * @cs: CPUState
  *
- * Returns: true if the KVM VCPU can enable its PMU
+ * Returns: true if KVM can enable the PMU
  * and false otherwise.
  */
-bool kvm_arm_pmu_supported(CPUState *cs);
+bool kvm_arm_pmu_supported(void);
 
 /**
  * kvm_arm_sve_supported:
- * @cs: CPUState
  *
- * Returns true if the KVM VCPU can enable SVE and false otherwise.
+ * Returns true if KVM can enable SVE and false otherwise.
  */
-bool kvm_arm_sve_supported(CPUState *cs);
+bool kvm_arm_sve_supported(void);
 
 /**
  * kvm_arm_get_max_vm_ipa_size:
@@ -359,17 +356,17 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
 static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
 
-static inline bool kvm_arm_aarch32_supported(CPUState *cs)
+static inline bool kvm_arm_aarch32_supported(void)
 {
     return false;
 }
 
-static inline bool kvm_arm_pmu_supported(CPUState *cs)
+static inline bool kvm_arm_pmu_supported(void)
 {
     return false;
 }
 
-static inline bool kvm_arm_sve_supported(CPUState *cs)
+static inline bool kvm_arm_sve_supported(void)
 {
     return false;
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5b7a36b5d7e..e44e18062cf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1108,7 +1108,7 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     ARMCPU *cpu = ARM_CPU(obj);
 
     if (value) {
-        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
+        if (kvm_enabled() && !kvm_arm_pmu_supported()) {
             error_setg(errp, "'pmu' feature not supported by KVM on this host");
             return;
         }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 778cecc2e6c..a0c1d8894b7 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -266,7 +266,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 
     /* Collect the set of vector lengths supported by KVM. */
     bitmap_zero(kvm_supported, ARM_MAX_VQ);
-    if (kvm_enabled() && kvm_arm_sve_supported(CPU(cpu))) {
+    if (kvm_enabled() && kvm_arm_sve_supported()) {
         kvm_arm_sve_get_vls(CPU(cpu), kvm_supported);
     } else if (kvm_enabled()) {
         assert(!cpu_isar_feature(aa64_sve, cpu));
@@ -473,7 +473,7 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+    if (kvm_enabled() && !kvm_arm_sve_supported()) {
         error_setg(errp, "cannot set sve-max-vq");
         error_append_hint(errp, "SVE not supported by KVM on this host\n");
         return;
@@ -519,7 +519,7 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
         error_setg(errp, "cannot enable %s", name);
         error_append_hint(errp, "SVE not supported by KVM on this host\n");
         return;
@@ -556,7 +556,7 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
+    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
         error_setg(errp, "'sve' feature not supported by KVM on this host");
         return;
     }
@@ -751,7 +751,7 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
      * uniform execution state like do_interrupt.
      */
     if (value == false) {
-        if (!kvm_enabled() || !kvm_arm_aarch32_supported(CPU(cpu))) {
+        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
             error_setg(errp, "'aarch64' feature cannot be disabled "
                              "unless KVM is enabled and 32-bit EL1 "
                              "is supported");
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index eef3bbd1cc2..7c672c78b88 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -208,9 +208,9 @@ void kvm_arm_add_vcpu_properties(Object *obj)
     }
 }
 
-bool kvm_arm_pmu_supported(CPUState *cpu)
+bool kvm_arm_pmu_supported(void)
 {
-    return kvm_check_extension(cpu->kvm_state, KVM_CAP_ARM_PMU_V3);
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
 }
 
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index f09ed9f4df3..3dc494aaa7e 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -652,18 +652,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return true;
 }
 
-bool kvm_arm_aarch32_supported(CPUState *cpu)
+bool kvm_arm_aarch32_supported(void)
 {
-    KVMState *s = KVM_STATE(current_accel());
-
-    return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);
 }
 
-bool kvm_arm_sve_supported(CPUState *cpu)
+bool kvm_arm_sve_supported(void)
 {
-    KVMState *s = KVM_STATE(current_accel());
-
-    return kvm_check_extension(s, KVM_CAP_ARM_SVE);
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
@@ -798,7 +794,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         env->features &= ~(1ULL << ARM_FEATURE_PMU);
     }
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        assert(kvm_arm_sve_supported(cs));
+        assert(kvm_arm_sve_supported());
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
     }
 
-- 
2.20.1


