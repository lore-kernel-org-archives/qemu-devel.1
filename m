Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23552C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE22B20873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE22B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOtJ-00010E-6I
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBOsW-0000QC-GP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBOsV-0002Jk-AR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:19:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:36659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBOsS-0002IT-RW; Mon, 09 Mar 2020 16:19:53 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E1D14746383;
 Mon,  9 Mar 2020 21:19:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 61F67746381; Mon,  9 Mar 2020 21:19:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6041774637D;
 Mon,  9 Mar 2020 21:19:51 +0100 (CET)
Date: Mon, 9 Mar 2020 21:19:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <e6a293bb-5019-9d2e-c694-2c0917bb0a35@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003092117370.94024@zero.eik.bme.hu>
References: <cover.1583714522.git.balaton@eik.bme.hu>
 <2acb7e522055bb9ac45586c1792edc7615ef3ae6.1583714522.git.balaton@eik.bme.hu>
 <e6a293bb-5019-9d2e-c694-2c0917bb0a35@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
>
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
>
> One other thing whilst I'm here: the above line is quite cryptic to read unless
> you're very familiar with the PCI IDE specifications. How about something like this
> towards the top of the function:
>
> int native = n ? pci_get_byte(d->config + PCI_CLASS_PROG) & 4 :
>                 pci_get_byte(d->config + PCI_CLASS_PROG) & 1;
>
> and change the if() accordingly:
>
> if (native) {
>   ...
> } else {
>   ...
> }
>
> With that you can could probably drop the comment since it's really obvious what the
> code is doing when reading it against the datasheet.

Too late, already sent v3, may consider later but the comment is actually 
for the line after the || not the one checking CLASS_PROG.

Regards,
BALATON Zoltan

