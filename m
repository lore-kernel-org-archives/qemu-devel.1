Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229D021D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjld9RWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229D021D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYmg-0008Qb-67
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlJ-0005yj-JD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlG-0000Tt-OW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id u13so9527246pgh.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BoRDf3bit7IL/G7WkzeTS4vBLLuVcOFhR6tLcvMtZHA=;
 b=wjld9RWo4af1VFX2xsSyA2pu597Rv7UPczc7pXqJP1YoC25m05WD2mWsttmVYSQDuM
 aHI/FjnaG4A5QA+dyg3ivNElGQQUDmtldoqwbCiud5xouSJjwnnok7VCYgY/bEyX1EDh
 btWEN6e+mbqck8YusQLl2lxITBUeZlpP1JJnGI/hu888CsLK1dUzIgawISyFWOqd/8Hx
 PsRFkmloPT90mXEonAhXoNMRG1U3ta2JuQKIU45VeC3QKHKKe5wxw6QefF+xZZzsT5Rw
 KX6eyKN8KsJSxVGbJ31w4PdHjtLOKhB8gnlh8isvEZrFW1nuHRGSAIoGnN6tZ7Z0X4sl
 8yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BoRDf3bit7IL/G7WkzeTS4vBLLuVcOFhR6tLcvMtZHA=;
 b=FIbx0xZDsjyKwssu8rS2dtxqsgmgg03KH6lhW7l/pRekcOMrc+hy5oOcS/G13A6yjV
 e1k2Mmcw0rzqY6Ikptc6nLg3i41ZR9UceT//gIIySRM3Gp/tL0yGdTNiaQ7KtQF51yJd
 K6CbS1t5BBEuSoAmxNGf+fhSLSr0Duq28pApzkgHaUw69Jq5OlZvlHZuEc+3J2e3f6Vp
 /cduZi1AHRwy51cOLniRBH4TOIN/ffUKTOecgIurxcoEThbziNBGeAgOS2eqV857Y9PT
 OdebPUjLJO3728gKHVBZNp5br3Lfz0ppbahQSwlN+DFp6bgCCh++pTSfh+i2PBqhJ8X5
 8uPQ==
X-Gm-Message-State: AOAM530SDVaz4N7jkynb9wuK4SSSYhbode71mLrvSkilfud8JKu9osFJ
 +AfqP0ntR3Cdg7gVt6zkqZi4
X-Google-Smtp-Source: ABdhPJy4ftVz9yl3t+PAzjmIZS1tY41dc5pMS4sAhQ4rLM5t5Q/UsK27Jnc2RG/ycXY68lj1iCT5tw==
X-Received: by 2002:a17:902:848a:: with SMTP id
 c10mr22261749plo.8.1599552833547; 
 Tue, 08 Sep 2020 01:13:53 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:53 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 09/12] hw/arm/virt: spe: Add SPE fdt binding for virt
 machine
Date: Tue,  8 Sep 2020 08:13:27 +0000
Message-Id: <c6ac607d2cd253de6a990538edfde7f86066f04f.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x543.google.com
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
selected in kvmtool.

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
index 6bacfb668d..bdb1ce925c 100644
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
+                }
+                kvm_arm_spe_init(cpu);
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


