Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7055AC35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310142067D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310142067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bBD-0002TN-BB
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b35-0004Za-B7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b32-0000fg-71
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3229 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2t-0000RM-Ks; Mon, 17 Feb 2020 02:42:24 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D4A2E50EFFD6B15E4E00;
 Mon, 17 Feb 2020 15:42:19 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:13 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 16/16] hw/arm: Introduce the microvm machine type
Date: Mon, 17 Feb 2020 02:51:28 -0500
Message-ID: <1581925888-103620-17-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's a minimalist machine type without PCI nor ACPI support, designed
for short-lived guests. microvm also establishes a baseline for
benchmarking and optimizing both QEMU and guest operating systems,
since it is optimized for both boot time and footprint.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 default-configs/aarch64-softmmu.mak |   2 +
 hw/arm/Kconfig                      |   7 +
 hw/arm/Makefile.objs                |   1 +
 hw/arm/arm.c                        |   8 +
 hw/arm/microvm.c                    | 303 ++++++++++++++++++++++++++++
 hw/arm/virt.c                       |  17 +-
 include/hw/arm/arm.h                |   2 +
 include/hw/arm/microvm.h            |  40 ++++
 include/hw/arm/virt.h               |   1 -
 9 files changed, 372 insertions(+), 9 deletions(-)
 create mode 100644 hw/arm/microvm.c
 create mode 100644 include/hw/arm/microvm.h

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 958b1e08e4..e9e994801c 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -6,3 +6,5 @@ include arm-softmmu.mak
 CONFIG_XLNX_ZYNQMP_ARM=y
 CONFIG_XLNX_VERSAL=y
 CONFIG_SBSA_REF=y
+
+CONFIG_ARM_MICROVM=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d86691ae0..153ffbabac 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -25,6 +25,13 @@ config ARM_VIRT
     select ACPI_MEMORY_HOTPLUG
     select ACPI_HW_REDUCED
 
+config ARM_MICROVM
+    bool
+    select A15MPCORE
+    select PL011 # UART
+    select PL031 # RTC
+    select VIRTIO_MMIO
+
 config CHEETAH
     bool
     select OMAP
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 51fcee2ac8..2a2f643774 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y += boot.o
 obj-$(CONFIG_PLATFORM_BUS) += sysbus-fdt.o
 obj-$(CONFIG_ARM_VIRT) += arm.o virt.o
+obj-$(CONFIG_ARM_MICROVM) += arm.o microvm.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
diff --git a/hw/arm/arm.c b/hw/arm/arm.c
index 8bb5d92d2e..0c5bf1a2f8 100644
--- a/hw/arm/arm.c
+++ b/hw/arm/arm.c
@@ -306,6 +306,14 @@ void qdev_create_gic(ArmMachineState *ams)
      */
     qdev_prop_set_uint32(ams->gic, "num-irq", NUM_IRQS + 32);
 
+    if (!kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(ams->gic, "has-security-extensions", false);
+        if (type != 3) {
+            qdev_prop_set_bit(ams->gic, "has-virtualization-extensions",
+                              false);
+        }
+    }
+
     if (type == 3) {
         uint32_t redist0_capacity =
                     ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
diff --git a/hw/arm/microvm.c b/hw/arm/microvm.c
new file mode 100644
index 0000000000..04f98d63cb
--- /dev/null
+++ b/hw/arm/microvm.c
@@ -0,0 +1,303 @@
+/*
+ * ARM mach-virt emulation
+ *
+ * Copyright (c) 2013 Linaro Limited
+ * Copyright (c) 2020 Huawei.
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
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/arm/arm.h"
+#include "hw/arm/microvm.h"
+#include "sysemu/device_tree.h"
+#include "sysemu/numa.h"
+#include "sysemu/sysemu.h"
+#include "hw/loader.h"
+#include "hw/qdev-properties.h"
+#include "hw/arm/fdt.h"
+#include "kvm_arm.h"
+
+/* Number of external interrupt lines to configure the GIC with */
+#define NUM_IRQS 256
+
+#define PLATFORM_BUS_NUM_IRQS 64
+
+/* Legacy RAM limit in GB (< version 4.0) */
+#define LEGACY_RAMLIMIT_GB 255
+#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
+
+/* Addresses and sizes of our components.
+ * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
+ * 128MB..256MB is used for miscellaneous device I/O.
+ * 256MB..1GB is reserved for possible future PCI support (ie where the
+ * PCI memory window will go if we add a PCI host controller).
+ * 1GB and up is RAM (which may happily spill over into the
+ * high memory region beyond 4GB).
+ * This represents a compromise between how much RAM can be given to
+ * a 32 bit VM and leaving space for expansion and in particular for PCI.
+ * Note that devices should generally be placed at multiples of 0x10000,
+ * to accommodate guests using 64K pages.
+ */
+static MemMapEntry base_memmap[] = {
+    /* Space up to 0x8000000 is reserved for a boot ROM */
+    [VIRT_CPUPERIPHS] =         { 0x08000000, 0x00020000 },
+    /* GIC distributor and CPU interfaces sit inside the CPU peripheral space */
+    [VIRT_GIC_DIST] =           { 0x08000000, 0x00010000 },
+    [VIRT_GIC_CPU] =            { 0x08010000, 0x00010000 },
+    /* This redistributor space allows up to 2*64kB*123 CPUs */
+    [VIRT_GIC_REDIST] =         { 0x080A0000, 0x00F60000 },
+    [VIRT_UART] =               { 0x09000000, 0x00001000 },
+    [VIRT_RTC] =                { 0x09010000, 0x00001000 },
+    [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
+    /* Actual RAM size depends on initial RAM and device memory settings */
+    [VIRT_MEM] =                { 0x40000000, LEGACY_RAMLIMIT_BYTES },
+    /* Additional 64 MB redist region (can contain up to 512 redistributors) */
+    [VIRT_HIGH_GIC_REDIST2] =   { 0x4000000000ULL, 0x4000000 },
+};
+
+static const int a15irqmap[] = {
+    [VIRT_UART] = 1,
+    [VIRT_RTC] = 2,
+    [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
+};
+
+static void fdt_gic_intc_node(MicrovmMachineState *mms)
+{
+    char *nodename;
+    ArmMachineState *ams = ARM_MACHINE(mms);
+
+    if (ams->gic_version == 3) {
+        return;
+    }
+
+    nodename = g_strdup_printf("/intc@%" PRIx64,
+                               ams->memmap[VIRT_GIC_DIST].base);
+
+    qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+            2, ams->memmap[VIRT_GIC_DIST].base,
+            2, ams->memmap[VIRT_GIC_DIST].size,
+            2, ams->memmap[VIRT_GIC_CPU].base,
+            2, ams->memmap[VIRT_GIC_CPU].size);
+
+    g_free(nodename);
+}
+
+
+static void create_gic(MicrovmMachineState *mms)
+{
+    ArmMachineState *ams = ARM_MACHINE(mms);
+
+    qdev_create_gic(ams);
+    qdev_init_nofail(ams->gic);
+
+    init_gic_sysbus(ams);
+    fdt_add_gic_node(ams);
+    fdt_gic_intc_node(mms);
+}
+
+static
+void microvm_machine_done(Notifier *notifier, void *data)
+{
+    ArmMachineState *ams = container_of(notifier, ArmMachineState,
+                                         machine_done);
+    MachineState *ms = MACHINE(ams);
+    ARMCPU *cpu = ARM_CPU(first_cpu);
+    struct arm_boot_info *info = &ams->bootinfo;
+    AddressSpace *as = arm_boot_address_space(cpu, info);
+
+    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
+        exit(1);
+    }
+}
+
+static void microvm_init(MachineState *machine)
+{
+    ArmMachineState *ams = ARM_MACHINE(machine);
+    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList *possible_cpus;
+    MemoryRegion *sysmem = get_system_memory();
+    int n, arm_max_cpus;
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    bool aarch64 = true;
+    unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int max_cpus = machine->smp.max_cpus;
+
+    /* microvm, only support KVM */
+    if (!kvm_enabled()) {
+        error_report("microvm requires KVM");
+        exit(1);
+    }
+
+    /* We can probe only here because during property set
+     * KVM is not available yet
+     */
+    if (ams->gic_version <= 0) {
+        ams->gic_version = kvm_arm_vgic_probe();
+        if (!ams->gic_version) {
+            error_report(
+                "Unable to determine GIC version supported by host");
+            exit(1);
+        }
+    }
+
+    if (!cpu_type_valid(machine->cpu_type)) {
+        error_report("mach-virt: CPU type %s not supported", machine->cpu_type);
+        exit(1);
+    }
+
+    ams->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
+
+    /* The maximum number of CPUs depends on the GIC version, or on how
+     * many redistributors we can fit into the memory map.
+     */
+    if (ams->gic_version == 3) {
+        arm_max_cpus =
+            ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+        arm_max_cpus +=
+            ams->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
+    } else {
+        arm_max_cpus = GIC_NCPU;
+    }
+
+    if (max_cpus > arm_max_cpus) {
+        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
+                     "supported by machine 'mach-microvm' (%d)",
+                     max_cpus, arm_max_cpus);
+        exit(1);
+    }
+
+    ams->smp_cpus = smp_cpus;
+
+    create_fdt(ams);
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
+        aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
+
+        object_property_set_int(cpuobj, ams->psci_conduit,
+                                    "psci-conduit", NULL);
+
+         /* Secondary CPUs start in PSCI powered-down state */
+        if (n > 0) {
+            object_property_set_bool(cpuobj, true,
+                                     "start-powered-off", NULL);
+        }
+
+        if (object_property_find(cpuobj, "pmu", NULL)) {
+            object_property_set_bool(cpuobj, false, "pmu", NULL);
+        }
+
+        if (object_property_find(cpuobj, "reset-cbar", NULL)) {
+            object_property_set_int(cpuobj, ams->memmap[VIRT_CPUPERIPHS].base,
+                                    "reset-cbar", &error_abort);
+        }
+
+        object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
+                                 &error_abort);
+
+        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
+        object_unref(cpuobj);
+    }
+    fdt_add_timer_nodes(ams);
+    fdt_add_cpu_nodes(ams);
+
+    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(sysmem, ams->memmap[VIRT_MEM].base, ram);
+
+    create_gic(mms);
+
+    create_uart(ams, VIRT_UART, sysmem, serial_hd(0));
+    create_rtc(ams);
+
+    /* Create mmio transports, so the user can create virtio backends
+     * (which will be automatically plugged in to the transports). If
+     * no backend is created the transport will just sit harmlessly idle.
+     */
+    create_virtio_devices(ams);
+
+    ams->bootinfo.ram_size = machine->ram_size;
+    ams->bootinfo.nb_cpus = smp_cpus;
+    ams->bootinfo.board_id = -1;
+    ams->bootinfo.loader_start = ams->memmap[VIRT_MEM].base;
+    ams->bootinfo.get_dtb = machvirt_dtb;
+    ams->bootinfo.skip_dtb_autoload = true;
+    ams->bootinfo.firmware_loaded = false;
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &ams->bootinfo);
+
+    ams->machine_done.notify = microvm_machine_done;
+    qemu_add_machine_init_done_notifier(&ams->machine_done);
+}
+
+static void microvm_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "QEMU ARM MicroVM Virtual Machine";
+    mc->init = microvm_init;
+    /* Start with max_cpus set to 512, which is the maximum supported by KVM.
+     * The value may be reduced later when we have more information about the
+     * configuration of the particular instance.
+     */
+    mc->max_cpus = 512;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("host");
+    mc->default_machine_opts = "accel=kvm";
+}
+
+static void microvm_instance_init(Object *obj)
+{
+    ArmMachineState *ams = ARM_MACHINE(obj);
+
+    ams->memmap = base_memmap;
+    ams->irqmap = a15irqmap;
+}
+
+static const TypeInfo microvm_machine_info = {
+    .name          = TYPE_MICROVM_MACHINE,
+    .parent        = TYPE_ARM_MACHINE,
+    .instance_size = sizeof(MicrovmMachineState),
+    .instance_init = microvm_instance_init,
+    .class_size    = sizeof(MicrovmMachineClass),
+    .class_init    = microvm_class_init,
+    .interfaces = (InterfaceInfo[]) {
+         { }
+    },
+};
+
+static void microvm_machine_init(void)
+{
+    type_register_static(&microvm_machine_info);
+}
+
+type_init(microvm_machine_init);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 14d20d5c46..c4ffeff4aa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -979,10 +979,10 @@ static void virt_build_smbios(VirtMachineState *vms)
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
-    VirtMachineState *vms = container_of(notifier, VirtMachineState,
+    ArmMachineState *ams = container_of(notifier, ArmMachineState,
                                          machine_done);
-    MachineState *ms = MACHINE(vms);
-    ArmMachineState *ams = ARM_MACHINE(vms);
+    MachineState *ms = MACHINE(ams);
+    VirtMachineState *vms = VIRT_MACHINE(ams);
     ARMCPU *cpu = ARM_CPU(first_cpu);
     struct arm_boot_info *info = &ams->bootinfo;
     AddressSpace *as = arm_boot_address_space(cpu, info);
@@ -1056,7 +1056,7 @@ static void virt_set_memmap(VirtMachineState *vms)
         ams->memmap[i].size = size;
         base += size;
     }
-    vms->highest_gpa = base - 1;
+    ams->highest_gpa = base - 1;
     if (device_memory_size > 0) {
         ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
         ms->device_memory->base = device_memory_base;
@@ -1260,7 +1260,7 @@ static void machvirt_init(MachineState *machine)
         if (aarch64 && vms->highmem) {
             int requested_pa_size, pamax = arm_pamax(cpu);
 
-            requested_pa_size = 64 - clz64(vms->highest_gpa);
+            requested_pa_size = 64 - clz64(ams->highest_gpa);
             if (pamax < requested_pa_size) {
                 error_report("VCPU supports less PA bits (%d) than requested "
                             "by the memory map (%d)", pamax, requested_pa_size);
@@ -1326,8 +1326,8 @@ static void machvirt_init(MachineState *machine)
     ams->bootinfo.firmware_loaded = firmware_loaded;
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ams->bootinfo);
 
-    vms->machine_done.notify = virt_machine_done;
-    qemu_add_machine_init_done_notifier(&vms->machine_done);
+    ams->machine_done.notify = virt_machine_done;
+    qemu_add_machine_init_done_notifier(&ams->machine_done);
 }
 
 static bool virt_get_secure(Object *obj, Error **errp)
@@ -1501,13 +1501,14 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
+    ArmMachineState *ams = ARM_MACHINE(ms);
     int max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms);
     int requested_pa_size;
 
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(ams->highest_gpa);
 
     if (requested_pa_size > max_vm_pa_size) {
         error_report("-m and ,maxmem option values "
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 37a419b784..f9ec676579 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -92,6 +92,7 @@ typedef struct {
 
 typedef struct {
     MachineState parent;
+    Notifier machine_done;
     int32_t gic_version;
     struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
@@ -102,6 +103,7 @@ typedef struct {
     uint32_t clock_phandle;
     uint32_t gic_phandle;
     int psci_conduit;
+    hwaddr highest_gpa;
     DeviceState *gic;
 } ArmMachineState;
 
diff --git a/include/hw/arm/microvm.h b/include/hw/arm/microvm.h
new file mode 100644
index 0000000000..be8e771b07
--- /dev/null
+++ b/include/hw/arm/microvm.h
@@ -0,0 +1,40 @@
+/*
+ *
+ * Copyright (c) 2015 Linaro Limited
+ * Copyright (c) 2020 Huawei.
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
+#ifndef QEMU_ARM_MICROVM_H
+#define QEMU_ARM_MICROVM_H
+
+#include "hw/arm/arm.h"
+
+typedef struct {
+    ArmMachineClass parent;
+} MicrovmMachineClass;
+
+typedef struct {
+    ArmMachineState parent;
+} MicrovmMachineState;
+
+#define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
+#define MICROVM_MACHINE(obj) \
+    OBJECT_CHECK(MicrovmMachineState, (obj), TYPE_MICROVM_MACHINE)
+#define MICROVM_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MicrovmMachineClass, obj, TYPE_MICROVM_MACHINE)
+#define MICROVM_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(MicrovmMachineClass, klass, TYPE_MICROVM_MACHINE)
+
+#endif /* QEMU_ARM_MICROVM_H */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aa66cd78d5..4e32c650b4 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -69,7 +69,6 @@ typedef struct {
     VirtIOMMUType iommu;
     uint32_t msi_phandle;
     uint32_t iommu_phandle;
-    hwaddr highest_gpa;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
 } VirtMachineState;
-- 
2.18.1


