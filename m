Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD9C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AB42146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AB42146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBPcp-0007Rr-Oj
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 17:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBPc2-0006XC-Th
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBPc1-00021E-GS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 17:06:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:25618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBPbx-0001x4-W8; Mon, 09 Mar 2020 17:06:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ABF6D747DFD;
 Mon,  9 Mar 2020 22:06:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7E552747DFA; Mon,  9 Mar 2020 22:06:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7CB9A747DCF;
 Mon,  9 Mar 2020 22:06:51 +0100 (CET)
Date: Mon, 9 Mar 2020 22:06:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 3/3] via-ide: Also emulate non 100% native mode
In-Reply-To: <alpine.BSF.2.22.395.2003092148350.94024@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2003092201120.94024@zero.eik.bme.hu>
References: <cover.1583781493.git.balaton@eik.bme.hu>
 <ac37e5f5b86a3b2680c01d7b0d027dafd27a3ac7.1583781494.git.balaton@eik.bme.hu>
 <20200309163537-mutt-send-email-mst@kernel.org>
 <alpine.BSF.2.22.395.2003092148350.94024@zero.eik.bme.hu>
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
Cc: qemu-block@nongnu.org, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020, BALATON Zoltan wrote:
> On Mon, 9 Mar 2020, Michael S. Tsirkin wrote:
>> On Mon, Mar 09, 2020 at 08:18:13PM +0100, BALATON Zoltan wrote:
>>> Some machines operate in "non 100% native mode" where interrupts are
>>> fixed at legacy IDE interrupts and some guests expect this behaviour
>>> without checking based on knowledge about hardware. Even Linux has
>>> arch specific workarounds for this that are activated on such boards
>>> so this needs to be emulated as well.
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
>>> v3: Patch pci.c instead of local workaround for PCI reset clearing
>>>     PCI_INTERRUPT_PIN config reg
>>>
>>>  hw/ide/via.c            | 37 +++++++++++++++++++++++++++++--------
>>>  hw/mips/mips_fulong2e.c |  2 +-
>>>  include/hw/ide.h        |  3 ++-
>>>  3 files changed, 32 insertions(+), 10 deletions(-)
>>> 
>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>> index 096de8dba0..02d29809f2 100644
>>> --- a/hw/ide/via.c
>>> +++ b/hw/ide/via.c
>>> @@ -1,9 +1,10 @@
>>>  /*
>>> - * QEMU IDE Emulation: PCI VIA82C686B support.
>>> + * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
>>>   *
>>>   * Copyright (c) 2003 Fabrice Bellard
>>>   * Copyright (c) 2006 Openedhand Ltd.
>>>   * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
>>> + * Copyright (c) 2019-2020 BALATON Zoltan
>>>   *
>>>   * Permission is hereby granted, free of charge, to any person obtaining 
>>> a copy
>>>   * of this software and associated documentation files (the "Software"), 
>>> to deal
>>> @@ -25,6 +26,8 @@
>>>   */
>>>
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/range.h"
>>> +#include "hw/qdev-properties.h"
>>>  #include "hw/pci/pci.h"
>>>  #include "migration/vmstate.h"
>>>  #include "qemu/module.h"
>>> @@ -111,11 +114,18 @@ static void via_ide_set_irq(void *opaque, int n, int 
>>> level)
>>>      } else {
>>>          d->config[0x70 + n * 8] &= ~0x80;
>>>      }
>>> -
>>>      level = (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
>>> -    n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
>>> -    if (n) {
>>> -        qemu_set_irq(isa_get_irq(NULL, n), level);
>>> +
>>> +    /*
>>> +     * Some machines operate in "non 100% native mode" where 
>>> PCI_INTERRUPT_LINE
>>> +     * is not used but IDE always uses ISA IRQ 14 and 15 even in native 
>>> mode.
>>> +     * Some guest drivers expect this, often without checking.
>>> +     */
>>> +    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||
>>> +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
>>> +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
>>> +    } else {
>>> +        qemu_set_irq(isa_get_irq(NULL, 14), level);
>>>      }
>>>  }
>>> 
>>> @@ -169,7 +179,8 @@ static void via_ide_realize(PCIDevice *dev, Error 
>>> **errp)
>>>
>>>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode 
>>> */
>>>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>>> -    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
>>> +    dev->wmask[PCI_CLASS_PROG] = 5;
>> 
>> What's the story here? Why is class suddenly writeable?
>
> The via-ide (function 1 of some VIA southbridge chips) use bits in this reg 
> to set legacy compatibility mode as described in VT82C686B and VT8231 
> datasheets and Linux writes this on pegasos2 board I'm emulating. See longer 
> description in this message:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg00019.html

And before we go through all previous discussions again I'd like to add 
that the comment in Linux fixup function saying that firmware sets 
conroller in legacy mode is wrong it does actually set it in native mode 
but on this hardware IRQs are hardcoded to legacy interrupts for some 
reason even in native mode. Most guest OSes just know this and expect that 
without looking at config regs but Linux uses this reg to force its driver 
to legacy mode despite using io addresses from PCI BARs which Linux calls 
non-100% native mode. This probably happens on some platforms but looks 
like pegasos2 will be the first in QEMU.

Regards,
BALATON Zoltan

