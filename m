Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D2C32750
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D3620843
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D3620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxjVU-0001ib-5m
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 22:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1hxjUb-0001FW-Cd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hxjUZ-0005BH-93
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:58:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:20966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hxjUZ-0005AF-0f
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:58:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Aug 2019 19:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,383,1559545200"; d="scan'208";a="167248569"
Received: from unknown (HELO [10.239.196.241]) ([10.239.196.241])
 by orsmga007.jf.intel.com with ESMTP; 13 Aug 2019 19:58:21 -0700
To: Eric Blake <eblake@redhat.com>, daniel@linux.ibm.com
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-10-tao3.xu@intel.com>
 <be305a8a-f1f4-7084-4bb7-4174d530483d@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <431d92ec-0033-bf9c-a47e-507af160c75b@intel.com>
Date: Wed, 14 Aug 2019 10:58:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <be305a8a-f1f4-7084-4bb7-4174d530483d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v9 09/11] numa: Extend the CLI to provide
 memory latency and bandwidth information
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 jonathan.cameron@huawei.com, imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/2019 11:11 PM, Eric Blake wrote:
> On 8/9/19 1:57 AM, Tao wrote:
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> Add -numa hmat-lb option to provide System Locality Latency and
>> Bandwidth Information. These memory attributes help to build
>> System Locality Latency and Bandwidth Information Structure(s)
>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v9:
>>      - change the CLI input way, make it more user firendly (Daniel Black)
>>      use latency=NUM[p|n|u]s and bandwidth=NUM[M|G|P](B/s) as input and drop
>>      the base-lat and base-bw input.
> 
> Why are you hand-rolling yet another scaling parser instead of reusing
> one that's already in-tree?

Because there are no time scaling parser and QMP 'size' type will use kb 
as default. It is a tricky issue because the entry in HMAT is small(max 
0xffff) and we need to store the unit in HMAT.

But as you mentioned blew, 'str' is not a good choice for QMP.
Therefore, what about this solution:

For bandwidth, reuse the qemu_strtosz_MiB() (because the smllest unit is 
MB/s). For latency, write a time scaling parser named as 
"qemu_strtotime_ps()" and "qemu_strtotime_ns()" in util/cutils.c. And 
then use it to pre-convert them into the single scale (QMP interface can 
use).

At last, in HMAT, we auto store the data, separate it into the same base 
unit and entry, and show error if overflow. Then the HMAT can support as 
large as possible.

I am wondering if this solution is OK.
> 
>> +++ b/hw/core/numa.c
> 
>> +void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
>> +                        Error **errp)
>> +{
> 
>> +    if (node->has_latency) {
>> +        hmat_lb = ms->numa_state->hmat_lb[node->hierarchy][node->data_type];
>> +
>> +        if (!hmat_lb) {
>> +            hmat_lb = g_malloc0(sizeof(*hmat_lb));
>> +            ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
>> +        } else if (hmat_lb->latency[node->initiator][node->target]) {
>> +            error_setg(errp, "Duplicate configuration of the latency for "
>> +                       "initiator=%" PRIu16 " and target=%" PRIu16 ".",
>> +                       node->initiator, node->target);
>> +            return;
>> +        }
>> +
>> +        ret = qemu_strtoui(node->latency, &endptr, 10, &latency);
>> +        if (ret < 0) {
>> +            error_setg(errp, "Invalid latency %s", node->latency);
>> +            return;
>> +        }
>> +
>> +        if (*endptr == '\0') {
>> +            base_lat = 1;
>> +        } else if (*(endptr + 1) == 's') {
>> +            switch (*endptr) {
>> +            case 'p':
>> +                base_lat = 1;
>> +                break;
>> +            case 'n':
>> +                base_lat = PICO_PER_NSEC;
>> +                break;
>> +            case 'u':
>> +                base_lat = PICO_PER_USEC;
>> +                break;
> 
> Hmm - this is a different scaling than any of our existing parsers
> (which assume multiples k/M/G..., not subdivisions u/n/s)
> 
> 
>> +    if (node->has_bandwidth) {
>> +        hmat_lb = ms->numa_state->hmat_lb[node->hierarchy][node->data_type];
>> +
>> +        if (!hmat_lb) {
>> +            hmat_lb = g_malloc0(sizeof(*hmat_lb));
>> +            ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
>> +        } else if (hmat_lb->bandwidth[node->initiator][node->target]) {
>> +            error_setg(errp, "Duplicate configuration of the bandwidth for "
>> +                       "initiator=%" PRIu16 " and target=%" PRIu16 ".",
>> +                       node->initiator, node->target);
>> +            return;
>> +        }
>> +
>> +        ret = qemu_strtoui(node->bandwidth, &endptr, 10, &bandwidth);
>> +        if (ret < 0) {
>> +            error_setg(errp, "Invalid bandwidth %s", node->bandwidth);
>> +            return;
>> +        }
>> +
>> +        switch (toupper(*endptr)) {
>> +        case '\0':
>> +        case 'M':
>> +            base_bw = 1;
>> +            break;
>> +        case 'G':
>> +            base_bw = UINT64_C(1) << 10;
>> +            break;
>> +        case 'P':
>> +            base_bw = UINT64_C(1) << 20;
>> +            break;
> 
> But this one, in addition to being wrong (P is 1<<30, not 1<<20), should
> definitely be reusing qemu_strtosz_metric() or similar (look in
> util/cutils.c).
> 
> 
>> +++ b/qapi/machine.json
>> @@ -377,10 +377,12 @@
>>   #
>>   # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>>   #
>> +# @hmat-lb: memory latency and bandwidth information (Since: 4.2)
>> +#
>>   # Since: 2.1
>>   ##
>>   { 'enum': 'NumaOptionsType',
>> -  'data': [ 'node', 'dist', 'cpu' ] }
>> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
>>   
> 
>> +##
>> +# @HmatLBDataType:
>> +#
>> +# Data type in the System Locality Latency
>> +# and Bandwidth Information Structure of HMAT (Heterogeneous
>> +# Memory Attribute Table)
>> +#
>> +# For more information of @HmatLBDataType see
>> +# the chapter 5.2.27.4: Table 5-142:  Field "Data Type" of ACPI 6.3 spec.
>> +#
>> +# @access-latency: access latency (picoseconds)
>> +#
>> +# @read-latency: read latency (picoseconds)
>> +#
>> +# @write-latency: write latency (picoseconds)
>> +#
>> +# @access-bandwidth: access bandwidth (MB/s)
>> +#
>> +# @read-bandwidth: read bandwidth (MB/s)
>> +#
>> +# @write-bandwidth: write bandwidth (MB/s)
> 
> Are these really the best scales?
> 
> 
>> +
>> +##
>> +# @NumaHmatLBOptions:
>> +#
>> +# Set the system locality latency and bandwidth information
>> +# between Initiator and Target proximity Domains.
>> +#
>> +# For more information of @NumaHmatLBOptions see
>> +# the chapter 5.2.27.4: Table 5-142 of ACPI 6.3 spec.
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
>> +# @latency: the value of latency from @initiator to @target proximity domain,
>> +#           the latency units are "ps(picosecond)", "ns(nanosecond)" or
>> +#           "us(microsecond)".
>> +#
>> +# @bandwidth: the value of bandwidth between @initiator and @target proximity
>> +#             domain, the bandwidth units are "MB(/s)","GB(/s)" or "PB(/s)".
>> +#
>> +# Since: 4.2
>> +##
>> +{ 'struct': 'NumaHmatLBOptions',
>> +    'data': {
>> +    'initiator': 'uint16',
>> +    'target': 'uint16',
>> +    'hierarchy': 'HmatLBMemoryHierarchy',
>> +    'data-type': 'HmatLBDataType',
>> +    '*latency': 'str',
>> +    '*bandwidth': 'str' }}
> 
> ...and then parsing strings instead of taking raw integers?  Parsing
> strings is okay for HMP, but for QMP, our goal should be a single
> representation with no additional sugar on top.  Latency and bandwidth
> should be int in a single scale.
> 
> 
>> +++ b/qemu-options.hx
>> @@ -164,16 +164,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>>       "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>>       "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
>>       "-numa dist,src=source,dst=destination,val=distance\n"
>> -    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
>> +    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
>> +    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n",
> 
> Command-line parsing can then take human-written scaled numbers, and
> pre-convert them into the single scale accepted by the QMP interface.
> 


