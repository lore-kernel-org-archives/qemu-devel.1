Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B28FC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403F722DBF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403F722DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5TTC-0006fA-IK
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i5TSQ-0005no-3o
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i5TSO-0006P4-Hs
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i5TSI-0006K7-LF; Wed, 04 Sep 2019 07:28:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56B8483F4C;
 Wed,  4 Sep 2019 11:28:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C358194B2;
 Wed,  4 Sep 2019 11:28:00 +0000 (UTC)
Date: Wed, 4 Sep 2019 13:27:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190904132759.2663148a@redhat.com>
In-Reply-To: <20190904085629.13872-2-shameerali.kolothum.thodi@huawei.com>
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 04 Sep 2019 11:28:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 01/11] hw/acpi: Make ACPI IO
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, shannon.zhaosl@gmail.com,
 ard.biesheuvel@linaro.org, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 09:56:19 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

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
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v9 --> v10
>   - Fixed "make check" failure on x86_64.
> 
> v8 --> v9
>   -base address is an input into build_memory_hotplug_aml()
>   -Removed R-by tags from Igor and Eric for now.
> ---
>  hw/acpi/memory_hotplug.c         | 33 ++++++++++++++------------------
>  hw/i386/acpi-build.c             |  7 ++++++-
>  hw/i386/pc.c                     |  3 +++
>  include/hw/acpi/memory_hotplug.h |  9 +++++++--
>  include/hw/i386/pc.h             |  3 +++
>  5 files changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 9483d66e86..9b0b150f4f 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -30,12 +30,7 @@
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
> @@ -210,7 +205,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
>  };
>  
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state, uint16_t io_base)
> +                              MemHotplugState *state, hwaddr io_base)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>  
> @@ -219,12 +214,10 @@ void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
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
> @@ -343,7 +336,8 @@ const VMStateDescription vmstate_memory_hotplug = {
>  
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                const char *res_root,
> -                              const char *event_handler_method)
> +                              const char *event_handler_method,
> +                              AmlRegionSpace rs, hwaddr memhp_io_base)
>  {
>      int i;
>      Aml *ifctx;
> @@ -352,10 +346,6 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>      Aml *mem_ctrl_dev;
>      char *mhp_res_path;
>  
> -    if (!memhp_io_base) {
> -        return;
> -    }
> -
>      mhp_res_path = g_strdup_printf("%s." MEMORY_HOTPLUG_DEVICE, res_root);
>      mem_ctrl_dev = aml_device("%s", mhp_res_path);
>      {
> @@ -366,14 +356,19 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>              aml_name_decl("_UID", aml_string("Memory hotplug resources")));
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
> index 034e413fd0..0d97cc701d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1873,7 +1873,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");
>      }
> -    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0", "\\_GPE._E03");
> +
> +    if (pcms->memhp_io_base && nr_mem) {
> +        build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
> +                                 "\\_GPE._E03", AML_SYSTEM_IO,
> +                                 pcms->memhp_io_base);
> +    }
>  
>      scope =  aml_scope("_GPE");
>      {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c14ed86439..b38cd07231 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1951,6 +1951,9 @@ void pc_memory_init(PCMachineState *pcms,
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
> index 19a837889d..ac09e42030 100644
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


