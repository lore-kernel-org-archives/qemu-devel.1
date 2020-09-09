Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC2EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9FB20758
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9FB20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2dx-0000iB-SB
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kG2a7-00072n-Nt
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:04:23 -0400
Received: from foss.arm.com ([217.140.110.172]:37396)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kG2a4-0004Fr-Pi
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:04:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27522101E;
 Wed,  9 Sep 2020 09:04:19 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC103F66E;
 Wed,  9 Sep 2020 09:04:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Andrew Jones <drjones@redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <857566df-1b98-84f7-9268-d092722dc749@arm.com>
Date: Wed, 9 Sep 2020 17:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 12:04:19
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, Juan Quintela <quintela@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/2020 16:25, Andrew Jones wrote:
> On Fri, Sep 04, 2020 at 05:00:16PM +0100, Steven Price wrote:
>> Arm's Memory Tagging Extension (MTE) adds 4 bits of tag data to every 16
>> bytes of memory in the system. This along with stashing a tag within the
>> high bit of virtual addresses allows runtime checking of memory
>> accesses.
>>
>> These patches add support to KVM to enable MTE within a guest. They are
>> based on Catalin's v9 MTE user-space support series[1].
>>
>> I'd welcome feedback on the proposed user-kernel ABI. Specifically this
>> series currently:
>>
>     0. Feature probing
> 
> Probably a KVM cap, rather than requiring userspace to attempt VCPU
> features one at a time with a scratch VCPU.

Ah, good point - thanks for pointing that out.

>>   1. Requires the VMM to enable MTE per-VCPU.
> 
> I suppose. We're collecting many features that are enabling CPU features,
> so they map nicely to VCPU features, yet they're effectively VM features
> due to a shared resource such as an irq or memory.

Yeah this is a little weird I'll admit. The architectural feature is 
described per-CPU (well "processing element"), but it makes little sense 
to have it only on some CPUs and has effects on the rest of the memory 
system. Given that it's theoretically possible to build e.g. a 
big.LITTLE setup with only some CPUs support MTE it seemed more 
future-proof to design the API to allow it even though I hope no-one 
will use it.

>>   2. Automatically promotes (normal host) memory given to the guest to be
>>      tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
>>      tags are cleared if the memory wasn't previously MTE enabled.
> 
> Shouldn't this be up to the guest? Or, is this required in order for the
> guest to use tagging at all. Something like making the guest IPAs memtag
> capable, but if the guest doesn't enable tagging then there is no guest
> impact? In any case, shouldn't userspace be the one that adds PROT_MTE
> to the memory regions it wants the guest to be able to use tagging with,
> rather than KVM adding the attribute page by page?

I think I've probably explained this badly.

The guest can choose how to populate the stage 1 mapping - so can choose 
which parts of memory are accessed tagged or not. However, the 
hypervisor cannot restrict this in stage 2 (except by e.g. making the 
memory uncached but that's obviously not great - however devices forward 
to the guest can be handled like this).

Because the hypervisor cannot restrict the guest's access to the tags, 
the hypervisor must assume that all memory given to the guest could have 
the tags accessed. So it must (a) clear any stale data from the tags, 
and (b) ensure that the tags are preserved (e.g. when swapping pages out).

Because of the above the current series automatically sets PG_mte_tagged 
on the pages. Note that this doesn't change the mappings that the VMM 
has (a non-PROT_MTE mapping will still not have access to the tags).

It's a shame that the stage-2 can't usefully restrict tag access, but 
this matches the architectural expectation: that if MTE is supported 
then all standard memory will be MTE-enabled.

>>   3. Doesn't provide any new methods for the VMM to access the tags on
>>      memory.
>>
>> (2) and (3) are particularly interesting from the aspect of VM migration.
>> The guest is able to store/retrieve data in the tags (presumably for the
>> purpose of tag checking, but architecturally it could be used as just
>> storage). This means that when migrating a guest the data needs to be
>> transferred (or saved/restored).
>>
>> MTE tags are controlled by the same permission model as normal pages
>> (i.e. a read-only page has read-only tags), so the normal methods of
>> detecting guest changes to pages can be used. But this would also
>> require the tags within a page to be migrated at the same time as the
>> data (since the access control for tags is the same as the normal data
>> within a page).
>>
>> (3) may be problematic and I'd welcome input from those familiar with
>> VMMs. User space cannot access tags unless the memory is mapped with the
>> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
>> for the user space process (assuming the VMM enables tag checking for
>> the process) and since the tags in memory are controlled by the guest
>> it's unlikely the VMM would have an appropriately tagged pointer for its
>> access. This means the VMM would either need to maintain two mappings of
>> memory (one to access tags, the other to access data) or disable tag
>> checking during the accesses to data.
> 
> If userspace needs to write to guest memory then it should be due to
> a device DMA or other specific hardware emulation. Those accesses can
> be done with tag checking disabled.

Yes, the question is can the VMM (sensibly) wrap the accesses with a 
disable/renable tag checking for the process sequence. The alternative 
at the moment is to maintain a separate (untagged) mapping for the 
purpose which might present it's own problems.

>>
>> If it's not practical to either disable tag checking in the VMM or
>> maintain multiple mappings then the alternatives I'm aware of are:
>>
>>   * Provide a KVM-specific method to extract the tags from guest memory.
>>     This might also have benefits in terms of providing an easy way to
>>     read bulk tag data from guest memory (since the LDGM instruction
>>     isn't available at EL0).
> 
> Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> the tags for all addresses of each dirty page.

Certainly possible, although it seems to conflate two operations: "get 
list of dirty pages", "get tags from page". It would also require a lot 
of return space (size of slot/32).

>>   * Provide support for user space setting the TCMA0 or TCMA1 bits in
>>     TCR_EL1. These would allow the VMM to generate pointers which are not
>>     tag checked.
> 
> So this is necessary to allow the VMM to keep tag checking enabled for
> itself, plus map guest memory as PROT_MTE, and write to that memory when
> needed?

This is certainly one option. The architecture provides two "magic" 
values (all-0s and all-1s) which can be configured using TCMAx to be 
treated differently. The VMM could therefore construct pointers to 
otherwise tagged memory which would be treated as untagged.

However, Catalin's user space series doesn't at the moment expose this 
functionality.

Steve

