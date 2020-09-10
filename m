Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065DEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBC421556
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBC421556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIpY-0000Wn-08
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kGIla-0005P6-Cg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:21:18 -0400
Received: from foss.arm.com ([217.140.110.172]:51344)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kGIlW-0007yc-Jo
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:21:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4410101E;
 Thu, 10 Sep 2020 02:21:11 -0700 (PDT)
Received: from [192.168.1.79] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E12263F68F;
 Thu, 10 Sep 2020 02:21:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Andrew Jones <drjones@redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <857566df-1b98-84f7-9268-d092722dc749@arm.com>
 <20200910062958.o55apuvdxmf3uiqb@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <37663bb6-d3a7-6f53-d0cd-88777633a2b2@arm.com>
Date: Thu, 10 Sep 2020 10:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910062958.o55apuvdxmf3uiqb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 05:21:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, linux-kernel@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 07:29, Andrew Jones wrote:
> On Wed, Sep 09, 2020 at 05:04:15PM +0100, Steven Price wrote:
>> On 09/09/2020 16:25, Andrew Jones wrote:
>>> On Fri, Sep 04, 2020 at 05:00:16PM +0100, Steven Price wrote:
>>>>    2. Automatically promotes (normal host) memory given to the guest to be
>>>>       tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
>>>>       tags are cleared if the memory wasn't previously MTE enabled.
>>>
>>> Shouldn't this be up to the guest? Or, is this required in order for the
>>> guest to use tagging at all. Something like making the guest IPAs memtag
>>> capable, but if the guest doesn't enable tagging then there is no guest
>>> impact? In any case, shouldn't userspace be the one that adds PROT_MTE
>>> to the memory regions it wants the guest to be able to use tagging with,
>>> rather than KVM adding the attribute page by page?
>>
>> I think I've probably explained this badly.
>>
>> The guest can choose how to populate the stage 1 mapping - so can choose
>> which parts of memory are accessed tagged or not. However, the hypervisor
>> cannot restrict this in stage 2 (except by e.g. making the memory uncached
>> but that's obviously not great - however devices forward to the guest can be
>> handled like this).
>>
>> Because the hypervisor cannot restrict the guest's access to the tags, the
>> hypervisor must assume that all memory given to the guest could have the
>> tags accessed. So it must (a) clear any stale data from the tags, and (b)
>> ensure that the tags are preserved (e.g. when swapping pages out).
>>
> 
> Yes, this is how I understood it.

Ok, I've obviously misunderstood your comment instead ;)

>> Because of the above the current series automatically sets PG_mte_tagged on
>> the pages. Note that this doesn't change the mappings that the VMM has (a
>> non-PROT_MTE mapping will still not have access to the tags).
> 
> But if userspace created the memslots with memory already set with
> PROT_MTE, then this wouldn't be necessary, right? And, as long as
> there's still a way to access the memory with tag checking disabled,
> then it shouldn't be a problem.

Yes, so one option would be to attempt to validate that the VMM has 
provided memory pages with the PG_mte_tagged bit set (e.g. by mapping 
with PROT_MTE). The tricky part here is that we support KVM_CAP_SYNC_MMU 
which means that the VMM can change the memory backing at any time - so 
we could end up in user_mem_abort() discovering that a page doesn't have 
PG_mte_tagged set - at that point there's no nice way of handling it 
(other than silently upgrading the page) so the VM is dead.

So since enforcing that PG_mte_tagged is set isn't easy and provides a 
hard-to-debug foot gun to the VMM I decided the better option was to let 
the kernel set the bit automatically.

>>>
>>> If userspace needs to write to guest memory then it should be due to
>>> a device DMA or other specific hardware emulation. Those accesses can
>>> be done with tag checking disabled.
>>
>> Yes, the question is can the VMM (sensibly) wrap the accesses with a
>> disable/renable tag checking for the process sequence. The alternative at
>> the moment is to maintain a separate (untagged) mapping for the purpose
>> which might present it's own problems.
> 
> Hmm, so there's no easy way to disable tag checking when necessary? If we
> don't map the guest ram with PROT_MTE and continue setting the attribute
> in KVM, as this series does, then we don't need to worry about it tag
> checking when accessing the memory, but then we can't access the tags for
> migration.

There's a "TCO" (Tag Check Override) bit in PSTATE which allows 
disabling tag checking, so if it's reasonable to wrap accesses to the 
memory you can simply set the TCO bit, perform the memory access and 
then unset TCO. That would mean a single mapping with MTE enabled would 
work fine. What I don't have a clue about is whether it's practical in 
the VMM to wrap guest accesses like this.

>>
>>>>
>>>> If it's not practical to either disable tag checking in the VMM or
>>>> maintain multiple mappings then the alternatives I'm aware of are:
>>>>
>>>>    * Provide a KVM-specific method to extract the tags from guest memory.
>>>>      This might also have benefits in terms of providing an easy way to
>>>>      read bulk tag data from guest memory (since the LDGM instruction
>>>>      isn't available at EL0).
>>>
>>> Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
>>> the tags for all addresses of each dirty page.
>>
>> Certainly possible, although it seems to conflate two operations: "get list
>> of dirty pages", "get tags from page". It would also require a lot of return
>> space (size of slot/32).
>>
> 
> It would require num-set-bits * host-page-size / 16 / 2, right?

Yes, where the worst case is all bits set which is size/32. Since you 
don't know at the time of the call how many bits are going to be set I'm 
not sure how you would design the API which doesn't require 
preallocating the worst case.

>>>>    * Provide support for user space setting the TCMA0 or TCMA1 bits in
>>>>      TCR_EL1. These would allow the VMM to generate pointers which are not
>>>>      tag checked.
>>>
>>> So this is necessary to allow the VMM to keep tag checking enabled for
>>> itself, plus map guest memory as PROT_MTE, and write to that memory when
>>> needed?
>>
>> This is certainly one option. The architecture provides two "magic" values
>> (all-0s and all-1s) which can be configured using TCMAx to be treated
>> differently. The VMM could therefore construct pointers to otherwise tagged
>> memory which would be treated as untagged.
>>
>> However, Catalin's user space series doesn't at the moment expose this
>> functionality.
>>
> 
> So if I understand correctly this would allow us to map the guest memory
> with PAGE_MTE and still access the memory when needed. If so, then this
> sounds interesting.

Yes - you could derive a pointer which didn't perform tag checking. Note 
that this also requires the rest of user space to play along (i.e. 
understand that the tag value is reserved). I believe for user space we 
have to use the all-0s value which means that a standard pointer 
(top-byte is 0) would be unchecked.

Steve

