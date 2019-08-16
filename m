Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A04C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C542086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqi493ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C542086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycG8-0007L8-Qf
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6z-0003T0-BX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6x-0005ea-4X
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6v-0005bK-Ka
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:42 -0400
Received: by mail-wm1-x341.google.com with SMTP id g67so4054798wme.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gOG9eP09SX1I4DbWjnDpdxCQC9UZs4XVu+2nUeoKx4w=;
 b=rqi493ckM5eAigzBVOVylWvnd22Z/Rl9aW4cRy9OULGGKUGKAHowCPJZUpeDPwuxk/
 9lhylEhRMlDv+k4FevUHesXRAIbYIKuZuHYpyDo2njsUJHa/B0n6RhkwkYBn9cOV9l4Q
 L8twz7hr98oOUR0kb3HBq6Kh7+EDTzQ845nfRO+6ks4uz5AWs2wfkEe9IfgNxYgr3gQp
 HP+CoVzTl0Ptu2a1hx7gj/F+QGwxQ8+mKMy4ha98CBKGy8nC3/xX8ZUAqbhKXlILvBEH
 rT1Se+jqcXfpfEXMsMYCiU2nxNOjzww9nw5pRiWozGz67BQCi0ekAjIso2mnX/IADDrl
 7HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gOG9eP09SX1I4DbWjnDpdxCQC9UZs4XVu+2nUeoKx4w=;
 b=TUI6o8fGpCy/iVaGtDMrMwWKbTaGcrLmwdHsrrF5Lh67TTrmW2UbIXTphCJls3i9sh
 0LrlFEpsSeU40aH5RXmC+F5N2uv/1rF6+8KLwG71mnYXMl6fn/VVCg81LJlf/9HmLB6e
 SABj2jz5oWKOVwoDTdQeH7eK0sox+EDXpZTqkynLCiGCulAuZsoGJBc1vDuIFHK+u0xX
 o9NSakliV3CIMcOFXDwj8UMXsnQqBTze7p6/gMX6y9Oom454HZrKwNMhemTYxT6ME7IO
 nYuxJu03fS/eg5PUQR+/n9+hMXy0ANgqHAMffW41QwgnVy3nMJDcU7p8fOSoOXOaz80Z
 vdew==
X-Gm-Message-State: APjAAAXApTmTUxsx0Qjgx2mNM1NHvOoAHPu52UcFGjKdtuKg3h1YRhEp
 +irNrw4uPiBIt5tNHnUBF+NazRoLse7kcQ==
X-Google-Smtp-Source: APXvYqwMbUoonxU9jngoQ+SoONtSF/n2jMZt1fCLQrYj2aiJ3K9T1XUCalzHvgQf+xv3CdghyPIKWA==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr7353020wmb.41.1565961460479;
 Fri, 16 Aug 2019 06:17:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:08 +0100
Message-Id: <20190816131719.28244-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 18/29] target/arm/cpu: Ensure we can use the pmu
 with kvm
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

From: Andrew Jones <drjones@redhat.com>

We first convert the pmu property from a static property to one with
its own accessors. Then we use the set accessor to check if the PMU is
supported when using KVM. Indeed a 32-bit KVM host does not support
the PMU, so this check will catch an attempt to use it at property-set
time.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 14 ++++++++++++++
 target/arm/cpu.c     | 30 +++++++++++++++++++++++++-----
 target/arm/kvm.c     |  7 +++++++
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 98af1050a75..b3106c8600a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -216,6 +216,15 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
  */
 bool kvm_arm_aarch32_supported(CPUState *cs);
 
+/**
+ * bool kvm_arm_pmu_supported:
+ * @cs: CPUState
+ *
+ * Returns: true if the KVM VCPU can enable its PMU
+ * and false otherwise.
+ */
+bool kvm_arm_pmu_supported(CPUState *cs);
+
 /**
  * kvm_arm_get_max_vm_ipa_size - Returns the number of bits in the
  * IPA address space supported by KVM
@@ -261,6 +270,11 @@ static inline bool kvm_arm_aarch32_supported(CPUState *cs)
     return false;
 }
 
+static inline bool kvm_arm_pmu_supported(CPUState *cs)
+{
+    return false;
+}
+
 static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     return -ENOENT;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ec2ab95dbeb..2399c144718 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -994,10 +994,6 @@ static Property arm_cpu_has_el3_property =
 static Property arm_cpu_cfgend_property =
             DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
 
-/* use property name "pmu" to match other archs and virt tools */
-static Property arm_cpu_has_pmu_property =
-            DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
-
 static Property arm_cpu_has_vfp_property =
             DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
 
@@ -1020,6 +1016,29 @@ static Property arm_cpu_pmsav7_dregion_property =
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
 
+static bool arm_get_pmu(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    return cpu->has_pmu;
+}
+
+static void arm_set_pmu(Object *obj, bool value, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    if (value) {
+        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
+            error_setg(errp, "'pmu' feature not supported by KVM on this host");
+            return;
+        }
+        set_feature(&cpu->env, ARM_FEATURE_PMU);
+    } else {
+        unset_feature(&cpu->env, ARM_FEATURE_PMU);
+    }
+    cpu->has_pmu = value;
+}
+
 static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
@@ -1094,7 +1113,8 @@ void arm_cpu_post_init(Object *obj)
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
-        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_pmu_property,
+        cpu->has_pmu = true;
+        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu,
                                  &error_abort);
     }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index fe4f461d4ef..bfe3d445e19 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -162,6 +162,13 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
     env->features = arm_host_cpu_features.features;
 }
 
+bool kvm_arm_pmu_supported(CPUState *cpu)
+{
+    KVMState *s = KVM_STATE(current_machine->accelerator);
+
+    return kvm_check_extension(s, KVM_CAP_ARM_PMU_V3);
+}
+
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
-- 
2.20.1


