Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A65C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF7520730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF7520730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytYJ-0004Sv-Cs
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iytXg-0003uJ-DY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iytXf-0002ot-36
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:26:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2695 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iytXb-000234-PQ; Tue, 04 Feb 2020 03:26:40 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B34012DCF8D3F3559FC9;
 Tue,  4 Feb 2020 16:26:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 4 Feb 2020 16:26:22 +0800
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
From: Heyi Guo <guoheyi@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <CAFEAcA-+tAbb9h2wZOm56TqUvjQJT0OYFLwTVS-UxKrF5PO3mQ@mail.gmail.com>
 <5aece614-4341-35e5-53a6-2f3d788e6e8d@huawei.com>
Message-ID: <e8b93460-48e6-43cd-4608-370c07cb45ec@huawei.com>
Date: Tue, 4 Feb 2020 16:26:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5aece614-4341-35e5-53a6-2f3d788e6e8d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Mark Rutland <mark.rutland@arm.com>, Gavin Shan <gshan@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update Marc's email address.

+cc Gavin as he is posting a RFC for ARM NMI.

Hi Marc,

Really sorry for missing to update your email address, for the initial=20
topic was raised long time ago and I forgot to update the Cc list in the=20
commit message of the patches.

Thanks Gavin for forwarding current discussion on ARM NMI to me.

For you said SDEI is "horrible", does it mean we'd better never=20
implement SDEI in virtual world? Or do you have any advice on how to=20
implement it?

Thanks,

Heyi

On 2019/12/23 16:20, Guoheyi wrote:
> Hi Peter,
>
> Really appreciate your comments.
>
> For other platforms/boards emulated in qemu, like omap, imx*, etc, are=20
> they just TCG platforms? Can we just enable security and EL3 emulation=20
> for these platforms instead of implementing copies of firmware=20
> interfaces in qemu? Also I think it is possible to optimize the code=20
> to support all KVM enabled virtual boards with one single copy of SDEI=20
> code, so at least the duplication of code inside qemu might be avoided.
>
> I can understand your concerns; the exsiting SDEI code in ARM Trusted=20
> Firmware also tempted me when I started to writing the code in qemu. I=20
> agree the ideal way is to use the existing firmware directly, but how=20
> can we achieve that? Either I don't think it is good to modify the=20
> firmware code too much, for firmware should be kept simple and reliable=
.
>
> Does James or Marc have any idea?
>
> Thanks,
>
> Heyi
>
> =E5=9C=A8 2019/12/20 21:44, Peter Maydell =E5=86=99=E9=81=93:
>> On Tue, 5 Nov 2019 at 09:12, Heyi Guo <guoheyi@huawei.com> wrote:
>>> SDEI is for ARM "Software Delegated Exception Interface". AS ARM64=20
>>> doesn't have
>>> native non-maskable interrupt (NMI), we rely on higher privileged=20
>>> (larger
>>> exception level) software to change the execution flow of lower=20
>>> privileged
>>> (smaller exception level) software when certain events occur, to=20
>>> emulate NMI
>>> mechanism, and SDEI is the standard interfaces between the two=20
>>> levels of
>>> privileged software. It is based on SMC/HVC calls.
>>>
>>> The higher privileged software implements an SDEI dispatcher to=20
>>> handle SDEI
>>> related SMC/HVC calls and trigger SDEI events; the lower privileged=20
>>> software
>>> implements an SDEI client to request SDEI services and handle SDEI=20
>>> events.
>> Hi; I read through these patches last week, but I didn't reply
>> then because although there are some aspects to the design that
>> I don't like, I don't have a clear idea of what a better approach
>> to the problems it's trying to solve would be. However I didn't
>> want to go home for the end of the year without providing at
>> least some response. So I'm going to lay out the parts I have
>> issues with and perhaps somebody else will have a good idea.
>>
>> The first part that I dislike here is that this is implementing
>> an entire ABI which in real hardware is provided by firmware. I
>> think that QEMU's design works best when QEMU provides emulation of
>> hardware or hardware-like facilities, which guest code (either
>> in the kernel, or firmware/bios running in the guest) can then
>> make use of. Once we start getting into implementing firmware
>> interfaces directly in QEMU this rapidly becomes a large amount
>> of work and code, and it's unclear where it should stop. Should
>> we implement also the equivalent of firmware for omap boards?
>> For imx* boards? For the raspberry pi? For xilinx boards?
>> Are we going to end up reimplementing more of ARM Trusted Firmware
>> functionality inside QEMU? The code to implement firmware-equivalent
>> ABIs in all these boards would I think quickly become a large part
>> of the codebase.
>>
>> My second concern is that to do the things it wants to do,
>> the implementation here does some pretty invasive things:
>> =C2=A0 * intercepting interrupt lines which ought to just be
>> =C2=A0=C2=A0=C2=A0 emulated hardware signals between devices and the G=
IC
>> =C2=A0 * capturing register values of other CPUs, and arbitrarily
>> =C2=A0=C2=A0=C2=A0 stopping those other CPUs and making them run other=
 code
>> =C2=A0=C2=A0=C2=A0 at a later point in time
>> I'm really uncomfortable with what's just an 'emulated firmware'
>> interface for one specific board model doing this kind of thing.
>>
>> Finally, the stated rationale for the patchset ("we'd like an
>> emulated NMI equivalent") doesn't really feel to me like it's
>> strong enough to counterbalance the amount of code here and
>> the degree to which it's moving us into a swamp I'd prefer
>> it if we could stay out of.
>>
>> I'd be much happier with a design where QEMU provides simple
>> facilities to the guest and the guest firmware and kernel
>> deal with making use of them. I appreciate that it's not
>> clear how that would work though, given that in real hardware
>> this works by the firmware running at EL3 and KVM not
>> providing a mechanism that allows guest code that runs at
>> a higher (effective or emulated) privilege level than the
>> guest kernel...
>>
>> thanks
>> -- PMM
>>
>> .


