Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F8C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C57206B1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 21:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C57206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC9GB-0004Ty-W2
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 17:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jC9FM-000412-LL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jC9FK-0004Qk-I5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 17:50:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:16884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jC9FG-0003lp-U5; Wed, 11 Mar 2020 17:50:31 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9756B747DF8;
 Wed, 11 Mar 2020 22:50:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 655A0747D5D; Wed, 11 Mar 2020 22:50:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 633E2746383;
 Wed, 11 Mar 2020 22:50:19 +0100 (CET)
Date: Wed, 11 Mar 2020 22:50:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v4 4/4] via-ide: Also emulate non 100% native mode
In-Reply-To: <b24001fe-0e20-cf05-6695-518e9972ac2d@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003112236040.44126@zero.eik.bme.hu>
References: <cover.1583867210.git.balaton@eik.bme.hu>
 <6b7af110e1576d6873777673b3e3fa01f4c9839e.1583867210.git.balaton@eik.bme.hu>
 <b24001fe-0e20-cf05-6695-518e9972ac2d@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Wed, 11 Mar 2020, Mark Cave-Ayland wrote:
> On 10/03/2020 19:06, BALATON Zoltan wrote:
>> Some machines operate in "non 100% native mode" where interrupts are
>> fixed at legacy IDE interrupts and some guests expect this behaviour
>> without checking based on knowledge about hardware. Even Linux has
>> arch specific workarounds for this that are activated on such boards
>> so this needs to be emulated as well.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>
>> Notes:
>>     v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
>>     v3: Patch pci.c instead of local workaround for PCI reset clearing
>>         PCI_INTERRUPT_PIN config reg
>>
>>  hw/ide/via.c | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index df0b352b58..1eada23097 100644
>> --- a/hw/ide/via.c
>> +++ b/hw/ide/via.c
>> @@ -1,9 +1,10 @@
>>  /*
>> - * QEMU IDE Emulation: PCI VIA82C686B support.
>> + * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
>>   *
>>   * Copyright (c) 2003 Fabrice Bellard
>>   * Copyright (c) 2006 Openedhand Ltd.
>>   * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
>> + * Copyright (c) 2019-2020 BALATON Zoltan
>>   *
>>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>>   * of this software and associated documentation files (the "Software"), to deal
>> @@ -25,6 +26,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "hw/qdev-properties.h"
>>  #include "hw/pci/pci.h"
>>  #include "migration/vmstate.h"
>>  #include "qemu/module.h"
>> @@ -111,11 +113,18 @@ static void via_ide_set_irq(void *opaque, int n, int level)
>>      } else {
>>          d->config[0x70 + n * 8] &= ~0x80;
>>      }
>> -
>>      level = (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
>> -    n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
>> -    if (n) {
>> -        qemu_set_irq(isa_get_irq(NULL, n), level);
>> +
>> +    /*
>> +     * Some machines operate in "non 100% native mode" where PCI_INTERRUPT_LINE
>> +     * is not used but IDE always uses ISA IRQ 14 and 15 even in native mode.
>> +     * Some guest drivers expect this, often without checking.
>> +     */
>> +    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||
>> +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
>> +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
>> +    } else {
>> +        qemu_set_irq(isa_get_irq(NULL, 14), level);
>>      }
>>  }
>>
>> @@ -169,7 +178,9 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>>
>>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
>>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>> -    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
>> +    /* Bits 0 and 4 of CLASS_PROG select native mode and are writable */
>> +    dev->wmask[PCI_CLASS_PROG] = 5;
>> +    dev->wmask[PCI_INTERRUPT_LINE] = 0;
>>
>>      memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_ops,
>>                            &d->bus[0], "via-ide0-data", 8);
>> @@ -213,6 +224,12 @@ static void via_ide_exitfn(PCIDevice *dev)
>>      }
>>  }
>>
>> +static Property via_ide_properties[] = {
>> +    DEFINE_PROP_BIT("legacy-irq", PCIIDEState, flags, PCI_IDE_LEGACY_IRQ,
>> +                    false),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>>  static void via_ide_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -225,6 +242,7 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>>      k->device_id = PCI_DEVICE_ID_VIA_IDE;
>>      k->revision = 0x06;
>>      k->class_id = PCI_CLASS_STORAGE_IDE;
>> +    device_class_set_props(dc, via_ide_properties);
>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>  }
>
> I don't think this (and adding the feature bit) are the right solution here. I'll do
> my best to look at the test cases you've sent off-list over the next couple of days
> and report back.

Thanks. No need to hurry as I don't have much free time for this now so 
maybe I'll come back to it when submitting pegasos2 patches. Until then if 
you can take at least the reviewed patches then we can revise the 
remaining ones when cleaning up VT82C686B and VT8231 models as that might 
be related to qdevifying this,

I don't see a way to avoid some property to tell the device that it should 
behave differently on pegasos2 than on fulong2e and using a feature bit 
for this seems to be the least hacky solution to me. Your proposed 
imaginary gpios seem more complex and likely not really match hardware so 
I don't think that would be less of a hack.

I've also tried using PCI_INTERRUPT_PIN config reg which at least the 686B 
datasheet said would switch to legacy IRQ routing but this did not work 
with Linux and MorphOS on pegasos2. We could also abuse another unused 
config reg value for this that clients don't care about but that wouldn't 
be any cleaner either.

Regards,
BALATON Zoltan

