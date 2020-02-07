Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B9C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64320214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64320214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03xe-0008VZ-Cr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1j03ws-0007Zm-1p
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1j03wq-0005BQ-Kj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:45:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2758 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1j03wm-0004l0-Uo; Fri, 07 Feb 2020 08:45:29 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 202298598E8A1BE03C7A;
 Fri,  7 Feb 2020 21:45:23 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0;
 Fri, 7 Feb 2020 21:45:13 +0800
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
To: James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <CAFEAcA-+tAbb9h2wZOm56TqUvjQJT0OYFLwTVS-UxKrF5PO3mQ@mail.gmail.com>
 <5aece614-4341-35e5-53a6-2f3d788e6e8d@huawei.com>
 <e8b93460-48e6-43cd-4608-370c07cb45ec@huawei.com>
 <350aa4ca1b57a466ed882236caf23051@kernel.org>
 <c67c1563-045f-a5f8-8b8b-97d792aa1912@huawei.com>
 <f8394aafb2adb513186cd2784a1cb077@kernel.org>
 <58519c6b-5c0e-b557-ac91-2024c594b28c@arm.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <0e727390-0ed9-0346-aa3b-dc983afd443d@huawei.com>
Date: Fri, 7 Feb 2020 21:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <58519c6b-5c0e-b557-ac91-2024c594b28c@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo
 Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com, Dave
 Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/7 18:52, James Morse wrote:
> Hi guys,
>
> On 06/02/2020 17:30, Marc Zyngier wrote:
>> On 2020-02-06 01:20, Heyi Guo wrote:
>>> On 2020/2/5 21:15, Marc Zyngier wrote:
>>>> My concern is that SDEI implies having EL3. EL3 not being virtualizable
>>>> with KVM, you end-up baking SDEI in *hardware*. Of course, this hardware
>>>> is actually software (it is QEMU), but this isn't the way it was intended.
>>>> It's not the first time we've done that (PSCI is another example), but the
>>>> logic behind SDEI looks much more invasive.
>>> Thanks for your comments.
>>>
>>> Thinking about them for quite a while, below is my understanding,
>>> please correct me if I'm wrong:
>>>
>>> So should the KVM based virtual machine be treated as one with CPUs
>>> only having NS-EL1 and NS-EL0, ideally? And SDEI messes up this model,
>>> isn't it?
>> Well, that's exactly what it is (until we have nested virt, in which case
>> you will be able to add NS-EL2 to the mix).
>>
>>> PSCI only contains some one-shot operations, so it is much less
>>> invasive than SDEI.
> Is there an established pattern for how Qemu 'gets' things that are done in secure-world?
> For PSCI the kernel does it, but this obviously doesn't scale to something like OP-TEE.
>
> Ideally we'd get the reference implementation (from ATF) in some form that is easy to use...
>
>
>>> I've another question. The origin of "virtual" SDEI requirement comes
>>> from the lack of hard lockup detector in VM.
> (this is your use case. Its origin was just symmetry with EL3<->EL2)
>
>
>> Sure. But nothing guarantees that the guest is going to register a SDEI
>> entry point anyway.
>>> We can have some kind of
>>> watchdog, but how can the watchdog trigger the VM OS to panic and run
>>> kdump, even in irq-off state?
>> Nothing. All the events, including SDEI, are maskable, one way or another.
>>
>> Gavin's approach to inject a SError is probably OK for Linux, given that
>> it tends to run with PSTATE.A==0. But that's not a guarantee either (if
>> you take a recursive exception, SError won't be delivered).
> Or get stuck in debug-state (for which we mask SError), power-management, the vectors or
> somewhere weird, like KVM's world-switch.
>
>
> If you just want to kill the OS if its sort-of-alive, there is another trick:
>
> Synchronous exceptions can't be masked because they are caused by the instruction pointed
> to by the ELR. You can't inject an emulated data-abort unless the ELR points to an
> instruction that accesses memory, but...
>
> synchronous external abort for instruction fetch is something that  could happen at any
> time. If you have v8.2 you can make the severity uncontainable for extra points.
>
> On real hardware, this would be as if this instruction missed in the i-cache, then got an
> abort from the PoU-cache. The PoU-cache must have suffered some metadata corruption to
> report an uncontained error. On real hardware its very likely the next instruction would
> suffer the same fate, but linux should put up a good show of trying to panic().

Good idea. It seems to be able to cover all the possible the cases, 
while we only need to highlight this exception in the user document :)

Thanks,

Heyi

>
>
>> The long and the short of it is that there is no way to do what you want
>> with absolute guarantees on the ARM architecture. It just doesn't exist.
> Yes. By sort-of-alive it needs to be making some kind of progress. If the CPU is spinning
> through the vectors (because some joker unmapped them), all bets are off.
>
>
> Thanks,
>
> James
>
> .


