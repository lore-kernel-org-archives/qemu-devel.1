Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A0C3F2CE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 11:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA06420880
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 11:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA06420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8Mz8-0001WF-0H
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 06:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j8MyW-0000wl-6b
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 06:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1j8MyV-0004Iq-2f
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 06:41:36 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:52556
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j8MyS-0004HJ-PG; Sun, 01 Mar 2020 06:41:32 -0500
Received: from host86-135-55-139.range86-135.btcentralplus.com
 ([86.135.55.139] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1j8Mye-0007GP-VA; Sun, 01 Mar 2020 11:41:49 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <32bb2eab213344151ca342bab5db2cf8c2758fb7.1583017348.git.balaton@eik.bme.hu>
 <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
Date: Sun, 1 Mar 2020 11:41:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.135.55.139
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Cc: John Snow <jsnow@redhat.com>, philmd@redhat.com,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/03/2020 11:35, Mark Cave-Ayland wrote:
> On 29/02/2020 23:02, BALATON Zoltan wrote:
> 
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

The other part I'm not sure about is that I can't see how via_ide_set_irq() can ever
raise a native PCI IRQ - comparing with my experience on cmd646, should there not be
a pci_set_irq(d, level) at the end?


ATB,

Mark.

