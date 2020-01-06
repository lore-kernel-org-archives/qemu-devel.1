Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD32C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022C1206DB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022C1206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVt8-0002qZ-73
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioVsW-0002LJ-8C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioVsV-000364-5H
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:09:20 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:37583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioVsU-00034H-VB
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:09:19 -0500
Received: from player738.ha.ovh.net (unknown [10.108.1.191])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id F239A11CDDD
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 18:09:16 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 98F17E03FC2A;
 Mon,  6 Jan 2020 17:09:11 +0000 (UTC)
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
 <20200106085042.GW2098@umbus>
 <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b0587d24-c7f6-ff1f-9527-ee389bd25b1f@kaod.org>
Date: Mon, 6 Jan 2020 18:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7618964673147603776
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.51.249
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>> index e62c89b3dd40..1c97534a0aea 100644
>>>>> --- a/hw/ppc/spapr.c
>>>>> +++ b/hw/ppc/spapr.c
>>>>> @@ -896,6 +896,51 @@ out:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>> =C2=A0 }
>>>>> =C2=A0 +/*
>>>>> + * Below is a compiled version of RTAS blob and OF client interfac=
e entry point.
>>>>> + *
>>>>> + * gcc -nostdlib=C2=A0 -mbig -o spapr-rtas.img spapr-rtas.S
>>>>> + * objcopy=C2=A0 -O binary -j .text=C2=A0 spapr-rtas.img spapr-rta=
s.bin
>>>>> + *
>>>>> + *=C2=A0=C2=A0 .globl=C2=A0 _start
>>>>> + *=C2=A0=C2=A0 _start:
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 4,3
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lis=
=C2=A0=C2=A0=C2=A0=C2=A0 3,KVMPPC_H_RTAS@h
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ori=
=C2=A0=C2=A0=C2=A0=C2=A0 3,3,KVMPPC_H_RTAS@l
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sc=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blr
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mr=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 4,3
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lis=
=C2=A0=C2=A0=C2=A0=C2=A0 3,KVMPPC_H_CLIENT@h
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ori=
=C2=A0=C2=A0=C2=A0=C2=A0 3,3,KVMPPC_H_CLIENT@l
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sc=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blr
>>>>> + */
>>>>> +static struct {
>>>>> +=C2=A0=C2=A0=C2=A0 uint8_t rtas[20], client[20];
>>>>> +} QEMU_PACKED rtas_client_blob =3D {
>>>>> +=C2=A0=C2=A0=C2=A0 .rtas =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x7c, 0x64, 0x1b, 0x78,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3c, 0x60, 0x00, 0x00,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x60, 0x63, 0xf0, 0x00,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x44, 0x00, 0x00, 0x22,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4e, 0x80, 0x00, 0x20
>>>>> +=C2=A0=C2=A0=C2=A0 },
>>>>> +=C2=A0=C2=A0=C2=A0 .client =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x7c, 0x64, 0x1b, 0x78,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x3c, 0x60, 0x00, 0x00,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x60, 0x63, 0xf0, 0x05,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x44, 0x00, 0x00, 0x22,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4e, 0x80, 0x00, 0x20
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +};
>>>>
>>>> I'd really prefer to read this in from a file (or files) which we
>>>> assemble (as with the existing spapr-rtas.img), rather than having a
>>>> magic array in qemu.
>>>
>>> Two considerations here:
>>> 1. This blob is not going to change (at least often)
>>
>> True, but I'd still prefer to build it from a .S rather than have the
>> binary written out.=C2=A0 We already had this until recently (when we =
moved
>> the RTAS image into SLOF), and it's really not too hard to manage.
>=20
>=20
> But what is exactly the benefit? It is not going to change. I can look =
into making it a .S, compile it to a binary an include this binary into q=
emu-system-ppc64 as a byte array, just need to refresh my gcc/ldd memorie=
s but a separate file is too much for this imho.

ARM bootloaders are also embedded in QEMU's code. See hw/arm/boot.c.
You could improve a bit the definition though.

C.

>=20
>>> 2. A new file which needs to be packaged/signed/copied.
>>
>> Eh, again, we had this for RTAS until very recently and it really
>> wasn't that much hassle.
>=20
>=20
> I keep secure VMs in mind. And SLOF is a separate package, why was not =
RTAS?


