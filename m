Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84210C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F8C20708
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F8C20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNQj-0004Kr-Ni
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.price@arm.com>)
 id 1kGNMh-000252-4j
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:15:56 -0400
Received: from foss.arm.com ([217.140.110.172]:58066)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steven.price@arm.com>) id 1kGNMd-0005vt-Ti
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:15:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 747EB113E;
 Thu, 10 Sep 2020 07:15:50 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92E7F3F66E;
 Thu, 10 Sep 2020 07:15:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To: Andrew Jones <drjones@redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <857566df-1b98-84f7-9268-d092722dc749@arm.com>
 <20200910062958.o55apuvdxmf3uiqb@kamzik.brq.redhat.com>
 <37663bb6-d3a7-6f53-d0cd-88777633a2b2@arm.com>
 <20200910135618.cvnlrgvhuy3amv6s@kamzik.brq.redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <17efa848-9bda-26b2-b70f-040c9fa3f2da@arm.com>
Date: Thu, 10 Sep 2020 15:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910135618.cvnlrgvhuy3amv6s@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=217.140.110.172;
 envelope-from=steven.price@arm.com; helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 10:15:50
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 14:56, Andrew Jones wrote:
> On Thu, Sep 10, 2020 at 10:21:04AM +0100, Steven Price wrote:
>> On 10/09/2020 07:29, Andrew Jones wrote:
>>> But if userspace created the memslots with memory already set with
>>> PROT_MTE, then this wouldn't be necessary, right? And, as long as
>>> there's still a way to access the memory with tag checking disabled,
>>> then it shouldn't be a problem.
>>
>> Yes, so one option would be to attempt to validate that the VMM has provided
>> memory pages with the PG_mte_tagged bit set (e.g. by mapping with PROT_MTE).
>> The tricky part here is that we support KVM_CAP_SYNC_MMU which means that
>> the VMM can change the memory backing at any time - so we could end up in
>> user_mem_abort() discovering that a page doesn't have PG_mte_tagged set - at
>> that point there's no nice way of handling it (other than silently upgrading
>> the page) so the VM is dead.
>>
>> So since enforcing that PG_mte_tagged is set isn't easy and provides a
>> hard-to-debug foot gun to the VMM I decided the better option was to let the
>> kernel set the bit automatically.
>>
> 
> The foot gun still exists when migration is considered, no? If userspace
> is telling a guest it can use MTE on its normal memory, but then doesn't
> prepare that memory correctly, or remember to migrate the tags correctly
> (which requires knowing the memory has tags and knowing how to get them),
> then I guess the VM is in trouble one way or another.

Well not all VMMs support migration, and it's only migration that is 
affected by this for a simple VMM (e.g. the changes to kvmtool are 
minimal for MTE). But yes fundamentally if a VMM enables MTE it needs to 
know how to deal with the extra tags everywhere.

> I feel like we should trust the VMM to ensure MTE will work on any memory
> the guest could use it on, and change the action in user_mem_abort() to
> abort the guest with a big error message if it sees the flag is missing.

I'm happy to change it, if you feel this is easier to debug.

>>>>>
>>>>> If userspace needs to write to guest memory then it should be due to
>>>>> a device DMA or other specific hardware emulation. Those accesses can
>>>>> be done with tag checking disabled.
>>>>
>>>> Yes, the question is can the VMM (sensibly) wrap the accesses with a
>>>> disable/renable tag checking for the process sequence. The alternative at
>>>> the moment is to maintain a separate (untagged) mapping for the purpose
>>>> which might present it's own problems.
>>>
>>> Hmm, so there's no easy way to disable tag checking when necessary? If we
>>> don't map the guest ram with PROT_MTE and continue setting the attribute
>>> in KVM, as this series does, then we don't need to worry about it tag
>>> checking when accessing the memory, but then we can't access the tags for
>>> migration.
>>
>> There's a "TCO" (Tag Check Override) bit in PSTATE which allows disabling
>> tag checking, so if it's reasonable to wrap accesses to the memory you can
>> simply set the TCO bit, perform the memory access and then unset TCO. That
>> would mean a single mapping with MTE enabled would work fine. What I don't
>> have a clue about is whether it's practical in the VMM to wrap guest
>> accesses like this.
>>
> 
> At least QEMU goes through many abstractions to get to memory already.
> There may already be a hook we could use, if not, it probably wouldn't
> be too hard to add one (famous last words).

Sounds good. My hope was that the abstractions were already in there.

Thanks,

Steve

