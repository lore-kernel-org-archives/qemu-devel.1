Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA9FCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BEB214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BEB214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTD8-0007Xx-OA
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMTCF-00073q-Al
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMTCD-00008T-Ft
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMTCB-00007f-Hh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:37:45 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61BC4C0495A3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:37:42 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a6so4010593wru.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sNVzdayrnlDBWeLmo+GkJozKhCJfQkOUxXT4oshMYOU=;
 b=AFsHRw5PeJpPLXpTvKC83UdN5DazHW9hS+u8gxmCZyjm+3EKO162J91lP7ka+y7EeC
 X9VeE5HT5GmbMaqfztZ4+pgZQWekXPSR5d6jBo6g2snZ/u0JScCgCudwWHN2s8KIeEj4
 QS6NtuCPxmbHfc9NP3+fH3Z4qb1yKQHykx42mQhY6hfCaOItkHQlQ6wL3IrzClalrbQe
 Ts+aMNXi30hv9xQCvdMDYxk/TP4DpO3tFdD+psDLLvBbFxHX527DkrrzvozW1mVfrC/8
 vHABm2JeYiMD9NUtKVbjyLrr4YNwYFdVOg4hfwnX8i312qr//pqakpGUAgwUmnWo8ZTC
 ERuQ==
X-Gm-Message-State: APjAAAXhFLz9SUHQNK2qpgmzq7EBK8e2Z1Zup0xdwNduGJb9VGVQ7+bF
 wAIp85YTsLgu/aPHmk6sXnP06MR2ZyHitlzK1YCJwzIZ6gH+6ota1ynaTlhVyw+J/ouguPgG98J
 b15fusFz/J3jd+Wo=
X-Received: by 2002:adf:e982:: with SMTP id h2mr15762965wrm.53.1571647061119; 
 Mon, 21 Oct 2019 01:37:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIXvsoQ2lva3Qh8sxfgmMW5TGFt2l9RAoV9jLJ75IuaStH1LFnj54GUkBkM6amq0YkL0CjcQ==
X-Received: by 2002:adf:e982:: with SMTP id h2mr15762935wrm.53.1571647060872; 
 Mon, 21 Oct 2019 01:37:40 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u21sm10320761wmu.27.2019.10.21.01.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 01:37:40 -0700 (PDT)
Subject: Re: [PATCH v2 02/20] piix4: Add the Reset Control Register
To: Li Qiang <liq3ea@gmail.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-3-philmd@redhat.com>
 <CAKXe6SKQGYj+N04An+t5sP4jVkpEpmmGGfpZxb5VAV+w3owsBw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3235e49f-fdd6-5e5c-f60b-44538ff05d76@redhat.com>
Date: Mon, 21 Oct 2019 10:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKQGYj+N04An+t5sP4jVkpEpmmGGfpZxb5VAV+w3owsBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 3:25 AM, Li Qiang wrote:
>=20
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E=20
> 2019=E5=B9=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=88=
9:50=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     From: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>=20
>     The RCR I/O port (0xcf9) is used to generate a hard reset or a soft
>     reset.
>=20
>     Acked-by: Michael S. Tsirkin <mst@redhat.com <mailto:mst@redhat.com=
>>
>     Acked-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
>     Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>     Message-Id: <20171216090228.28505-7-hpoussin@reactos.org
>     <mailto:20171216090228.28505-7-hpoussin@reactos.org>>
>     Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
>     <mailto:amarkovic@wavecomp.com>>
>     [PMD: rebased, updated includes]
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/isa/piix4.c | 49 ++++++++++++++++++++++++++++++++++++++++=
++++++---
>      =C2=A01 file changed, 46 insertions(+), 3 deletions(-)
>=20
>     diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>     index 890d999abf..d0b18e0586 100644
>     --- a/hw/isa/piix4.c
>     +++ b/hw/isa/piix4.c
>     @@ -2,6 +2,7 @@
>      =C2=A0 * QEMU PIIX4 PCI Bridge Emulation
>      =C2=A0 *
>      =C2=A0 * Copyright (c) 2006 Fabrice Bellard
>     + * Copyright (c) 2018 Herv=C3=A9 Poussineau
>      =C2=A0 *
>      =C2=A0 * Permission is hereby granted, free of charge, to any pers=
on
>     obtaining a copy
>      =C2=A0 * of this software and associated documentation files (the
>     "Software"), to deal
>     @@ -28,11 +29,17 @@
>      =C2=A0#include "hw/isa/isa.h"
>      =C2=A0#include "hw/sysbus.h"
>      =C2=A0#include "migration/vmstate.h"
>     +#include "sysemu/reset.h"
>     +#include "sysemu/runstate.h"
>=20
>      =C2=A0PCIDevice *piix4_dev;
>=20
>      =C2=A0typedef struct PIIX4State {
>      =C2=A0 =C2=A0 =C2=A0PCIDevice dev;
>     +
>     +=C2=A0 =C2=A0 /* Reset Control Register */
>     +=C2=A0 =C2=A0 MemoryRegion rcr_mem;
>     +=C2=A0 =C2=A0 uint8_t rcr;
>      =C2=A0} PIIX4State;
>=20
>      =C2=A0#define TYPE_PIIX4_PCI_DEVICE "PIIX4"
>     @@ -87,15 +94,51 @@ static const VMStateDescription vmstate_piix4 =3D=
 {
>      =C2=A0 =C2=A0 =C2=A0}
>      =C2=A0};
>=20
>     +static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t va=
l,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int len)
>     +{
>     +=C2=A0 =C2=A0 PIIX4State *s =3D opaque;
>     +
>     +=C2=A0 =C2=A0 if (val & 4) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_request(SHUTDOWN_CAU=
SE_GUEST_RESET);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     +=C2=A0 =C2=A0 }
>     +
>     +=C2=A0 =C2=A0 s->rcr =3D val & 2; /* keep System Reset type only *=
/
>     +}
>     +
>     +static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned
>     int len)
>     +{
>     +=C2=A0 =C2=A0 PIIX4State *s =3D opaque;
>     +
>     +=C2=A0 =C2=A0 return s->rcr;
>     +}
>     +
>     +static const MemoryRegionOps piix4_rcr_ops =3D {
>     +=C2=A0 =C2=A0 .read =3D piix4_rcr_read,
>     +=C2=A0 =C2=A0 .write =3D piix4_rcr_write,
>     +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
>     +=C2=A0 =C2=A0 .impl =3D {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 1,
>     +=C2=A0 =C2=A0 },
>     +};
>     +
>      =C2=A0static void piix4_realize(PCIDevice *dev, Error **errp)
>      =C2=A0{
>     -=C2=A0 =C2=A0 PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);
>     +=C2=A0 =C2=A0 PIIX4State *s =3D PIIX4_PCI_DEVICE(dev);
>=20
>     -=C2=A0 =C2=A0 if (!isa_bus_new(DEVICE(d), pci_address_space(dev),
>     +=C2=A0 =C2=A0 if (!isa_bus_new(DEVICE(dev), pci_address_space(dev)=
,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pci_address_space_io(dev), errp)) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>      =C2=A0 =C2=A0 =C2=A0}
>     -=C2=A0 =C2=A0 piix4_dev =3D &d->dev;
>     +
>     +=C2=A0 =C2=A0 memory_region_init_io(&s->rcr_mem, OBJECT(dev), &pii=
x4_rcr_ops, s,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 "reset-control", 1);
>     +=C2=A0 =C2=A0 memory_region_add_subregion_overlap(pci_address_spac=
e_io(dev),
>     0xcf9,
>=20
>=20
>=20
> Can we use 'RCR_IOPORT' instead of constant value here? Also don't see=20
> this change
> in later patches of this seirals.

Good idea, I missed this one :)

> Anyway
>=20
> Reviewed-by: Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>>

Thanks!

>=20
> Thanks,
> Li Qiang
>=20
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &s->rcr_mem, 1);
>     +
>     +=C2=A0 =C2=A0 piix4_dev =3D dev;
>      =C2=A0}
>=20
>      =C2=A0int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
>     --=20
>     2.21.0
>=20
>=20

