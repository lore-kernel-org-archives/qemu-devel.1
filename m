Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC0DC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2602020873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2602020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOrs-00083I-7n
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBOrA-0007aS-6l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBOr8-0001aL-J8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:18:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:34428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBOqG-0000c7-9T; Mon, 09 Mar 2020 16:18:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1A9AC747DFE;
 Mon,  9 Mar 2020 21:17:34 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CB2D8747D5D; Mon,  9 Mar 2020 21:17:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9F18746383;
 Mon,  9 Mar 2020 21:17:33 +0100 (CET)
Date: Mon, 9 Mar 2020 21:17:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <c3c58b0b-71fb-e188-208e-3fbf479bb346@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003092048250.94024@zero.eik.bme.hu>
References: <cover.1583714522.git.balaton@eik.bme.hu>
 <2acb7e522055bb9ac45586c1792edc7615ef3ae6.1583714522.git.balaton@eik.bme.hu>
 <c3c58b0b-71fb-e188-208e-3fbf479bb346@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020, Mark Cave-Ayland wrote:
> On 09/03/2020 00:42, BALATON Zoltan wrote:
>> Some machines operate in "non 100% native mode" where interrupts are
>> fixed at legacy IDE interrupts and some guests expect this behaviour
>> without checking based on knowledge about hardware. Even Linux has
>> arch specific workarounds for this that are activated on such boards
>> so this needs to be emulated as well.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
>>
>>  hw/ide/via.c            | 57 +++++++++++++++++++++++++++++++++++------
>>  hw/mips/mips_fulong2e.c |  2 +-
>>  include/hw/ide.h        |  3 ++-
>>  3 files changed, 52 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>> index 096de8dba0..44ecc2af29 100644
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
>> @@ -111,14 +114,40 @@ static void via_ide_set_irq(void *opaque, int n, int level)
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
>
> There's still the need to convert this to qdev gpio, but for now I'll review the
> updated version of this patch (and provide an example once the rest of the patchset
> is okay).

There's no need to do that now. I think it only makes sense to do that 
when the 686B and VT8231 models are also qdevified (which I'll plan to do 
when cleaning up my pegasos2 patches later) since that may change how this 
should be qdevified. But I don't have time to fully do it now so don't 
even ask. This will have to do for now as it's not worse than it is 
already and does fix clients so I see no immediate need to force more 
clean ups upon me.

> This looks much closer to what I was expecting with the fixed IRQs, and in fact
> doesn't it make the feature bit requirement obsolete? The PCI_CLASS_PROG bit is now
> the single source of truth as to whether native or legacy IRQs are used, and the code
> routes the IRQ accordingly.

No, the feature bit is still needed to flag if this device should work 
with 100% native mode as on fulong2e or with forced legacy IRQ non-100% 
native mode as on pegasos2. In both cases PCI_CLASS_PROG is actually set 
to native mode (most of the time, Linux fixes this up on pegasos2 for it's 
own convenience but other OSes don't care about it but we still need to 
know to use legacy interrupts) so the feature bit is needed to know when 
to use legacy and when native interrupts.

The hardcoded IRQ14 in native mode is also wrong, If you check VT8231 
datasheet it clearly says that the IRQ raised is selected by 
PCI_INTERRUPT_LINE so I think my previous version was correct but this 
still works because we fixed PCI_INTERRUPT_LINE to 14 so we know here it's 
14 without looking at the config reg that you forbid me to do. But due to 
coincidence it still works and matches your ideals about PCI specs that I 
don't think apply for this device but I could not convince you about that 
so if this is what it takes then so be it. As long as it works with 
clients I don't care, we can always clean this up later.

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
> The comment here is interesting so I had a quick look at pci_do_device_reset() to see
> what is happening there, and to me it seems that the real bug is
> pci_do_device_reset() doesn't honour wmask for PCI_INTERRUPT_LINE. This is because
> normally the BIOS would write this value long after the PCI bus has been physically
> reset and since via-ide is the first device to hardwire a value here, this wouldn't
> have been needed up until now.
>
> Fortunately it seems that there is already precedent for this so does the following
> diff work?
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index e1ed6677e1..4ae0e0e90f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -302,8 +302,10 @@ static void pci_do_device_reset(PCIDevice *dev)
>     pci_word_test_and_clear_mask(dev->config + PCI_STATUS,
>                                  pci_get_word(dev->wmask + PCI_STATUS) |
>                                  pci_get_word(dev->w1cmask + PCI_STATUS));
> +    pci_word_test_and_clear_mask(dev->config + PCI_INTERRUPT_LINE,
> +                                 pci_get_word(dev->wmask + PCI_INTERRUPT_LINE) |
> +                                 pci_get_word(dev->w1cmask + PCI_INTERRUPT_LINE));
>     dev->config[PCI_CACHE_LINE_SIZE] = 0x0;
> -    dev->config[PCI_INTERRUPT_LINE] = 0x0;
>     for (r = 0; r < PCI_NUM_REGIONS; ++r) {
>         PCIIORegion *region = &dev->io_regions[r];
>         if (!region->size) {
>
> If this works, it will help simplify your patch even further.

This seems to work but originally I did not want to touch anything that 
could break other parts so I did not investigate this further. Thanks for 
the suggestion, I've added this patch in v3 and removed workaround from 
via-ide.

>>  static void via_ide_reset(DeviceState *dev)
>>  {
>>      PCIIDEState *d = PCI_IDE(dev);
>> @@ -169,7 +198,8 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>>
>>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
>>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>> -    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
>> +    dev->wmask[PCI_CLASS_PROG] = 5;
>
> Possibly a separate patch for PCI_CLASS_PROG change? Although with the latest version
> of the patchset is it even still needed?

I don't see a need to add another one line patch for this here unless 
someone authorative asks for that. This is needed to allow Linux on 
pegasos2 to use this reg to signal its driver that it should use legacy 
interrupts. That is, while everything else is using native mode and this 
reg should also say that the pegasos2 fixup function of Linux sets this 
reg to legacy mode so it knows later that legacy interrupts should be used 
on this board. Therefore we need to allow this change.

Regards,
BALATON Zoltan

