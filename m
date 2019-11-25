Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56319C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7E12071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7E12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ2uE-0006P4-AQ
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 20:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iZ2td-0005zF-AX
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iZ2tc-0002w0-0w
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:10:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:16618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iZ2tb-0002ue-NT
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:10:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Nov 2019 17:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; d="scan'208";a="205951623"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2019 17:10:28 -0800
Subject: Re: [PATCH v17 12/14] hmat acpi: Build Memory Side Cache Information
 Structure(s)
To: Igor Mammedov <imammedo@redhat.com>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-13-tao3.xu@intel.com>
 <20191122133219.1d46d30c@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <a43bdc6f-c20a-564a-49f9-87d36f73e2f0@intel.com>
Date: Mon, 25 Nov 2019 09:10:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122133219.1d46d30c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "armbru@redhat.com" <armbru@redhat.com>, Daniel Black <daniel@linux.ibm.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/2019 8:32 PM, Igor Mammedov wrote:
> On Fri, 22 Nov 2019 15:48:24 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> This structure describes memory side cache information for memory
>> proximity domains if the memory side cache is present and the
>> physical device forms the memory side cache.
>> The software could use this information to effectively place
>> the data in memory to maximize the performance of the system
>> memory that use the memory side cache.
>>
>> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> for the future reference,
> You are not supposed to carry over Reviewed-by tags
> if you do non trivial change to the patch.
> 

OK, thanks for your suggestion
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
>> ---
>>
>> No changes in v17.
>>
>> Changes in v16:
>>      - Use checks and assert to replace masks (Igor)
>>      - Fields in Cache Attributes are promoted to uint32_t before
>>        shifting (Igor)
>>      - Drop cpu_to_le32() (Igor)
>>
>> Changes in v13:
>>      - rename level as cache_level
>> ---
>>   hw/acpi/hmat.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
>> index e5ee8b4317..bb6adb0ccf 100644
>> --- a/hw/acpi/hmat.c
>> +++ b/hw/acpi/hmat.c
>> @@ -143,14 +143,62 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
>>       g_free(entry_list);
>>   }
>>   
>> +/* ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure: Table 5-147 */
>> +static void build_hmat_cache(GArray *table_data, uint8_t total_levels,
>> +                             NumaHmatCacheOptions *hmat_cache)
>> +{
>> +    /*
>> +     * Cache Attributes: Bits [3:0] – Total Cache Levels
>> +     * for this Memory Proximity Domain
>> +     */
>> +    uint32_t cache_attr = total_levels;
>> +
>> +    /* Bits [7:4] : Cache Level described in this structure */
>> +    cache_attr |= (uint32_t) hmat_cache->level << 4;
>> +
>> +    /* Bits [11:8] - Cache Associativity */
>> +    cache_attr |= (uint32_t) hmat_cache->assoc << 8;
>> +
>> +    /* Bits [15:12] - Write Policy */
>> +    cache_attr |= (uint32_t) hmat_cache->policy << 12;
>> +
>> +    /* Bits [31:16] - Cache Line size in bytes */
>> +    cache_attr |= (uint32_t) hmat_cache->line << 16;
>> +
>> +    /* Type */
>> +    build_append_int_noprefix(table_data, 2, 2);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /* Length */
>> +    build_append_int_noprefix(table_data, 32, 4);
>> +    /* Proximity Domain for the Memory */
>> +    build_append_int_noprefix(table_data, hmat_cache->node_id, 4);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 4);
>> +    /* Memory Side Cache Size */
>> +    build_append_int_noprefix(table_data, hmat_cache->size, 8);
>> +    /* Cache Attributes */
>> +    build_append_int_noprefix(table_data, cache_attr, 4);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +    /*
>> +     * Number of SMBIOS handles (n)
>> +     * Linux kernel uses Memory Side Cache Information Structure
>> +     * without SMBIOS entries for now, so set Number of SMBIOS handles
>> +     * as 0.
>> +     */
>> +    build_append_int_noprefix(table_data, 0, 2);
>> +}
>> +
>>   /* Build HMAT sub table structures */
>>   static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
>>   {
>>       uint16_t flags;
>>       uint32_t num_initiator = 0;
>>       uint32_t initiator_list[MAX_NODES];
>> -    int i, hierarchy, type;
>> +    int i, hierarchy, type, cache_level, total_levels;
>>       HMAT_LB_Info *hmat_lb;
>> +    NumaHmatCacheOptions *hmat_cache;
>>   
>>       for (i = 0; i < numa_state->num_nodes; i++) {
>>           flags = 0;
>> @@ -184,6 +232,25 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
>>               }
>>           }
>>       }
>> +
>> +    /*
>> +     * ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure:
>> +     * Table 5-147
>> +     */
>> +    for (i = 0; i < numa_state->num_nodes; i++) {
>> +        total_levels = 0;
>> +        for (cache_level = 1; cache_level < HMAT_LB_LEVELS; cache_level++) {
>> +            if (numa_state->hmat_cache[i][cache_level]) {
>> +                total_levels++;
>> +            }
>> +        }
>> +        for (cache_level = 0; cache_level <= total_levels; cache_level++) {
>> +            hmat_cache = numa_state->hmat_cache[i][cache_level];
>> +            if (hmat_cache) {
>> +                build_hmat_cache(table_data, total_levels, hmat_cache);
>> +            }
>> +        }
>> +    }
>>   }
>>   
>>   void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_state)
> 


