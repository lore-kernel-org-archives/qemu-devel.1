Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A50C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A6320989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A6320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOks5-00067s-HY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:22:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOkqZ-0005Lr-My
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hOkqY-0006FR-EA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hOkqT-0006CQ-M5; Thu, 09 May 2019 11:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE58C18DF7C;
	Thu,  9 May 2019 15:20:16 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-72.brq.redhat.com [10.40.204.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14ED817F41;
	Thu,  9 May 2019 15:20:08 +0000 (UTC)
Date: Thu, 9 May 2019 17:20:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190509172002.5f65f78c@Igors-MacBook-Pro>
In-Reply-To: <20190409102935.28292-6-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 09 May 2019 15:20:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 5/8] hw/arm/virt: Enable device memory
 cold/hot plug with ACPI boot
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
	shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
	xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
	qemu-arm@nongnu.org, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Apr 2019 11:29:32 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This initializes the GED device with base memory and irq, configures
> ged memory hotplug event and builds the corresponding aml code. GED
> irq routing to Guest is also enabled. With this, both hot and cold
> plug of device memory is enabled now for Guest with ACPI boot.
> 
> Memory cold plug support with Guest DT boot is not yet supported.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  default-configs/arm-softmmu.mak |  2 ++
>  hw/arm/virt-acpi-build.c        |  9 ++++++
>  hw/arm/virt.c                   | 61 +++++++++++++++++++++++++++++++++++++++--
>  include/hw/arm/virt.h           |  4 +++
>  4 files changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 9f4b803..c9a9b34 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -163,3 +163,5 @@ CONFIG_LSI_SCSI_PCI=y
>  
>  CONFIG_MEM_DEVICE=y
>  CONFIG_DIMM=y
> +CONFIG_ACPI_MEMORY_HOTPLUG=y
> +CONFIG_ACPI_HW_REDUCED=y
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bf9c0bc..1ad394b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -40,6 +40,8 @@
>  #include "hw/loader.h"
>  #include "hw/hw.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
> @@ -727,6 +729,7 @@ static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      Aml *scope, *dsdt;
> +    MachineState *ms = MACHINE(vms);
>      const MemMapEntry *memmap = vms->memmap;
>      const int *irqmap = vms->irqmap;
>  
> @@ -753,6 +756,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>      acpi_dsdt_add_power_button(scope);
>  
> +    build_ged_aml(scope, "\\_SB."GED_DEVICE, HOTPLUG_HANDLER(vms->acpi_dev),
> +                  irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY);
> +
> +    build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
> +                             AML_SYSTEM_MEMORY);
>
are you sure we should add these parts if acpi_device not present or ms->ram_slots == 0 ?

>      aml_append(dsdt, scope);
>  
>      /* copy AML table into ACPI tables blob and patch header there */

[...]

> +
>  static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>  {
>      /* We create a standalone GIC */
> @@ -670,6 +707,8 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
>          pic[i] = qdev_get_gpio_in(gicdev, i);
>      }
>  
> +    vms->gsi = qemu_allocate_irqs(virt_gsi_handler, pic, NUM_IRQS);

Why do we need this "gsi" to begin with?

> +
>      fdt_add_gic_node(vms);
>  
>      if (type == 3 && vms->its) {
> @@ -1418,7 +1457,7 @@ static void machvirt_init(MachineState *machine)
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *possible_cpus;
> -    qemu_irq pic[NUM_IRQS];
> +    qemu_irq *pic;
>      MemoryRegion *sysmem = get_system_memory();
>      MemoryRegion *secure_sysmem = NULL;
>      int n, virt_max_cpus;
> @@ -1614,6 +1653,7 @@ static void machvirt_init(MachineState *machine)
>  
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>  
> +    pic = g_new0(qemu_irq, NUM_IRQS);
>      create_gic(vms, pic);
>  
>      fdt_add_pmu_nodes(vms);
> @@ -1644,6 +1684,8 @@ static void machvirt_init(MachineState *machine)
>  
>      create_platform_bus(vms, pic);
>  
> +    vms->acpi_dev = create_acpi_ged(vms);

what if we start QEMU with -no-acpi?

>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
>      vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
> @@ -1811,21 +1853,34 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>  static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                   Error **errp)
>  {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        error_setg(errp, "memory cold/hot plug is not yet supported");
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> +
> +    if (is_nvdimm) {
> +        error_setg(errp, "nvdimm is not yet supported");
>          return;
>      }
>  
> +    if (!vms->acpi_dev) {
> +        error_setg(errp, "memory hotplug is not enabled: missing acpi device");
> +        return;
> +    }
> +
> +    hotplug_handler_pre_plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, errp);
> +
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>  }
>  
>  static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
> +    HotplugHandlerClass *hhc;
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>  
>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), NULL);
>  
> +    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> +    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, NULL);
>  }
>  
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 507517c..9c6b0b1 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -77,6 +77,8 @@ enum {
>      VIRT_GPIO,
>      VIRT_SECURE_UART,
>      VIRT_SECURE_MEM,
> +    VIRT_PCDIMM_ACPI,
> +    VIRT_ACPI_GED,
>      VIRT_LOWMEMMAP_LAST,
>  };
>  
> @@ -132,6 +134,8 @@ typedef struct {
>      uint32_t iommu_phandle;
>      int psci_conduit;
>      hwaddr highest_gpa;
> +    DeviceState *acpi_dev;
> +    qemu_irq *gsi;
>  } VirtMachineState;
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)


