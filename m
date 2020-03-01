Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9596AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 16:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6944521775
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 16:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6944521775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8Rgv-00073c-LB
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 11:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8RgA-0006Tf-GE
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 11:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8Rg9-0003gD-9M
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 11:42:58 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:11409)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8Rg6-0003dZ-Dg; Sun, 01 Mar 2020 11:42:54 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3F47474637E;
 Sun,  1 Mar 2020 17:42:52 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0BBBB74637D; Sun,  1 Mar 2020 17:42:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 081AB74569F;
 Sun,  1 Mar 2020 17:42:52 +0100 (CET)
Date: Sun, 1 Mar 2020 17:42:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003011731130.95594@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <32bb2eab213344151ca342bab5db2cf8c2758fb7.1583017348.git.balaton@eik.bme.hu>
 <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
 <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
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

On Sun, 1 Mar 2020, Mark Cave-Ayland wrote:
> On 01/03/2020 11:35, Mark Cave-Ayland wrote:
>> On 29/02/2020 23:02, BALATON Zoltan wrote:
>>
>>> Some machines operate in "non 100% native mode" where interrupts are
>>> fixed at legacy IDE interrupts and some guests expect this behaviour
>>> without checking based on knowledge about hardware. Even Linux has
>>> arch specific workarounds for this that are activated on such boards
>>> so this needs to be emulated as well.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  hw/ide/via.c            | 60 +++++++++++++++++++++++++++++++++++------
>>>  hw/mips/mips_fulong2e.c |  2 +-
>>>  include/hw/ide.h        |  3 ++-
>>>  3 files changed, 55 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>> index 096de8dba0..17418c5822 100644
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
>>>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>>>   * of this software and associated documentation files (the "Software"), to deal
>>> @@ -25,6 +26,8 @@
>>>   */
>>>
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/range.h"
>>> +#include "hw/qdev-properties.h"
>>>  #include "hw/pci/pci.h"
>>>  #include "migration/vmstate.h"
>>>  #include "qemu/module.h"
>>> @@ -111,14 +114,43 @@ static void via_ide_set_irq(void *opaque, int n, int level)
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
>>> +     * Some machines operate in "non 100% native mode" where PCI_INTERRUPT_LINE
>>> +     * is not used but IDE always uses ISA IRQ 14 and 15 even in native mode.
>>> +     * Some guest drivers expect this, often without checking.
>>> +     */
>>> +    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||
>>> +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
>>> +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
>>> +    } else {
>>> +        n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
>>> +        if (n) {
>>> +            qemu_set_irq(isa_get_irq(NULL, n), level);
>>> +        }
>>>      }
>>>  }
>
> The other part I'm not sure about is that I can't see how via_ide_set_irq() can ever
> raise a native PCI IRQ - comparing with my experience on cmd646, should there not be
> a pci_set_irq(d, level) at the end?

According to my tests with several guests it seems the via-ide does not 
seem to use PCI interrupts as described in the previous reply, only either 
legacy IRQ14 and 15 or one ISA IRQ line set by a config reg in native mode 
(except on Pegasos2). This may be due to how it's internally connected in 
the southbridge chip it's part of or some other platform specific quirk, 
I'm not sure.

The CMD646 may be a more conformant PCI device and use PCI interrupts 
(unless that also has some kind of legacy mode and similar interconnection 
with ISA interrupts). If it's really using PCI interrupt and Solaris still 
does not get expexted IRQ then maybe the routing is not matching real 
hardware somehow? Maybe it would help finding out what interrupt the 
Solaris driver is checking to find out why it misses the IRQ.

Regards,
BALATON Zoltan

