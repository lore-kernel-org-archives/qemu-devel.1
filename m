Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17CBC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6113620665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6113620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhu5S-00047G-Ee
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hhu2Z-0003Md-QT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hhu2X-0000df-7z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:00:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hhu2W-0000cY-VE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:00:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 062363162916;
 Mon,  1 Jul 2019 10:59:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B09E19C77;
 Mon,  1 Jul 2019 10:59:55 +0000 (UTC)
Date: Mon, 1 Jul 2019 12:59:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190701125950.76f8b553@redhat.com>
In-Reply-To: <20190614155626.27932-6-tao3.xu@intel.com>
References: <20190614155626.27932-1-tao3.xu@intel.com>
 <20190614155626.27932-6-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 01 Jul 2019 11:00:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 5/8] acpi: introduce
 AcpiDeviceIfClass.build_mem_ranges hook
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
Cc: jingqi.liu@intel.com, fan.du@intel.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 23:56:23 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Add build_mem_ranges callback to AcpiDeviceIfClass and use
> it for generating SRAT and HMAT numa memory ranges.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Co-developed-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v5 -> v4:
>     - Add the missing if 'mem_len > 0' in pc_build_mem_ranges() (Igor)
>     - Correct the descriptions of build_mem_ranges
>     in AcpiDeviceIfClass (Igor)
>     - Use GArray for NUMA memory ranges data (Igor)
>     - Add the reason of using stub (Igor)
> ---
>  hw/acpi/piix4.c                      |   1 +
>  hw/i386/acpi-build.c                 | 133 +++++++++++++++++----------
>  hw/isa/lpc_ich9.c                    |   1 +
>  include/hw/acpi/acpi_dev_interface.h |   4 +
>  include/hw/i386/pc.h                 |   1 +
>  include/sysemu/numa.h                |  12 +++
>  stubs/Makefile.objs                  |   1 +
>  stubs/pc_build_mem_ranges.c          |  14 +++
>  8 files changed, 120 insertions(+), 47 deletions(-)
>  create mode 100644 stubs/pc_build_mem_ranges.c
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index ec4e186cec..bc078c1ad7 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -702,6 +702,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
>      adevc->ospm_status = piix4_ospm_status;
>      adevc->send_event = piix4_send_gpe;
>      adevc->madt_cpu = pc_madt_cpu_entry;
> +    adevc->build_mem_ranges = pc_build_mem_ranges;
>  }
>  
>  static const TypeInfo piix4_pm_info = {
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 055e677c30..44dd447fa5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2279,18 +2279,89 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>  #define HOLE_640K_START  (640 * KiB)
>  #define HOLE_640K_END   (1 * MiB)
>  
> +void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *ms)
> +{
> +    uint64_t mem_len, mem_base, next_base;
> +    int i;
> +    PCMachineState *pcms = PC_MACHINE(ms);
> +    NumaState *nstat = ms->numa_state;
> +    NumaMemRange *mem_range;
> +    nstat->mem_ranges_num = 0;
> +    next_base = 0;
> +
> +    /*
> +     * the memory map is a bit tricky, it contains at least one hole
> +     * from 640k-1M and possibly another one from 3.5G-4G.
> +     */
> +
> +    for (i = 0; i < pcms->numa_nodes; ++i) {
> +        mem_base = next_base;
> +        mem_len = pcms->node_mem[i];
> +        next_base = mem_base + mem_len;
> +
> +        /* Cut out the 640K hole */
> +        if (mem_base <= HOLE_640K_START &&
> +            next_base > HOLE_640K_START) {
> +            mem_len -= next_base - HOLE_640K_START;
> +            if (mem_len > 0) {
> +                mem_range = acpi_data_push(nstat->mem_ranges,
> +                                           sizeof *mem_range);
> +                mem_range->base = mem_base;
> +                mem_range->length = mem_len;
> +                mem_range->node = i;
> +                nstat->mem_ranges_num++;
> +            }
> +
> +            /* Check for the rare case: 640K < RAM < 1M */
> +            if (next_base <= HOLE_640K_END) {
> +                next_base = HOLE_640K_END;
> +                continue;
> +            }
> +            mem_base = HOLE_640K_END;
> +            mem_len = next_base - HOLE_640K_END;
> +        }
> +
> +        /* Cut out the ACPI_PCI hole */
> +        if (mem_base <= pcms->below_4g_mem_size &&
> +            next_base > pcms->below_4g_mem_size) {
> +            mem_len -= next_base - pcms->below_4g_mem_size;
> +            if (mem_len > 0) {
> +                mem_range = acpi_data_push(nstat->mem_ranges,
> +                                           sizeof *mem_range);
> +                mem_range->base = mem_base;
> +                mem_range->length = mem_len;
> +                mem_range->node = i;
> +                nstat->mem_ranges_num++;
> +            }
> +            mem_base = 1ULL << 32;
> +            mem_len = next_base - pcms->below_4g_mem_size;
> +            next_base = mem_base + mem_len;
> +        }
> +        if (mem_len > 0) {
> +            mem_range = acpi_data_push(nstat->mem_ranges,
> +                                       sizeof *mem_range);
> +            mem_range->base = mem_base;
> +            mem_range->length = mem_len;
> +            mem_range->node = i;
> +            nstat->mem_ranges_num++;
> +        }
> +    }
> +}
> +
>  static void
>  build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  {
>      AcpiSystemResourceAffinityTable *srat;
>      AcpiSratMemoryAffinity *numamem;
>  
> -    int i;
> -    int srat_start, numa_start, slots;
> -    uint64_t mem_len, mem_base, next_base;
> +    int i, srat_start, numa_start, slots;
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>      const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
>      PCMachineState *pcms = PC_MACHINE(machine);
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
> +    AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
> +    NumaState *nstat = machine->numa_state;
> +    NumaMemRange *mem_range;
>      ram_addr_t hotplugabble_address_space_size =
>          object_property_get_int(OBJECT(pcms), PC_MACHINE_DEVMEM_REGION_SIZE,
>                                  NULL);
> @@ -2327,57 +2398,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>          }
>      }
>  
> +    if (pcms->numa_nodes && !nstat->mem_ranges_num) {
suggest to drop nstat->mem_ranges_num field and use nstat->mem_ranges->len instead,
also its probably better to initialize nstat->mem_ranges
at the same place where ms->numa_state is initialized, so that
a specific platform code won't need to duplicate it.

> +        nstat->mem_ranges = g_array_new(false, true /* clear */,
> +                                        sizeof *mem_range);
> +        adevc->build_mem_ranges(adev, machine);
> +    }
>  
> -    /* the memory map is a bit tricky, it contains at least one hole
> -     * from 640k-1M and possibly another one from 3.5G-4G.
> -     */
> -    next_base = 0;
>      numa_start = table_data->len;
>  
> -    for (i = 1; i < pcms->numa_nodes + 1; ++i) {
> -        mem_base = next_base;
> -        mem_len = pcms->node_mem[i - 1];
> -        next_base = mem_base + mem_len;
> -
> -        /* Cut out the 640K hole */
> -        if (mem_base <= HOLE_640K_START &&
> -            next_base > HOLE_640K_START) {
> -            mem_len -= next_base - HOLE_640K_START;
> -            if (mem_len > 0) {
> -                numamem = acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> -                                  MEM_AFFINITY_ENABLED);
> -            }
> -
> -            /* Check for the rare case: 640K < RAM < 1M */
> -            if (next_base <= HOLE_640K_END) {
> -                next_base = HOLE_640K_END;
> -                continue;
> -            }
> -            mem_base = HOLE_640K_END;
> -            mem_len = next_base - HOLE_640K_END;
> -        }
> -
> -        /* Cut out the ACPI_PCI hole */
> -        if (mem_base <= pcms->below_4g_mem_size &&
> -            next_base > pcms->below_4g_mem_size) {
> -            mem_len -= next_base - pcms->below_4g_mem_size;
> -            if (mem_len > 0) {
> -                numamem = acpi_data_push(table_data, sizeof *numamem);
> -                build_srat_memory(numamem, mem_base, mem_len, i - 1,
> -                                  MEM_AFFINITY_ENABLED);
> -            }
> -            mem_base = 1ULL << 32;
> -            mem_len = next_base - pcms->below_4g_mem_size;
> -            next_base = mem_base + mem_len;
> -        }
> -
> -        if (mem_len > 0) {
> +    for (i = 0; i < nstat->mem_ranges_num; i++) {
> +        mem_range = &g_array_index(nstat->mem_ranges, NumaMemRange, i);
> +        if (mem_range->length > 0) {
why do we have this condition,
I'd assume adevc->build_mem_ranges() shouldn't return empty ranges.

>              numamem = acpi_data_push(table_data, sizeof *numamem);
> -            build_srat_memory(numamem, mem_base, mem_len, i - 1,
> +            build_srat_memory(numamem, mem_range->base,
> +                              mem_range->length,
> +                              mem_range->node,
>                                MEM_AFFINITY_ENABLED);
>          }
>      }
> +
>      slots = (table_data->len - numa_start) / sizeof *numamem;
>      for (; slots < pcms->numa_nodes + 2; slots++) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 35d17246e9..20d919c63d 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -801,6 +801,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
>      adevc->ospm_status = ich9_pm_ospm_status;
>      adevc->send_event = ich9_send_gpe;
>      adevc->madt_cpu = pc_madt_cpu_entry;
> +    adevc->build_mem_ranges = pc_build_mem_ranges;
>  }
>  
>  static const TypeInfo ich9_lpc_info = {
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 43ff119179..5956b5ea33 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -39,6 +39,8 @@ void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
>   *           for CPU indexed by @uid in @apic_ids array,
>   *           returned structure types are:
>   *           0 - Local APIC, 9 - Local x2APIC, 0xB - GICC
> + * build_mem_ranges: build memory ranges of ACPI SRAT (except misc
> + * and hotplug SRAT ranges) and HMAT
>   *
>   * Interface is designed for providing unified interface
>   * to generic ACPI functionality that could be used without
> @@ -54,5 +56,7 @@ typedef struct AcpiDeviceIfClass {
>      void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
>      void (*madt_cpu)(AcpiDeviceIf *adev, int uid,
>                       const CPUArchIdList *apic_ids, GArray *entry);
> +    void (*build_mem_ranges)(AcpiDeviceIf *adev, MachineState *ms);
> +
>  } AcpiDeviceIfClass;
>  #endif
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 5d5636241e..21b9ac3d11 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -281,6 +281,7 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>  /* acpi-build.c */
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
> +void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *ms);
>  
>  /* e820 types */
>  #define E820_RAM        1
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 437eb21fef..e3c85b77bc 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -20,6 +20,12 @@ struct NumaNodeMem {
>      uint64_t node_plugged_mem;
>  };
>  
> +typedef struct NumaMemRange {
> +    uint64_t base;
> +    uint64_t length;
> +    uint32_t node;
> +} NumaMemRange;
> +
>  struct NumaState {
>      /* Number of NUMA nodes */
>      int num_nodes;
> @@ -29,6 +35,12 @@ struct NumaState {
>  
>      /* NUMA nodes information */
>      NodeInfo nodes[MAX_NODES];
> +
> +    /* Number of NUMA memory ranges */
> +    uint32_t mem_ranges_num;
> +
> +    /* NUMA memory ranges */
> +    GArray *mem_ranges;
>  };
>  typedef struct NumaState NumaState;
>  
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 9c7393b08c..4f0cdc1a45 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -33,6 +33,7 @@ stub-obj-y += qmp_memory_device.o
>  stub-obj-y += target-monitor-defs.o
>  stub-obj-y += target-get-monitor-def.o
>  stub-obj-y += pc_madt_cpu_entry.o
> +stub-obj-y += pc_build_mem_ranges.o
>  stub-obj-y += vmgenid.o
>  stub-obj-y += xen-common.o
>  stub-obj-y += xen-hvm.o
> diff --git a/stubs/pc_build_mem_ranges.c b/stubs/pc_build_mem_ranges.c
> new file mode 100644
> index 0000000000..997cdfe00b
> --- /dev/null
> +++ b/stubs/pc_build_mem_ranges.c
> @@ -0,0 +1,14 @@
> +/*
> + * Stub for pc_build_mem_ranges().
> + * piix4 is used not only pc, but also mips and etc. In order to add
> + * build_mem_ranges callback to AcpiDeviceIfClass and use pc_build_mem_ranges
> + * in hw/acpi/piix4.c, pc_build_mem_ranges() stub is added to make other arch
> + * can compile successfully.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i386/pc.h"
> +
> +void pc_build_mem_ranges(AcpiDeviceIf *adev, MachineState *ms)
> +{
> +}


