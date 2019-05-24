Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303D4C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80E1206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80E1206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUB5s-000092-7P
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:22:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hUB0A-0005Yt-Nc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hUB08-0005Lc-Cw
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:16:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hUB06-0005J8-T4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:16:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B882C88E57;
	Fri, 24 May 2019 14:16:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A43A7E5D4;
	Fri, 24 May 2019 14:16:46 +0000 (UTC)
Date: Fri, 24 May 2019 16:16:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190524161642.3d82bcd5@redhat.com>
In-Reply-To: <20190508061726.27631-6-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-6-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 24 May 2019 14:16:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 05/11] hmat acpi: Build Memory Subsystem
 Address Range Structure(s) in ACPI HMAT
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 14:17:20 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> From: Liu Jingqi <jingqi.liu@intel.com>
> 
> HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Table (HMAT).
> The specification references below link:
> http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> 
> It describes the memory attributes, such as memory side cache
> attributes and bandwidth and latency details, related to the
> System Physical Address (SPA) Memory Ranges. The software is
> expected to use this information as hint for optimization.
> 
> This structure describes the System Physical Address(SPA) range
> occupied by memory subsystem and its associativity with processor
> proximity domain as well as hint for memory usage.
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
> 
> Changes in v4 -> v3:
>     - spilt the 1/8 of v3 patch into two patches, 4/13 introduces
>     build_mem_ranges() and adding it to ACPI interface, 5/13 builds
>     HMAT (Igor)
>     - use MachineState instead of PCMachineState to build HMAT more
>     generalic (Igor)
>     - move hmat_build_spa() inside of hmat_build_hma() (Igor)
> ---
>  hw/acpi/Kconfig       |   5 ++
>  hw/acpi/Makefile.objs |   1 +
>  hw/acpi/hmat.c        | 135 ++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/hmat.h        |  43 ++++++++++++++
>  hw/i386/acpi-build.c  |  11 ++--
>  include/hw/boards.h   |   2 +
>  numa.c                |   6 ++
>  7 files changed, 199 insertions(+), 4 deletions(-)
>  create mode 100644 hw/acpi/hmat.c
>  create mode 100644 hw/acpi/hmat.h
> 
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index eca3beed75..074dbd5a42 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -7,6 +7,7 @@ config ACPI_X86
>      select ACPI_NVDIMM
>      select ACPI_CPU_HOTPLUG
>      select ACPI_MEMORY_HOTPLUG
> +    select ACPI_HMAT
>  
>  config ACPI_X86_ICH
>      bool
> @@ -27,3 +28,7 @@ config ACPI_VMGENID
>      bool
>      default y
>      depends on PC
> +
> +config ACPI_HMAT
> +    bool
> +    depends on ACPI
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 2d46e3789a..932ba42d13 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
> +common-obj-$(CONFIG_ACPI_HMAT) += hmat.o
>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>  
>  common-obj-y += acpi_interface.o
> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> new file mode 100644
> index 0000000000..bffe453280
> --- /dev/null
> +++ b/hw/acpi/hmat.c
> @@ -0,0 +1,135 @@
> +/*
> + * HMAT ACPI Implementation
> + *
> + * Copyright(C) 2019 Intel Corporation.
> + *
> + * Author:
> + *  Liu jingqi <jingqi.liu@linux.intel.com>
> + *  Tao Xu <tao3.xu@intel.com>
> + *
> + * HMAT is defined in ACPI 6.2.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/numa.h"
> +#include "hw/i386/pc.h"
table is generic, pls make code generic too so it could be reused elsewhere

> +#include "hw/acpi/hmat.h"
> +#include "hw/nvram/fw_cfg.h"
why do you need this heared?

> +
> +/* Build Memory Subsystem Address Range Structure */
when creating APIs that build ACPI spec primitives, pls add
earliest version of the spec it is supported in and reference
chapter/table in that spec version where it's described.

see hw/acpi/aml-build.c for examples:

typical comment should look like:
 /* ACPI 1.0b: x.x.x.x chapter foo: Table y-y */

point is that it should be trivial for reader to find the spec
and grep referenced chapter/table in that spec by just copy-pasting
description form the code.

> +static void build_hmat_spa(GArray *table_data, MachineState *ms,
> +                           uint64_t base, uint64_t length, int node)
> +{
> +    uint16_t flags = 0;
> +
> +    if (ms->numa_state->nodes[node].is_initiator) {
you use only ms->numa_state->nodes from machine state here,
I'd suggest to pass is_initiator/is_target as arguments
so API won't depend on machine state

> +        flags |= HMAT_SPA_PROC_VALID;
> +    }
> +    if (ms->numa_state->nodes[node].is_target) {
> +        flags |= HMAT_SPA_MEM_VALID;
> +    }
> +
> +    /* Memory Subsystem Address Range Structure */
> +    /* Type */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 40, 4);
> +    /* Flags */
> +    build_append_int_noprefix(table_data, flags, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    /* Process Proximity Domain */
> +    build_append_int_noprefix(table_data, node, 4);
> +    /* Memory Proximity Domain */
> +    build_append_int_noprefix(table_data, node, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +    /* System Physical Address Range Base */
> +    build_append_int_noprefix(table_data, base, 8);
> +    /* System Physical Address Range Length */
> +    build_append_int_noprefix(table_data, length, 8);
> +}
> +
> +static int pc_dimm_device_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> +        *list = g_slist_append(*list, DEVICE(obj));
> +    }

missing 'if (dev->realized)' check, see memory_device_build_list()

> +
> +    object_child_foreach(obj, pc_dimm_device_list, opaque);
> +    return 0;
> +}
> +
> +/*
> + * The Proximity Domain of System Physical Address ranges defined
> + * in the HMAT, NFIT and SRAT tables shall match each other.
> + */

where does this comment comes from? (pointer to spec pls)

> +static void hmat_build_hma(GArray *table_data, MachineState *ms)
where does _hma comes from?
What you are building here is "Memory Subsystem Address Range Structure"
so I'd rather use acronym: msar

> +{
> +    GSList *device_list = NULL;
> +    uint64_t mem_base, mem_len;
> +    int i;
> +    uint32_t mem_ranges_num = ms->numa_state->mem_ranges_num;
> +    NumaMemRange *mem_ranges = ms->numa_state->mem_ranges;
> +
> +    PCMachineState *pcms = PC_MACHINE(ms);
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
> +    AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
> +
> +    /* Build HMAT Memory Subsystem Address Range. */
> +    if (pcms->numa_nodes && !mem_ranges_num) {
well, you've just moved a bunch of numa globals into MachineState,
why do you still use PCMachineState here making code depend on PCMachine.
I'd suggest to make it specific machine agnostic if possible
using MachineState instead.

With your refactoring duplicated PCMachineState numa fields probably
shouldn't be necessary and should be removed.

> +        adevc->build_mem_ranges(adev, ms);
> +    }
> +
> +    for (i = 0; i < mem_ranges_num; i++) {
> +        build_hmat_spa(table_data, ms, mem_ranges[i].base,
> +                       mem_ranges[i].length,
> +                       mem_ranges[i].node);
> +    }
> +
> +    /* Build HMAT SPA structures for PC-DIMM devices. */
> +    object_child_foreach(qdev_get_machine(),
> +                         pc_dimm_device_list, &device_list);
> +
> +    for (; device_list; device_list = device_list->next) {
> +        PCDIMMDevice *dimm = device_list->data;
> +        mem_base = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> +                                            NULL);
> +        mem_len = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
> +                                           NULL);
> +        i = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP, NULL);
> +        build_hmat_spa(table_data, ms, mem_base, mem_len, i);
> +    }
> +}
> +
> +void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms)
> +{
> +    uint64_t hmat_start, hmat_len;
> +
> +    hmat_start = table_data->len;

    +  /* reserve space for HMAT header  */

> +    acpi_data_push(table_data, 40);
> +
> +    hmat_build_hma(table_data, ms);
> +    hmat_len = table_data->len - hmat_start;
> +
> +    build_header(linker, table_data,
> +                 (void *)(table_data->data + hmat_start),
> +                 "HMAT", hmat_len, 1, NULL, NULL);

s/hmat_len/table_data->len - hmat_start/


> +}
> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
> new file mode 100644
> index 0000000000..4f480c1e43
> --- /dev/null
> +++ b/hw/acpi/hmat.h
> @@ -0,0 +1,43 @@
> +/*
> + * HMAT ACPI Implementation Header
> + *
> + * Copyright(C) 2019 Intel Corporation.
> + *
> + * Author:
> + *  Liu jingqi <jingqi.liu@linux.intel.com>
> + *  Tao Xu <tao3.xu@intel.com>
> + *
> + * HMAT is defined in ACPI 6.2.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#ifndef HMAT_H
> +#define HMAT_H
> +
> +#include "hw/acpi/acpi-defs.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "hw/acpi/aml-build.h"
> +
> +/* the values of AcpiHmatSpaRange flag */
> +enum {
> +    HMAT_SPA_PROC_VALID       = 0x1,
> +    HMAT_SPA_MEM_VALID        = 0x2,
> +    HMAT_SPA_RESERVATION_HINT = 0x4,
> +};
> +
> +void hmat_build_acpi(GArray *table_data, BIOSLinker *linker, MachineState *ms);

s/hmat_build_acpi/build_hmat/

> +
> +#endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5598e7f780..d3d8c93631 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -64,6 +64,7 @@
>  #include "hw/i386/intel_iommu.h"
>  
>  #include "hw/acpi/ipmi.h"
> +#include "hw/acpi/hmat.h"
>  
>  /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
>   * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
> @@ -2389,13 +2390,13 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>  
>      for (i = 0; i < mem_ranges_num; i++) {
>          if (mem_ranges[i].length > 0) {
> -                numamem = acpi_data_push(table_data, sizeof *numamem);
> +            numamem = acpi_data_push(table_data, sizeof *numamem);
>              build_srat_memory(numamem, mem_ranges[i].base,
>                                mem_ranges[i].length,
>                                mem_ranges[i].node,
> -                                  MEM_AFFINITY_ENABLED);
> -            }
> -            }
> +                              MEM_AFFINITY_ENABLED);
> +        }
> +    }

unrelated hunk move it to the patch that introduced wrongly
aligned lines in the first place

>      slots = (table_data->len - numa_start) / sizeof *numamem;
>      for (; slots < pcms->numa_nodes + 2; slots++) {
>          numamem = acpi_data_push(table_data, sizeof *numamem);
> @@ -2715,6 +2716,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>              acpi_add_table(table_offsets, tables_blob);
>              build_slit(tables_blob, tables->linker, machine);
>          }
> +        acpi_add_table(table_offsets, tables_blob);
> +        hmat_build_acpi(tables_blob, tables->linker, machine);
>      }
>      if (acpi_get_mcfg(&mcfg)) {
>          acpi_add_table(table_offsets, tables_blob);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 9fbf921ecf..d392634e08 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -237,6 +237,8 @@ struct NodeInfo {
>      uint64_t node_mem;
>      struct HostMemoryBackend *node_memdev;
>      bool present;
> +    bool is_initiator;
> +    bool is_target;
>      uint8_t distance[MAX_NODES];
>  };
>  
> diff --git a/numa.c b/numa.c
> index ddea376d72..71b0aee02a 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -102,6 +102,10 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          }
>      }
>  
> +    if (node->cpus) {
> +        numa_info[nodenr].is_initiator = true;
> +    }
this only takes care of legacy '-numa node,cpus=range' option
you also need to add handling for '-numa cpu' option

probably the better place to take care of all cpu options at once
is machine_numa_finish_cpu_init().


>      if (node->has_mem && node->has_memdev) {
>          error_setg(errp, "cannot specify both mem= and memdev=");
>          return;
> @@ -118,6 +122,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>  
>      if (node->has_mem) {
>          numa_info[nodenr].node_mem = node->mem;
> +        numa_info[nodenr].is_target = true;
>      }
>      if (node->has_memdev) {
>          Object *o;
> @@ -130,6 +135,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>          object_ref(o);
>          numa_info[nodenr].node_mem = object_property_get_uint(o, "size", NULL);
>          numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
> +        numa_info[nodenr].is_target = true;
>      }
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);


