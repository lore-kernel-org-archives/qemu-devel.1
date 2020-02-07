Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B399C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E426D217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E426D217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03XI-0003cK-0Z
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1j03WV-00035U-65
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:18:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1j03WU-0001MZ-3B
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:18:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38246 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1j03WR-0001Au-A0; Fri, 07 Feb 2020 08:18:15 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3B0F73F34A8B2E1395DD;
 Fri,  7 Feb 2020 21:18:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0;
 Fri, 7 Feb 2020 21:17:58 +0800
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
To: Marc Zyngier <maz@kernel.org>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <CAFEAcA-+tAbb9h2wZOm56TqUvjQJT0OYFLwTVS-UxKrF5PO3mQ@mail.gmail.com>
 <5aece614-4341-35e5-53a6-2f3d788e6e8d@huawei.com>
 <e8b93460-48e6-43cd-4608-370c07cb45ec@huawei.com>
 <350aa4ca1b57a466ed882236caf23051@kernel.org>
 <c67c1563-045f-a5f8-8b8b-97d792aa1912@huawei.com>
 <f8394aafb2adb513186cd2784a1cb077@kernel.org>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <659a85d2-07e0-ad33-a2c0-99f21fc24ef8@huawei.com>
Date: Fri, 7 Feb 2020 21:17:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f8394aafb2adb513186cd2784a1cb077@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
 qemu-arm <qemu-arm@nongnu.org>, James
 Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/7 1:30, Marc Zyngier wrote:
> On 2020-02-06 01:20, Heyi Guo wrote:
>> Hi Marc,
>>
>> On 2020/2/5 21:15, Marc Zyngier wrote:
>>> Hi Heyi,
>>>
>>> On 2020-02-04 08:26, Heyi Guo wrote:
>>>> Update Marc's email address.
>>>>
>>>> +cc Gavin as he is posting a RFC for ARM NMI.
>>>>
>>>> Hi Marc,
>>>>
>>>> Really sorry for missing to update your email address, for the initi=
al
>>>> topic was raised long time ago and I forgot to update the Cc list in
>>>> the commit message of the patches.
>>>>
>>>> Thanks Gavin for forwarding current discussion on ARM NMI to me.
>>>>
>>>> For you said SDEI is "horrible", does it mean we'd better never
>>>> implement SDEI in virtual world? Or do you have any advice on how to
>>>> implement it?
>>>
>>> My concern is that SDEI implies having EL3. EL3 not being virtualizab=
le
>>> with KVM, you end-up baking SDEI in *hardware*. Of course, this=20
>>> hardware
>>> is actually software (it is QEMU), but this isn't the way it was=20
>>> intended.
>>
>>>
>>> It's not the first time we've done that (PSCI is another example),=20
>>> but the
>>> logic behind SDEI looks much more invasive.
>>
>> Thanks for your comments.
>>
>> Thinking about them for quite a while, below is my understanding,
>> please correct me if I'm wrong:
>>
>> So should the KVM based virtual machine be treated as one with CPUs
>> only having NS-EL1 and NS-EL0, ideally? And SDEI messes up this model,
>> isn't it?
>
> Well, that's exactly what it is (until we have nested virt, in which ca=
se
> you will be able to add NS-EL2 to the mix).
>
>> PSCI only contains some one-shot operations, so it is much less
>> invasive than SDEI.
>>
>>
>> I've another question. The origin of "virtual" SDEI requirement comes
>> from the lack of hard lockup detector in VM.
>
> Sure. But nothing guarantees that the guest is going to register a SDEI
> entry point anyway.
>
>> We can have some kind of
>> watchdog, but how can the watchdog trigger the VM OS to panic and run
>> kdump, even in irq-off state?
>
> Nothing. All the events, including SDEI, are maskable, one way or=20
> another.

Indeed...

>
> Gavin's approach to inject a SError is probably OK for Linux, given tha=
t
> it tends to run with PSTATE.A=3D=3D0. But that's not a guarantee either=
 (if
> you take a recursive exception, SError won't be delivered).
>
> The long and the short of it is that there is no way to do what you wan=
t
> with absolute guarantees on the ARM architecture. It just doesn't exist=
.

Much appreciate your explanation and advice.

Thanks,

Heyi

>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.


