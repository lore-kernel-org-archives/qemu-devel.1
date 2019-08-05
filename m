Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D988C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529192070D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529192070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huTol-0000ow-HX
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 23:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1huToL-0000Jr-GV
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1huToK-0007Wk-Fz
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:37:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:48295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>)
 id 1huToI-0007Qf-2c; Sun, 04 Aug 2019 23:37:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Aug 2019 20:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,348,1559545200"; d="scan'208";a="176191455"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.216])
 ([10.239.196.216])
 by orsmga003.jf.intel.com with ESMTP; 04 Aug 2019 20:37:15 -0700
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190801075258.19070-1-tao3.xu@intel.com>
 <20190802065538.GA2031@umbus.fritz.box>
 <27846884-9bf4-7729-7a9e-0392280ee67f@intel.com>
 <20190805025844.GA29381@umbus.fritz.box>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <6d051cbd-fa46-08ec-697e-56b42f1f5fa2@intel.com>
Date: Mon, 5 Aug 2019 11:37:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805025844.GA29381@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [RFC PATCH] numa: add auto_enable_numa to fix
 broken check in spapr
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
Cc: imammedo@redhat.com, qemu-ppc@nongnu.org, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/2019 10:58 AM, David Gibson wrote:
> On Mon, Aug 05, 2019 at 08:56:40AM +0800, Tao Xu wrote:
>> On 8/2/2019 2:55 PM, David Gibson wrote:
>>> On Thu, Aug 01, 2019 at 03:52:58PM +0800, Tao Xu wrote:
>>>> Introduce MachineClass::auto_enable_numa for one implicit NUMA node,
>>>> and enable it to fix broken check in spapr_validate_node_memory(), when
>>>> spapr_populate_memory() creates a implicit node and info then use
>>>> nb_numa_nodes which is 0.
>>>>
>>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>
>>> The change here looks fine so,
>>>
>>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>>
>>> However, I'm not following what check in spapr is broken and why.
>>>
>> Sorry, may be I should update the commit message.
>>
>> Because in spapr_populate_memory(), if numa node is 0
>>
>>      if (!nb_nodes) {
>>          nb_nodes = 1;
>>          ramnode.node_mem = machine->ram_size;
>>          nodes = &ramnode;
>>      }
>>
>> it use a local 'nb_nodes' as 1 and update global nodes info, but
>> inpapr_validate_node_memory(), use the global nb_numa_nodes
>>
>>      for (i = 0; i < nb_numa_nodes; i++) {
>>      	if (numa_info[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
>>
>> so the global is 0 and skip the node_mem check.
> 
> Well, not really.  That loop is that each node has memory size a
> multiple of 256MiB.  But we've already checked that the whole memory
> size is a multiple of 256MiB, so in the case of one NUMA node, the
> per-node check doesn't actually do anything extra.
> 
> And in the "non-NUMA" case, nb_numa_nodes == 0, then I don't believe
> numa_info[] is populated anyway, so we couldn't do the check like
> this.
> 
Thank you David. I understand. I will modify the commit message. So can 
I modify and keep this patch as a feature? Because it can reuse the 
generic numa code.


