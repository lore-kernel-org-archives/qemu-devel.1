Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F94EC73C7F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B73820651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B73820651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl7yB-00088z-ML
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <longpeng2@huawei.com>) id 1hl7xC-0007Fw-Lv
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1hl7xB-0002At-E5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:27:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36942 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1hl7xA-00024L-Uz
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:27:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D4A265F07DABF74F23E3;
 Wed, 10 Jul 2019 16:27:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0;
 Wed, 10 Jul 2019 16:27:35 +0800
To: Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
References: <785B5B0623C08241B2D0E6E7D8FA6B181E0A8FFF@DGGEMM506-MBX.china.huawei.com>
 <20190708094750.GE2746@work-vm>
 <fb1d9412-d017-3a74-012b-2bcd88271160@redhat.com>
 <83ba270d-5302-3ffe-2663-8adc36e9f079@huawei.com>
 <2c37ed34-7cd9-8962-c4bd-d55b91336bd5@redhat.com>
From: "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <5621ea8b-00b5-8fd7-c34b-61e21928d9f8@huawei.com>
Date: Wed, 10 Jul 2019 16:27:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2c37ed34-7cd9-8962-c4bd-d55b91336bd5@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [BUG] VM abort after migration
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
Cc: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "v.maffione@gmail.com" <v.maffione@gmail.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=E5=9C=A8 2019/7/10 11:57, Jason Wang =E5=86=99=E9=81=93:
>=20
> On 2019/7/10 =E4=B8=8A=E5=8D=8811:36, Longpeng (Mike) wrote:
>> =E5=9C=A8 2019/7/10 11:25, Jason Wang =E5=86=99=E9=81=93:
>>> On 2019/7/8 =E4=B8=8B=E5=8D=885:47, Dr. David Alan Gilbert wrote:
>>>> * longpeng (longpeng2@huawei.com) wrote:
>>>>> Hi guys,
>>>>>
>>>>> We found a qemu core in our testing environment, the assertion
>>>>> 'assert(bus->irq_count[i] =3D=3D 0)' in pcibus_reset() was triggere=
d and
>>>>> the bus->irq_count[i] is '-1'.
>>>>>
>>>>> Through analysis, it was happened after VM migration and we think
>>>>> it was caused by the following sequence:
>>>>>
>>>>> *Migration Source*
>>>>> 1. save bus pci.0 state, including irq_count[x] ( =3D0 , old )
>>>>> 2. save E1000:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 e1000_pre_save
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e1000_mit_timer
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_interrupt_cause
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_set_irq --> update p=
ci_dev->irq_state to 1 and
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update bus->irq_count[x] to=
 1 ( new )
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the irq_state sent to dest.
>>>>>
>>>>> *Migration Dest*
>>>>> 1. Receive the irq_count[x] of pci.0 is 0 , but the irq_state of e1=
000 is 1.
>>>>> 2. If the e1000 need change irqline , it would call to pci_irq_hand=
ler(),
>>>>> =C2=A0=C2=A0=C2=A0 the irq_state maybe change to 0 and bus->irq_cou=
nt[x] will become
>>>>> =C2=A0=C2=A0=C2=A0 -1 in this situation.
>>>>> 3. do VM reboot then the assertion will be triggered.
>>>>>
>>>>> We also found some guys faced the similar problem:
>>>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02525.=
html
>>>>> [2] https://bugs.launchpad.net/qemu/+bug/1702621
>>>>>
>>>>> Is there some patches to fix this problem ?
>>>> I don't remember any.
>>>>
>>>>> Can we save pcibus state after all the pci devs are saved ?
>>>> Does this problem only happen with e1000? I think so.
>>>> If it's only e1000 I think we should fix it - I think once the VM is
>>>> stopped for doing the device migration it shouldn't be raising
>>>> interrupts.
>>>
>>> I wonder maybe we can simply fix this by no setting ICS on pre_save()=
 but
>>> scheduling mit timer unconditionally in post_load().
>>>
>> I also think this is a bug of e1000 because we find more cores with th=
e same
>> frame thease days.
>>
>> I'm not familiar with e1000 so hope someone could fix it, thanks. :)
>>
>=20
> Draft a path in attachment, please test.
>=20
Thanks. We'll test it for a few weeks and then give you the feedback. :)

> Thanks
>=20
>=20
>>> Thanks
>>>
>>>
>>>> Dave
>>>>
>>>>> Thanks,
>>>>> Longpeng(Mike)
>>>> --=C2=A0
>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>> .
>>>


--=20
Regards,
Longpeng(Mike)


