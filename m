Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B0FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080A72173E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 08:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080A72173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iewyZ-0003PJ-6U
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 03:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1iewxo-0002r1-Fc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1iewxn-0001u2-31
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 03:03:16 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2222 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1iewxh-0001ND-OE; Wed, 11 Dec 2019 03:03:10 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5F1A8C7F098378EFBC40;
 Wed, 11 Dec 2019 16:02:56 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 16:02:53 +0800
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
References: <20191016143410.5023-1-drjones@redhat.com>
 <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <5679d43f-3f29-6ee1-0894-19ef2f3e08a2@huawei.com>
Date: Wed, 11 Dec 2019 16:02:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8j8M_J8Ocdpms8a2XufigVQ6oB4JBy2BcYAkXfJX5y5A@mail.gmail.com>
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E5=9C=A8 2019/12/6 23:22, Peter Maydell =E5=86=99=E9=81=93:
> On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
>> v2:
>>   - move from RFC status to v1
>>   - put kvm_arm_vm_state_change() in kvm.c to share among kvm32.c and =
kvm64.c
>>   - add r-b's from Richard
>>
>>
>> This series is inspired by a series[1] posted by Bijan Mottahedeh abou=
t
>> a year ago.  The problem described in the cover letter of [1] is easil=
y
>> reproducible and some users would like to have the option to avoid it.
>> However the solution, which is to adjust the virtual counter offset ea=
ch
>> time the VM transitions to the running state, introduces a different
>> problem, which is that the virtual and physical counters diverge.  As
>> described in the cover letter of [1] this divergence is easily observe=
d
>> when comparing the output of `date` and `hwclock` after suspending the
>> guest, waiting a while, and then resuming it.  Because this different
>> problem may actually be worse for some users, unlike [1], the series
>> posted here makes the virtual counter offset adjustment optional and n=
ot
>> even enabled by default.  Besides the adjustment being optional, this
>> series approaches the needed changes differently to apply them in more
>> appropriate locations.  Finally, unlike [1], this series doesn't attem=
pt
>> to measure "pause time" itself.  Simply using QEMU_CLOCK_VIRTUAL, whic=
h
>> only ticks when the VM is not stopped, is sufficient.
> So I guess my overall question is "what is the x86 solution to
> this problem, and why is this all arm-specific?" It would also
> be helpful to know how it fits into all the other proposals regarding
> time in VMs.

I also sent a RFC in March and ARM KVM experts were also invoved in the=20
discussion:

https://lists.cs.columbia.edu/pipermail/kvmarm/2019-March/035026.html

According to the discussion, qemu on x86 is using KVM_KVMCLOCK_CTRL to=20
request KVM to set a flag "PVCLOCK_GUEST_STOPPED" in pvclock, informing=20
VM kernel about external force stop.

Thanks,

Heyi


>
> thanks
> -- PMM
>
>


