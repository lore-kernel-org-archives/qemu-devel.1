Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F5FC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF3E20644
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF3E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrzd1-0001n0-NY
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 02:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hrzcb-0001LO-Px
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hrzca-0003pP-F2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:59:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:4797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hrzca-0003MX-4R
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:59:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jul 2019 23:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,321,1559545200"; d="scan'208";a="162088033"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.148])
 ([10.239.196.148])
 by orsmga007.jf.intel.com with ESMTP; 28 Jul 2019 23:58:54 -0700
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20190716145121.19578-1-tao3.xu@intel.com>
 <20190716145121.19578-3-tao3.xu@intel.com>
 <20190723165641.55930926@redhat.com> <20190723152357.GI11469@habkost.net>
 <20190724162721.736f7efe@Igors-MacBook-Pro>
 <20190724150241.GM11469@habkost.net>
 <20190724174811.545b4598@Igors-MacBook-Pro>
 <20190724181528.GA8322@habkost.net> <20190726154343.610584f2@redhat.com>
 <20190726141742.GE17432@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <753129e1-3f92-29e5-2d76-32714ce228c5@intel.com>
Date: Mon, 29 Jul 2019 14:58:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726141742.GE17432@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH v7 02/11] numa: move numa global variable
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
Cc: jingqi.liu@intel.com, dan.j.williams@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/2019 10:17 PM, Eduardo Habkost wrote:
> On Fri, Jul 26, 2019 at 03:43:43PM +0200, Igor Mammedov wrote:
>> On Wed, 24 Jul 2019 15:15:28 -0300
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>>> On Wed, Jul 24, 2019 at 05:48:11PM +0200, Igor Mammedov wrote:
>>>> On Wed, 24 Jul 2019 12:02:41 -0300
>>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>    
>>>>> On Wed, Jul 24, 2019 at 04:27:21PM +0200, Igor Mammedov wrote:
>>>>>> On Tue, 23 Jul 2019 12:23:57 -0300
>>>>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>>>    
>>>>>>> On Tue, Jul 23, 2019 at 04:56:41PM +0200, Igor Mammedov wrote:
>>>>>>>> On Tue, 16 Jul 2019 22:51:12 +0800
>>>>>>>> Tao Xu <tao3.xu@intel.com> wrote:
>>>>>>>>    
>>>>>>>>> Add struct NumaState in MachineState and move existing numa global
>>>>>>>>> nb_numa_nodes(renamed as "num_nodes") into NumaState. And add variable
>>>>>>>>> numa_support into MachineClass to decide which submachines support NUMA.
>>>>>>>>>
>>>>>>>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>>>>>>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>>>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> No changes in v7.
>>>>>>>>>
>>>>>>>>> Changes in v6:
>>>>>>>>>      - Rebase to upstream, move globals in arm/sbsa-ref and use
>>>>>>>>>        numa_mem_supported
>>>>>>>>>      - When used once or twice in the function, use
>>>>>>>>>        ms->numa_state->num_nodes directly
>>>>>>>>>      - Correct some mistakes
>>>>>>>>>      - Use once monitor_printf in hmp_info_numa
>>>>>>>>> ---
>>>>>>> [...]
>>>>>>>>>       if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
>>>>>>>>> -        pxb->numa_node >= nb_numa_nodes) {
>>>>>>>>> +        pxb->numa_node >= ms->numa_state->num_nodes) {
>>>>>>>> this will crash if user tries to use device on machine that doesn't support numa
>>>>>>>> check that numa_state is not NULL before dereferencing
>>>>>>>
>>>>>>> That's exactly why the machine_num_numa_nodes() was created in
>>>>>>> v5, but then you asked for its removal.
>>>>>> V4 to more precise.
>>>>>> I dislike small wrappers because they usually doesn't simplify code and make it more obscure,
>>>>>> forcing to jump around to see what's really going on.
>>>>>> Like it's implemented in this patch it's obvious what's wrong right away.
>>>>>>
>>>>>> In that particular case machine_num_numa_nodes() was also misused since only a handful
>>>>>> of places (6) really need NULL check while majority (48) can directly access ms->numa_state->num_nodes.
>>>>>> without NULL check.
>>>>>
>>>>> I strongly disagree, here.  Avoiding a ms->numa_state==NULL check
>>>>> is pointless optimization,
>>>> I see it not as optimization (compiler probably would manage to optimize out most of them)
>>>> but as rather properly self documented code. Doing check in places where it's
>>>> not needed is confusing at best and can mask/introduce later subtle bugs at worst.
>>>>    
>>>>> and leads to hard to spot bugs like
>>>>> the one you saw above.
>>>> That one was actually easy to spot because of the way it's written in this patch.
>>>
>>> When somebody is looking at a line of code containing
>>> "ms->numa_state->num_nodes", how exactly are they supposed to
>>> know if ms->numa_state is already guaranteed to be non-NULL, or
>>> not?
>> read the code/patch
>> (at least I don't review just by looking at one line. And less time
>> I have to spend, on reading extra code and finding answers why it's
>> written the way it's, the better)
>>
>> In this patch code touching ms->numa_state, is divided in 2 categories
>> generic code (memory API, CLI entry point, generic machine call
>> site for numa specific code, devices, monitor/qmp) and numa aware code
>> (huma parser and numa aware machines). The later one is majority of
>> affected code where  ms->numa_state != NULL.
>>
>> Even after I forget how this works and read code later, it would be
>> easy to do educated guess/check where NULL check is not need seeing
>> related code.
> 
> It's even easier to not have to check if/when numa_state can be
> NULL because the code is safe on either case.
> 
> You don't review code by looking at a single line, but you don't
> need to make it harder than it is.
> 
> 
>> With machine_num_numa_nodes() would have to look for answer why we
>> are doing it (unless we add a comment that check is there for noreason
>> in most cases and it's exercise for reader to find out where
>> it it's really need).
> 
> Sorry, your justification doesn't make sense to me.  You don't
> need to look for any answer at all, if the code makes it not
> matter if numa_state is NULL.  Having a single caller with
> numa_state==NULL would be enough justification for the check.
> 
>>
>> I don't see any justification for wrapper this case,
>> could we stop bikeshedding and just let author to move on with fixing bugs, pls?
> 
> The author can move on and decide what to do, as I won't block a
> patch only because of presence or absence of the wrapper.
> 

Thank you Eduardo and Igor, I have submit v8 to fix the bugs. Both way 
is Okay for me. And if there are bugs later, I will fix it ASAP.

