Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 06:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AEC218BA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 06:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AEC218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXJqj-0002FX-4Z
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 01:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iXJpn-0001Ja-NV
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iXJpk-0002z1-6Q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:51:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:55176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iXJpj-0002tS-TL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:51:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 22:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,220,1571727600"; d="scan'208";a="381263826"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by orsmga005.jf.intel.com with ESMTP; 19 Nov 2019 22:51:16 -0800
Subject: Re: [PATCH v16 09/14] numa: Extend CLI to provide memory side cache
 information
To: Igor Mammedov <imammedo@redhat.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-10-tao3.xu@intel.com>
 <20191119124736.42f85fe9@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <3e66e561-f7b3-8265-1a33-acb82e848aa4@intel.com>
Date: Wed, 20 Nov 2019 14:51:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191119124736.42f85fe9@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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

On 11/19/2019 7:47 PM, Igor Mammedov wrote:
> On Fri, 15 Nov 2019 15:53:47 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> Add -numa hmat-cache option to provide Memory Side Cache Information.
>> These memory attributes help to build Memory Side Cache Information
>> Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>
>> Reviewed-by: Daniel Black <daniel@linux.ibm.com>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v16:
>>      - Add cross check with hmat_lb data (Igor)
>>      - Drop total_levels in struct HMAT_Cache_Info (Igor)
>>      - Correct the error table number (Igor)
>>
>> Changes in v15:
>>      - Change the QAPI version tag to 5.0 (Eric)
>>
>> Changes in v13:
>>      - Drop the total_levels option.
>>      - Use readable cache size (Igor)
>> ---
>>   hw/core/numa.c        | 73 ++++++++++++++++++++++++++++++++++++++++
>>   include/sysemu/numa.h | 26 +++++++++++++++
>>   qapi/machine.json     | 78 +++++++++++++++++++++++++++++++++++++++++--
>>   qemu-options.hx       | 16 +++++++--
>>   4 files changed, 189 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index 47c7a96863..4d7af60bfd 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -359,6 +359,66 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
>>       g_array_append_val(hmat_lb->list, lb_data);
>>   }
>>   
>> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>> +                           Error **errp)
>> +{
>> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    NodeInfo *numa_info = ms->numa_state->nodes;
>> +    HMAT_Cache_Info *hmat_cache = NULL;
>> +
>> +    if (node->node_id >= nb_numa_nodes) {
>> +        error_setg(errp, "Invalid node-id=%" PRIu32 ", it should be less "
>> +                   "than %d", node->node_id, nb_numa_nodes);
>> +        return;
>> +    }
>> +
>> +    if (numa_info[node->node_id].lb_info_provided != (BIT(0) | BIT(1))) {
>> +        error_setg(errp, "The latency and bandwidth information of "
>> +                   "node-id=%" PRIu32 " should be provided before configure "
> 
> s/configure//
> 
>> +                   "memory side cache attributes",
>> +                   node->node_id);
>> +        return;
>> +    }
>> +
>> +    if (node->level >= HMAT_LB_LEVELS) {
>> +        error_setg(errp, "Invalid level=%" PRIu8 ", it should be less than or "
>> +                   "equal to %d", node->level, HMAT_LB_LEVELS - 1);
>> +        return;
>> +    }
>> +    assert(node->assoc < HMAT_CACHE_ASSOCIATIVITY__MAX);
>> +    assert(node->policy < HMAT_CACHE_WRITE_POLICY__MAX);
>> +    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
>> +        error_setg(errp, "Duplicate configuration of the side cache for "
>> +                   "node-id=%" PRIu32 " and level=%" PRIu8,
>> +                   node->node_id, node->level);
>> +        return;
>> +    }
>> +
>> +    if ((node->level > 1) &&
>> +        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
> will this check work as expected if I define on CLI "L+1" and then after it "L"?
> 

No, I will fix it.
>> +        (node->size >=
>> +            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
>> +        error_setg(errp, "Invalid size=0x%" PRIx64 ", the size of level=%" PRIu8
>> +                   " should be less than the size(0x%" PRIx64 ") of "
>> +                   "level=%" PRIu8, node->size, node->level,
>> +                   ms->numa_state->hmat_cache[node->node_id]
>> +                                             [node->level - 1]->size,
>> +                   node->level - 1);
>> +        return;
>> +    }
>> +
>> +    hmat_cache = g_malloc0(sizeof(*hmat_cache));
>> +
>> +    hmat_cache->proximity = node->node_id;
>> +    hmat_cache->size = node->size;
>> +    hmat_cache->level = node->level;
>> +    hmat_cache->associativity = node->assoc;
>> +    hmat_cache->write_policy = node->policy;
>> +    hmat_cache->line_size = node->line;
>> +
>> +    ms->numa_state->hmat_cache[node->node_id][node->level] = hmat_cache;
>> +}
>> +
>>   void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>>   {
>>       Error *err = NULL;
>> @@ -410,6 +470,19 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>>               goto end;
>>           }
>>           break;
>> +    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
>> +        if (!ms->numa_state->hmat_enabled) {
>> +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
>> +                       "(HMAT) is disabled, enable it with -machine hmat=on "
>> +                       "before using any of hmat specific options");
>> +            return;
>> +        }
>> +
>> +        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
>> +        if (err) {
>> +            goto end;
>> +        }
>> +        break;
>>       default:
>>           abort();
>>       }
>> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
>> index 70f93c83d7..b415550678 100644
>> --- a/include/sysemu/numa.h
>> +++ b/include/sysemu/numa.h
>> @@ -76,6 +76,27 @@ struct HMAT_LB_Info {
>>   };
>>   typedef struct HMAT_LB_Info HMAT_LB_Info;
>>   
>> +struct HMAT_Cache_Info {
>> +    /* The memory proximity domain to which the memory belongs. */
>> +    uint32_t    proximity;
>> +
>> +    /* Size of memory side cache in bytes. */
>> +    uint64_t    size;
>> +
>> +    /* Cache level described in this structure. */
>> +    uint8_t     level;
>> +
>> +    /* Cache Associativity: None/Direct Mapped/Comple Cache Indexing */
>> +    uint8_t     associativity;
>> +
>> +    /* Write Policy: None/Write Back(WB)/Write Through(WT) */
>> +    uint8_t     write_policy;
>> +
>> +    /* Cache Line size in bytes. */
>> +    uint16_t    line_size;
>> +};
>> +typedef struct HMAT_Cache_Info HMAT_Cache_Info;
> Is there a reason why you use this structure instead of QAPI
> generated NumaHmatCacheOptions structure?
> 

Thank you for your suggestion. I will use NumaHmatCacheOptions to 
replace HMAT_Cache_Info.

