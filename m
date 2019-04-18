Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A4C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB802183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 04:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmzeMY6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB802183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGyLQ-0003sc-Gq
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 00:08:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hGyIg-00029w-EG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hGyId-000213-0p
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:05:26 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1hGyIc-00020P-Jw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:05:22 -0400
Received: by mail-pg1-x541.google.com with SMTP id 10so155117pgv.13
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 21:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+RH+Ui4b5wc2/yJel9rhq51E5AUQ3jvmY6g/+lrpsUM=;
	b=rmzeMY6DTOEbsBEDdWBLnUk8C29lrsLG7mvGkMxVrZP9YBaAfNwmQWDVCp0qzrJTtg
	mDu6nRAPh2f0NDrFFBlA8n5MMZTpgC1PtNPEwhzb/3/wcNbyjagQiWFQp/fHu62PS1Ba
	fQTHKwJ7VH4eN66B/w8NiX/M6ycaDvonMKUanhptzcHFF1E7GmO9U04rHbXSIfoUuMK+
	c82ZEL9O37+Wo/Tp3X2Tg8mkSXth2omzIvH9rjEyZg9Laly25bB8PVzvUSzijhB15Lov
	VwIeL7u4goAHXA/7SMGogNG5Ro5oYcbQjiOS5Embz6wDnsAjX8A5p9WxBE7InHVTcwhv
	50Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+RH+Ui4b5wc2/yJel9rhq51E5AUQ3jvmY6g/+lrpsUM=;
	b=YJhexF5OVG81NNWoG2USpVLuNHgA3rBEAM3MJRhXMyK2CHp9JWd9Ha3v+6VSo1094i
	tDwnfyr8ivNZXhKHTgLEhoPDbe5NHwkH3fmNkkpBF2AkOaipz85B/KS6Fsf8cQTYuhKn
	vfrWkYZ0sPSO4vWvJdK+mGgbC/l5LW69bwq9zHdMbQCU3HQnfceNqbX1NIdzzGcnBywk
	0PJN7uPtlQPLZ67HKh+zSoimjtgs6PAcV3e78o6+DHn8ofdpcBsDkpAeETNXE0L59XBM
	i92BRyKycBlqkQ7gFp6DVA4vfVZYfUyG7CeKkURQbiGJnYqWVWlwV2Ny91yVY3WQlCbJ
	uztg==
X-Gm-Message-State: APjAAAVsyLuKzoC4TRzrz1QHkJWW7ceTphAfsQVATvxO9JgqOV4PS0uv
	qfyftPGcu8xtI7oPSnkpiNaX7w==
X-Google-Smtp-Source: APXvYqxSoGtohXpTHj3lV5DLUrC2VBASBF+twa+EzhNTDmXjMAWVFTdWqjP0RmW1NVWOdXEnIqNy6g==
X-Received: by 2002:a63:720c:: with SMTP id n12mr86693858pgc.348.1555560321545;
	Wed, 17 Apr 2019 21:05:21 -0700 (PDT)
Received: from localhost.localdomain ([38.106.11.25])
	by smtp.gmail.com with ESMTPSA id h8sm910688pfo.149.2019.04.17.21.05.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 17 Apr 2019 21:05:20 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Thu, 18 Apr 2019 12:04:51 +0800
Message-Id: <1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference machine,
 devices part
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, radoslaw.biernacki@linaro.org,
	leif.lindholm@linaro.org, ard.biesheuvel@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418040451.0Ss47BYfwwtnTmZWzpwHnv0jOOS08Wbak3hUIPE7iwM@z>

Following the previous patch, this patch adds peripheral devices to the
newly introduced SBSA-ref machine.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 hw/arm/sbsa-ref.c | 451 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 451 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 652ec13..3fb0027 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "sysemu/device_tree.h"
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
@@ -28,11 +29,28 @@
 #include "kvm_arm.h"
 #include "hw/arm/arm.h"
 #include "hw/boards.h"
+#include "hw/ide/internal.h"
+#include "hw/ide/ahci_internal.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/loader.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/usb.h"
+#include "net/net.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
 
+#define NUM_IRQS        256
+#define NUM_SMMU_IRQS   4
+#define NUM_SATA_PORTS  6
+
+#define VIRTUAL_PMU_IRQ        7
+#define ARCH_GIC_MAINT_IRQ     9
+#define ARCH_TIMER_VIRT_IRQ    11
+#define ARCH_TIMER_S_EL1_IRQ   13
+#define ARCH_TIMER_NS_EL1_IRQ  14
+#define ARCH_TIMER_NS_EL2_IRQ  10
+
 enum {
     SBSA_FLASH,
     SBSA_MEM,
@@ -115,6 +133,415 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_EHCI] = 11,
 };
 
+/*
+ * Firmware on this machine only uses ACPI table to load OS, these limited
+ * device tree nodes are just to let firmware know the info which varies from
+ * command line parameters, so it is not necessary to be fully compatible
+ * with the kernel CPU and NUMA binding rules.
+ */
+static void create_fdt(SBSAMachineState *vms)
+{
+    void *fdt = create_device_tree(&vms->fdt_size);
+    const MachineState *ms = MACHINE(vms);
+    int cpu;
+
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    vms->fdt = fdt;
+
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,sbsa-ref");
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
+
+    if (have_numa_distance) {
+        int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
+        uint32_t *matrix = g_malloc0(size);
+        int idx, i, j;
+
+        for (i = 0; i < nb_numa_nodes; i++) {
+            for (j = 0; j < nb_numa_nodes; j++) {
+                idx = (i * nb_numa_nodes + j) * 3;
+                matrix[idx + 0] = cpu_to_be32(i);
+                matrix[idx + 1] = cpu_to_be32(j);
+                matrix[idx + 2] = cpu_to_be32(numa_info[i].distance[j]);
+            }
+        }
+
+        qemu_fdt_add_subnode(fdt, "/distance-map");
+        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
+                         matrix, size);
+        g_free(matrix);
+    }
+
+    qemu_fdt_add_subnode(vms->fdt, "/cpus");
+
+    for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
+        char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
+        CPUState *cs = CPU(armcpu);
+
+        qemu_fdt_add_subnode(vms->fdt, nodename);
+
+        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
+            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
+                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
+        }
+
+        g_free(nodename);
+    }
+}
+
+static void create_one_flash(const char *name, hwaddr flashbase,
+                             hwaddr flashsize, const char *file,
+                             MemoryRegion *sysmem)
+{
+    /*
+     * Create and map a single flash device. We use the same
+     * parameters as the flash devices on the Versatile Express board.
+     */
+    DriveInfo *dinfo = drive_get_next(IF_PFLASH);
+    DeviceState *dev = qdev_create(NULL, "cfi.pflash01");
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    const uint64_t sectorlength = 256 * 1024;
+
+    if (dinfo) {
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
+                            &error_abort);
+    }
+
+    qdev_prop_set_uint32(dev, "num-blocks", flashsize / sectorlength);
+    qdev_prop_set_uint64(dev, "sector-length", sectorlength);
+    qdev_prop_set_uint8(dev, "width", 4);
+    qdev_prop_set_uint8(dev, "device-width", 2);
+    qdev_prop_set_bit(dev, "big-endian", false);
+    qdev_prop_set_uint16(dev, "id0", 0x89);
+    qdev_prop_set_uint16(dev, "id1", 0x18);
+    qdev_prop_set_uint16(dev, "id2", 0x00);
+    qdev_prop_set_uint16(dev, "id3", 0x00);
+    qdev_prop_set_string(dev, "name", name);
+    qdev_init_nofail(dev);
+
+    memory_region_add_subregion(sysmem, flashbase,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+
+    if (file) {
+        char *fn;
+        int image_size;
+
+        if (drive_get(IF_PFLASH, 0, 0)) {
+            error_report("The contents of the first flash device may be "
+                         "specified with -bios or with -drive if=pflash... "
+                         "but you cannot use both options at once");
+            exit(1);
+        }
+        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, file);
+        if (!fn) {
+            error_report("Could not find ROM image '%s'", file);
+            exit(1);
+        }
+        image_size = load_image_mr(fn, sysbus_mmio_get_region(sbd, 0));
+        g_free(fn);
+        if (image_size < 0) {
+            error_report("Could not load ROM image '%s'", file);
+            exit(1);
+        }
+    }
+}
+
+static void create_flash(const SBSAMachineState *vms,
+                         MemoryRegion *sysmem,
+                         MemoryRegion *secure_sysmem)
+{
+    /*
+     * Create one secure and nonsecure flash devices to fill SBSA_FLASH
+     * space in the memmap, file passed via -bios goes in the first one.
+     */
+    hwaddr flashsize = vms->memmap[SBSA_FLASH].size / 2;
+    hwaddr flashbase = vms->memmap[SBSA_FLASH].base;
+
+    create_one_flash("sbsa-ref.flash0", flashbase, flashsize,
+                     bios_name, secure_sysmem);
+    create_one_flash("sbsa-ref.flash1", flashbase + flashsize, flashsize,
+                     NULL, sysmem);
+}
+
+static void create_secure_ram(SBSAMachineState *vms,
+                              MemoryRegion *secure_sysmem)
+{
+    MemoryRegion *secram = g_new(MemoryRegion, 1);
+    hwaddr base = vms->memmap[SBSA_SECURE_MEM].base;
+    hwaddr size = vms->memmap[SBSA_SECURE_MEM].size;
+
+    memory_region_init_ram(secram, NULL, "sbsa-ref.secure-ram", size,
+                           &error_fatal);
+    memory_region_add_subregion(secure_sysmem, base, secram);
+}
+
+static void create_gic(SBSAMachineState *vms, qemu_irq *pic)
+{
+    DeviceState *gicdev;
+    SysBusDevice *gicbusdev;
+    const char *gictype;
+    uint32_t redist0_capacity, redist0_count;
+    int i;
+
+    gictype = gicv3_class_name();
+
+    gicdev = qdev_create(NULL, gictype);
+    qdev_prop_set_uint32(gicdev, "revision", 3);
+    qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
+    /*
+     * Note that the num-irq property counts both internal and external
+     * interrupts; there are always 32 of the former (mandated by GIC spec).
+     */
+    qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
+    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+
+    redist0_capacity =
+                vms->memmap[SBSA_GIC_REDIST].size / GICV3_REDIST_SIZE;
+    redist0_count = MIN(smp_cpus, redist0_capacity);
+
+    qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
+    qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
+
+    qdev_init_nofail(gicdev);
+    gicbusdev = SYS_BUS_DEVICE(gicdev);
+    sysbus_mmio_map(gicbusdev, 0, vms->memmap[SBSA_GIC_DIST].base);
+    sysbus_mmio_map(gicbusdev, 1, vms->memmap[SBSA_GIC_REDIST].base);
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     */
+    for (i = 0; i < smp_cpus; i++) {
+        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int irq;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs used for this board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+        };
+
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(gicdev,
+                                                   ppibase + timer_irq[irq]));
+        }
+
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev, ppibase
+                                                     + ARCH_GIC_MAINT_IRQ));
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(gicdev, ppibase
+                                                     + VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+
+    for (i = 0; i < NUM_IRQS; i++) {
+        pic[i] = qdev_get_gpio_in(gicdev, i);
+    }
+}
+
+static void create_uart(const SBSAMachineState *vms, qemu_irq *pic, int uart,
+                        MemoryRegion *mem, Chardev *chr)
+{
+    hwaddr base = vms->memmap[uart].base;
+    int irq = vms->irqmap[uart];
+    DeviceState *dev = qdev_create(NULL, "pl011");
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+
+    qdev_prop_set_chr(dev, "chardev", chr);
+    qdev_init_nofail(dev);
+    memory_region_add_subregion(mem, base,
+                                sysbus_mmio_get_region(s, 0));
+    sysbus_connect_irq(s, 0, pic[irq]);
+}
+
+static void create_rtc(const SBSAMachineState *vms, qemu_irq *pic)
+{
+    hwaddr base = vms->memmap[SBSA_RTC].base;
+    int irq = vms->irqmap[SBSA_RTC];
+
+    sysbus_create_simple("pl031", base, pic[irq]);
+}
+
+static DeviceState *gpio_key_dev;
+static void sbsa_ref_powerdown_req(Notifier *n, void *opaque)
+{
+    /* use gpio Pin 3 for power button event */
+    qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
+}
+
+static Notifier sbsa_ref_powerdown_notifier = {
+    .notify = sbsa_ref_powerdown_req
+};
+
+static void create_gpio(const SBSAMachineState *vms, qemu_irq *pic)
+{
+    DeviceState *pl061_dev;
+    hwaddr base = vms->memmap[SBSA_GPIO].base;
+    int irq = vms->irqmap[SBSA_GPIO];
+
+    pl061_dev = sysbus_create_simple("pl061", base, pic[irq]);
+
+    gpio_key_dev = sysbus_create_simple("gpio-key", -1,
+                                        qdev_get_gpio_in(pl061_dev, 3));
+
+    /* connect powerdown request */
+    qemu_register_powerdown_notifier(&sbsa_ref_powerdown_notifier);
+}
+
+static void create_ahci(const SBSAMachineState *vms, qemu_irq *pic)
+{
+    hwaddr base = vms->memmap[SBSA_AHCI].base;
+    int irq = vms->irqmap[SBSA_AHCI];
+    DeviceState *dev;
+    DriveInfo *hd[NUM_SATA_PORTS];
+    SysbusAHCIState *sysahci;
+    AHCIState *ahci;
+    int i;
+
+    dev = qdev_create(NULL, "sysbus-ahci");
+    qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
+
+    sysahci = SYSBUS_AHCI(dev);
+    ahci = &sysahci->ahci;
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < ahci->ports; i++) {
+        if (hd[i] == NULL) {
+            continue;
+        }
+        ide_create_drive(&ahci->dev[i].port, 0, hd[i]);
+    }
+}
+
+static void create_ehci(const SBSAMachineState *vms, qemu_irq *pic)
+{
+    hwaddr base = vms->memmap[SBSA_EHCI].base;
+    int irq = vms->irqmap[SBSA_EHCI];
+    USBBus *usb_bus;
+
+    sysbus_create_simple("platform-ehci-usb", base, pic[irq]);
+
+    usb_bus = usb_bus_find(-1);
+    usb_create_simple(usb_bus, "usb-kbd");
+    usb_create_simple(usb_bus, "usb-mouse");
+}
+
+static void create_smmu(const SBSAMachineState *vms, qemu_irq *pic,
+                        PCIBus *bus)
+{
+    hwaddr base = vms->memmap[SBSA_SMMU].base;
+    int irq =  vms->irqmap[SBSA_SMMU];
+    DeviceState *dev;
+    int i;
+
+    dev = qdev_create(NULL, "arm-smmuv3");
+
+    object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
+                             &error_abort);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    for (i = 0; i < NUM_SMMU_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+    }
+}
+
+static void create_pcie(SBSAMachineState *vms, qemu_irq *pic)
+{
+    hwaddr base_ecam = vms->memmap[SBSA_PCIE_ECAM].base;
+    hwaddr size_ecam = vms->memmap[SBSA_PCIE_ECAM].size;
+    hwaddr base_mmio = vms->memmap[SBSA_PCIE_MMIO].base;
+    hwaddr size_mmio = vms->memmap[SBSA_PCIE_MMIO].size;
+    hwaddr base_mmio_high = vms->memmap[SBSA_PCIE_MMIO_HIGH].base;
+    hwaddr size_mmio_high = vms->memmap[SBSA_PCIE_MMIO_HIGH].size;
+    hwaddr base_pio = vms->memmap[SBSA_PCIE_PIO].base;
+    int irq = vms->irqmap[SBSA_PCIE];
+    MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
+    MemoryRegion *ecam_alias, *ecam_reg;
+    DeviceState *dev;
+    PCIHostState *pci;
+    int i;
+
+    dev = qdev_create(NULL, TYPE_GPEX_HOST);
+    qdev_init_nofail(dev);
+
+    /* Map ECAM space */
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
+                             ecam_reg, 0, size_ecam);
+    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
+
+    /* Map the MMIO space */
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
+                             mmio_reg, base_mmio, size_mmio);
+    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
+
+    /* Map the MMIO_HIGH space */
+    mmio_alias_high = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "pcie-mmio-high",
+                             mmio_reg, base_mmio_high, size_mmio_high);
+    memory_region_add_subregion(get_system_memory(), base_mmio_high,
+                                mmio_alias_high);
+
+    /* Map IO port space */
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
+
+    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
+    }
+
+    pci = PCI_HOST_BRIDGE(dev);
+    if (pci->bus) {
+        for (i = 0; i < nb_nics; i++) {
+            NICInfo *nd = &nd_table[i];
+
+            if (!nd->model) {
+                nd->model = g_strdup("e1000e");
+            }
+
+            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+        }
+    }
+
+    pci_create_simple(pci->bus, -1, "VGA");
+
+    create_smmu(vms, pic, pci->bus);
+}
+
+static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
+{
+    const SBSAMachineState *board = container_of(binfo, SBSAMachineState,
+                                                 bootinfo);
+
+    *fdt_size = board->fdt_size;
+    return board->fdt;
+}
+
 static void sbsa_ref_init(MachineState *machine)
 {
     SBSAMachineState *vms = SBSA_MACHINE(machine);
@@ -125,6 +552,7 @@ static void sbsa_ref_init(MachineState *machine)
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
     const CPUArchIdList *possible_cpus;
     int n, sbsa_max_cpus;
+    qemu_irq pic[NUM_IRQS];
 
     if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
         error_report("sbsa-ref: CPU type other than the built-in "
@@ -209,11 +637,34 @@ static void sbsa_ref_init(MachineState *machine)
                                          machine->ram_size);
     memory_region_add_subregion(sysmem, vms->memmap[SBSA_MEM].base, ram);
 
+    create_fdt(vms);
+
+    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
+
+    create_secure_ram(vms, secure_sysmem);
+
+    create_gic(vms, pic);
+
+    create_uart(vms, pic, SBSA_UART, sysmem, serial_hd(0));
+    create_uart(vms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
+    create_uart(vms, pic, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2));
+
+    create_rtc(vms, pic);
+
+    create_gpio(vms, pic);
+
+    create_ahci(vms, pic);
+
+    create_ehci(vms, pic);
+
+    create_pcie(vms, pic);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.kernel_filename = machine->kernel_filename;
     vms->bootinfo.nb_cpus = smp_cpus;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[SBSA_MEM].base;
+    vms->bootinfo.get_dtb = sbsa_ref_dtb;
     vms->bootinfo.firmware_loaded = firmware_loaded;
     arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
 }
-- 
2.7.4


