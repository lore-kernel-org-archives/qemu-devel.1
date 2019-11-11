Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0372C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 01:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975C7206DF
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 01:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975C7206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTyPn-0004xJ-Oh
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 20:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iTyPB-0004Vc-6o
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 20:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iTyP8-0007ZH-Pp
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 20:22:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:24256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iTyP8-0007Sx-GU
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 20:22:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Nov 2019 17:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,290,1569308400"; d="scan'208";a="206597524"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.160])
 ([10.239.196.160])
 by orsmga003.jf.intel.com with ESMTP; 10 Nov 2019 17:21:53 -0800
Subject: Re: [PATCH v15 09/12] hmat acpi: Build Memory Proximity Domain
 Attributes Structure(s)
To: Igor Mammedov <imammedo@redhat.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
 <20191107074511.14304-10-tao3.xu@intel.com>
 <20191108144407.204130ba@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <a373885f-e6fe-cbc4-81b7-eacf02d42c7e@intel.com>
Date: Mon, 11 Nov 2019 09:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191108144407.204130ba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 Daniel Black <daniel@linux.ibm.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/2019 9:44 PM, Igor Mammedov wrote:
> On Thu,  7 Nov 2019 15:45:08 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Table
>> (HMAT). The specification references below link:
>> http://www.uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
>>
>> It describes the memory attributes, such as memory side cache
>> attributes and bandwidth and latency details, related to the
>> Memory Proximity Domain. The software is
>> expected to use this information as hint for optimization.
>>
>> This structure describes Memory Proximity Domain Attributes by memory
>> subsystem and its associativity with processor proximity domain as well as
>> hint for memory usage.
>>
>> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
>> the platform's HMAT tables.
>>
>> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
> 
> with nit below fixed
>    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
>>
>> No changes in v15.
>>
>> Changes in v13:
>>      - Remove the unnecessary head file.
>> ---
>>   hw/acpi/Kconfig       |  7 ++-
>>   hw/acpi/Makefile.objs |  1 +
>>   hw/acpi/hmat.c        | 99 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/acpi/hmat.h        | 42 ++++++++++++++++++
>>   hw/i386/acpi-build.c  |  5 +++
>>   5 files changed, 152 insertions(+), 2 deletions(-)
>>   create mode 100644 hw/acpi/hmat.c
>>   create mode 100644 hw/acpi/hmat.h
>>
>> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>> index 12e3f1e86e..54209c6f2f 100644
>> --- a/hw/acpi/Kconfig
>> +++ b/hw/acpi/Kconfig
>> @@ -7,6 +7,7 @@ config ACPI_X86
>>       select ACPI_NVDIMM
>>       select ACPI_CPU_HOTPLUG
>>       select ACPI_MEMORY_HOTPLUG
>> +    select ACPI_HMAT
>>   
>>   config ACPI_X86_ICH
>>       bool
>> @@ -23,6 +24,10 @@ config ACPI_NVDIMM
>>       bool
>>       depends on ACPI
>>   
>> +config ACPI_HMAT
>> +    bool
>> +    depends on ACPI
>> +
>>   config ACPI_PCI
>>       bool
>>       depends on ACPI && PCI
>> @@ -33,5 +38,3 @@ config ACPI_VMGENID
>>       depends on PC
>>   
>>   config ACPI_HW_REDUCED
>> -    bool
>> -    depends on ACPI
>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 655a9c1973..517bd88704 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>>   common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>>   common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
>>   common-obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device.o
>> +common-obj-$(CONFIG_ACPI_HMAT) += hmat.o
>>   common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>>   
>>   common-obj-y += acpi_interface.o
>> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
>> new file mode 100644
>> index 0000000000..c595098ba7
>> --- /dev/null
>> +++ b/hw/acpi/hmat.c
>> @@ -0,0 +1,99 @@
>> +/*
>> + * HMAT ACPI Implementation
>> + *
>> + * Copyright(C) 2019 Intel Corporation.
>> + *
>> + * Author:
>> + *  Liu jingqi <jingqi.liu@linux.intel.com>
>> + *  Tao Xu <tao3.xu@intel.com>
>> + *
>> + * HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Table
>> + * (HMAT)
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "sysemu/numa.h"
>> +#include "hw/acpi/hmat.h"
>> +
>> +/*
>> + * ACPI 6.3:
>> + * 5.2.27.3 Memory Proximity Domain Attributes Structure: Table 5-145
>> + */
>> +static void build_hmat_mpda(GArray *table_data, uint16_t flags,
> 
>> +                            uint16_t initiator, uint16_t mem_node)
> why do you use 16 bit for fields that spec defines as 4byte ones?
> 
> It's ACPI api so it, I suggest to stay close to spec when building
> ACPI primitives (i.e. use uint32_t here).
> 

Thank you for your suggestion. I will fix it.
>> +{
>> +
>> +    /* Memory Proximity Domain Attributes Structure */
>> +    /* Type */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Length */
>> +    build_append_int_noprefix(table_data, 40, 4);
>> +    /* Flags */
>> +    build_append_int_noprefix(table_data, flags, 2);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Proximity Domain for the Attached Initiator */
>> +    build_append_int_noprefix(table_data, initiator, 4);
>> +    /* Proximity Domain for the Memory */
>> +    build_append_int_noprefix(table_data, mem_node, 4);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 4);
>> +    /*
>> +     * Reserved:
>> +     * Previously defined as the Start Address of the System Physical
>> +     * Address Range. Deprecated since ACPI Spec 6.3.
>> +     */
>> +    build_append_int_noprefix(table_data, 0, 8);
>> +    /*
>> +     * Reserved:
>> +     * Previously defined as the Range Length of the region in bytes.
>> +     * Deprecated since ACPI Spec 6.3.
>> +     */
>> +    build_append_int_noprefix(table_data, 0, 8);
>> +}
>> +
>> +/* Build HMAT sub table structures */
>> +static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
>> +{
>> +    uint16_t flags;
>> +    int i;
>> +
>> +    for (i = 0; i < numa_state->num_nodes; i++) {
>> +        flags = 0;
>> +
>> +        if (numa_state->nodes[i].initiator < MAX_NODES) {
>> +            flags |= HMAT_PROXIMITY_INITIATOR_VALID;
>> +        }
>> +
>> +        build_hmat_mpda(table_data, flags, numa_state->nodes[i].initiator, i);
>> +    }
>> +}
>> +
>> +void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_state)
>> +{
>> +    int hmat_start = table_data->len;
>> +
>> +    /* reserve space for HMAT header  */
>> +    acpi_data_push(table_data, 40);
>> +
>> +    hmat_build_table_structs(table_data, numa_state);
>> +
>> +    build_header(linker, table_data,
>> +                 (void *)(table_data->data + hmat_start),
>> +                 "HMAT", table_data->len - hmat_start, 2, NULL, NULL);
>> +}
>> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
>> new file mode 100644
>> index 0000000000..437dbc6872
>> --- /dev/null
>> +++ b/hw/acpi/hmat.h
>> @@ -0,0 +1,42 @@
>> +/*
>> + * HMAT ACPI Implementation Header
>> + *
>> + * Copyright(C) 2019 Intel Corporation.
>> + *
>> + * Author:
>> + *  Liu jingqi <jingqi.liu@linux.intel.com>
>> + *  Tao Xu <tao3.xu@intel.com>
>> + *
>> + * HMAT is defined in ACPI 6.3: 5.2.27 Heterogeneous Memory Attribute Table
>> + * (HMAT)
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
>> + */
>> +
>> +#ifndef HMAT_H
>> +#define HMAT_H
>> +
>> +#include "hw/acpi/aml-build.h"
>> +
>> +/*
>> + * ACPI 6.3: 5.2.27.3 Memory Proximity Domain Attributes Structure,
>> + * Table 5-145, Field "flag", Bit [0]: set to 1 to indicate that data in
>> + * the Proximity Domain for the Attached Initiator field is valid.
>> + * Other bits reserved.
>> + */
>> +#define HMAT_PROXIMITY_INITIATOR_VALID  0x1
>> +
>> +void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_state);
>> +
>> +#endif
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 266d9b534b..aec8b71569 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -67,6 +67,7 @@
>>   #include "hw/i386/intel_iommu.h"
>>   
>>   #include "hw/acpi/ipmi.h"
>> +#include "hw/acpi/hmat.h"
>>   
>>   /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
>>    * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
>> @@ -2721,6 +2722,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>>               acpi_add_table(table_offsets, tables_blob);
>>               build_slit(tables_blob, tables->linker, machine);
>>           }
>> +        if (machine->numa_state->hmat_enabled) {
>> +            acpi_add_table(table_offsets, tables_blob);
>> +            build_hmat(tables_blob, tables->linker, machine->numa_state);
>> +        }
>>       }
>>       if (acpi_get_mcfg(&mcfg)) {
>>           acpi_add_table(table_offsets, tables_blob);
> 


