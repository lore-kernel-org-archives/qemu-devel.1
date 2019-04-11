Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21998C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E332083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E332083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50889 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbmh-0008Rk-34
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:38:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.price@arm.com>) id 1hEbgL-0003Sb-Mc
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.price@arm.com>) id 1hEbgJ-0003Or-Jb
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:32:05 -0400
Received: from foss.arm.com ([217.140.101.70]:41512)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.price@arm.com>)
	id 1hEbgF-00034M-8k; Thu, 11 Apr 2019 11:31:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 107F980D;
	Thu, 11 Apr 2019 08:31:42 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDBE83F68F;
	Thu, 11 Apr 2019 08:31:40 -0700 (PDT)
To: Heyi Guo <guoheyi@huawei.com>, Christoffer Dall <christoffer.dall@arm.com>
References: <1552370960-2061-1-git-send-email-guoheyi@huawei.com>
	<CAFEAcA-29Q-sTg2wLre0GJJCr2gfu89rg0vuTOf7cW5drE4d7Q@mail.gmail.com>
	<136f773f-9b08-a39b-3ecb-2c00ff290b49@arm.com>
	<22f57e8a-bdb0-ffeb-ab78-3e9e41cac66b@arm.com>
	<20190315085948.GB10950@e113682-lin.lund.arm.com>
	<ff1db661-13c2-50ff-940e-4a1d71bd0309@huawei.com>
	<101c5f17-9811-e2d0-ff3c-a0e64beee921@arm.com>
	<662367df-e702-dd0a-da83-f1b448c5f203@huawei.com>
	<1a315d48-1657-e50b-97ec-ead9c6c459c2@huawei.com>
	<0e1f903a-d445-6bef-3dfd-6d9f7f6a5f98@arm.com>
	<3867fef8-15d9-623c-7bd3-2c673dccf745@huawei.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <ef3e617e-aa51-88d8-1e06-450febee43a4@arm.com>
Date: Thu, 11 Apr 2019 16:31:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3867fef8-15d9-623c-7bd3-2c673dccf745@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [RFC] arm/cpu: fix soft lockup panic after
 resuming from stop
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marc Zyngier <marc.zyngier@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411153139.VtWWWR3h4zu5ONXgSc-atOcnWjreDrgIS0b2RFDErHA@z>

On 11/04/2019 08:27, Heyi Guo wrote:
> Hi Steve,
>=20
> After reading kernel code about time keeping and something related, I'v=
e
> not got a clear picture of how we can use MSR_KVM_WALL_CLOCK_NEW to kee=
p
> wall clock in guest VM.
>=20
> 1. On X86, MSR_KVM_WALL_CLOCK_NEW is only used by the callback of syste=
m
> suspend and resume; I didn't find it used for runtime wall clock readin=
g.

The MSR is only to provide an offset from the guest's view of system
time to the actual wall-clock time. Like you mention it's used on resume
to resynchronise with wall-clock time.

Looking at this more carefully, I think I may have got a bit confused
with how this works on x86. As you say MSR_KVM_WALL_CLOCK_NEW is only
used on boot (and suspend/resume) to provide the difference between the
TSC and wall-clock.

MSR_KVM_SYSTEM_TIME_NEW seems to be the MSR that provides the offset
between the host's TSC and the guest's view of time. In particular the
KVM request KVM_REQ_CLOCK_UPDATE causes this to be updated.

There's a lot of code in there to deal with e.g. the host's TSC going
backwards (due to buggy hardware, but also due to suspend/hibernate).

> 2. To use the MSR for wall clock synchronization, shall we register KVM
> PV-clock as a higher rating clock source, so that it will be bound to
> tk_core.timekeeper and be read at each time of running
> update_wall_time() in each timer tick?
>
> 3. If the above is true, how can we keep the paravirtualized wall clock
> always updated? Is it always trapped to the hypervisor? I'm afraid this
> may cause performance loss. If there is no trap and the data is updated
> by the hypervisor periodically, how can we guarantee the accuracy?

We obviously don't want to be making frequent hypercalls (or other
traps) - so the idea is to provide the guest with a structure which is
updated when the host is aware something has changed. The guest then
reads this structure (using a version field to avoid races with the
host) and uses it compute it's own version of time.

> Meanwhile it seems easier to use KVM_KVMCLOCK_CTRL to get rid of false
> positive soft lock panic, and guest can rely on cntvct for wall clock
> updating as it does now, and it seems not difficult for the hypervisor
> to keep cntvct "always on" and "monotonic".
>=20
> Please let me know if I miss something.

Yes I'm coming around to that way of thinking - as long as the
hypervisor provides the "always on"/"monotonic" properties then really
the only missing bit is informing the guest when it was paused so it can
"do the right thing". This does appear to be what the x86 code is doing,
but I have to admit I struggle to fully understand it.

Steve

> Thanks,
> Heyi
>=20
> On 2019/3/27 1:12, Steven Price wrote:
>> Hi Heyi,
>>
>> On 26/03/2019 13:53, Heyi Guo wrote:
>>> I also tested save/restore operations, and observed that clock in gue=
st
>>> would not jump after restoring either. If we consider guest clock not
>>> being synchronized with real wall clock as an issue, does it mean
>>> save/restore function has the same issue?
>> Basically at the moment when the guest isn't running you have a choice
>> of two behaviours:
>>
>> =C2=A0 1. Stop (i.e. save/restore) CNTVCT - this means that the guest =
sees no
>> time occur. If the guest needs to have a concept of wall-clock time
>> (e.g. it communicates with other systems over a network) then this can
>> cause problems (e.g. timeouts might be wrong, certificates might start
>> appearing to be in the future etc).
>>
>> =C2=A0 2. Leave CNTVCT running - the guest sees the time pass but inte=
rprets
>> the vCPUs as effectively having locked up. Linux will trigger the soft
>> lockup warning.
>>
>> There are two ways of solving this, which match the two behaviours abo=
ve:
>>
>> =C2=A0 1. Provide the guest with a view of wall-clock time. The obviou=
s way of
>> doing this is with a pvclock implementation like MSR_KVM_WALL_CLOCK_NE=
W
>> for x86.
>>
>> =C2=A0 2. Inform the guest to ignore the apparent "soft-lockup". There=
's
>> already an ioctl for x86 for this: KVM_KVMCLOCK_CTRL
>>
>> My preference is for option 1 - as this gives the guest a good view of
>> both the time that it is actually executing (useful for internal
>> watchdog timers like the soft-lockup one in Linux) and maintains a vie=
w
>> of wall-clock time (useful when communicating with other external
>> services - e.g. the a server on the internet). Your patch to QEMU
>> provides the first step of that, but as you mention there's much more
>> to do.
>>
>> One thing I haven't investigated in great detail is how KVM handles th=
e
>> timer during various forms of suspend. In particular for suspend types
>> like full hibernation the host's physical counter will jump (quite
>> possibly backwards) - I haven't looked in detail how KVM presents this
>> to the guest. Hopefully not by making it go backwards!
>>
>> I'm not sure how much time I'm going to have to look at this in the ne=
ar
>> future, but please keep me in the loop if you decide to tackle any of
>> this.
>>
>> Thanks,
>>
>> Steve
>>
>> .
>>
>=20
>=20
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm


