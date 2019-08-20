Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079ECC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2A82339E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2A82339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzzcE-0000E8-SF
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 04:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1hzzbZ-00089B-LJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hzzbX-0001f8-IA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:35:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:56735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hzzbX-0001UI-7D
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:34:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Aug 2019 01:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; d="scan'208";a="378484663"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.137])
 ([10.239.196.137])
 by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2019 01:34:44 -0700
To: Igor Mammedov <imammedo@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-6-tao3.xu@intel.com>
 <20190813170027.0617b129@redhat.com>
 <CAPcyv4j=wBtBcscJBtrMNDDz=d6+HYYDF=4QLU69d0EPMkTTqg@mail.gmail.com>
 <a73f7c81-0363-c10f-8ae1-9344abc55449@intel.com>
 <CAPcyv4jCuy6zvM8NcacXhvpUBUyp_BYMcEtBuA_ck3AhkyGNsQ@mail.gmail.com>
 <789df028-9dd9-884a-2493-aecc9a646e63@intel.com>
 <CAPcyv4h-WmFPSsPMfPz5AALm=MyxGzyU5Ju0iSKsxORVh1wV7Q@mail.gmail.com>
 <20190816165758.47042712@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <b0a958d6-2e2c-ab4b-36b7-b1fc13e0c2e3@intel.com>
Date: Tue, 20 Aug 2019 16:34:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816165758.47042712@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH v9 05/11] numa: Extend CLI to provide
 initiator information for numa nodes
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 "Du, Fan" <fan.du@intel.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "daniel@linux.ibm.com" <daniel@linux.ibm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/2019 10:57 PM, Igor Mammedov wrote:
> On Wed, 14 Aug 2019 19:31:27 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> On Wed, Aug 14, 2019 at 6:57 PM Tao Xu <tao3.xu@intel.com> wrote:
>>>
>>> On 8/15/2019 5:29 AM, Dan Williams wrote:
>>>> On Tue, Aug 13, 2019 at 10:14 PM Tao Xu <tao3.xu@intel.com> wrote:
>>>>>
>>>>> On 8/14/2019 10:39 AM, Dan Williams wrote:
>>>>>> On Tue, Aug 13, 2019 at 8:00 AM Igor Mammedov <imammedo@redhat.com> wrote:
>>>>>>>
>>>>>>> On Fri,  9 Aug 2019 14:57:25 +0800
>>>>>>> Tao <tao3.xu@intel.com> wrote:
>>>>>>>   
>>>>>>>> From: Tao Xu <tao3.xu@intel.com>
>>>>>>>>   
>>> [...]
>>>>>>>> +    for (i = 0; i < machine->numa_state->num_nodes; i++) {
>>>>>>>> +        if (numa_info[i].initiator_valid &&
>>>>>>>> +            !numa_info[numa_info[i].initiator].has_cpu) {
>>>>>>>                              ^^^^^^^^^^^^^^^^^^^^^^ possible out of bounds read, see bellow
>>>>>>>   
>>>>>>>> +            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
>>>>>>>> +                         " does not exist.", numa_info[i].initiator, i);
>>>>>>>> +            error_printf("\n");
>>>>>>>> +
>>>>>>>> +            exit(1);
>>>>>>>> +        }
>>>>>>> it takes care only about nodes that have cpus or memory-only ones that have
>>>>>>> initiator explicitly provided on CLI. And leaves possibility to have
>>>>>>> memory-only nodes without initiator mixed with nodes that have initiator.
>>>>>>> Is it valid to have mixed configuration?
>>>>>>> Should we forbid it?
>>>>>>
>>>>>> The spec talks about the "Proximity Domain for the Attached Initiator"
>>>>>> field only being valid if the memory controller for the memory can be
>>>>>> identified by an initiator id in the SRAT. So I expect the only way to
>>>>>> define a memory proximity domain without this local initiator is to
>>>>>> allow specifying a node-id that does not have an entry in the SRAT.
>>>>>>   
>>>>> Hi Dan,
>>>>>
>>>>> So there may be a situation for the Attached Initiator field is not
>>>>> valid? If true, I would allow user to input Initiator invalid.
>>>>
>>>> Yes it's something the OS needs to consider because the platform may
>>>> not be able to meet the constraint that a single initiator is
>>>> associated with the memory controller for a given memory target. In
>>>> retrospect it would have been nice if the spec reserved 0xffffffff for
>>>> this purpose, but it seems "not in SRAT" is the only way to identify
>>>> memory that is not attached to any single initiator.
>>>>   
>>> But As far as I konw, QEMU can't emulate a NUMA node "not in SRAT". I am
>>> wondering if it is effective only set Initiator invalid?
>>
>> You don't need to emulate a NUMA node not in SRAT. Just put a number
>> in this HMAT entry larger than the largest proximity domain number
>> found in the SRAT.
>>>   
>>
> 
> So behavior is really not defined in the spec
> (well I wasn't able to convince myself that above behavior is in the spec).
> 
> In this case I'd go with a strict check for now not allowing invalid initiator
> (we can easily relax check and allow it point to nonsense later but no other way around)
> 

So let me summarize the solution, in order to avoid misunderstanding, if 
there are something wrong, pls tell me:

1)
-machine,hmat=yes
-object memory-backend-ram,size=1G,id=m0 \
-object memory-backend-ram,size=1G,id=m1 \
-object memory-backend-ram,size=1G,id=m2 \
-numa node,nodeid=0,memdev=m0 \
-numa node,nodeid=1,memdev=m1,initiator=0 \
-numa node,nodeid=2,memdev=m2,initiator=0 \
-numa cpu,node-id=0,socket-id=0 \
-numa cpu,node-id=0,socket-id=1

then qemu can use HMAT.

2)
if initiator this case:

-numa node,nodeid=0,memdev=m0 \
-numa node,nodeid=1,memdev=m1,initiator=0 \
-numa node,nodeid=2,memdev=m2

then qemu can't boot and show error message.

3)
if initiator this case:

-numa node,nodeid=0,memdev=m0 \
-numa node,nodeid=1,memdev=m1,initiator=0 \
-numa node,nodeid=2,memdev=m2,initiator=1

then qemu can boot and the initiator of nodeid=2 is invalid.

