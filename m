Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCEFC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E9D218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 06:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E9D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iISLw-0000m0-6x
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 02:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iISKr-0000Km-Ne
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iISKp-0005oa-F4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:54:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:40099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iISKp-0005mD-67
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 02:54:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Oct 2019 23:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; d="scan'208";a="345608190"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.22])
 ([10.239.197.22])
 by orsmga004.jf.intel.com with ESMTP; 09 Oct 2019 23:53:57 -0700
From: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v12 09/11] hmat acpi: Build System Locality Latency and
 Bandwidth Information Structure(s)
To: Igor Mammedov <imammedo@redhat.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-10-tao3.xu@intel.com>
 <20191003164111.078fdce4@redhat.com>
Message-ID: <24a4842c-4ce4-3a7f-5032-8e74458de44c@intel.com>
Date: Thu, 10 Oct 2019 14:53:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003164111.078fdce4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/2019 10:41 PM, Igor Mammedov wrote:
> On Fri, 20 Sep 2019 15:43:47 +0800
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
>> Changes in v12:
>>      - Fix a bug that if HMAT is enabled and without hmat-lb setting,
>>        QEMU will crash. (reported by Danmei Wei)
>>
>> Changes in v11:
>>      - Calculate base in build_hmat_lb().
>> ---
>>   hw/acpi/hmat.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   hw/acpi/hmat.h |   2 +
>>   2 files changed, 127 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
>> index 1368fce7ee..e7be849581 100644
>> --- a/hw/acpi/hmat.c
>> +++ b/hw/acpi/hmat.c
>> @@ -27,6 +27,7 @@
>>   #include "qemu/osdep.h"
>>   #include "sysemu/numa.h"
>>   #include "hw/acpi/hmat.h"
>> +#include "qemu/error-report.h"
>>   
>>   /*
>>    * ACPI 6.3:
>> @@ -67,11 +68,105 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
>>       build_append_int_noprefix(table_data, 0, 8);
>>   }
>>   
>> +static bool entry_overflow(uint64_t *lb_data, uint64_t base, int len)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < len; i++) {
>> +        if (lb_data[i] / base >= UINT16_MAX) {
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
> I suggest to do this check at CLI parsing time
> 
>> +/*
>> + * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
>> + * Structure: Table 5-146
>> + */
>> +static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>> +                          uint32_t num_initiator, uint32_t num_target,
>> +                          uint32_t *initiator_list, int type)
>> +{
>> +    uint8_t mask = 0x0f;
>> +    uint32_t s = num_initiator;
>> +    uint32_t t = num_target;
> drop this locals and use arguments directly
> 
>> +    uint64_t base = 1;
>> +    uint64_t *lb_data;
>> +    int i, unit;
>> +
>> +    /* Type */
>> +    build_append_int_noprefix(table_data, 1, 2);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Length */
>> +    build_append_int_noprefix(table_data, 32 + 4 * s + 4 * t + 2 * s * t, 4);
>                                               ^^^^
> to me above looks like /dev/random output, absolutely unreadable.
> Suggest to use local var (like: lb_length) for expression with comments
> beside magic numbers.
> 
>> +    /* Flags: Bits [3:0] Memory Hierarchy, Bits[7:4] Reserved */
>> +    build_append_int_noprefix(table_data, hmat_lb->hierarchy & mask, 1);
> 
> why do you need to use mask here?
> 
Because Bits[7:4] Reserved, so I use mask to keep it reserved.

>> +    /* Data Type */
>> +    build_append_int_noprefix(table_data, hmat_lb->data_type, 1);
> 
> Isn't hmat_lb->data_type and passed argument 'type' the same?
> 
Yes, I will drop 'type'.
> 
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Number of Initiator Proximity Domains (s) */
>> +    build_append_int_noprefix(table_data, s, 4);
>> +    /* Number of Target Proximity Domains (t) */
>> +    build_append_int_noprefix(table_data, t, 4);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 4);
>> +
>> +    if (HMAT_IS_LATENCY(type)) {
>> +        unit = 1000;
>> +        lb_data = hmat_lb->latency;
>> +    } else {
>> +        unit = 1024;
>> +        lb_data = hmat_lb->bandwidth;
>> +    }
>> +
>> +    while (entry_overflow(lb_data, base, s * t)) {
>> +        for (i = 0; i < s * t; i++) {
>> +            if (!QEMU_IS_ALIGNED(lb_data[i], unit * base)) {
>> +                error_report("Invalid latency/bandwidth input, all "
>> +                "latencies/bandwidths should be specified in the same units.");
>> +                exit(1);
>> +            }
>> +        }
>> +        base *= unit;
>> +    }
> Can you clarify what you are trying to check here?
> 
This part I use entry_overflow() to check if uint16 can store entry. If 
can't store and the entries matrix can be divisible by unit * base, then 
base will be unit * base.

For example, if lb_data[i] are 1048576(1TB/s) and 1024(1GB/s), unit is 
1024, so 1048576 is bigger than UINT16_MAX, and can be divisible by 1024 
* 1, so base is 1024 and entries are 1024 and 1 (see entry = 
hmat_lb->latency[i] / base;). The benefit is even user input different 
unit(TB/s vs GB/s), we can still store the data as far as possible.

>> +
>> +    /* Entry Base Unit */
>> +    build_append_int_noprefix(table_data, base, 8);
>> +
>> +    /* Initiator Proximity Domain List */
>> +    for (i = 0; i < s; i++) {
>> +        build_append_int_noprefix(table_data, initiator_list[i], 4);
>> +    }
>> +
>> +    /* Target Proximity Domain List */
>> +    for (i = 0; i < t; i++) {
>> +        build_append_int_noprefix(table_data, i, 4);
>> +    }
>> +
>> +    /* Latency or Bandwidth Entries */
>> +    for (i = 0; i < s * t; i++) {
>> +        uint16_t entry;
>> +
>> +        if (HMAT_IS_LATENCY(type)) {
> drop if condition and reuse lb_data, that you've just initialized above
> 
> 
>> +            entry = hmat_lb->latency[i] / base;
> ...
>> +            entry = hmat_lb->bandwidth[i] / base;
> I'm not sure that above is correct.
> Pls clarify math behind above 2 expressions
> 
>> +        }
>> +
>> +        build_append_int_noprefix(table_data, entry, 2);
>> +    }
>> +}
>> +
>>   /* Build HMAT sub table structures */
>>   static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
>>   {
>>       uint16_t flags;
>> -    int i;
>> +    uint32_t *initiator_list = NULL;
>> +    int i, j, hrchy, type;
> s/hrchy/hierarchy/
> 
>> +    HMAT_LB_Info *numa_hmat_lb;
>>   
>>       for (i = 0; i < nstat->num_nodes; i++) {
>>           flags = 0;
>> @@ -82,6 +177,35 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
>>   
>>           build_hmat_mpda(table_data, flags, nstat->nodes[i].initiator, i);
>>       }
>> +
>> +    if (nstat->num_initiator) {
>> +        initiator_list = g_malloc0(nstat->num_initiator * sizeof(uint32_t));
>> +        for (i = 0, j = 0; i < nstat->num_nodes; i++) {
>> +            if (nstat->nodes[i].has_cpu) {
>> +                initiator_list[j] = i;
>> +                j++;
>> +            }
>> +        }
>> +    }
>> +
>> +    /*
>> +     * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
>> +     * Structure: Table 5-146
>> +     */
>> +    for (hrchy = HMAT_LB_MEM_MEMORY;
>> +         hrchy <= HMAT_LB_MEM_CACHE_3RD_LEVEL; hrchy++) {
>> +        for (type = HMAT_LB_DATA_ACCESS_LATENCY;
>> +             type <= HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
>> +            numa_hmat_lb = nstat->hmat_lb[hrchy][type];
>> +
>> +            if (numa_hmat_lb) {
>> +                build_hmat_lb(table_data, numa_hmat_lb, nstat->num_initiator,
>> +                              nstat->num_nodes, initiator_list, type);
>> +            }
>> +        }
>> +    }
>> +
>> +    g_free(initiator_list);
>>   }
>>   
>>   void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat)
>> diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
>> index 0c1839cf6f..1154dfb48e 100644
>> --- a/hw/acpi/hmat.h
>> +++ b/hw/acpi/hmat.h
>> @@ -40,6 +40,8 @@
>>    */
>>   #define HMAT_PROX_INIT_VALID 0x1
>>   
>> +#define HMAT_IS_LATENCY(type) (type <= HMAT_LB_DATA_WRITE_LATENCY)
> 
> it's not worth to create macro for 1-off calculation, just drop it
> and s/if (HMAT_IS_LATENCY(type))/if(type <= HMAT_LB_DATA_WRITE_LATENCY)/
> 
>> +
>>   void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *nstat);
>>   
>>   #endif
> 


