Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86764C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 16:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5661D222C4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 16:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5661D222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8RWA-0002hf-Es
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 11:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8RUu-0001s7-Uz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 11:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8RUt-0006HC-77
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 11:31:20 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:48883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8RUo-0006Ep-BV; Sun, 01 Mar 2020 11:31:14 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B665D746381;
 Sun,  1 Mar 2020 17:31:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7718774637D; Sun,  1 Mar 2020 17:31:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7576D74569F;
 Sun,  1 Mar 2020 17:31:09 +0100 (CET)
Date: Sun, 1 Mar 2020 17:31:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003011627550.95594@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <32bb2eab213344151ca342bab5db2cf8c2758fb7.1583017348.git.balaton@eik.bme.hu>
 <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
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
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Mar 2020, Mark Cave-Ayland wrote:
> On 29/02/2020 23:02, BALATON Zoltan wrote:
>> Some machines operate in "non 100% native mode" where interrupts are
>> fixed at legacy IDE interrupts and some guests expect this behaviour
>> without checking based on knowledge about hardware. Even Linux has
>> arch specific workarounds for this that are activated on such boards
>> so this needs to be emulated as well.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ide/via.c            | 60 +++++++++++++++++++++++++++++++++++------
>>  hw/mips/mips_fulong2e.c |  2 +-
>>  include/hw/ide.h        |  3 ++-
>>  3 files changed, 55 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index 096de8dba0..17418c5822 100644
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
>> @@ -25,6 +26,8 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/range.h"
>> +#include "hw/qdev-properties.h"
>>  #include "hw/pci/pci.h"
>>  #include "migration/vmstate.h"
>>  #include "qemu/module.h"
>> @@ -111,14 +114,43 @@ static void via_ide_set_irq(void *opaque, int n, int level)
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
>> +        n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
>> +        if (n) {
>> +            qemu_set_irq(isa_get_irq(NULL, n), level);
>> +        }
>>      }
>>  }
>>
>> +static uint32_t via_ide_config_read(PCIDevice *d, uint32_t address, int len)
>> +{
>> +    /*
>> +     * The pegasos2 firmware writes to PCI_INTERRUPT_LINE but on real
>> +     * hardware it's fixed at 14 and won't change. Some guests also expect
>> +     * legacy interrupts, without reading PCI_INTERRUPT_LINE but Linux
>> +     * depends on this to read 14. We set it to 14 in the reset method and
>> +     * also set the wmask to 0 to emulate this but that turns out to be not
>> +     * enough. QEMU resets the PCI bus after this device and
>> +     * pci_do_device_reset() called from pci_device_reset() will zero
>> +     * PCI_INTERRUPT_LINE so this config_read function is to counter that and
>> +     * restore the correct value, otherwise this should not be needed.
>> +     */
>> +    if (range_covers_byte(address, len, PCI_INTERRUPT_LINE)) {
>> +        pci_set_byte(d->config + PCI_INTERRUPT_LINE, 14);
>> +    }
>> +    return pci_default_read_config(d, address, len);
>> +}
>
> This all seems quite strange: so what you're saying is that the VIA is programmed
> into PCI native mode, but at least on the Pegasos then it should still be generating
> interrupts on both the PCI bus and the compatibility IRQs?

In my understanding in this "non 100% native mode" IDE interrupts are 
using only legacy interrupts 14 and 15 even in native mode and PCI 
interrupts aren't used at all. Linux has this platform specific code:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/powerpc/platforms/chrp/pci.c?h=v4.14.172#n353

which says forcing legacy mode but that's not what actually happens. 
According to docs in legacy mode (which we don't emulate because we can't 
switch between legacy and native mode) apart from legacy interrupts the io 
adresses should also be fixed to legacy IDE ports but what I've seen from 
firmware and Amiga like OSes on pegasos2 they actually use the controller 
in "half-native" mode where the io addresses are set with the PCI BARs but 
the irq is still using 14 and 15. Even in true, 100% native mode a PCI 
interrupt does not seem to be used but instead the PCI_INTERRUPT_LINE 
config reg selects one of the ISA interrupts which is then used for both 
ide channels. On pegasos2 the firmware writes 9 to PCI_INTERRUPT_LINE and 
without this patch Linux detected that as 100% native mode using IRQ 9 for 
both channels and worked with that but MorphOS and AmigaOS don't check 
interrupt config reg and just expect interrupts on 14 and 15 despite using 
PCI BARs to map io and leaving the mode reg in native mode which the 
firmware also writes there. So this seems to be a kind of half-native mode 
in which PCI BARs map io registers but interrupts are locked to legacy 
interrupts and we need to emulate this for MorphOS and AmigaOS at least. 
Linux could work both ways if regs are set accordingly but when it says 
"forcing legacy mode" in above fixup func that just seems to activate 
other compatibility funcs in

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/ide/setup-pci.c?h=v4.14.172#n484

to know that legacy interrupts should be used instead of the one in config 
reg but PCI BARs are still mapped and io is accessed at those addresses 
which would not make sense in true legacy mode.

I've also got register dumps from a real Pegasos2 which shows 
PCI_INTERRUPT_LINE set to 14 after booting Linux even if firmware tries to 
change that to 9 so I think it's fixed on real hardware and guests work if 
we emulate that in this patch so I think this confirms this matches real 
hardware at least more or less.

This patch fixes interrupt line to 14 but that's not a problem at least 
for Linux or anything that checks the config reg contents, the only 
difference is that without legacy-irq set it will use IRQ 14 for both IDE 
channels that seems to work with the mips_fulong2e which is the only other 
board using via-ide.

All of the above is true for via-ide and the two boards we emulate, I 
don't know if this applies to CMD646 or that conroller and boards using it 
have different quirks. Also via-ide is part of a southbridge chip (or 
several similar southbridges) where connetctions within the chip to IRQs 
may be peculiar while CMD646 may be a more normal PCI device.

Regards,
BALATON Zoltan

>
>>  static void via_ide_reset(DeviceState *dev)
>>  {
>>      PCIIDEState *d = PCI_IDE(dev);
>> @@ -169,7 +201,8 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>>
>>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
>>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>> -    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
>> +    dev->wmask[PCI_CLASS_PROG] = 5;
>> +    dev->wmask[PCI_INTERRUPT_LINE] = 0;
>>
>>      memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_ops,
>>                            &d->bus[0], "via-ide0-data", 8);
>> @@ -213,14 +246,23 @@ static void via_ide_exitfn(PCIDevice *dev)
>>      }
>>  }
>>
>> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
>> +void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
>> +                  bool legacy_irq)
>>  {
>>      PCIDevice *dev;
>>
>> -    dev = pci_create_simple(bus, devfn, "via-ide");
>> +    dev = pci_create(bus, devfn, "via-ide");
>> +    qdev_prop_set_bit(&dev->qdev, "legacy-irq", legacy_irq);
>> +    qdev_init_nofail(&dev->qdev);
>>      pci_ide_create_devs(dev, hd_table);
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
>> @@ -229,10 +271,12 @@ static void via_ide_class_init(ObjectClass *klass, void *data)
>>      dc->reset = via_ide_reset;
>>      k->realize = via_ide_realize;
>>      k->exit = via_ide_exitfn;
>> +    k->config_read = via_ide_config_read;
>>      k->vendor_id = PCI_VENDOR_ID_VIA;
>>      k->device_id = PCI_DEVICE_ID_VIA_IDE;
>>      k->revision = 0x06;
>>      k->class_id = PCI_CLASS_STORAGE_IDE;
>> +    device_class_set_props(dc, via_ide_properties);
>>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>>  }
>>
>> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
>> index 4727b1d3a4..150182c62a 100644
>> --- a/hw/mips/mips_fulong2e.c
>> +++ b/hw/mips/mips_fulong2e.c
>> @@ -257,7 +257,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
>>      isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
>>
>>      ide_drive_get(hd, ARRAY_SIZE(hd));
>> -    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1));
>> +    via_ide_init(pci_bus, hd, PCI_DEVFN(slot, 1), false);
>>
>>      pci_create_simple(pci_bus, PCI_DEVFN(slot, 2), "vt82c686b-usb-uhci");
>>      pci_create_simple(pci_bus, PCI_DEVFN(slot, 3), "vt82c686b-usb-uhci");
>> diff --git a/include/hw/ide.h b/include/hw/ide.h
>> index d88c5ee695..2a7001ccba 100644
>> --- a/include/hw/ide.h
>> +++ b/include/hw/ide.h
>> @@ -18,7 +18,8 @@ PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>>  PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>>  PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>>  int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>> -void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>> +void via_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn,
>> +                  bool legacy_irq);
>>
>>  /* ide-mmio.c */
>>  void mmio_ide_init_drives(DeviceState *dev, DriveInfo *hd0, DriveInfo *hd1);
>
> ATB,
>
> Mark.
>
>

