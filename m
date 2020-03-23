Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A76C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C1B20409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C1B20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPDx-0000Yo-Vo
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGPDN-0008UP-Ti
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGPDM-0005bT-SA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:42:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:15593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jGPDH-0005XF-MQ; Mon, 23 Mar 2020 11:42:05 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AE4B1746381;
 Mon, 23 Mar 2020 16:42:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8874974637F; Mon, 23 Mar 2020 16:42:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 86B8C74637E;
 Mon, 23 Mar 2020 16:42:01 +0100 (CET)
Date: Mon, 23 Mar 2020 16:42:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] ide/sii3112: Avoid leaking irqs array
In-Reply-To: <9dd18e5b-d1f1-7c3b-428f-0e549616a9d6@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003231635490.61044@zero.eik.bme.hu>
References: <20200323143514.DB3B4747E04@zero.eik.bme.hu>
 <9dd18e5b-d1f1-7c3b-428f-0e549616a9d6@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1599095249-1584978121=:61044"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1599095249-1584978121=:61044
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/23/20 3:32 PM, BALATON Zoltan wrote:
>> Coverity CID 1421984 reports a leak in allocated irqs, this patch
>> attempts to plug that.
>>=20
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ide/sii3112.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
>> index 06605d7af2..c886916873 100644
>> --- a/hw/ide/sii3112.c
>> +++ b/hw/ide/sii3112.c
>> @@ -31,6 +31,7 @@ typedef struct SiI3112Regs {
>>   typedef struct SiI3112PCIState {
>>       PCIIDEState i;
>>       MemoryRegion mmio;
>> +    qemu_irq *irqs;
>>       SiI3112Regs regs[2];
>>   } SiI3112PCIState;
>>   @@ -252,7 +253,6 @@ static void sii3112_pci_realize(PCIDevice *dev, =
Error=20
>> **errp)
>>       SiI3112PCIState *d =3D SII3112_PCI(dev);
>>       PCIIDEState *s =3D PCI_IDE(dev);
>>       MemoryRegion *mr;
>> -    qemu_irq *irq;
>>       int i;
>>         pci_config_set_interrupt_pin(dev->config, 1);
>> @@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev, =
Error=20
>> **errp)
>>       memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d->mmio=
, 0,=20
>> 16);
>>       pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
>>   -    irq =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
>> +    d->irqs =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
>>       for (i =3D 0; i < 2; i++) {
>>           ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVICE(dev), i, 1=
);
>> -        ide_init2(&s->bus[i], irq[i]);
>> +        ide_init2(&s->bus[i], d->irqs[i]);
>>             bmdma_init(&s->bus[i], &s->bmdma[i], s);
>>           s->bmdma[i].bus =3D &s->bus[i];
>> @@ -291,6 +291,13 @@ static void sii3112_pci_realize(PCIDevice *dev, E=
rror=20
>> **errp)
>>       }
>>   }
>>   +static void sii3112_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    SiI3112PCIState *d =3D SII3112_PCI(dev);
>> +
>> +    qemu_free_irqs(d->irqs, 2);
>
> You can't do that without calling unrealize() on all the devices in eac=
h=20
> IDEBus.

What? Those devices are not created in this object so whoever adds them=20
later is supposed to free them before this object is unrelaized. Or is=20
ownership of those devices silently passed to the the controller when=20
adding devices? Anyway, Peter's patch is simpler and should also fix the=20
issue so this does not matter any more (other than maybe showing we might=
=20
also leak the devices if their ownership is not clear).

> Apparently there is no code available to do that. Maybe easier to not=20
> add any sii3112_unrealize(). Keeping a reference in the state should be=
=20
> enough to silent Coverity.

The idea was to fix the problem not to hide it from Coverity so if it=20
can't be fixed it's probably better to be reminded about it than hiding=20
it.

Regards,
BALATON Zoltan
--3866299591-1599095249-1584978121=:61044--

