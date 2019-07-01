Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE9C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B152146F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZDSSWEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B152146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3WE-0005zB-Eq
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:07:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45480)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Eb-00023T-N6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3EV-0001uo-Ce
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:49:07 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3ET-0001pb-Cd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:49:01 -0400
Received: by mail-wm1-f51.google.com with SMTP id s15so926900wmj.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YreNQHlm+doIoZhj84WwaRq/l3PPbbq8nMhtQ4YKDMQ=;
 b=IZDSSWEtGbhGJUG7oVffLANDiMjIWTrtMt8zpbg5F60w38RFwTCsvZsqbmBcf3nV8S
 stDA/5xOx5Y8xVs0CDbtcV4/zo9A4NNM5PcHRgpaDvEiScTJ8r3m4UkHI1IozT7Oj1tW
 dfNBc0RkdNZnNSMdGPVBJkGppYuh7ch793nTtD+IJAi5TMSqzJjXVYenOoXp3gZLeYSD
 Hsce237cfTb9oY9ikyKhhz67YabxrcyysFeiETUF3cLzNCI0wk6I/ZneR37cxP6lw0Ya
 LpiXiDtigu+JMu+jtnildX/D0jn4PStwd0c/O7MrYG1Ztyv2YVv570ZSKqoPArkcDgnh
 NVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YreNQHlm+doIoZhj84WwaRq/l3PPbbq8nMhtQ4YKDMQ=;
 b=PxWBlwGNERZrcA916ZzKufVopy9E0ABsYkBrd8PvB05piOPG1ZuTLijqQGZrsQ2qcT
 3gy8QNCVVjiN1D35x2CECngfqmNk8Dm+6MwMkt3KqniqLQKxGiX1yfBpbVyOuyMM9Cw+
 3F3YSC/kgcBBwjAOjhF5r8ncOq8D/hy9RB7Msan3gmj+F+RDqwfgHZfUbiPo3ANir8h5
 rNXKbfUjW9u1bOEHHeTnT5GpiebUDKaK5iqTiTgLVeax3yD3EoEKLIOE1/IjSZSlHbdL
 BLk0A7H/RHmYsyhMKlv3DVCRB27Mmo7HLu3o2ovxhkMwEvOOztE8rkNO2qWql6Haf3/2
 rh7g==
X-Gm-Message-State: APjAAAXnrvn4KgD73W84cLZmux5UdgUw2g8cSheuOK47afb7NGTim3V/
 G7bjCOdF0qvfUekSmz7RCFlJvRr6BIerxw==
X-Google-Smtp-Source: APXvYqx18mwzL1PZziFNq6r3eSfQCHh9TMXSEdkkUrDTiGMtA5WBpN/m2+ADeVcao/GHDE8Mdy1xkA==
X-Received: by 2002:a1c:c109:: with SMTP id r9mr106312wmf.143.1561999213481;
 Mon, 01 Jul 2019 09:40:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:23 +0100
Message-Id: <20190701163943.22313-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.51
Subject: [Qemu-devel] [PULL 26/46] hw/arm: Add arm SBSA reference machine,
 skeleton part
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

From: Hongbo Zhang <hongbo.zhang@linaro.org>

For AArch64, the existing "virt" machine is primarily meant to
run on KVM and execute virtualization workloads, but we need an
environment as faithful as possible to physical hardware, for supporting
firmware and OS development for physical Aarch64 machines.

This patch introduces new machine type 'sbsa-ref' with main features:
 - Based on 'virt' machine type.
 - A new memory map.
 - CPU type cortex-a57.
 - EL2 and EL3 are enabled.
 - GIC version 3.
 - System bus AHCI controller.
 - System bus EHCI controller.
 - CDROM and hard disc on AHCI bus.
 - E1000E ethernet card on PCIE bus.
 - VGA display adaptor on PCIE bus.
 - No virtio devices.
 - No fw_cfg device.
 - No ACPI table supplied.
 - Only minimal device tree nodes.

Arm Trusted Firmware and UEFI porting to this are done accordingly,
and the firmware should supply ACPI tables to the guest OS.  The
minimal device tree nodes supplied by QEMU for this platform are only
to pass the dynamic info reflecting command line input to firmware,
not for loading the guest OS.

To make the review easier, this task is split into two patches, the
fundamental skeleton part and the peripheral devices part; this patch is
the first part.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
Message-id: 1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org
[PMM: commit message tweaks; moved some bits between patch 1 and 2
 to ensure patch 1 builds cleanly; removed unneeded lines from
 Kconfig stanza; only provide board for qemu-system-aarch64, not
 qemu-system-arm; added MAINTAINERS entry]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs                |   1 +
 hw/arm/sbsa-ref.c                   | 271 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   8 +
 default-configs/aarch64-softmmu.mak |   1 +
 hw/arm/Kconfig                      |  14 ++
 5 files changed, 295 insertions(+)
 create mode 100644 hw/arm/sbsa-ref.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 994e67dd0da..43ce8d5b19f 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -19,6 +19,7 @@ obj-$(CONFIG_SPITZ) += spitz.o
 obj-$(CONFIG_TOSA) += tosa.o
 obj-$(CONFIG_Z2) += z2.o
 obj-$(CONFIG_REALVIEW) += realview.o
+obj-$(CONFIG_SBSA_REF) += sbsa-ref.o
 obj-$(CONFIG_STELLARIS) += stellaris.o
 obj-$(CONFIG_COLLIE) += collie.o
 obj-$(CONFIG_VERSATILE) += versatilepb.o
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
new file mode 100644
index 00000000000..b2e7d10bada
--- /dev/null
+++ b/hw/arm/sbsa-ref.c
@@ -0,0 +1,271 @@
+/*
+ * ARM SBSA Reference Platform emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Hongbo Zhang <hongbo.zhang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
+#include "exec/hwaddr.h"
+#include "kvm_arm.h"
+#include "hw/arm/boot.h"
+#include "hw/boards.h"
+#include "hw/intc/arm_gicv3_common.h"
+
+#define RAMLIMIT_GB 8192
+#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
+
+enum {
+    SBSA_FLASH,
+    SBSA_MEM,
+    SBSA_CPUPERIPHS,
+    SBSA_GIC_DIST,
+    SBSA_GIC_REDIST,
+    SBSA_SMMU,
+    SBSA_UART,
+    SBSA_RTC,
+    SBSA_PCIE,
+    SBSA_PCIE_MMIO,
+    SBSA_PCIE_MMIO_HIGH,
+    SBSA_PCIE_PIO,
+    SBSA_PCIE_ECAM,
+    SBSA_GPIO,
+    SBSA_SECURE_UART,
+    SBSA_SECURE_UART_MM,
+    SBSA_SECURE_MEM,
+    SBSA_AHCI,
+    SBSA_EHCI,
+};
+
+typedef struct MemMapEntry {
+    hwaddr base;
+    hwaddr size;
+} MemMapEntry;
+
+typedef struct {
+    MachineState parent;
+    struct arm_boot_info bootinfo;
+    int smp_cpus;
+    void *fdt;
+    int fdt_size;
+    int psci_conduit;
+} SBSAMachineState;
+
+#define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
+#define SBSA_MACHINE(obj) \
+    OBJECT_CHECK(SBSAMachineState, (obj), TYPE_SBSA_MACHINE)
+
+static const MemMapEntry sbsa_ref_memmap[] = {
+    /* 512M boot ROM */
+    [SBSA_FLASH] =              {          0, 0x20000000 },
+    /* 512M secure memory */
+    [SBSA_SECURE_MEM] =         { 0x20000000, 0x20000000 },
+    /* Space reserved for CPU peripheral devices */
+    [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
+    [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
+    [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
+    [SBSA_UART] =               { 0x60000000, 0x00001000 },
+    [SBSA_RTC] =                { 0x60010000, 0x00001000 },
+    [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
+    [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
+    [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
+    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
+    /* Space here reserved for more SMMUs */
+    [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
+    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
+    /* Space here reserved for other devices */
+    [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
+    /* 32-bit address PCIE MMIO space */
+    [SBSA_PCIE_MMIO] =          { 0x80000000, 0x70000000 },
+    /* 256M PCIE ECAM space */
+    [SBSA_PCIE_ECAM] =          { 0xf0000000, 0x10000000 },
+    /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
+    [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
+    [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
+};
+
+static void sbsa_ref_init(MachineState *machine)
+{
+    SBSAMachineState *sms = SBSA_MACHINE(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    const CPUArchIdList *possible_cpus;
+    int n, sbsa_max_cpus;
+
+    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
+        error_report("sbsa-ref: CPU type other than the built-in "
+                     "cortex-a57 not supported");
+        exit(1);
+    }
+
+    if (kvm_enabled()) {
+        error_report("sbsa-ref: KVM is not supported for this machine");
+        exit(1);
+    }
+
+    /*
+     * This machine has EL3 enabled, external firmware should supply PSCI
+     * implementation, so the QEMU's internal PSCI is disabled.
+     */
+    sms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+
+    sbsa_max_cpus = sbsa_ref_memmap[SBSA_GIC_REDIST].size / GICV3_REDIST_SIZE;
+
+    if (max_cpus > sbsa_max_cpus) {
+        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
+                     "supported by machine 'sbsa-ref' (%d)",
+                     max_cpus, sbsa_max_cpus);
+        exit(1);
+    }
+
+    sms->smp_cpus = smp_cpus;
+
+    if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
+        error_report("sbsa-ref: cannot model more than %dGB RAM", RAMLIMIT_GB);
+        exit(1);
+    }
+
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    for (n = 0; n < possible_cpus->len; n++) {
+        Object *cpuobj;
+        CPUState *cs;
+
+        if (n >= smp_cpus) {
+            break;
+        }
+
+        cpuobj = object_new(possible_cpus->cpus[n].type);
+        object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
+                                "mp-affinity", NULL);
+
+        cs = CPU(cpuobj);
+        cs->cpu_index = n;
+
+        numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
+                          &error_fatal);
+
+        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+            object_property_set_int(cpuobj,
+                                    sbsa_ref_memmap[SBSA_CPUPERIPHS].base,
+                                    "reset-cbar", &error_abort);
+        }
+
+        object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
+                                 &error_abort);
+
+        object_property_set_link(cpuobj, OBJECT(secure_sysmem),
+                                 "secure-memory", &error_abort);
+
+        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        object_unref(cpuobj);
+    }
+
+    memory_region_allocate_system_memory(ram, NULL, "sbsa-ref.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base, ram);
+
+    sms->bootinfo.ram_size = machine->ram_size;
+    sms->bootinfo.kernel_filename = machine->kernel_filename;
+    sms->bootinfo.nb_cpus = smp_cpus;
+    sms->bootinfo.board_id = -1;
+    sms->bootinfo.loader_start = sbsa_ref_memmap[SBSA_MEM].base;
+    arm_load_kernel(ARM_CPU(first_cpu), &sms->bootinfo);
+}
+
+static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
+{
+    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    return arm_cpu_mp_affinity(idx, clustersz);
+}
+
+static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineState *ms)
+{
+    SBSAMachineState *sms = SBSA_MACHINE(ms);
+    int n;
+
+    if (ms->possible_cpus) {
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].arch_id =
+            sbsa_ref_cpu_mp_affinity(sms, n);
+        ms->possible_cpus->cpus[n].props.has_thread_id = true;
+        ms->possible_cpus->cpus[n].props.thread_id = n;
+    }
+    return ms->possible_cpus;
+}
+
+static CpuInstanceProperties
+sbsa_ref_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+static int64_t
+sbsa_ref_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx % nb_numa_nodes;
+}
+
+static void sbsa_ref_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = sbsa_ref_init;
+    mc->desc = "QEMU 'SBSA Reference' ARM Virtual Machine";
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a57");
+    mc->max_cpus = 512;
+    mc->pci_allow_0_address = true;
+    mc->minimum_page_bits = 12;
+    mc->block_default_type = IF_IDE;
+    mc->no_cdrom = 1;
+    mc->default_ram_size = 1 * GiB;
+    mc->default_cpus = 4;
+    mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
+    mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;
+}
+
+static const TypeInfo sbsa_ref_info = {
+    .name          = TYPE_SBSA_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = sbsa_ref_class_init,
+    .instance_size = sizeof(SBSAMachineState),
+};
+
+static void sbsa_ref_machine_init(void)
+{
+    type_register_static(&sbsa_ref_info);
+}
+
+type_init(sbsa_ref_machine_init);
diff --git a/MAINTAINERS b/MAINTAINERS
index cad58b94879..a875868e8ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -728,6 +728,14 @@ F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
 
+SBSA-REF
+M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
+M: Peter Maydell <peter.maydell@linaro.org>
+R: Leif Lindholm <leif.lindholm@linaro.org>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/sbsa-ref.c
+
 Sharp SL-5500 (Collie) PDA
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 49ff415ee4c..958b1e08e40 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -5,3 +5,4 @@ include arm-softmmu.mak
 
 CONFIG_XLNX_ZYNQMP_ARM=y
 CONFIG_XLNX_VERSAL=y
+CONFIG_SBSA_REF=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9aced9d54de..ab65ecd2169 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -184,6 +184,20 @@ config REALVIEW
     select DS1338 # I2C RTC+NVRAM
     select USB_OHCI
 
+config SBSA_REF
+    bool
+    imply PCI_DEVICES
+    select AHCI
+    select ARM_SMMUV3
+    select GPIO_KEY
+    select PCI_EXPRESS
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select PFLASH_CFI01
+    select PL011 # UART
+    select PL031 # RTC
+    select PL061 # GPIO
+    select USB_EHCI_SYSBUS
+
 config SABRELITE
     bool
     select FSL_IMX6
-- 
2.20.1


