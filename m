Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A86C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878F7222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878F7222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsCU-0002WZ-Mu
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs55-0004sK-SH
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs54-0004Es-7F
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs53-0004Df-Tn
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:14 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BF0285541
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:12 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id m6so10852792qtk.23
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mj5tL5U2qnuTXB+U/884lTnt7YEuEt5oh/67y8RvJ6U=;
 b=Ipy3Wx0Uprx9/5fKuTBdo7JageC2O67EFeBmS/8Gq6AwNlc1sVVv+G5EX0OShX4ATY
 xwrxJxkfMP5PtfafGnsVbzxM43BZDYNKrgZAn966ZMdUEo7YFJ/cnFP9Sp8agBx8opMj
 CFJo90UmD/l+wSOJL0dB1DG68Q3WhN5J/PNwcqPzwNWlqbZFudOxxVXgZBRnfgIxDygZ
 6CaVirMUR0bryEMLVyGbQXmJYqBVeGYwXS8XKUof4E4UZR8D40jXgUTFoBZ3JaMA8eZP
 o7iUII6rgA/O/rh5q/s4RMHi28ZsoX40LBRbva1BJVG/37hUODj/7unx7ixKHUTXMvTW
 q/rg==
X-Gm-Message-State: APjAAAXCj5NtjpDmPPVTICw2+rYLqoncXbaJJqEM72XXVIHRe2MxqY57
 NXnyuQ9RhLAcClXCmWVZIPyJbm5EUNzNeWB4z/nBPi8v8zslPxUgMUBeyqO7bFY8SVeMR5+oK/d
 toifF+qPYdYPnE7w=
X-Received: by 2002:ac8:4784:: with SMTP id k4mr23586033qtq.303.1570312750949; 
 Sat, 05 Oct 2019 14:59:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxlnfHWFSlVYbUksaVsa80RS5F2hCzfbRLDfARkj5yYV4p05a8RgIjwwAwIkMjk0z/Row4xFA==
X-Received: by 2002:ac8:4784:: with SMTP id k4mr23586018qtq.303.1570312750551; 
 Sat, 05 Oct 2019 14:59:10 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 c131sm6006346qke.24.2019.10.05.14.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:09 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] hw/arm/virt: Enable device memory cold/hot plug with
 ACPI boot
Message-ID: <20190918130633.4872-6-shameerali.kolothum.thodi@huawei.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215905.n5PldSmKcXpoDUskjguUz-B7bnR0yle0Pxf_B3HR2-g@z>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This initializes the GED device with base memory and irq, configures
ged memory hotplug event and builds the corresponding aml code. With
this, both hot and cold plug of device memory is enabled now for Guest
with ACPI boot. Memory cold plug support with Guest DT boot is not yet
supported.

As DSDT table gets changed by this, update bios-tables-test-allowed-diff.h
to avoid "make check" failure.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-Id: <20190918130633.4872-6-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/Kconfig                        |  2 +
 hw/arm/virt-acpi-build.c              | 21 ++++++++++
 hw/arm/virt.c                         | 59 +++++++++++++++++++++++----
 include/hw/arm/virt.h                 |  4 ++
 tests/bios-tables-test-allowed-diff.h |  1 +
 5 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 39d285ad3d..c6e7782580 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -22,6 +22,8 @@ config ARM_VIRT
     select ACPI_PCI
     select MEM_DEVICE
     select DIMM
+    select ACPI_MEMORY_HOTPLUG
+    select ACPI_HW_REDUCED
 
 config CHEETAH
     bool
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6cdf156cf5..cadeea0f41 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -39,6 +39,8 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
+#include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/generic_event_device.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
@@ -708,6 +710,7 @@ static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     Aml *scope, *dsdt;
+    MachineState *ms = MACHINE(vms);
     const MemMapEntry *memmap = vms->memmap;
     const int *irqmap = vms->irqmap;
 
@@ -732,6 +735,24 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                       vms->highmem, vms->highmem_ecam);
     acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
                        (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
+    if (vms->acpi_dev) {
+        build_ged_aml(scope, "\\_SB."GED_DEVICE,
+                      HOTPLUG_HANDLER(vms->acpi_dev),
+                      irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
+                      memmap[VIRT_ACPI_GED].base);
+    }
+
+    if (vms->acpi_dev) {
+        uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
+                                                  "ged-event", &error_abort);
+
+        if (event & ACPI_GED_MEM_HOTPLUG_EVT) {
+            build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
+                                     AML_SYSTEM_MEMORY,
+                                     memmap[VIRT_PCDIMM_ACPI].base);
+        }
+    }
+
     acpi_dsdt_add_power_button(scope);
 
     aml_append(dsdt, scope);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1c967e3fee..f926477ba5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -70,6 +70,7 @@
 #include "target/arm/internals.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/acpi/generic_event_device.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -140,6 +141,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
     [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
     [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
+    [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
+    [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -175,6 +178,7 @@ static const int a15irqmap[] = {
     [VIRT_PCIE] = 3, /* ... to 6 */
     [VIRT_GPIO] = 7,
     [VIRT_SECURE_UART] = 8,
+    [VIRT_ACPI_GED] = 9,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -527,6 +531,29 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     }
 }
 
+static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq *pic)
+{
+    DeviceState *dev;
+    MachineState *ms = MACHINE(vms);
+    int irq = vms->irqmap[VIRT_ACPI_GED];
+    uint32_t event = 0;
+
+    if (ms->ram_slots) {
+        event = ACPI_GED_MEM_HOTPLUG_EVT;
+    }
+
+    dev = qdev_create(NULL, TYPE_ACPI_GED);
+    qdev_prop_set_uint32(dev, "ged-event", event);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
+
+    qdev_init_nofail(dev);
+
+    return dev;
+}
+
 static void create_its(VirtMachineState *vms, DeviceState *gicdev)
 {
     const char *itsclass = its_class_name();
@@ -1491,6 +1518,7 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     bool firmware_loaded;
     bool aarch64 = true;
+    bool has_ged = !vmc->no_ged;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
@@ -1705,6 +1733,10 @@ static void machvirt_init(MachineState *machine)
 
     create_gpio(vms, pic);
 
+    if (has_ged && aarch64 && firmware_loaded && acpi_enabled) {
+        vms->acpi_dev = create_acpi_ged(vms, pic);
+    }
+
     /* Create mmio transports, so the user can create virtio backends
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
@@ -1881,14 +1913,17 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    /*
-     * The device memory is not yet exposed to the Guest either through
-     * DT or ACPI and hence both cold/hot plug of memory is explicitly
-     * disabled for now.
-     */
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        error_setg(errp, "memory cold/hot plug is not yet supported");
+    if (is_nvdimm) {
+        error_setg(errp, "nvdimm is not yet supported");
+        return;
+    }
+
+    if (!vms->acpi_dev) {
+        error_setg(errp,
+                   "memory hotplug is not enabled: missing acpi-ged device");
         return;
     }
 
@@ -1898,11 +1933,18 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 static void virt_memory_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
+    HotplugHandlerClass *hhc;
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     Error *local_err = NULL;
 
     pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
+    if (local_err) {
+        goto out;
+    }
 
+    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
+    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
+out:
     error_propagate(errp, local_err);
 }
 
@@ -2109,8 +2151,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
 
 static void virt_machine_4_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_4_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
+    vmc->no_ged = true;
 }
 DEFINE_VIRT_MACHINE(4, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index a72094204e..577ee49b4b 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -77,6 +77,8 @@ enum {
     VIRT_GPIO,
     VIRT_SECURE_UART,
     VIRT_SECURE_MEM,
+    VIRT_PCDIMM_ACPI,
+    VIRT_ACPI_GED,
     VIRT_LOWMEMMAP_LAST,
 };
 
@@ -106,6 +108,7 @@ typedef struct {
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
     bool no_highmem_ecam;
+    bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
 } VirtMachineClass;
 
 typedef struct {
@@ -133,6 +136,7 @@ typedef struct {
     uint32_t iommu_phandle;
     int psci_conduit;
     hwaddr highest_gpa;
+    DeviceState *acpi_dev;
 } VirtMachineState;
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index dfb8523c8b..7b4adbc822 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/virt/DSDT",
-- 
MST


