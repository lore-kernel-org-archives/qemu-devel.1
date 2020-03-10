Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F27DC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C9A20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C9A20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjO2-00072V-3U
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jBjND-0006cO-0N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jBjNA-0006wr-2C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:12:58 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:45148
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jBjN9-0006lx-RX; Tue, 10 Mar 2020 14:12:56 -0400
Received: from host86-177-178-88.range86-177.btcentralplus.com
 ([86.177.178.88] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jBjNM-0004Mm-UQ; Tue, 10 Mar 2020 18:13:13 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <cover.1583714522.git.balaton@eik.bme.hu>
 <2acb7e522055bb9ac45586c1792edc7615ef3ae6.1583714522.git.balaton@eik.bme.hu>
 <c3c58b0b-71fb-e188-208e-3fbf479bb346@ilande.co.uk>
 <alpine.BSF.2.22.395.2003092048250.94024@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
Message-ID: <ae7962c6-8abc-633e-7b90-83f90038217f@ilande.co.uk>
Date: Tue, 10 Mar 2020 18:12:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003092048250.94024@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.177.178.88
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 2/2] via-ide: Also emulate non 100% native mode
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/03/2020 20:17, BALATON Zoltan wrote:

> On Mon, 9 Mar 2020, Mark Cave-Ayland wrote:
>> On 09/03/2020 00:42, BALATON Zoltan wrote:
>>> Some machines operate in "non 100% native mode" where interrupts are
>>> fixed at legacy IDE interrupts and some guests expect this behaviour
>>> without checking based on knowledge about hardware. Even Linux has
>>> arch specific workarounds for this that are activated on such boards
>>> so this needs to be emulated as well.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> v2: Don't use PCI_INTERRUPT_LINE in via_ide_set_irq()
>>>
>>>  hw/ide/via.c            | 57 +++++++++++++++++++++++++++++++++++------
>>>  hw/mips/mips_fulong2e.c |  2 +-
>>>  include/hw/ide.h        |  3 ++-
>>>  3 files changed, 52 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/ide/via.c b/hw/ide/via.c
>>> index 096de8dba0..44ecc2af29 100644
>>> --- a/hw/ide/via.c
>>> +++ b/hw/ide/via.c
>>> @@ -1,9 +1,10 @@
>>>  /*
>>> - * QEMU IDE Emulation: PCI VIA82C686B support.
>>> + * QEMU VIA southbridge IDE emulation (VT82C686B, VT8231)
>>>   *
>>>   * Copyright (c) 2003 Fabrice Bellard
>>>   * Copyright (c) 2006 Openedhand Ltd.
>>>   * Copyright (c) 2010 Huacai Chen <zltjiangshi@gmail.com>
>>> + * Copyright (c) 2019-2020 BALATON Zoltan
>>>   *
>>>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>>>   * of this software and associated documentation files (the "Software"), to deal
>>> @@ -25,6 +26,8 @@
>>>   */
>>>
>>>  #include "qemu/osdep.h"
>>> +#include "qemu/range.h"
>>> +#include "hw/qdev-properties.h"
>>>  #include "hw/pci/pci.h"
>>>  #include "migration/vmstate.h"
>>>  #include "qemu/module.h"
>>> @@ -111,14 +114,40 @@ static void via_ide_set_irq(void *opaque, int n, int level)
>>>      } else {
>>>          d->config[0x70 + n * 8] &= ~0x80;
>>>      }
>>> -
>>>      level = (d->config[0x70] & 0x80) || (d->config[0x78] & 0x80);
>>> -    n = pci_get_byte(d->config + PCI_INTERRUPT_LINE);
>>> -    if (n) {
>>> -        qemu_set_irq(isa_get_irq(NULL, n), level);
>>> +
>>> +    /*
>>> +     * Some machines operate in "non 100% native mode" where PCI_INTERRUPT_LINE
>>> +     * is not used but IDE always uses ISA IRQ 14 and 15 even in native mode.
>>> +     * Some guest drivers expect this, often without checking.
>>> +     */
>>> +    if (!(pci_get_byte(d->config + PCI_CLASS_PROG) & (n ? 4 : 1)) ||
>>> +        PCI_IDE(d)->flags & BIT(PCI_IDE_LEGACY_IRQ)) {
>>> +        qemu_set_irq(isa_get_irq(NULL, (n ? 15 : 14)), level);
>>> +    } else {
>>> +        qemu_set_irq(isa_get_irq(NULL, 14), level);
>>>      }
>>>  }
>>
>> There's still the need to convert this to qdev gpio, but for now I'll review the
>> updated version of this patch (and provide an example once the rest of the patchset
>> is okay).
> 
> There's no need to do that now. I think it only makes sense to do that when the 686B
> and VT8231 models are also qdevified (which I'll plan to do when cleaning up my
> pegasos2 patches later) since that may change how this should be qdevified. But I
> don't have time to fully do it now so don't even ask. This will have to do for now as
> it's not worse than it is already and does fix clients so I see no immediate need to
> force more clean ups upon me.
> 
>> This looks much closer to what I was expecting with the fixed IRQs, and in fact
>> doesn't it make the feature bit requirement obsolete? The PCI_CLASS_PROG bit is now
>> the single source of truth as to whether native or legacy IRQs are used, and the code
>> routes the IRQ accordingly.
> 
> No, the feature bit is still needed to flag if this device should work with 100%
> native mode as on fulong2e or with forced legacy IRQ non-100% native mode as on
> pegasos2. In both cases PCI_CLASS_PROG is actually set to native mode (most of the
> time, Linux fixes this up on pegasos2 for it's own convenience but other OSes don't
> care about it but we still need to know to use legacy interrupts) so the feature bit
> is needed to know when to use legacy and when native interrupts.
> 
> The hardcoded IRQ14 in native mode is also wrong, If you check VT8231 datasheet it
> clearly says that the IRQ raised is selected by PCI_INTERRUPT_LINE so I think my
> previous version was correct but this still works because we fixed PCI_INTERRUPT_LINE
> to 14 so we know here it's 14 without looking at the config reg that you forbid me to
> do. But due to coincidence it still works and matches your ideals about PCI specs
> that I don't think apply for this device but I could not convince you about that so
> if this is what it takes then so be it. As long as it works with clients I don't
> care, we can always clean this up later.

Actually I've just realised that the conversion to qdev solves all these issues,
because qdev has the concept of connecting outputs to inputs. The way to do this is
to define the VIA(PCI)IDEState with an array of two name legacy IRQs (as detailed in
my previous email), plus the PCI IRQ.

Then all via_ide_set_irq() has to do is set each qdev gpio level accordingly; if a
board isn't interested in an IRQ it just doesn't wire it up. The final piece of the
puzzle is what do we do in PCI native mode, but that is simple: always drive the
legacy IRQs if there is no PCI IRQ connected.

>>> +static uint32_t via_ide_config_read(PCIDevice *d, uint32_t address, int len)
>>> +{
>>> +    /*
>>> +     * The pegasos2 firmware writes to PCI_INTERRUPT_LINE but on real
>>> +     * hardware it's fixed at 14 and won't change. Some guests also expect
>>> +     * legacy interrupts, without reading PCI_INTERRUPT_LINE but Linux
>>> +     * depends on this to read 14. We set it to 14 in the reset method and
>>> +     * also set the wmask to 0 to emulate this but that turns out to be not
>>> +     * enough. QEMU resets the PCI bus after this device and
>>> +     * pci_do_device_reset() called from pci_device_reset() will zero
>>> +     * PCI_INTERRUPT_LINE so this config_read function is to counter that and
>>> +     * restore the correct value, otherwise this should not be needed.
>>> +     */
>>> +    if (range_covers_byte(address, len, PCI_INTERRUPT_LINE)) {
>>> +        pci_set_byte(d->config + PCI_INTERRUPT_LINE, 14);
>>> +    }
>>> +    return pci_default_read_config(d, address, len);
>>> +}
>>
>> The comment here is interesting so I had a quick look at pci_do_device_reset() to see
>> what is happening there, and to me it seems that the real bug is
>> pci_do_device_reset() doesn't honour wmask for PCI_INTERRUPT_LINE. This is because
>> normally the BIOS would write this value long after the PCI bus has been physically
>> reset and since via-ide is the first device to hardwire a value here, this wouldn't
>> have been needed up until now.
>>
>> Fortunately it seems that there is already precedent for this so does the following
>> diff work?
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index e1ed6677e1..4ae0e0e90f 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -302,8 +302,10 @@ static void pci_do_device_reset(PCIDevice *dev)
>>     pci_word_test_and_clear_mask(dev->config + PCI_STATUS,
>>                                  pci_get_word(dev->wmask + PCI_STATUS) |
>>                                  pci_get_word(dev->w1cmask + PCI_STATUS));
>> +    pci_word_test_and_clear_mask(dev->config + PCI_INTERRUPT_LINE,
>> +                                 pci_get_word(dev->wmask + PCI_INTERRUPT_LINE) |
>> +                                 pci_get_word(dev->w1cmask + PCI_INTERRUPT_LINE));
>>     dev->config[PCI_CACHE_LINE_SIZE] = 0x0;
>> -    dev->config[PCI_INTERRUPT_LINE] = 0x0;
>>     for (r = 0; r < PCI_NUM_REGIONS; ++r) {
>>         PCIIORegion *region = &dev->io_regions[r];
>>         if (!region->size) {
>>
>> If this works, it will help simplify your patch even further.
> 
> This seems to work but originally I did not want to touch anything that could break
> other parts so I did not investigate this further. Thanks for the suggestion, I've
> added this patch in v3 and removed workaround from via-ide.
> 
>>>  static void via_ide_reset(DeviceState *dev)
>>>  {
>>>      PCIIDEState *d = PCI_IDE(dev);
>>> @@ -169,7 +198,8 @@ static void via_ide_realize(PCIDevice *dev, Error **errp)
>>>
>>>      pci_config_set_prog_interface(pci_conf, 0x8f); /* native PCI ATA mode */
>>>      pci_set_long(pci_conf + PCI_CAPABILITY_LIST, 0x000000c0);
>>> -    dev->wmask[PCI_INTERRUPT_LINE] = 0xf;
>>> +    dev->wmask[PCI_CLASS_PROG] = 5;
>>
>> Possibly a separate patch for PCI_CLASS_PROG change? Although with the latest version
>> of the patchset is it even still needed?
> 
> I don't see a need to add another one line patch for this here unless someone
> authorative asks for that. This is needed to allow Linux on pegasos2 to use this reg
> to signal its driver that it should use legacy interrupts. That is, while everything
> else is using native mode and this reg should also say that the pegasos2 fixup
> function of Linux sets this reg to legacy mode so it knows later that legacy
> interrupts should be used on this board. Therefore we need to allow this change.


ATB,

Mark.

