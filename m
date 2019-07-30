Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D13C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC4A206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC4A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGPY-0003lv-4r
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 20:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hsGOd-0003LZ-FY
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hsGOc-0001sl-A2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:53:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:30716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hsGOc-0001qK-22
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:53:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jul 2019 17:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,324,1559545200"; d="scan'208";a="371327254"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.148])
 ([10.239.196.148])
 by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2019 17:53:36 -0700
To: Igor Mammedov <imammedo@redhat.com>
References: <20190729063127.2801-1-tao3.xu@intel.com>
 <20190729063127.2801-3-tao3.xu@intel.com>
 <20190729150957.157a7c03@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <04ce7f87-815c-924b-e1df-6a4028750926@intel.com>
Date: Tue, 30 Jul 2019 08:53:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729150957.157a7c03@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v8 02/11] numa: move numa global variable
 nb_numa_nodes into MachineState
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
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/2019 9:09 PM, Igor Mammedov wrote:
> On Mon, 29 Jul 2019 14:31:18 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> Add struct NumaState in MachineState and move existing numa global
>> nb_numa_nodes(renamed as "num_nodes") into NumaState. And add variable
>> numa_support into MachineClass to decide which submachines support NUMA.
>>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v8:
>>      - Add check if numa->numa_state is NULL in pxb_dev_realize_common
>>      - Use nb_nodes in spapr_populate_memory() (Igor)
>> ---
> [...]
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 821f0d4a49..1c7c12c415 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -331,7 +331,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
>>               return ret;
>>           }
>>   
>> -        if (nb_numa_nodes > 1) {
>> +        if (ms->numa_state->num_nodes > 1) {
>>               ret = spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
>>               if (ret < 0) {
>>                   return ret;
>> @@ -351,9 +351,9 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
>>   
>>   static hwaddr spapr_node0_size(MachineState *machine)
>>   {
>> -    if (nb_numa_nodes) {
>> +    if (machine->numa_state->num_nodes) {
>>           int i;
>> -        for (i = 0; i < nb_numa_nodes; ++i) {
>> +        for (i = 0; i < machine->numa_state->num_nodes; ++i) {
>>               if (numa_info[i].node_mem) {
>>                   return MIN(pow2floor(numa_info[i].node_mem),
>>                              machine->ram_size);
>> @@ -398,13 +398,14 @@ static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
>>   {
>>       MachineState *machine = MACHINE(spapr);
>>       hwaddr mem_start, node_size;
>> -    int i, nb_nodes = nb_numa_nodes;
>> +    int i, nb_nodes = machine->numa_state->num_nodes;
>>       NodeInfo *nodes = numa_info;
>>       NodeInfo ramnode;
>>   
>>       /* No NUMA nodes, assume there is just one node with whole RAM */
>> -    if (!nb_numa_nodes) {
>> +    if (!nb_nodes) {
>>           nb_nodes = 1;
>> +        machine->numa_state->num_nodes = nb_nodes;
> You've not addressed a v7 comment
> On Tue, 23 Jul 2019 16:56:41 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> I don't like user fixing up generic machine data that came from CLI
>> (or luck of such)
> [...]
>> I'd keep fixup local (i.e. using nb_nodes)
> 
> i.e. do not modify machine->numa_state->num_nodes and just use value local
> like current code does.

But modify machine->numa_state->num_nodes can fix the issue:
spapr_populate_memory() creates a implicit node and info
temporarily but then spapr_validate_node_memory() will use
global nb_numa_nodes which is 0 and skip check.

Or if I should modify the check part, i.e.
static void spapr_validate_node_memory(MachineState *machine, Error **errp)
{
[...]
     for (i = 0; machine->numa_state->nodes[i] == NULL; i++) {
         if (machine->numa_state->nodes[i].node_mem % 
SPAPR_MEMORY_BLOCK_SIZE) {
             error_setg(errp,
                        "Node %d memory size 0x%" PRIx64
                        " is not aligned to %" PRIu64 " MiB",
                        i, machine->numa_state->nodes[i].node_mem,
                        SPAPR_MEMORY_BLOCK_SIZE / MiB);)

> 
>>           ramnode.node_mem = machine->ram_size;
>>           nodes = &ramnode;
>>       }
> [...]
> 


