Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5153C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D64207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D64207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9k2u-0000ya-Sp
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 01:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuzenghui@huawei.com>) id 1j9k1t-0000Nm-T8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuzenghui@huawei.com>) id 1j9k1s-00009A-Nz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:30:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3259 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yuzenghui@huawei.com>)
 id 1j9k1p-0008PR-RU; Thu, 05 Mar 2020 01:30:42 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4BB4BA99A342402E1B34;
 Thu,  5 Mar 2020 14:30:29 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Mar 2020
 14:30:18 +0800
Subject: Re: [kvm-unit-tests PATCH v3 08/14] arm/arm64: ITS:
 its_enable_defaults
To: Auger Eric <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20200128103459.19413-1-eric.auger@redhat.com>
 <20200128103459.19413-9-eric.auger@redhat.com>
 <10d0630f-1464-b12a-5ad5-ee617eaa5cca@huawei.com>
 <a49227ce-355a-be35-c006-441e2adca8e1@redhat.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <1b91ddb6-5139-5deb-2325-c18af7657825@huawei.com>
Date: Thu, 5 Mar 2020 14:30:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a49227ce-355a-be35-c006-441e2adca8e1@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

On 2020/3/4 22:26, Auger Eric wrote:
> Hi Zenghui,
> On 2/7/20 4:20 AM, Zenghui Yu wrote:
>> Hi Eric,
>>
>> On 2020/1/28 18:34, Eric Auger wrote:
>>> its_enable_defaults() is the top init function that allocates the
>>> command queue and all the requested tables (device, collection,
>>> lpi config and pending tables), enable LPIs at distributor level
>>> and ITS level.
>>>
>>> gicv3_enable_defaults must be called before.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> v2 -> v3:
>>> - introduce its_setup_baser in this patch
>>> - squash "arm/arm64: ITS: Init the command queue" in this patch.
>>> ---
>>>  =C2=A0 lib/arm/asm/gic-v3-its.h |=C2=A0 8 ++++
>>>  =C2=A0 lib/arm/gic-v3-its.c=C2=A0=C2=A0=C2=A0=C2=A0 | 89 +++++++++++=
+++++++++++++++++++++++++++++
>>>  =C2=A0 2 files changed, 97 insertions(+)
>>>
>>> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
>>> index 815c515..fe73c04 100644
>>> --- a/lib/arm/asm/gic-v3-its.h
>>> +++ b/lib/arm/asm/gic-v3-its.h
>>> @@ -36,6 +36,8 @@ struct its_data {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *base;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_typer typer;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_baser baser[GITS_BASER_NR_=
REGS];
>>> +=C2=A0=C2=A0=C2=A0 struct its_cmd_block *cmd_base;
>>> +=C2=A0=C2=A0=C2=A0 struct its_cmd_block *cmd_write;
>>>  =C2=A0 };
>>>  =C2=A0 =C2=A0 extern struct its_data its_data;
>>> @@ -88,10 +90,16 @@ extern struct its_data its_data;
>>>  =C2=A0 #define GITS_BASER_TYPE_DEVICE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1
>>>  =C2=A0 #define GITS_BASER_TYPE_COLLECTION=C2=A0=C2=A0=C2=A0 4
>>>  =C2=A0 +
>>> +struct its_cmd_block {
>>> +=C2=A0=C2=A0=C2=A0 u64 raw_cmd[4];
>>> +};
>>> +
>>>  =C2=A0 extern void its_parse_typer(void);
>>>  =C2=A0 extern void its_init(void);
>>>  =C2=A0 extern int its_parse_baser(int i, struct its_baser *baser);
>>>  =C2=A0 extern struct its_baser *its_lookup_baser(int type);
>>> +extern void its_enable_defaults(void);
>>>  =C2=A0 =C2=A0 #else /* __arm__ */
>>>  =C2=A0 diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
>>> index 2c0ce13..d1e7e52 100644
>>> --- a/lib/arm/gic-v3-its.c
>>> +++ b/lib/arm/gic-v3-its.c
>>> @@ -86,3 +86,92 @@ void its_init(void)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its_parse_bas=
er(i, &its_data.baser[i]);
>>>  =C2=A0 }
>>>  =C2=A0 +static void its_setup_baser(int i, struct its_baser *baser)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned long n =3D (baser->nr_pages * baser->psz=
) >> PAGE_SHIFT;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long order =3D is_power_of_2(n) ? fls(n)=
 : fls(n) + 1;
>>> +=C2=A0=C2=A0=C2=A0 u64 val;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 baser->table_addr =3D (u64)virt_to_phys(alloc_pag=
es(order));
>>> +
>>> +=C2=A0=C2=A0=C2=A0 val =3D ((u64)baser->table_addr=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((u64)baser->type=C2=A0=C2=
=A0=C2=A0 << GITS_BASER_TYPE_SHIFT)=C2=A0=C2=A0=C2=A0 |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((u64)(baser->esz - 1)=C2=
=A0=C2=A0=C2=A0 << GITS_BASER_ENTRY_SIZE_SHIFT)=C2=A0=C2=A0=C2=A0 |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((baser->nr_pages - 1)=C2=
=A0=C2=A0=C2=A0 << GITS_BASER_PAGES_SHIFT)=C2=A0=C2=A0=C2=A0 |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u64)baser->indirect=C2=A0=
=C2=A0=C2=A0 << 62=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>
>> I haven't seen the 'nr_pages' and 'indirect' are programmed anywhere
>> except in its_parse_baser(). It looks like they're treated as RO (but
>> they shouldn't) and I now don't think it makes sense to parse them in
>> its_parse_baser(), in patch#5.
>=20
> First of all please forgive me for the delay.

Never mind.

>=20
> I agree with you on nr_pages. However indirect also indicates the BASER
> capability to support or not 2 level tables. So I think it makes sense
> to read it on init.

Yes, you're right. As the spec says, the Indirect field "is RAZ/WI for
GIC implementations that only support flat tables".


Thanks,
Zenghui


