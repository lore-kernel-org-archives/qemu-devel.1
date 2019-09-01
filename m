Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD8C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 11:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB142190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 11:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB142190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4NtJ-0002ZT-IK
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 07:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i4Nro-0001Mb-6n
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 07:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i4Nrm-0001V7-Ro
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 07:17:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i4Nri-0001Sv-QO; Sun, 01 Sep 2019 07:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF148C057F23;
 Sun,  1 Sep 2019 11:17:48 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F14DA10016EB;
 Sun,  1 Sep 2019 11:17:44 +0000 (UTC)
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
References: <20190813210539.31164-1-shameerali.kolothum.thodi@huawei.com>
 <20190813210539.31164-2-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <476ef412-e201-822e-4ee5-020a5825ea13@redhat.com>
Date: Sun, 1 Sep 2019 13:17:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190813210539.31164-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Sun, 01 Sep 2019 11:17:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v9 01/12] hw/acpi: Make ACPI IO
 address space configurable
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shameer,
On 8/13/19 11:05 PM, Shameer Kolothum wrote:
> This is in preparation for adding support for ARM64 platforms
> where it doesn't use port mapped IO for ACPI IO space. We are
> making changes so that MMIO region can be accommodated
> and board can pass the base address into the aml build function.
> 
> Also move few MEMORY_* definitions to header so that other memory
> hotplug event signalling mechanisms (eg. Generic Event Device on
> HW-reduced acpi platforms) can use the same from their respective
> event handler code.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v8 --> v9
>   -base address is an input into build_memory_hotplug_aml()
>   -Removed R-by tags from Igor and Eric for now.
> ---
>  hw/acpi/memory_hotplug.c         | 29 ++++++++++++++---------------
>  hw/i386/acpi-build.c             |  4 +++-
>  hw/i386/pc.c                     |  3 +++
>  include/hw/acpi/memory_hotplug.h |  9 +++++++--
>  include/hw/i386/pc.h             |  3 +++
>  5 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 297812d5f7..1734d4b44f 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -29,12 +29,7 @@
>  #define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
>  #define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
>  #define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
> -#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
>  #define MEMORY_HOTPLUG_DEVICE        "MHPD"
> -#define MEMORY_HOTPLUG_IO_LEN         24
> -#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
> -
> -static uint16_t memhp_io_base;
>  
>  static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
>  {
> @@ -209,7 +204,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
>  };
>  
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state, uint16_t io_base)
> +                              MemHotplugState *state, hwaddr io_base)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>  
> @@ -218,12 +213,10 @@ void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
>          return;
>      }
>  
> -    assert(!memhp_io_base);
> -    memhp_io_base = io_base;
>      state->devs = g_malloc0(sizeof(*state->devs) * state->dev_count);
>      memory_region_init_io(&state->io, owner, &acpi_memory_hotplug_ops, state,
>                            "acpi-mem-hotplug", MEMORY_HOTPLUG_IO_LEN);
> -    memory_region_add_subregion(as, memhp_io_base, &state->io);
> +    memory_region_add_subregion(as, io_base, &state->io);
>  }
>  
>  /**
> @@ -342,7 +335,8 @@ const VMStateDescription vmstate_memory_hotplug = {
>  
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                const char *res_root,
> -                              const char *event_handler_method)
> +                              const char *event_handler_method,
> +                              AmlRegionSpace rs, hwaddr memhp_io_base)
>  {
>      int i;
>      Aml *ifctx;
> @@ -365,14 +359,19 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>              aml_name_decl("_UID", aml_string("Memory hotplug resources")));
do you want to keep

    if (!memhp_io_base) {
        return;
    }

at the beginning of the function? I think we should rather call the
function only if all args are resolved?
>  
>          crs = aml_resource_template();
> -        aml_append(crs,
> -            aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
> -                   MEMORY_HOTPLUG_IO_LEN)
> -        );
> +        if (rs == AML_SYSTEM_IO) {
> +            aml_append(crs,
> +                aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
> +                       MEMORY_HOTPLUG_IO_LEN)
> +            );
> +        } else {
> +            aml_append(crs, aml_memory32_fixed(memhp_io_base,
> +                            MEMORY_HOTPLUG_IO_LEN, AML_READ_WRITE));
> +        }
>          aml_append(mem_ctrl_dev, aml_name_decl("_CRS", crs));
>  
>          aml_append(mem_ctrl_dev, aml_operation_region(
> -            MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
> +            MEMORY_HOTPLUG_IO_REGION, rs,
>              aml_int(memhp_io_base), MEMORY_HOTPLUG_IO_LEN)
>          );
>  
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f3fdfefcd5..e76d6631ea 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1871,7 +1871,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");
>      }
> -    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0", "\\_GPE._E03");
> +    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
> +                             "\\_GPE._E03", AML_SYSTEM_IO,
> +                             pcms->memhp_io_base);
>  
>      scope =  aml_scope("_GPE");
>      {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 549c437050..be973cea99 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1936,6 +1936,9 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      /* Init default IOAPIC address space */
>      pcms->ioapic_as = &address_space_memory;
> +
> +    /* Init ACPI memory hotplug IO base address */
> +    pcms->memhp_io_base = ACPI_MEMORY_HOTPLUG_BASE;
>  }
>  
>  /*
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index 77c65765d6..dfe9cf3fde 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -5,6 +5,10 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
>  
> +#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
> +#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
> +#define MEMORY_HOTPLUG_IO_LEN         24
> +
>  /**
>   * MemStatus:
>   * @is_removing: the memory device in slot has been requested to be ejected.
> @@ -29,7 +33,7 @@ typedef struct MemHotplugState {
>  } MemHotplugState;
>  
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state, uint16_t io_base);
> +                              MemHotplugState *state, hwaddr io_base);
>  
>  void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
>                           DeviceState *dev, Error **errp);
> @@ -48,5 +52,6 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>  
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                const char *res_root,
> -                              const char *event_handler_method);
> +                              const char *event_handler_method,
> +                              AmlRegionSpace rs, hwaddr memhp_io_base);
>  #endif
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 859b64c51d..49b47535cf 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -69,6 +69,9 @@ struct PCMachineState {
>      /* Address space used by IOAPIC device. All IOAPIC interrupts
>       * will be translated to MSI messages in the address space. */
>      AddressSpace *ioapic_as;
> +
> +    /* ACPI Memory hotplug IO base address */
> +    hwaddr memhp_io_base;
>  };
>  
>  #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 

Thanks

Eric

