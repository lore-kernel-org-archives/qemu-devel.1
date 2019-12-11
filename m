Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A55C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B963214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B963214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2Ri-0001vA-At
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1if2OS-0006Eo-09
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1if2OQ-0000Sf-Hn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:51:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2223 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1if2ON-0000JN-3n; Wed, 11 Dec 2019 08:51:03 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 48958B31F41B410CF4E1;
 Wed, 11 Dec 2019 21:50:54 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 21:50:44 +0800
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
To: Andrew Jones <drjones@redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
 <5679d43f-3f29-6ee1-0894-19ef2f3e08a2@huawei.com>
 <20191211090000.kajcyk7oqlqr3chk@kamzik.brq.redhat.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <c5241a1e-f81c-2616-8169-1696c23b747d@huawei.com>
Date: Wed, 11 Dec 2019 21:50:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211090000.kajcyk7oqlqr3chk@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.133.216.73]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin 00208455 <wanghaibin.wang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E5=9C=A8 2019/12/11 17:00, Andrew Jones =E5=86=99=E9=81=93:
> On Wed, Dec 11, 2019 at 04:02:52PM +0800, Guoheyi wrote:
>> =E5=9C=A8 2019/12/6 23:22, Peter Maydell =E5=86=99=E9=81=93:
>>> On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote=
:
>>>> v2:
>>>>    - move from RFC status to v1
>>>>    - put kvm_arm_vm_state_change() in kvm.c to share among kvm32.c a=
nd kvm64.c
>>>>    - add r-b's from Richard
>>>>
>>>>
>>>> This series is inspired by a series[1] posted by Bijan Mottahedeh ab=
out
>>>> a year ago.  The problem described in the cover letter of [1] is eas=
ily
>>>> reproducible and some users would like to have the option to avoid i=
t.
>>>> However the solution, which is to adjust the virtual counter offset =
each
>>>> time the VM transitions to the running state, introduces a different
>>>> problem, which is that the virtual and physical counters diverge.  A=
s
>>>> described in the cover letter of [1] this divergence is easily obser=
ved
>>>> when comparing the output of `date` and `hwclock` after suspending t=
he
>>>> guest, waiting a while, and then resuming it.  Because this differen=
t
>>>> problem may actually be worse for some users, unlike [1], the series
>>>> posted here makes the virtual counter offset adjustment optional and=
 not
>>>> even enabled by default.  Besides the adjustment being optional, thi=
s
>>>> series approaches the needed changes differently to apply them in mo=
re
>>>> appropriate locations.  Finally, unlike [1], this series doesn't att=
empt
>>>> to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, wh=
ich
>>>> only ticks when the VM is not stopped, is sufficient.
>>> So I guess my overall question is "what is the x86 solution to
>>> this problem, and why is this all arm-specific?" It would also
>>> be helpful to know how it fits into all the other proposals regarding
>>> time in VMs.
>> I also sent a RFC in March and ARM KVM experts were also invoved in th=
e
>> discussion:
>>
>> https://lists.cs.columbia.edu/pipermail/kvmarm/2019-March/035026.html
>>
>> According to the discussion, qemu on x86 is using KVM_KVMCLOCK_CTRL to
>> request KVM to set a flag "PVCLOCK_GUEST_STOPPED" in pvclock, informin=
g VM
>> kernel about external force stop.
>>
>> Thanks,
>>
>> Heyi
> Hi Heyi,
>
> Apologies for having forgotten about that thread. I recall now having
> followed it last March. Indeed it even addresses the issue in the way
> we're coming around to now (save/restore vs. update with virtual time).

Never mind :) We were also blocked by this issue when trying to support=20
VM suspend/resume, save/restore, etc, so I'm happy to see your patches=20
that we have the chance to fix it.

>
> I just reread the whole thread, and my feeling is that, while there are
> still many issues left to work, until we get a pvclock for arm, a patch
> like this one, but with a way to opt-in/out in order to give users a
> chance to choose their poison, is the best we can do. Also a patch like
> this one is a step in the right direction, as it will be needed as part
> of the bigger pvclock solution eventually, just as it is for x86.

Yes, it is simple and it works with current version of ARM64 OS=20
distributions.

Thanks,

Heyi

>
> One comment on the patch is that I would prefer to do the save/restore
> for all VCPUs, even though KVM does currently handle synchronization.
> Not only does it "feel" more correct to apply VCPU APIs to all VCPUs,
> but I assume it will be less problematic to implement CPU hotplug at
> some point.
>
> Thanks,
> drew
>
>
> .


