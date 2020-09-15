Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CCCC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0755208DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOo4r4dR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0755208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1V3-0003ZT-Ui
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OE-0000X6-Qt
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:18 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OC-0001jd-Rb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:18 -0400
Received: by mail-pl1-x644.google.com with SMTP id r19so595360pls.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wTYoRE3KabLlNzdAWbQ4B72mCCOePuXWQIvQyEahYoY=;
 b=DOo4r4dR+FsJDwA4pVnXfry/tBoU4vf6YEgnBtQVktT9pq6VSspJxZ4cjjYy6YilQH
 rvNFJ0XIumysM2gHLY5zQnKO80xBRCQbyiXwvN3J05pkOoa+LO4xRfxjqJ5JRovDoOmB
 2gqX3TaE8KVD9gyLkcPwIzTKXuEGpwWfRkQvLtYJf8z6blPDXY3FEulf2w+E/JZlsdec
 V0BUBzXChf/DBSJ/gD80jjorZcCurc/rcYPpYOgsjXmi64CYG+BiQFl0o6XhaeIiTU+o
 fQSAP3qK6JvwkJ4CXXEtN4epUG39LCjCPQEC8EKNOwc2QK+zE2idoBw7Q9D9k70W3Z1S
 5Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wTYoRE3KabLlNzdAWbQ4B72mCCOePuXWQIvQyEahYoY=;
 b=MlxS3GgFQ2OyFhIPmbqXRXVQSQmDj11RsTUXTUOXM0Qi8xjMXhITKULLQ00codDvVD
 ie3QLKbcfb0t1ZGzlt22gur6fy3z3hAl/KBqnS2oS+TITXfue63wx0mxcX9+zPJG3QnI
 JYJXrTCKNOQ0Yp5nZ0DuAQhmdaCAeSCMxa77jBjmpxAhusmZ3humXednkTYm/+BX88hU
 n7Ua19FNw4xMPq9J2Ulq2iCIA/CzzAQHw68PHRMTOfn4RClZuIw9O3cgu+ymyDWsiCc6
 a11ltObi5jJG0kYZiXLeipmaCSb+wXELfWxbhK2cMKjGayYAXQIK73h+OcqCyUbR2LQF
 ZGqw==
X-Gm-Message-State: AOAM532tOdHrG/eAECtczdW04uOf1itbHAh3CxGhszFxLDWe1+IHMFuP
 tGrw3Q9qP5lawpWjHuTaSwEGPaKJzZUrKWk=
X-Google-Smtp-Source: ABdhPJwFxDY9LRvQQZA7ipKMBpySjRlEOiCwE224Deh+Wi0YCtE3DfmtXuxk2l46AxR/OfCInOoN2A==
X-Received: by 2002:a17:902:b58e:: with SMTP id
 a14mr5588089pls.19.1600139535427; 
 Mon, 14 Sep 2020 20:12:15 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:14 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 09/12] hw/arm/virt: spe: Add vSPE device and corresponding
 interrupt support
Date: Tue, 15 Sep 2020 03:11:45 +0000
Message-Id: <dbdcfa7ae3ef6e966ed26a6c862deb1e53396509.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=haibo.xu@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a virtual SPE device for virt machine while using
PPI 5 for SPE overflow interrupt number which has already
selected in kvmtool for the in-kernel irqchip support.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 hw/arm/virt-acpi-build.c    |  3 +++
 hw/arm/virt.c               | 43 ++++++++++++++++++++++++++++++++++++-
 include/hw/acpi/acpi-defs.h |  3 +++
 include/hw/arm/virt.h       |  1 +
 target/arm/cpu.c            |  2 ++
 target/arm/cpu.h            |  2 ++
 6 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9efd7a3881..3fd80fda53 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -665,6 +665,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
         }
+        if (cpu_isar_feature(aa64_spe, armcpu)) {
+            gicc->spe_interrupt = cpu_to_le32(PPI(VIRTUAL_SPE_IRQ));
+        }
         if (vms->virt) {
             gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GIC_MAINT_IRQ));
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6bacfb668d..ee0831922b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -545,6 +545,32 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     }
 }
 
+static void fdt_add_spe_nodes(const VirtMachineState *vms)
+{
+    ARMCPU *armcpu = ARM_CPU(first_cpu);
+    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
+
+    if (!cpu_isar_feature(aa64_spe, armcpu)) {
+        assert(!object_property_get_bool(OBJECT(armcpu), "spe", NULL));
+        return;
+    }
+
+    if (vms->gic_version == VIRT_GIC_VERSION_2) {
+        irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
+                             GIC_FDT_IRQ_PPI_CPU_WIDTH,
+                             (1 << vms->smp_cpus) - 1);
+    }
+
+    qemu_fdt_add_subnode(vms->fdt, "/spe");
+    if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
+        const char compat[] = "arm,statistical-profiling-extension-v1";
+        qemu_fdt_setprop(vms->fdt, "/spe", "compatible",
+                         compat, sizeof(compat));
+        qemu_fdt_setprop_cells(vms->fdt, "/spe", "interrupts",
+                               GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_SPE_IRQ, irqflags);
+    }
+}
+
 static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
@@ -717,6 +743,10 @@ static void create_gic(VirtMachineState *vms)
                                     qdev_get_gpio_in(vms->gic, ppibase
                                                      + VIRTUAL_PMU_IRQ));
 
+        qdev_connect_gpio_out_named(cpudev, "spe-interrupt", 0,
+                                    qdev_get_gpio_in(vms->gic, ppibase
+                                                     + VIRTUAL_SPE_IRQ));
+
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
         sysbus_connect_irq(gicbusdev, i + smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
@@ -1664,11 +1694,12 @@ static void finalize_gic_version(VirtMachineState *vms)
 
 static void virt_cpu_post_init(VirtMachineState *vms)
 {
-    bool aarch64, pmu;
+    bool aarch64, pmu, spe;
     CPUState *cpu;
 
     aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
     pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
+    spe = object_property_get_bool(OBJECT(first_cpu), "spe", NULL);
 
     if (kvm_enabled()) {
         CPU_FOREACH(cpu) {
@@ -1679,6 +1710,14 @@ static void virt_cpu_post_init(VirtMachineState *vms)
                 }
                 kvm_arm_pmu_init(cpu);
             }
+
+            if (spe) {
+                assert(ARM_CPU(cpu)->has_spe == ON_OFF_AUTO_ON);
+                if (kvm_irqchip_in_kernel()) {
+                    kvm_arm_spe_set_irq(cpu, PPI(VIRTUAL_SPE_IRQ));
+                    kvm_arm_spe_init(cpu);
+                }
+            }
         }
     } else {
         if (aarch64 && vms->highmem) {
@@ -1927,6 +1966,8 @@ static void machvirt_init(MachineState *machine)
 
     fdt_add_pmu_nodes(vms);
 
+    fdt_add_spe_nodes(vms);
+
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
 
     if (vms->secure) {
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 38a42f409a..21e58f27c5 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -302,6 +302,9 @@ struct AcpiMadtGenericCpuInterface {
     uint32_t vgic_interrupt;
     uint64_t gicr_base_address;
     uint64_t arm_mpidr;
+    uint8_t  efficiency_class;
+    uint8_t  reserved2[1];
+    uint16_t spe_interrupt; /* ACPI 6.3 */
 } QEMU_PACKED;
 
 typedef struct AcpiMadtGenericCpuInterface AcpiMadtGenericCpuInterface;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 72c269aaa5..6013b6d535 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -49,6 +49,7 @@
 #define ARCH_TIMER_NS_EL1_IRQ 14
 #define ARCH_TIMER_NS_EL2_IRQ 10
 
+#define VIRTUAL_SPE_IRQ 5
 #define VIRTUAL_PMU_IRQ 7
 
 #define PPI(irq) ((irq) + 16)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f211958eaa..786cc6134c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1041,6 +1041,8 @@ static void arm_cpu_initfn(Object *obj)
                              "gicv3-maintenance-interrupt", 1);
     qdev_init_gpio_out_named(DEVICE(cpu), &cpu->pmu_interrupt,
                              "pmu-interrupt", 1);
+    qdev_init_gpio_out_named(DEVICE(cpu), &cpu->spe_interrupt,
+                             "spe-interrupt", 1);
 #endif
 
     /* DTB consumers generally don't in fact care what the 'compatible'
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index baf2bbcee8..395a1e5df8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -800,6 +800,8 @@ struct ARMCPU {
     qemu_irq gicv3_maintenance_interrupt;
     /* GPIO output for the PMU interrupt */
     qemu_irq pmu_interrupt;
+    /* GPIO output for the SPE interrupt */
+    qemu_irq spe_interrupt;
 
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
-- 
2.17.1


