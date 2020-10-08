Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3337C04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507CE21927
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtz1avyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507CE21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWuf-0007PV-B4
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs7-0004Wh-FY
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs3-00061B-NG
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id w5so6836126wrp.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KJ/bQldPYsaCR4+FndR920ZofeGys1yXjN1RcJSmlhQ=;
 b=gtz1avypSEGKTSPp0NcGlCqZNS+G3aIwONL1ReP+Ewl4aTgsVYUVTJMOnKb1TSqRhO
 W2z21dpkLuIW3aB0vbcQU1dvAcmdOa9WG16pLMs8GpRj+Q77K+ipdWHEZsN0KnPVs0eJ
 urWBETnCfnUIvDZkcxQilq0WXwbMzPWuno1q6NmvooFz/CswzFCv8zFEAJZW/MR5P6Dd
 dk7iCESWr1Ng6eKuEQAuwT2/Ct7Bx9bSgfYgthB5v1lLRqzUnJ61Xz5yfm5NTS6yQSwL
 7Ua1SjADQMetgHDCfStyskMARdjDduMDFP9nu1Vf9R8SgkNnwwLCfdd2fahS+q6KqaIU
 x7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KJ/bQldPYsaCR4+FndR920ZofeGys1yXjN1RcJSmlhQ=;
 b=lUbdai1OdCQD9D+CNTeGLefqVEh32+aSfBmReLevLb+ZHerMFfs0Co+CWBJ2bnwqch
 ixAvxa/C7OhNNprPblpbfuMbnKXXC9MLipi7RyB44xKxbn6QSeYtXINWM4zRqlFe6s5t
 9N731z4CGdpIsmO+C2T0SyYgnUrvDAGNGGoMV/cbl+kxm00d8tNt0LZ1gS6R1pEC/Uxs
 byq1y1PIZqw1FdzEilfFJITulRSrrJf4DCTtiCRvEhGI7Erta/KPNtcsAm0+fi49ltfy
 n88fjADT284P2eIBNQFFYgIMLDLK2GPv9KNmlyBCUfBtTlmyDjxPjmg+yPHO934HO0KC
 77bw==
X-Gm-Message-State: AOAM530oDfUOYIhldhh0dk+L6wkxG9lph6qNaugYqHq7EE7rn0y2eDTh
 bUOgP8cD2q9xuTSbO01PEZvBewGnwDRm0Yrg
X-Google-Smtp-Source: ABdhPJwF7n26oDmmy14syH4JVwxXT0063nF3UHaptmrNtDDRcvCGLCFEGHXdlAQt4MSBc4Lf0BaDhw==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr9727806wrq.59.1602167173383;
 Thu, 08 Oct 2020 07:26:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] hw/arm/virt: Implement kvm-steal-time
Date: Thu,  8 Oct 2020 15:25:56 +0100
Message-Id: <20201008142557.9845-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Andrew Jones <drjones@redhat.com>

We add the kvm-steal-time CPU property and implement it for machvirt.
A tiny bit of refactoring was also done to allow pmu and pvtime to
use the same vcpu device helper functions.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20201001061718.101915-7-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst | 11 ++++++
 include/hw/arm/virt.h            |  5 +++
 target/arm/cpu.h                 |  4 ++
 target/arm/kvm_arm.h             | 43 +++++++++++++++++++++
 hw/arm/virt.c                    | 43 +++++++++++++++++++--
 target/arm/cpu.c                 |  8 ++++
 target/arm/kvm.c                 | 16 ++++++++
 target/arm/kvm64.c               | 64 +++++++++++++++++++++++++++++---
 target/arm/monitor.c             |  2 +-
 tests/qtest/arm-cpu-features.c   | 25 +++++++++++--
 10 files changed, 208 insertions(+), 13 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 2d5c06cd016..35196a6b759 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -200,6 +200,17 @@ the list of KVM VCPU features and their descriptions.
                            adjustment, also restoring the legacy (pre-5.0)
                            behavior.
 
+  kvm-steal-time           Since v5.2, kvm-steal-time is enabled by
+                           default when KVM is enabled, the feature is
+                           supported, and the guest is 64-bit.
+
+                           When kvm-steal-time is enabled a 64-bit guest
+                           can account for time its CPUs were not running
+                           due to the host not scheduling the corresponding
+                           VCPU threads.  The accounting statistics may
+                           influence the guest scheduler behavior and/or be
+                           exposed to the guest userspace.
+
 SVE CPU Properties
 ==================
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 655b895d5eb..aad6d698412 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -54,6 +54,9 @@
 
 #define PPI(irq) ((irq) + 16)
 
+/* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
+#define PVTIME_SIZE_PER_CPU 64
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
@@ -81,6 +84,7 @@ enum {
     VIRT_PCDIMM_ACPI,
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
+    VIRT_PVTIME,
     VIRT_LOWMEMMAP_LAST,
 };
 
@@ -121,6 +125,7 @@ struct VirtMachineClass {
     bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
     bool kvm_no_adjvtime;
+    bool no_kvm_steal_time;
     bool acpi_expose_flash;
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e4549a8cc0c..cfff1b5c8fe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -24,6 +24,7 @@
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "qapi/qapi-types-common.h"
 
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
@@ -863,6 +864,9 @@ struct ARMCPU {
     bool kvm_vtime_dirty;
     uint64_t kvm_vtime;
 
+    /* KVM steal time */
+    OnOffAuto kvm_steal_time;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index f513702176a..eb81b7059eb 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -267,6 +267,24 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
  */
 void kvm_arm_add_vcpu_properties(Object *obj);
 
+/**
+ * kvm_arm_steal_time_finalize:
+ * @cpu: ARMCPU for which to finalize kvm-steal-time
+ * @errp: Pointer to Error* for error propagation
+ *
+ * Validate the kvm-steal-time property selection and set its default
+ * based on KVM support and guest configuration.
+ */
+void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
+
+/**
+ * kvm_arm_steal_time_supported:
+ *
+ * Returns: true if KVM can enable steal time reporting
+ * and false otherwise.
+ */
+bool kvm_arm_steal_time_supported(void);
+
 /**
  * kvm_arm_aarch32_supported:
  *
@@ -340,6 +358,16 @@ int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_set_irq(CPUState *cs, int irq);
 void kvm_arm_pmu_init(CPUState *cs);
+
+/**
+ * kvm_arm_pvtime_init:
+ * @cs: CPUState
+ * @ipa: Per-vcpu guest physical base address of the pvtime structures
+ *
+ * Initializes PVTIME for the VCPU, setting the PVTIME IPA to @ipa.
+ */
+void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
+
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
 #else
@@ -363,6 +391,11 @@ static inline bool kvm_arm_sve_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_steal_time_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
@@ -396,6 +429,16 @@ static inline void kvm_arm_pmu_init(CPUState *cs)
     g_assert_not_reached();
 }
 
+static inline void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
+{
+    g_assert_not_reached();
+}
+
+static inline void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
 static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)
 {
     g_assert_not_reached();
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 92ab0fd094d..d5095046315 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -151,6 +151,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
+    [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -1666,15 +1667,39 @@ static void finalize_gic_version(VirtMachineState *vms)
  * virt_cpu_post_init() must be called after the CPUs have
  * been realized and the GIC has been created.
  */
-static void virt_cpu_post_init(VirtMachineState *vms)
+static void virt_cpu_post_init(VirtMachineState *vms, int max_cpus,
+                               MemoryRegion *sysmem)
 {
-    bool aarch64, pmu;
+    bool aarch64, pmu, steal_time;
     CPUState *cpu;
 
     aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
     pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
+    steal_time = object_property_get_bool(OBJECT(first_cpu),
+                                          "kvm-steal-time", NULL);
 
     if (kvm_enabled()) {
+        hwaddr pvtime_reg_base = vms->memmap[VIRT_PVTIME].base;
+        hwaddr pvtime_reg_size = vms->memmap[VIRT_PVTIME].size;
+
+        if (steal_time) {
+            MemoryRegion *pvtime = g_new(MemoryRegion, 1);
+            hwaddr pvtime_size = max_cpus * PVTIME_SIZE_PER_CPU;
+
+            /* The memory region size must be a multiple of host page size. */
+            pvtime_size = REAL_HOST_PAGE_ALIGN(pvtime_size);
+
+            if (pvtime_size > pvtime_reg_size) {
+                error_report("pvtime requires a %ld byte memory region for "
+                             "%d CPUs, but only %ld has been reserved",
+                             pvtime_size, max_cpus, pvtime_reg_size);
+                exit(1);
+            }
+
+            memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
+            memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime);
+        }
+
         CPU_FOREACH(cpu) {
             if (pmu) {
                 assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
@@ -1683,6 +1708,10 @@ static void virt_cpu_post_init(VirtMachineState *vms)
                 }
                 kvm_arm_pmu_init(cpu);
             }
+            if (steal_time) {
+                kvm_arm_pvtime_init(cpu, pvtime_reg_base +
+                                         cpu->cpu_index * PVTIME_SIZE_PER_CPU);
+            }
         }
     } else {
         if (aarch64 && vms->highmem) {
@@ -1853,6 +1882,11 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
         }
 
+        if (vmc->no_kvm_steal_time &&
+            object_property_find(cpuobj, "kvm-steal-time")) {
+            object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
+        }
+
         if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
             object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
@@ -1924,7 +1958,7 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms);
 
-    virt_cpu_post_init(vms);
+    virt_cpu_post_init(vms, possible_cpus->len, sysmem);
 
     fdt_add_pmu_nodes(vms);
 
@@ -2566,8 +2600,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
 
 static void virt_machine_5_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_5_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    vmc->no_kvm_steal_time = true;
 }
 DEFINE_VIRT_MACHINE(5, 1)
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 858c5a4bcb3..056319859fb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1310,6 +1310,14 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
+
+    if (kvm_enabled()) {
+        kvm_arm_steal_time_finalize(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0dcb9bfe137..ffe186de8d1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -192,6 +192,16 @@ static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_adjvtime = !value;
 }
 
+static bool kvm_steal_time_get(Object *obj, Error **errp)
+{
+    return ARM_CPU(obj)->kvm_steal_time != ON_OFF_AUTO_OFF;
+}
+
+static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
+{
+    ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(Object *obj)
 {
@@ -207,6 +217,12 @@ void kvm_arm_add_vcpu_properties(Object *obj)
                                         "the virtual counter. VM stopped time "
                                         "will be counted.");
     }
+
+    cpu->kvm_steal_time = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(obj, "kvm-steal-time", kvm_steal_time_get,
+                             kvm_steal_time_set);
+    object_property_set_description(obj, "kvm-steal-time",
+                                    "Set off to disable KVM steal time.");
 }
 
 bool kvm_arm_pmu_supported(void)
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index fae07c3f043..f74bac24574 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -17,6 +17,7 @@
 #include <linux/kvm.h>
 
 #include "qemu-common.h"
+#include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
@@ -397,19 +398,20 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
     return NULL;
 }
 
-static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
+static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
+                                    const char *name)
 {
     int err;
 
     err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
     err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
@@ -426,7 +428,7 @@ void kvm_arm_pmu_init(CPUState *cs)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
     }
@@ -443,12 +445,29 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to set irq for PMU");
         abort();
     }
 }
 
+void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VCPU_PVTIME_CTRL,
+        .attr = KVM_ARM_VCPU_PVTIME_IPA,
+        .addr = (uint64_t)&ipa,
+    };
+
+    if (ARM_CPU(cs)->kvm_steal_time == ON_OFF_AUTO_OFF) {
+        return;
+    }
+    if (!kvm_arm_set_device_attr(cs, &attr, "PVTIME IPA")) {
+        error_report("failed to init PVTIME IPA");
+        abort();
+    }
+}
+
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     uint64_t ret;
@@ -655,6 +674,36 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return true;
 }
 
+void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
+{
+    bool has_steal_time = kvm_arm_steal_time_supported();
+
+    if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
+        if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+            cpu->kvm_steal_time = ON_OFF_AUTO_OFF;
+        } else {
+            cpu->kvm_steal_time = ON_OFF_AUTO_ON;
+        }
+    } else if (cpu->kvm_steal_time == ON_OFF_AUTO_ON) {
+        if (!has_steal_time) {
+            error_setg(errp, "'kvm-steal-time' cannot be enabled "
+                             "on this host");
+            return;
+        } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+            /*
+             * DEN0057A chapter 2 says "This specification only covers
+             * systems in which the Execution state of the hypervisor
+             * as well as EL1 of virtual machines is AArch64.". And,
+             * to ensure that, the smc/hvc calls are only specified as
+             * smc64/hvc64.
+             */
+            error_setg(errp, "'kvm-steal-time' cannot be enabled "
+                             "for AArch32 guests");
+            return;
+        }
+    }
+}
+
 bool kvm_arm_aarch32_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);
@@ -665,6 +714,11 @@ bool kvm_arm_sve_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
+bool kvm_arm_steal_time_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 375f34bfaa7..169d8a64b65 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -103,7 +103,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve128", "sve256", "sve384", "sve512",
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
-    "kvm-no-adjvtime",
+    "kvm-no-adjvtime", "kvm-steal-time",
     NULL
 };
 
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 77b5e30a9cf..d20094d5a70 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -452,6 +452,7 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_set_feature(qts, "max", "pmu", true);
 
     assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
+    assert_has_not_feature(qts, "max", "kvm-steal-time");
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         assert_has_feature_enabled(qts, "max", "aarch64");
@@ -493,6 +494,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
     assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        bool kvm_supports_steal_time;
         bool kvm_supports_sve;
         char max_name[8], name[8];
         uint32_t max_vq, vq;
@@ -500,6 +502,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         QDict *resp;
         char *error;
 
+        assert_error(qts, "cortex-a15",
+            "We cannot guarantee the CPU type 'cortex-a15' works "
+            "with KVM on this host", NULL);
+
         assert_has_feature_enabled(qts, "host", "aarch64");
 
         /* Enabling and disabling pmu should always work. */
@@ -507,16 +513,26 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         assert_set_feature(qts, "host", "pmu", false);
         assert_set_feature(qts, "host", "pmu", true);
 
-        assert_error(qts, "cortex-a15",
-            "We cannot guarantee the CPU type 'cortex-a15' works "
-            "with KVM on this host", NULL);
-
+        /*
+         * Some features would be enabled by default, but they're disabled
+         * because this instance of KVM doesn't support them. Test that the
+         * features are present, and, when enabled, issue further tests.
+         */
+        assert_has_feature(qts, "host", "kvm-steal-time");
         assert_has_feature(qts, "host", "sve");
+
         resp = do_query_no_props(qts, "host");
+        kvm_supports_steal_time = resp_get_feature(resp, "kvm-steal-time");
         kvm_supports_sve = resp_get_feature(resp, "sve");
         vls = resp_get_sve_vls(resp);
         qobject_unref(resp);
 
+        if (kvm_supports_steal_time) {
+            /* If we have steal-time then we should be able to toggle it. */
+            assert_set_feature(qts, "host", "kvm-steal-time", false);
+            assert_set_feature(qts, "host", "kvm-steal-time", true);
+        }
+
         if (kvm_supports_sve) {
             g_assert(vls != 0);
             max_vq = 64 - __builtin_clzll(vls);
@@ -577,6 +593,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
         assert_has_not_feature(qts, "host", "sve");
+        assert_has_not_feature(qts, "host", "kvm-steal-time");
     }
 
     qtest_quit(qts);
-- 
2.20.1


