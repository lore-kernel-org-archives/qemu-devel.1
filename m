Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73689C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DBC21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DBC21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaW1e-0007xk-GN
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 21:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iaVq5-0001eY-9t
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 21:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iaVb3-0003fX-He
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 21:01:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:28574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iaVb1-0003Rx-TK
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 21:01:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Nov 2019 18:01:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,255,1571727600"; d="scan'208";a="199667222"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115])
 ([10.239.197.115])
 by orsmga007.jf.intel.com with ESMTP; 28 Nov 2019 18:01:12 -0800
Subject: Re: [PATCH v19 2/8] numa: Extend CLI to provide memory latency and
 bandwidth information
To: Markus Armbruster <armbru@redhat.com>
References: <20191128082109.30081-1-tao3.xu@intel.com>
 <20191128082109.30081-3-tao3.xu@intel.com>
 <87o8wwnrt7.fsf@dusky.pond.sub.org>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <b1699994-5b65-bf98-f6b1-c2fb56ee8eee@intel.com>
Date: Fri, 29 Nov 2019 10:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87o8wwnrt7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/2019 7:50 PM, Markus Armbruster wrote:
> Tao Xu <tao3.xu@intel.com> writes:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> Add -numa hmat-lb option to provide System Locality Latency and
>> Bandwidth Information. These memory attributes help to build
>> System Locality Latency and Bandwidth Information Structure(s)
>> in ACPI Heterogeneous Memory Attribute Table (HMAT). Before using
>> hmat-lb option, enable HMAT with -machine hmat=on.
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
> [...]
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 27d0e37534..cf9851fcd1 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -426,10 +426,12 @@
>>   #
>>   # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>>   #
>> +# @hmat-lb: memory latency and bandwidth information (Since: 5.0)
>> +#
>>   # Since: 2.1
>>   ##
>>   { 'enum': 'NumaOptionsType',
>> -  'data': [ 'node', 'dist', 'cpu' ] }
>> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
>>   
>>   ##
>>   # @NumaOptions:
>> @@ -444,7 +446,8 @@
>>     'data': {
>>       'node': 'NumaNodeOptions',
>>       'dist': 'NumaDistOptions',
>> -    'cpu': 'NumaCpuOptions' }}
>> +    'cpu': 'NumaCpuOptions',
>> +    'hmat-lb': 'NumaHmatLBOptions' }}
>>   
>>   ##
>>   # @NumaNodeOptions:
>> @@ -557,6 +560,92 @@
>>      'base': 'CpuInstanceProperties',
>>      'data' : {} }
>>   
>> +##
>> +# @HmatLBMemoryHierarchy:
>> +#
>> +# The memory hierarchy in the System Locality Latency and Bandwidth
>> +# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
>> +#
>> +# For more information about @HmatLBMemoryHierarchy see chapter
> 
> @HmatLBMemoryHierarchy, see
> 
>> +# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
>> +#
>> +# @memory: the structure represents the memory performance
>> +#
>> +# @first-level: first level of memory side cache
>> +#
>> +# @second-level: second level of memory side cache
>> +#
>> +# @third-level: third level of memory side cache
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'enum': 'HmatLBMemoryHierarchy',
>> +  'data': [ 'memory', 'first-level', 'second-level', 'third-level' ] }
>> +
>> +##
>> +# @HmatLBDataType:
>> +#
>> +# Data type in the System Locality Latency and Bandwidth
>> +# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
>> +#
>> +# For more information about @HmatLBDataType see chapter
> 
> @HmatLBDataType, see
> 
>> +# 5.2.27.4: Table 5-146:  Field "Data Type" of ACPI 6.3 spec.
>> +#
>> +# @access-latency: access latency (nanoseconds)
>> +#
>> +# @read-latency: read latency (nanoseconds)
>> +#
>> +# @write-latency: write latency (nanoseconds)
>> +#
>> +# @access-bandwidth: access bandwidth (Bytes per second)
>> +#
>> +# @read-bandwidth: read bandwidth (Bytes per second)
>> +#
>> +# @write-bandwidth: write bandwidth (Bytes per second)
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'enum': 'HmatLBDataType',
>> +  'data': [ 'access-latency', 'read-latency', 'write-latency',
>> +            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
>> +
>> +##
>> +# @NumaHmatLBOptions:
>> +#
>> +# Set the system locality latency and bandwidth information
>> +# between Initiator and Target proximity Domains.
>> +#
>> +# For more information about @NumaHmatLBOptions see chapter
> 
> @NumaHmatLBOptions, see
> 
>> +# 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
>> +#
>> +# @initiator: the Initiator Proximity Domain.
>> +#
>> +# @target: the Target Proximity Domain.
>> +#
>> +# @hierarchy: the Memory Hierarchy. Indicates the performance
>> +#             of memory or side cache.
>> +#
>> +# @data-type: presents the type of data, access/read/write
>> +#             latency or hit latency.
>> +#
>> +# @latency: the value of latency from @initiator to @target
>> +#           proximity domain, the latency unit is "ns(nanosecond)".
>> +#
>> +# @bandwidth: the value of bandwidth between @initiator and @target
>> +#             proximity domain, the bandwidth unit is
>> +#             "Bytes per second".
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'struct': 'NumaHmatLBOptions',
>> +    'data': {
>> +    'initiator': 'uint16',
>> +    'target': 'uint16',
>> +    'hierarchy': 'HmatLBMemoryHierarchy',
>> +    'data-type': 'HmatLBDataType',
>> +    '*latency': 'uint64',
>> +    '*bandwidth': 'size' }}
>> +
>>   ##
>>   # @HostMemPolicy:
>>   #
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 63f6b33322..23303fc7d7 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -168,16 +168,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>>       "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>>       "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>>       "-numa dist,src=source,dst=destination,val=distance\n"
>> -    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
>> +    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>> +    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n",
>>       QEMU_ARCH_ALL)
>>   STEXI
>>   @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
>>   @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
>>   @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
>>   @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
>> +@itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{hierarchy},data-type=@var{tpye}[,latency=@var{lat}][,bandwidth=@var{bw}]
>>   @findex -numa
>>   Define a NUMA node and assign RAM and VCPUs to it.
>>   Set the NUMA distance from a source node to a destination node.
>> +Set the ACPI Heterogeneous Memory Attributes for the given nodes.
>>   
>>   Legacy VCPU assignment uses @samp{cpus} option where
>>   @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
>> @@ -256,6 +259,49 @@ specified resources, it just assigns existing resources to NUMA
>>   nodes. This means that one still has to use the @option{-m},
>>   @option{-smp} options to allocate RAM and VCPUs respectively.
>>   
>> +Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Information
>> +between initiator and target NUMA nodes in ACPI Heterogeneous Attribute Memory Table (HMAT).
>> +Initiator NUMA node can create memory requests, usually it has one or more processors.
>> +Target NUMA node contains addressable memory.
>> +
>> +In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{hierarchy} is the memory
>> +hierarchy of the target NUMA node: if @var{hierarchy} is 'memory', the structure
>> +represents the memory performance; if @var{hierarchy} is 'first-level|second-level|third-level',
>> +this structure represents aggregated performance of memory side caches for each domain.
>> +@var{type} of 'data-type' is type of data represented by this structure instance:
>> +if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' latency or 'access|read|write'
>> +bandwidth of the target memory; if 'hierarchy' is 'first-level|second-level|third-level',
>> +'data-type' is 'access|read|write' hit latency or 'access|read|write' hit bandwidth of the
>> +target memory side cache.
>> +
>> +@var{lat} is latency value in nanoseconds. @var{bw} is bandwidth value,
>> +the possible value and units are NUM[M|G|T], mean that the bandwidth value are
>> +NUM byte per second (or MB/s, GB/s or TB/s depending on used suffix).
>> +And if input bandwidth value without any unit, the unit will be byte per second.
> 
> This sentence feels redundant to meOK, I will remove this sentence:

"And if input bandwidth value without any unit, the unit will be byte 
per second."
> 
>> +Note that if latency or bandwidth value is 0, means the corresponding latency or
>> +bandwidth information is not provided.
>> +
>> +For example, the following options describe 2 NUMA nodes. Node 0 has 2 cpus and
>> +a ram, node 1 has only a ram. The processors in node 0 access memory in node
>> +0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
>> +The processors in NUMA node 0 access memory in NUMA node 1 with access-latency 10
>> +nanoseconds, access-bandwidth is 100 MB/s.
>> +@example
>> +-machine hmat=on \
>> +-m 2G \
>> +-object memory-backend-ram,size=1G,id=m0 \
>> +-object memory-backend-ram,size=1G,id=m1 \
>> +-smp 2 \
>> +-numa node,nodeid=0,memdev=m0 \
>> +-numa node,nodeid=1,memdev=m1,initiator=0 \
>> +-numa cpu,node-id=0,socket-id=0 \
>> +-numa cpu,node-id=0,socket-id=1 \
>> +-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5 \
>> +-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
>> +-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10 \
>> +-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M
>> +@end example
>> +
>>   ETEXI
>>   
>>   DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
> 


