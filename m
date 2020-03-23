Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E4C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174B62070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174B62070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGT8i-00055D-8O
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGT84-0004aP-GG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGT83-0007aw-D2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:52:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jGT80-0007LF-9c; Mon, 23 Mar 2020 15:52:52 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9C297747DFB;
 Mon, 23 Mar 2020 20:52:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 71A027476D5; Mon, 23 Mar 2020 20:52:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6FB3C746381;
 Mon, 23 Mar 2020 20:52:48 +0100 (CET)
Date: Mon, 23 Mar 2020 20:52:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] hw/ide/sii3112: Use qdev gpio rather than
 qemu_allocate_irqs()
In-Reply-To: <5f30cd13-4573-ddad-8b89-4b6800c32a95@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003232036570.37714@zero.eik.bme.hu>
References: <20200323151715.29454-1-peter.maydell@linaro.org>
 <alpine.BSF.2.22.395.2003231801370.76703@zero.eik.bme.hu>
 <5f30cd13-4573-ddad-8b89-4b6800c32a95@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1695753553-1584993168=:37714"
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
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1695753553-1584993168=:37714
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2020, John Snow wrote:
> On 3/23/20 1:04 PM, BALATON Zoltan wrote:
>> On Mon, 23 Mar 2020, Peter Maydell wrote:
>>> Coverity points out (CID 1421984) that we are leaking the
>>> memory returned by qemu_allocate_irqs(). We can avoid this
>>> leak by switching to using qdev_init_gpio_in(); the base
>>> class finalize will free the irqs that this allocates under
>>> the hood.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> This is how the 'use qdev gpio' approach to fixing the leak looks.
>>> Disclaimer: I have only tested this with "make check", nothing more.
>>>
>>> hw/ide/sii3112.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
>>> index 06605d7af2b..2ae6f5d9df6 100644
>>> --- a/hw/ide/sii3112.c
>>> +++ b/hw/ide/sii3112.c
>>> @@ -251,8 +251,8 @@ static void sii3112_pci_realize(PCIDevice *dev,
>>> Error **errp)
>>> {
>>> =A0=A0=A0 SiI3112PCIState *d =3D SII3112_PCI(dev);
>>> =A0=A0=A0 PCIIDEState *s =3D PCI_IDE(dev);
>>> +=A0=A0=A0 DeviceState *ds =3D DEVICE(dev);
>>> =A0=A0=A0 MemoryRegion *mr;
>>> -=A0=A0=A0 qemu_irq *irq;
>>> =A0=A0=A0 int i;
>>>
>>> =A0=A0=A0 pci_config_set_interrupt_pin(dev->config, 1);
>>> @@ -280,10 +280,10 @@ static void sii3112_pci_realize(PCIDevice *dev,
>>> Error **errp)
>>> =A0=A0=A0 memory_region_init_alias(mr, OBJECT(d), "sii3112.bar4", &d-=
>mmio,
>>> 0, 16);
>>> =A0=A0=A0 pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, mr);
>>>
>>> -=A0=A0=A0 irq =3D qemu_allocate_irqs(sii3112_set_irq, d, 2);
>>> +=A0=A0=A0 qdev_init_gpio_in(ds, sii3112_set_irq, 2);
>>> =A0=A0=A0 for (i =3D 0; i < 2; i++) {
>>> =A0=A0=A0=A0=A0=A0=A0 ide_bus_new(&s->bus[i], sizeof(s->bus[i]), DEVI=
CE(dev), i, 1);
>>> -=A0=A0=A0=A0=A0=A0=A0 ide_init2(&s->bus[i], irq[i]);
>>> +=A0=A0=A0=A0=A0=A0=A0 ide_init2(&s->bus[i], qdev_get_gpio_in(ds, i))=
;
>>
>> Maybe we could just use DEVICE(dev) here and above as well just like i=
n
>> ide_bus_new above just to keep it consistent and avoid the confusion
>> caused by having dev, d, s and now also ds. DEVICE(dev) is short and
>> clear enough I think.
>>
>> Regards,
>> BALATON Zoltan
>>
>
> Reviewed-by: John Snow <jsnow@redhat.com>
>
>
> The named temporary is fine. We probably should be using a named
> temporary in the other locations, too.

Yes that's fine too if using cast more than once is less efficient. Could=
=20
you change the existing DEVICE(dev) also to ds when applying please?=20
Probably no need for a v2 for that.

> I will run my usual tests, but admit I don't really test the non-x86
> boards directly. Do you want to give a tested-by on this, if it matters
> to you? Otherwise, I'm fairly content to trust Peter's judgment here.

I've tried that AmigaOS still boots on sam460ex so:

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

The sii3112 should also work on x86 or other platforms with Linux's=20
sata_sil driver but only as a 2nd non-bootable controller because we don'=
t=20
have option ROM and BIOS probably has no driver. Apart from that it's a=20
common PCI SATA controller so likely a lot of guests have driver for it.

Regards,
BALATON Zoltan
--3866299591-1695753553-1584993168=:37714--

