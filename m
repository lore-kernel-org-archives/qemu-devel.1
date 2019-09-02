Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CED5C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11A021874
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11A021874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4iif-00029G-1A
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i4ihc-0001Z7-AN
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i4ihZ-0005jl-Eo
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i4ihL-0005WH-Ke; Mon, 02 Sep 2019 05:32:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9219C80F7C;
 Mon,  2 Sep 2019 09:32:22 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 935CF196B2;
 Mon,  2 Sep 2019 09:32:19 +0000 (UTC)
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
References: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
 <20190813210539.31164-7-shameerali.kolothum.thodi@huawei.com>
 <1cae1b24-babc-8f97-96c1-5f416610ef02@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83F3B3656@lhreml524-mbb.china.huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <01343ddb-1d5d-7270-b899-008fd3f4e8c9@redhat.com>
Date: Mon, 2 Sep 2019 11:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F3B3656@lhreml524-mbb.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 02 Sep 2019 09:32:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v9 06/12] hw/arm/virt: Enable
 device memory cold/hot plug with ACPI boot
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,

On 9/2/19 11:21 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: 01 September 2019 12:19
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> qemu-devel@nongnu.org; qemu-arm@nongnu.org; imammedo@redhat.com
>> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
>> sameo@linux.intel.com; sebastien.boeuf@intel.com; xuwei (O)
>> <xuwei5@huawei.com>; lersek@redhat.com; ard.biesheuvel@linaro.org;
>> Linuxarm <linuxarm@huawei.com>
>> Subject: Re: [PATCH-for-4.2 v9 06/12] hw/arm/virt: Enable device memory
>> cold/hot plug with ACPI boot
>>
>> Hi Shameer,
>>
>> On 8/13/19 11:05 PM, Shameer Kolothum wrote:
>>> This initializes the GED device with base memory and irq, configures
>>> ged memory hotplug event and builds the corresponding aml code. With
>>> this, both hot and cold plug of device memory is enabled now for Guest
>>> with ACPI boot.
>>>
>>> Memory cold plug support with Guest DT boot is not yet supported.
>>
>> I think you should comment about bios-tables-test-allowed-diff.h update.
> 
> Ok. I will add that.
> 
>> Can't you update the table instead of ignoring the test?
> 
> I think that is not how it is handled now. The process is,
> 
> "Expected table change is then handled like this:
> 1. add table to diff allowed list
> 2. change generating code (can be combined with 1)
> 3. maintainer runs a script to update expected +
>    blows away allowed diff list "
> https://patchwork.kernel.org/patch/10967339/

Ok. Thanks for the link.

Best Regards

Eric
> 
> Thanks,
> Shameer
> 
>>
>> Thanks
>>
>> Eric
>>>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>> v8 --> v9
>>>  -Changes related to GED being a TYPE_SYS_BUS_DEVICE now.
>>>  -Error propagation to _plug() handler.
>>>  -Removed R-by by Eric for now.
>>>
>>> v7 --> v8
>>>  -Changed no_acpi_dev to no_ged.
>>>  -Fixed 'dev' reference leak by object_new().
>>>  -Updated bios-tables-test-allowed-diff.h to avoid "make check"
>>>   failure.
>>>
>>> ---
>>>  hw/arm/Kconfig                        |  2 +
>>>  hw/arm/virt-acpi-build.c              | 16 +++++++
>>>  hw/arm/virt.c                         | 62
>> ++++++++++++++++++++++++---
>>>  include/hw/arm/virt.h                 |  4 ++
>>>  tests/bios-tables-test-allowed-diff.h |  1 +
>>>  5 files changed, 78 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig index
>>> 84961c17ab..ad7f7c089b 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -22,6 +22,8 @@ config ARM_VIRT
>>>      select ACPI_PCI
>>>      select MEM_DEVICE
>>>      select DIMM
>>> +    select ACPI_MEMORY_HOTPLUG
>>> +    select ACPI_HW_REDUCED
>>>
>>>  config CHEETAH
>>>      bool
>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index
>>> 0afb372769..63fa845076 100644
>>> --- a/hw/arm/virt-acpi-build.c
>>> +++ b/hw/arm/virt-acpi-build.c
>>> @@ -40,6 +40,8 @@
>>>  #include "hw/acpi/aml-build.h"
>>>  #include "hw/acpi/utils.h"
>>>  #include "hw/acpi/pci.h"
>>> +#include "hw/acpi/memory_hotplug.h"
>>> +#include "hw/acpi/generic_event_device.h"
>>>  #include "hw/pci/pcie_host.h"
>>>  #include "hw/pci/pci.h"
>>>  #include "hw/arm/virt.h"
>>> @@ -705,6 +707,7 @@ static void
>>>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState
>>> *vms)  {
>>>      Aml *scope, *dsdt;
>>> +    MachineState *ms = MACHINE(vms);
>>>      const MemMapEntry *memmap = vms->memmap;
>>>      const int *irqmap = vms->irqmap;
>>>
>>> @@ -729,6 +732,19 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>> VirtMachineState *vms)
>>>                        vms->highmem, vms->highmem_ecam);
>>>      acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
>>>                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
>>> +    if (vms->acpi_dev) {
>>> +        build_ged_aml(scope, "\\_SB."GED_DEVICE,
>>> +                      HOTPLUG_HANDLER(vms->acpi_dev),
>>> +                      irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE,
>> AML_SYSTEM_MEMORY,
>>> +                      memmap[VIRT_ACPI_GED].base);
>>> +    }
>>> +
>>> +    if (vms->acpi_dev && ms->ram_slots) {
>>> +        build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB",
>> NULL,
>>> +                                 AML_SYSTEM_MEMORY,
>>> +
>> memmap[VIRT_PCDIMM_ACPI].base);
>>> +    }
>>> +
>>>      acpi_dsdt_add_power_button(scope);
>>>
>>>      aml_append(dsdt, scope);
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
>>> ef65e721d2..0949a227a9 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -66,6 +66,7 @@
>>>  #include "target/arm/internals.h"
>>>  #include "hw/mem/pc-dimm.h"
>>>  #include "hw/mem/nvdimm.h"
>>> +#include "hw/acpi/generic_event_device.h"
>>>
>>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc,
>>> \ @@ -136,6 +137,8 @@ static const MemMapEntry base_memmap[] = {
>>>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>>>      [VIRT_SECURE_UART] =        { 0x09040000, 0x00001000 },
>>>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
>>> +    [VIRT_PCDIMM_ACPI] =        { 0x09070000,
>> MEMORY_HOTPLUG_IO_LEN },
>>> +    [VIRT_ACPI_GED] =           { 0x09080000,
>> ACPI_GED_EVT_SEL_LEN },
>>>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>>>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that
>> size */
>>>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
>>> @@ -171,6 +174,7 @@ static const int a15irqmap[] = {
>>>      [VIRT_PCIE] = 3, /* ... to 6 */
>>>      [VIRT_GPIO] = 7,
>>>      [VIRT_SECURE_UART] = 8,
>>> +    [VIRT_ACPI_GED] = 9,
>>>      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
>>>      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
>>>      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
>>> @@ -520,6 +524,26 @@ static void fdt_add_pmu_nodes(const
>> VirtMachineState *vms)
>>>      }
>>>  }
>>>
>>> +static inline DeviceState *create_acpi_ged(VirtMachineState *vms,
>>> +qemu_irq *pic) {
>>> +    DeviceState *dev;
>>> +    int irq = vms->irqmap[VIRT_ACPI_GED];
>>> +    uint32_t event = ACPI_GED_MEM_HOTPLUG_EVT;
>>> +
>>> +    dev = qdev_create(NULL, TYPE_ACPI_GED);
>>> +    qdev_prop_set_uint32(dev, "ged-event", event);
>>> +    object_property_add_child(qdev_get_machine(), "acpi-ged",
>>> +                              OBJECT(dev), NULL);
>>> +    qdev_init_nofail(dev);
>>> +
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
>> vms->memmap[VIRT_ACPI_GED].base);
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1,
>>> + vms->memmap[VIRT_PCDIMM_ACPI].base);
>>> +
>>> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
>>> +
>>> +    return dev;
>>> +}
>>> +
>>>  static void create_its(VirtMachineState *vms, DeviceState *gicdev)  {
>>>      const char *itsclass = its_class_name(); @@ -1483,6 +1507,7 @@
>>> static void machvirt_init(MachineState *machine)
>>>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>>>      bool firmware_loaded;
>>>      bool aarch64 = true;
>>> +    bool has_ged = !vmc->no_ged;
>>>      unsigned int smp_cpus = machine->smp.cpus;
>>>      unsigned int max_cpus = machine->smp.max_cpus;
>>>
>>> @@ -1697,6 +1722,10 @@ static void machvirt_init(MachineState
>>> *machine)
>>>
>>>      create_gpio(vms, pic);
>>>
>>> +    if (has_ged && aarch64 && firmware_loaded && acpi_enabled) {
>>> +        vms->acpi_dev = create_acpi_ged(vms, pic);
>>> +    }
>>> +
>>>      /* Create mmio transports, so the user can create virtio backends
>>>       * (which will be automatically plugged in to the transports). If
>>>       * no backend is created the transport will just sit harmlessly idle.
>>> @@ -1876,14 +1905,23 @@ static const CPUArchIdList
>>> *virt_possible_cpu_arch_ids(MachineState *ms)  static void
>> virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>                                   Error **errp)  {
>>> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>>> +    const bool is_nvdimm = object_dynamic_cast(OBJECT(dev),
>> TYPE_NVDIMM);
>>> +    Error *local_err = NULL;
>>>
>>> -    /*
>>> -     * The device memory is not yet exposed to the Guest either through
>>> -     * DT or ACPI and hence both cold/hot plug of memory is explicitly
>>> -     * disabled for now.
>>> -     */
>>> -    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>>> -        error_setg(errp, "memory cold/hot plug is not yet supported");
>>> +    if (is_nvdimm) {
>>> +        error_setg(errp, "nvdimm is not yet supported");
>>> +        return;
>>> +    }
>>> +
>>> +    if (!vms->acpi_dev) {
>>> +        error_setg(errp, "memory hotplug is not enabled: missing acpi
>> device");
>>> +        return;
>>> +    }
>>> +
>>> +    hotplug_handler_pre_plug(HOTPLUG_HANDLER(vms->acpi_dev), dev,
>> &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>>          return;
>>>      }
>>>
>>> @@ -1893,11 +1931,18 @@ static void
>>> virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>> static void virt_memory_plug(HotplugHandler *hotplug_dev,
>>>                               DeviceState *dev, Error **errp)  {
>>> +    HotplugHandlerClass *hhc;
>>>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
>>>      Error *local_err = NULL;
>>>
>>>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
>>> +    if (local_err) {
>>> +        goto out;
>>> +    }
>>>
>>> +    hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
>>> +    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
>>> +out:
>>>      error_propagate(errp, local_err);  }
>>>
>>> @@ -2104,8 +2149,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
>>>
>>>  static void virt_machine_4_1_options(MachineClass *mc)  {
>>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>>> +
>>>      virt_machine_4_2_options(mc);
>>>      compat_props_add(mc->compat_props, hw_compat_4_1,
>>> hw_compat_4_1_len);
>>> +    vmc->no_ged = true;
>>>  }
>>>  DEFINE_VIRT_MACHINE(4, 1)
>>>
>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
>>> a72094204e..577ee49b4b 100644
>>> --- a/include/hw/arm/virt.h
>>> +++ b/include/hw/arm/virt.h
>>> @@ -77,6 +77,8 @@ enum {
>>>      VIRT_GPIO,
>>>      VIRT_SECURE_UART,
>>>      VIRT_SECURE_MEM,
>>> +    VIRT_PCDIMM_ACPI,
>>> +    VIRT_ACPI_GED,
>>>      VIRT_LOWMEMMAP_LAST,
>>>  };
>>>
>>> @@ -106,6 +108,7 @@ typedef struct {
>>>      bool claim_edge_triggered_timers;
>>>      bool smbios_old_sys_ver;
>>>      bool no_highmem_ecam;
>>> +    bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device
>> */
>>>  } VirtMachineClass;
>>>
>>>  typedef struct {
>>> @@ -133,6 +136,7 @@ typedef struct {
>>>      uint32_t iommu_phandle;
>>>      int psci_conduit;
>>>      hwaddr highest_gpa;
>>> +    DeviceState *acpi_dev;
>>>  } VirtMachineState;
>>>
>>>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
>>> VIRT_PCIE_ECAM) diff --git a/tests/bios-tables-test-allowed-diff.h
>>> b/tests/bios-tables-test-allowed-diff.h
>>> index dfb8523c8b..7b4adbc822 100644
>>> --- a/tests/bios-tables-test-allowed-diff.h
>>> +++ b/tests/bios-tables-test-allowed-diff.h
>>> @@ -1 +1,2 @@
>>>  /* List of comma-separated changed AML files to ignore */
>>> +"tests/data/acpi/virt/DSDT",
>>>

