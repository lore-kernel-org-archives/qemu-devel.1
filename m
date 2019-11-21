Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9C720878
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9C720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXbHz-0007Hr-LN
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iXbGX-0006IN-LO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iXbGV-0006ty-J2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:28:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:26299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iXbGV-0006sd-Ar
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:28:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Nov 2019 17:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; d="scan'208";a="357635556"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by orsmga004.jf.intel.com with ESMTP; 20 Nov 2019 17:28:04 -0800
Subject: Re: [PATCH v16 11/14] hmat acpi: Build System Locality Latency and
 Bandwidth Information Structure(s)
To: Igor Mammedov <imammedo@redhat.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-12-tao3.xu@intel.com>
 <20191120110939.7c60b184@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <b684f71c-bdab-8941-31bf-e0dc7e701a3f@intel.com>
Date: Thu, 21 Nov 2019 09:28:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191120110939.7c60b184@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/2019 6:09 PM, Igor Mammedov wrote:
> On Fri, 15 Nov 2019 15:53:49 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> This structure describes the memory access latency and bandwidth
>> information from various memory access initiator proximity domains.
>> The latency and bandwidth numbers represented in this structure
>> correspond to rated latency and bandwidth for the platform.
>> The software could use this information as hint for optimization.
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v16:
>>      - Add more description for lb_length (Igor)
>>      - Drop entry_list and calculate entries in this patch (Igor)
>>
>> Changes in v13:
>>      - Calculate the entries in a new patch.
>> ---
>>   hw/acpi/hmat.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 104 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
>> index 9ff79308a4..ed19ebed2f 100644
>> --- a/hw/acpi/hmat.c
>> +++ b/hw/acpi/hmat.c
>> @@ -25,8 +25,10 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>   #include "sysemu/numa.h"
>>   #include "hw/acpi/hmat.h"
>> +#include "qemu/error-report.h"
> 
> do you really need this header in this patch?
> 

I will drop this header in next version
> 
> modulo above nit, patch looks good so
> with above fixed (if necessary)
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
>>   
>>   /*
>>    * ACPI 6.3:
>> @@ -67,11 +69,89 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags,
>>       build_append_int_noprefix(table_data, 0, 8);
>>   }
>>   
>> +/*
>> + * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
>> + * Structure: Table 5-146
>> + */
>> +static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>> +                          uint32_t num_initiator, uint32_t num_target,
>> +                          uint32_t *initiator_list)
>> +{
>> +    int i, index;
>> +    HMAT_LB_Data *lb_data;
>> +    uint16_t *entry_list;
>> +    uint32_t base;
>> +    /* Length in bytes for entire structure */
>> +    uint32_t lb_length
>> +        = 32 /* Table length upto and including Entry Base Unit */
>> +        + 4 * num_initiator /* Initiator Proximity Domain List */
>> +        + 4 * num_target /* Target Proximity Domain List */
>> +        + 2 * num_initiator * num_target; /* Latency or Bandwidth Entries */
>> +
>> +    /* Type */
>> +    build_append_int_noprefix(table_data, 1, 2);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Length */
>> +    build_append_int_noprefix(table_data, lb_length, 4);
>> +    /* Flags: Bits [3:0] Memory Hierarchy, Bits[7:4] Reserved */
>> +    assert(!(hmat_lb->hierarchy >> 4));
>> +    build_append_int_noprefix(table_data, hmat_lb->hierarchy, 1);
>> +    /* Data Type */
>> +    build_append_int_noprefix(table_data, hmat_lb->data_type, 1);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Number of Initiator Proximity Domains (s) */
>> +    build_append_int_noprefix(table_data, num_initiator, 4);
>> +    /* Number of Target Proximity Domains (t) */
>> +    build_append_int_noprefix(table_data, num_target, 4);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 4);
>> +
>> +    /* Entry Base Unit */
>> +    if (hmat_lb->data_type <= HMAT_LB_DATA_WRITE_LATENCY) {
>> +        /* Convert latency base from nanoseconds to picosecond */
>> +        base = hmat_lb->base * 1000;
>> +    } else {
>> +        /* Convert bandwidth base from Byte to Megabyte */
>> +        base = hmat_lb->base / MiB;
>> +    }
>> +    build_append_int_noprefix(table_data, base, 8);
>> +
>> +    /* Initiator Proximity Domain List */
>> +    for (i = 0; i < num_initiator; i++) {
>> +        build_append_int_noprefix(table_data, initiator_list[i], 4);
>> +    }
>> +
>> +    /* Target Proximity Domain List */
>> +    for (i = 0; i < num_target; i++) {
>> +        build_append_int_noprefix(table_data, i, 4);
>> +    }
>> +
>> +    /* Latency or Bandwidth Entries */
>> +    entry_list = g_malloc0(hmat_lb->list->len * sizeof(uint16_t));
>> +    for (i = 0; i < hmat_lb->list->len; i++) {
>> +        lb_data = &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
>> +        index = lb_data->initiator * num_target + lb_data->target;
>> +
>> +        entry_list[index] = (uint16_t)(lb_data->data / hmat_lb->base);
>> +    }
>> +
>> +    for (i = 0; i < num_initiator * num_target; i++) {
>> +        build_append_int_noprefix(table_data, entry_list[i], 2);
>> +    }
>> +
>> +    g_free(entry_list);
>> +}
>> +
>>   /* Build HMAT sub table structures */
>>   static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
>>   {
>>       uint16_t flags;
>> -    int i;
>> +    uint32_t num_initiator = 0;
>> +    uint32_t initiator_list[MAX_NODES];
>> +    int i, hierarchy, type;
>> +    HMAT_LB_Info *hmat_lb;
>>   
>>       for (i = 0; i < numa_state->num_nodes; i++) {
>>           flags = 0;
>> @@ -82,6 +162,29 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
>>   
>>           build_hmat_mpda(table_data, flags, numa_state->nodes[i].initiator, i);
>>       }
>> +
>> +    for (i = 0; i < numa_state->num_nodes; i++) {
>> +        if (numa_state->nodes[i].has_cpu) {
>> +            initiator_list[num_initiator++] = i;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
>> +     * Structure: Table 5-146
>> +     */
>> +    for (hierarchy = HMAT_LB_MEM_MEMORY;
>> +         hierarchy <= HMAT_LB_MEM_CACHE_3RD_LEVEL; hierarchy++) {
>> +        for (type = HMAT_LB_DATA_ACCESS_LATENCY;
>> +             type <= HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
>> +            hmat_lb = numa_state->hmat_lb[hierarchy][type];
>> +
>> +            if (hmat_lb) {
>> +                build_hmat_lb(table_data, hmat_lb, num_initiator,
>> +                              numa_state->num_nodes, initiator_list);
>> +            }
>> +        }
>> +    }
>>   }
>>   
>>   void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_state)
> 


