Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB86C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E61820727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E61820727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjjP-0001jz-Mh
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBjiH-0008Gn-0a
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBjiF-0007MF-Bm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:34:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:29611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBjiB-00077S-Ci; Tue, 10 Mar 2020 14:34:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E607E746381;
 Tue, 10 Mar 2020 19:34:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9AF1274637D; Tue, 10 Mar 2020 19:34:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 99530745953;
 Tue, 10 Mar 2020 19:34:36 +0100 (CET)
Date: Tue, 10 Mar 2020 19:34:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <ae7962c6-8abc-633e-7b90-83f90038217f@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003101921020.30321@zero.eik.bme.hu>
References: <cover.1583714522.git.balaton@eik.bme.hu>
 <2acb7e522055bb9ac45586c1792edc7615ef3ae6.1583714522.git.balaton@eik.bme.hu>
 <c3c58b0b-71fb-e188-208e-3fbf479bb346@ilande.co.uk>
 <alpine.BSF.2.22.395.2003092048250.94024@zero.eik.bme.hu>
 <ae7962c6-8abc-633e-7b90-83f90038217f@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1009266962-1583865276=:30321"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1009266962-1583865276=:30321
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2020, Mark Cave-Ayland wrote:
> On 09/03/2020 20:17, BALATON Zoltan wrote:
>> On Mon, 9 Mar 2020, Mark Cave-Ayland wrote:
>>> On 09/03/2020 00:42, BALATON Zoltan wrote:
>>>> Some machines operate in "non 100% native mode" where interrupts are
>>>> fixed at legacy IDE interrupts and some guests expect this behaviour
>>>> without checking based on knowledge about hardware. Even Linux has
>>>> arch specific workarounds for this that are activated on such boards
>>>> so this needs to be emulated as well.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>> v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
>>>>
>>>> =C2=A0hw/ide/via.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 57 +++++++++++++++++++++++++++++++++++------
>>>> =C2=A0hw/mips/mips_fulong2e.c |=C2=A0 2 +-
>>>> =C2=A0include/hw/ide.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
>>>> =C2=A03 files changed, 52 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>>> index 096de8dba0..44ecc2af29 100644
>>>> --- a/hw/ide/via.c
>>>> +++ b/hw/ide/via.c
>>>> @@ -1,9 +1,10 @@
>>>> =C2=A0/*
>>>> - * QEMU IDE Emulation: PCI VIA82C686B support.
>>>> + * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
>>>> =C2=A0 *
>>>> =C2=A0 * Copyright (c) 2003 Fabrice Bellard
>>>> =C2=A0 * Copyright (c) 2006 Openedhand Ltd.
>>>> =C2=A0 * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
>>>> + * Copyright (c) 2019-2020 BALATON Zoltan
>>>> =C2=A0 *
>>>> =C2=A0 * Permission is hereby granted, free of charge, to any person=
 obtaining a copy
>>>> =C2=A0 * of this software and associated documentation files (the "S=
oftware"), to deal
>>>> @@ -25,6 +26,8 @@
>>>> =C2=A0 */
>>>>
>>>> =C2=A0#include "qemu/osdep.h"
>>>> +#include "qemu/range.h"
>>>> +#include "hw/qdev-properties.h"
>>>> =C2=A0#include "hw/pci/pci.h"
>>>> =C2=A0#include "migration/vmstate.h"
>>>> =C2=A0#include "qemu/module.h"
>>>> @@ -111,14 +114,40 @@ static void via_ide_set_irq(void *opaque, int =
n, int level)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->config[0x70 + n =
* 8] &=3D ~0x80;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 level =3D (d->config[0x70] & 0x80) || (d->c=
onfig[0x78] & 0x80);
>>>> -=C2=A0=C2=A0=C2=A0 n =3D pci_get_byte(d->config + PCI_INTERRUPT_LIN=
E);
>>>> -=C2=A0=C2=A0=C2=A0 if (n) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_irq(isa_get_irq=
(NULL, n), level);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Some machines operate in "non 100% nativ=
e mode" where PCI_INTERRUPT_LINE
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * is not used but IDE always uses ISA IRQ =
14 and 15 even in native mode.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Some guest drivers expect this, often wi=
thout checking.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (!(pci_get_byte(d->config + PCI_CLASS_PROG) &=
 (n ? 4 : 1)) ||
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_IDE(d)->flags & BIT(=
PCI_IDE_LEGACY_IRQ)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_irq(isa_get_irq=
(NULL, (n ? 15 : 14)), level);
>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_irq(isa_get_irq=
(NULL, 14), level);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0}
>>>
>>> There's still the need to convert this to qdev gpio, but for now I'll=
 review the
>>> updated version of this patch (and provide an example once the rest o=
f the patchset
>>> is okay).
>>
>> There's no need to do that now. I think it only makes sense to do that=
 when the 686B
>> and VT8231 models are also qdevified (which I'll plan to do when clean=
ing up my
>> pegasos2 patches later) since that may change how this should be qdevi=
fied. But I
>> don't have time to fully do it now so don't even ask. This will have t=
o do for now as
>> it's not worse than it is already and does fix clients so I see no imm=
ediate need to
>> force more clean ups upon me.
>>
>>> This looks much closer to what I was expecting with the fixed IRQs, a=
nd in fact
>>> doesn't it make the feature bit requirement obsolete? The PCI_CLASS_P=
ROG bit is now
>>> the single source of truth as to whether native or legacy IRQs are us=
ed, and the code
>>> routes the IRQ accordingly.
>>
>> No, the feature bit is still needed to flag if this device should work=
 with 100%
>> native mode as on fulong2e or with forced legacy IRQ non-100% native m=
ode as on
>> pegasos2. In both cases PCI_CLASS_PROG is actually set to native mode =
(most of the
>> time, Linux fixes this up on pegasos2 for it's own convenience but oth=
er OSes don't
>> care about it but we still need to know to use legacy interrupts) so t=
he feature bit
>> is needed to know when to use legacy and when native interrupts.
>>
>> The hardcoded IRQ14 in native mode is also wrong, If you check VT8231 =
datasheet it
>> clearly says that the IRQ raised is selected by PCI_INTERRUPT_LINE so =
I think my
>> previous version was correct but this still works because we fixed PCI=
_INTERRUPT_LINE
>> to 14 so we know here it's 14 without looking at the config reg that y=
ou forbid me to
>> do. But due to coincidence it still works and matches your ideals abou=
t PCI specs
>> that I don't think apply for this device but I could not convince you =
about that so
>> if this is what it takes then so be it. As long as it works with clien=
ts I don't
>> care, we can always clean this up later.
>
> Actually I've just realised that the conversion to qdev solves all thes=
e issues,
> because qdev has the concept of connecting outputs to inputs. The way t=
o do this is
> to define the VIA(PCI)IDEState with an array of two name legacy IRQs (a=
s detailed in
> my previous email), plus the PCI IRQ.

This device (being part of an integrated southbridge chip) has no PCI IRQ=
=20
at all, stop talking about it, that only may apply to CMD646. Once you=20
accept this it may be easier to actually get to a solution. The via-ide=20
either drives the legacy interrupts in legacy mode and on pegasos2 always=
,=20
regardless of mode. Or in true native mode it drives one ISA interrupt fo=
r=20
both channels selected by PCI_INTERRUPT_LINE config reg. This is clear=20
from the VT8231 datasheet and my test with guests.

> Then all via_ide_set_irq() has to do is set each qdev gpio level accord=
ingly; if a
> board isn't interested in an IRQ it just doesn't wire it up. The final =
piece of the
> puzzle is what do we do in PCI native mode, but that is simple: always =
drive the
> legacy IRQs if there is no PCI IRQ connected.

How does the device code know if there's anything connected to the gpio i=
t=20
defines? I don't see your proposal would be simpler or even easier to=20
understand (aka cleaner) than what I've implemented. You'll need to=20
explain a bit more but I think the real solution is to model VT82C686B an=
d=20
VT8231 and not parts of it in qdev. We don't want to model the inside of=20
these chips.

Regards,
BALATON Zoltan
--3866299591-1009266962-1583865276=:30321--

