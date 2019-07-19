Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD104C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851442085A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851442085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoI1w-00014z-OP
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 21:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <guoheyi@huawei.com>) id 1hoI1m-0000bM-0B
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1hoI1k-0006fD-NG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:49:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58568 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1hoI1h-0006Wv-O1; Thu, 18 Jul 2019 21:49:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 946D830309C0A785A41F;
 Fri, 19 Jul 2019 09:49:28 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 19 Jul 2019
 09:49:22 +0800
To: Dave Martin <Dave.Martin@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1b0aa6b2-80b1-a72e-6849-7323c3b9c6bc@huawei.com>
 <20190715134059.GJ2790@e103592.cambridge.arm.com>
 <20190715134848.GI56232@lakrids.cambridge.arm.com>
 <4daefb19-6c15-f82c-31e9-1ae035d45bd5@arm.com>
 <20190715144446.GK56232@lakrids.cambridge.arm.com>
 <20190716084734.GL2790@e103592.cambridge.arm.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <287f566e-7697-3763-56b8-eb4821bd8347@huawei.com>
Date: Fri, 19 Jul 2019 09:49:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190716084734.GL2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [RFC] Add virtual SDEI support in qemu
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, James Morse <james.morse@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for all your comments. I'm going to write a simple demo to go 
through the whole workflow first, and then adjust the policies following 
the conclusions of our discussion.

Heyi


On 2019/7/16 16:47, Dave Martin wrote:
> On Mon, Jul 15, 2019 at 03:44:46PM +0100, Mark Rutland wrote:
>> On Mon, Jul 15, 2019 at 03:26:39PM +0100, James Morse wrote:
>>> On 15/07/2019 14:48, Mark Rutland wrote:
>>>> On Mon, Jul 15, 2019 at 02:41:00PM +0100, Dave Martin wrote:
>>>>> One option (suggested to me by James Morse) would be to allow userspace
>>>>> to disable in the in-kernel PSCI implementation and provide its own
>>>>> PSCI to the guest via SMC -- in which case userspace that wants to
>>>>> implement SDEI would have to implement PSCI as well.
>>>> I think this would be the best approach, since it puts userspace in
>>>> charge of everything.
>>>>
>>>> However, this interacts poorly with FW-based mitigations that we
>>>> implement in hyp. I suspect we'd probably need a mechanism to delegate
>>>> that responsibility back to the kernel, and figure out if that has any
>>>> interaction with thigns that got punted to userspace...
>>> This has come up before:
>>> https://lore.kernel.org/r/59C139D0.3040507@arm.com
>>>
>>> I agree Qemu should opt-in to this, it needs to be a feature that is enabled.
>>>
>>> I had an early version of something like this for testing SDEI before
>>> there was firmware available. The review feedback from Christoffer was
>>> that it should include HVC and SMC, their immediates, and shouldn't be
>>> tied to SMC-CC ranges.
>>>
>>> I think this should be a catch-all as Heyi describes to deliver
>>> 'unhandled SMC/HVC' to user-space as hypercall exits. We should
>>> include the immediate in the struct.
>>>
>>> We can allow Qemu to disable the in-kernel PSCI implementation, which
>>> would let it be done in user-space via this catch-all mechanism. (PSCI
>>> in user-space has come up on another thread recently). The in-kernel
>>> PSCI needs to be default-on for backwards compatibility.
>>>
>>> As Mark points out, the piece that's left is the 'arch workaround'
>>> stuff. We always need to handle these in the kernel. I don't think
>>> these should be routed-back, they should be un-obtainable by
>>> user-space.
>> Sure; I meant that those should be handled in the kernel rather than
>> going to host userspace and back.
>>
>> I was suggesting was that userspace would opt into taking ownership of
>> all HVC calls, then explicitly opt-in to the kernel handling specific
>> (sets of) calls.
> The most logical thing to do would be to have userspace handle all
> calls, but add an ioctl to forward a call to KVM.  This puts userspace
> in charge of the SMCCC interface, with KVM handling only those things
> that userspace can't do for itself, on request.
>
> If the performance overhead is unacceptable for certain calls, we could
> have a way to delegate specific function IDs to KVM.  I suspect that
> will be the exception rather than the rule.
>
>> There are probably issues with that, but I suspect defining "all
>> undandled calls" will be problematic otherwise.
> Agreed: the set of calls not handled by KVM will mutate over time.
>
> Cheers
> ---Dave
>
> .
>



