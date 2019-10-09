Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BF2ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15D221848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15D221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFFN-0004aZ-M0
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iI6nT-0003HS-MZ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iI6nQ-0001lr-S8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:54:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:49284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iI6nQ-0001ka-5h
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 03:54:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Oct 2019 00:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; d="scan'208";a="205673591"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.191])
 ([10.239.196.191])
 by orsmga002.jf.intel.com with ESMTP; 09 Oct 2019 00:54:00 -0700
Subject: Re: [PATCH v12 07/11] numa: Extend CLI to provide memory side cache
 information
To: Igor Mammedov <imammedo@redhat.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-8-tao3.xu@intel.com>
 <20191003131901.630b1e0e@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <0ec60fe1-2817-16e0-9a4a-ca1a0a3536e1@intel.com>
Date: Wed, 9 Oct 2019 15:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003131901.630b1e0e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Daniel Black <daniel@linux.ibm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/2019 7:19 PM, Igor Mammedov wrote:
> On Fri, 20 Sep 2019 15:43:45 +0800
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
>> No changes in v12.
>>
>> Changes in v11:
>>      - Move numa option patches forward.
>> ---
>>   hw/core/numa.c        | 74 +++++++++++++++++++++++++++++++++++++++
>>   include/sysemu/numa.h | 31 +++++++++++++++++
>>   qapi/machine.json     | 81 +++++++++++++++++++++++++++++++++++++++++--
>>   qemu-options.hx       | 16 +++++++--
>>   4 files changed, 198 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index f5a1c9e909..182e4d9d62 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -293,6 +293,67 @@ void parse_numa_hmat_lb(NumaState *nstat, NumaHmatLBOptions *node,
>>       }
>>   }
>>   
>> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>> +                           Error **errp)
>> +{
>> +    int nb_numa_nodes = ms->numa_state->num_nodes;
>> +    HMAT_Cache_Info *hmat_cache = NULL;
>> +
>> +    if (node->node_id >= nb_numa_nodes) {
>> +        error_setg(errp, "Invalid node-id=%" PRIu32
>> +                   ", it should be less than %d.",
>> +                   node->node_id, nb_numa_nodes);
>> +        return;
>> +    }
>> +
>> +    if (node->total > MAX_HMAT_CACHE_LEVEL) {
>> +        error_setg(errp, "Invalid total=%" PRIu8
>> +                   ", it should be less than or equal to %d.",
>> +                   node->total, MAX_HMAT_CACHE_LEVEL);
>> +        return;
>> +    }
>> +    if (node->level > node->total) {
>> +        error_setg(errp, "Invalid level=%" PRIu8
>> +                   ", it should be less than or equal to"
>> +                   " total=%" PRIu8 ".",
>> +                   node->level, node->total);
>> +        return;
>> +    }
>> +    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
>> +        error_setg(errp, "Duplicate configuration of the side cache for "
>> +                   "node-id=%" PRIu32 " and level=%" PRIu8 ".",
>> +                   node->node_id, node->level);
>> +        return;
>> +    }
>> +
>> +    if ((node->level > 1) &&
>> +        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
>> +        (node->size >=
>> +            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
>> +        error_setg(errp, "Invalid size=0x%" PRIx64
>> +                   ", the size of level=%" PRIu8
>> +                   " should be less than the size(0x%" PRIx64
>> +                   ") of level=%" PRIu8 ".",
>> +                   node->size, node->level,
>> +                   ms->numa_state->hmat_cache[node->node_id]
>> +                                             [node->level - 1]->size,
>> +                   node->level - 1);
>> +        return;
>> +    }
>> +
>> +    hmat_cache = g_malloc0(sizeof(*hmat_cache));
>> +
>> +    hmat_cache->mem_proximity = node->node_id;
>> +    hmat_cache->size = node->size;
>> +    hmat_cache->total_levels = node->total;
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
>> @@ -344,6 +405,19 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>>               goto end;
>>           }
>>           break;
>> +    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
>> +        if (!ms->numa_state->hmat_enabled) {
>> +            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
>> +                       "(HMAT) is disabled, use -machine hmat=on before "
>> +                       "set initiator of NUMA");
>> +            return;
> the same as in 6/11 at similar place
> 
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
>> index 876beaee22..39312eefd4 100644
>> --- a/include/sysemu/numa.h
>> +++ b/include/sysemu/numa.h
>> @@ -35,6 +35,8 @@ enum {
>>   #define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
>>   #define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
>>   
>> +#define MAX_HMAT_CACHE_LEVEL        3
> 
> s/3/HMAT_LB_MEM_CACHE_3RD_LEVEL/
> 
> 
>>   struct NodeInfo {
>>       uint64_t node_mem;
>>       struct HostMemoryBackend *node_memdev;
>> @@ -65,6 +67,30 @@ struct HMAT_LB_Info {
>>   };
>>   typedef struct HMAT_LB_Info HMAT_LB_Info;
>>   
>> +struct HMAT_Cache_Info {
>> +    /* The memory proximity domain to which the memory belongs. */
>> +    uint32_t    mem_proximity;
> mem prefix here is redundant
> 
>> +    /* Size of memory side cache in bytes. */
>> +    uint64_t    size;
>> +
>> +    /* Total cache levels for this memory proximity domain. */
>> +    uint8_t     total_levels;
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
>> +
>>   struct NumaState {
>>       /* Number of NUMA nodes */
>>       int num_nodes;
>> @@ -83,6 +109,9 @@ struct NumaState {
>>   
>>       /* NUMA nodes HMAT Locality Latency and Bandwidth Information */
>>       HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
>> +
>> +    /* Memory Side Cache Information Structure */
>> +    HMAT_Cache_Info *hmat_cache[MAX_NODES][MAX_HMAT_CACHE_LEVEL + 1];
>>   };
>>   typedef struct NumaState NumaState;
>>   
>> @@ -90,6 +119,8 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp);
>>   void parse_numa_opts(MachineState *ms);
>>   void parse_numa_hmat_lb(NumaState *nstat, NumaHmatLBOptions *node,
>>                           Error **errp);
>> +void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>> +                           Error **errp);
>>   void numa_complete_configuration(MachineState *ms);
>>   void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
>>   extern QemuOptsList qemu_numa_opts;
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index b6019335e8..088be81920 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -428,10 +428,12 @@
>>   #
>>   # @hmat-lb: memory latency and bandwidth information (Since: 4.2)
>>   #
>> +# @hmat-cache: memory side cache information (Since: 4.2)
>> +#
>>   # Since: 2.1
>>   ##
>>   { 'enum': 'NumaOptionsType',
>> -  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
>> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
>>   
>>   ##
>>   # @NumaOptions:
>> @@ -447,7 +449,8 @@
>>       'node': 'NumaNodeOptions',
>>       'dist': 'NumaDistOptions',
>>       'cpu': 'NumaCpuOptions',
>> -    'hmat-lb': 'NumaHmatLBOptions' }}
>> +    'hmat-lb': 'NumaHmatLBOptions',
>> +    'hmat-cache': 'NumaHmatCacheOptions' }}
>>   
>>   ##
>>   # @NumaNodeOptions:
>> @@ -648,6 +651,80 @@
>>       '*latency': 'time',
>>       '*bandwidth': 'size' }}
>>   
>> +##
>> +# @HmatCacheAssociativity:
>> +#
>> +# Cache associativity in the Memory Side Cache
>> +# Information Structure of HMAT
>> +#
>> +# For more information of @HmatCacheAssociativity see
>> +# the chapter 5.2.27.5: Table 5-143 of ACPI 6.3 spec.
>> +#
>> +# @none: None
>> +#
>> +# @direct: Direct Mapped
>> +#
>> +# @complex: Complex Cache Indexing (implementation specific)
>> +#
>> +# Since: 4.2
>> +##
>> +{ 'enum': 'HmatCacheAssociativity',
>> +  'data': [ 'none', 'direct', 'complex' ] }
>> +
>> +##
>> +# @HmatCacheWritePolicy:
>> +#
>> +# Cache write policy in the Memory Side Cache
>> +# Information Structure of HMAT
>> +#
>> +# For more information of @HmatCacheWritePolicy see
>> +# the chapter 5.2.27.5: Table 5-143: Field "Cache Attributes" of ACPI 6.3 spec.
>> +#
>> +# @none: None
>> +#
>> +# @write-back: Write Back (WB)
>> +#
>> +# @write-through: Write Through (WT)
>> +#
>> +# Since: 4.2
>> +##
>> +{ 'enum': 'HmatCacheWritePolicy',
>> +  'data': [ 'none', 'write-back', 'write-through' ] }
>> +
>> +##
>> +# @NumaHmatCacheOptions:
>> +#
>> +# Set the memory side cache information for a given memory domain.
>> +#
>> +# For more information of @NumaHmatCacheOptions see
>> +# the chapter 5.2.27.5: Table 5-143: Field "Cache Attributes" of ACPI 6.3 spec.
>> +#
>> +# @node-id: the memory proximity domain to which the memory belongs.
>> +#
>> +# @size: the size of memory side cache in bytes.
>> +#
>> +# @total: the total cache levels for this memory proximity domain.
> 
> Can we calculate this without making user to do it?
> 

Yes we can. For example, if user input level 1 2 3, total is 3.

>> +# @level: the cache level described in this structure.
>> +#
>> +# @assoc: the cache associativity, none/direct-mapped/complex(complex cache indexing).
>> +#
>> +# @policy: the write policy, none/write-back/write-through.
>> +#
>> +# @line: the cache Line size in bytes.
>> +#
>> +# Since: 4.2
>> +##
>> +{ 'struct': 'NumaHmatCacheOptions',
>> +  'data': {
>> +   'node-id': 'uint32',
>> +   'size': 'size',
>> +   'total': 'uint8',
>> +   'level': 'uint8',
>> +   'assoc': 'HmatCacheAssociativity',
>> +   'policy': 'HmatCacheWritePolicy',
>> +   'line': 'uint16' }}
>> +
>>   ##
>>   # @HostMemPolicy:
>>   #
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 129da0cdc3..7cf214a653 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -169,7 +169,8 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>>       "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>>       "-numa dist,src=source,dst=destination,val=distance\n"
>>       "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>> -    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n",
>> +    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n"
>> +    "-numa hmat-cache,node-id=node,size=size,total=total,level=level[,assoc=none|direct|complex][,policy=none|write-back|write-through][,line=size]\n",
>>       QEMU_ARCH_ALL)
>>   STEXI
>>   @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
>> @@ -177,6 +178,7 @@ STEXI
>>   @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
>>   @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
>>   @itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{str},data-type=@var{str}[,latency=@var{lat}][,bandwidth=@var{bw}]
>> +@itemx -numa hmat-cache,node-id=@var{node},size=@var{size},total=@var{total},level=@var{level}[,assoc=@var{str}][,policy=@var{str}][,line=@var{size}]
>>   @findex -numa
>>   Define a NUMA node and assign RAM and VCPUs to it.
>>   Set the NUMA distance from a source node to a destination node.
>> @@ -282,11 +284,19 @@ if NUM is 0, means the corresponding latency or bandwidth information is not pro
>>   And if input numbers without any unit, the latency unit will be 'ps' and the bandwidth
>>   will be MB/s.
>>   
>> +In @samp{hmat-cache} option, @var{node-id} is the NUMA-id of the memory belongs.
>> +@var{size} is the size of memory side cache in bytes. @var{total} is the total cache levels.
>> +@var{level} is the cache level described in this structure. @var{assoc} is the cache associativity,
>> +the possible value is 'none/direct(direct-mapped)/complex(complex cache indexing)'.
>> +@var{policy} is the write policy. @var{line} is the cache Line size in bytes.
>> +
>>   For example, the following option assigns NUMA node 0 and 1. Node 0 has 2 cpus and
>>   a ram, node 1 has only a ram. The processors in node 0 access memory in node
>>   0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
>>   The processors in NUMA node 0 access memory in NUMA node 1 with access-latency 10
>>   nanoseconds, access-bandwidth is 100 MB/s.
>> +And for memory side cache information, NUMA node 0 and 1 both have 1 level memory
>> +cache, size is 0x20000 bytes, policy is write-back, the cache Line size is 8 bytes:
> hex is not particularly user readable format, use decimal here and size suffixes
> here and in the example below.
> 
>>   @example
>>   -machine hmat=on \
>>   -m 2G \
>> @@ -300,7 +310,9 @@ nanoseconds, access-bandwidth is 100 MB/s.
>>   -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5ns \
>>   -numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>>   -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10ns \
>> --numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M
>> +-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M \
>> +-numa hmat-cache,node-id=0,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8 \
>> +-numa hmat-cache,node-id=1,size=0x20000,total=1,level=1,assoc=direct,policy=write-back,line=8
>>   @end example
>>   
>>   ETEXI
> 


