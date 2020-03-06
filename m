Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BD1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1A0206E2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 18:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1A0206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAHwj-0007m6-TU
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 13:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAHvz-0006q3-Rz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAHvy-0006kL-Gs
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 13:42:55 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:36754
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAHvy-0006i8-AL; Fri, 06 Mar 2020 13:42:54 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAHwD-0003HG-67; Fri, 06 Mar 2020 18:43:09 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011731130.95594@zero.eik.bme.hu>
 <57ff6676-5054-d3f6-f4fc-6ff02b09019f@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011902490.28669@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2003011951370.28669@zero.eik.bme.hu>
 <38cb0f83-79fc-7021-38fc-c1e28c3c0fa0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003012202330.79908@zero.eik.bme.hu>
 <9ce6d135-4169-96ae-c457-1131b4510c49@ilande.co.uk>
 <alpine.BSF.2.22.395.2003022145430.47473@zero.eik.bme.hu>
 <2a39ccab-e4d4-8172-9a1d-0bc089e0104c@ilande.co.uk>
 <alpine.BSF.2.22.395.2003032356230.41934@zero.eik.bme.hu>
 <a579c016-fd6c-ad4f-c091-2286265c9a57@ilande.co.uk>
 <alpine.BSF.2.22.395.2003042227190.70853@zero.eik.bme.hu>
 <b3bce0d3-3ab3-7fb3-ed3c-60f1f19159d6@ilande.co.uk>
 <alpine.BSF.2.22.395.2003060007040.48868@zero.eik.bme.hu>
 <071fff0a-e922-502d-da18-2572f73cecdf@ilande.co.uk>
 <alpine.BSF.2.22.395.2003061221220.10004@zero.eik.bme.hu>
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
Message-ID: <bb74c3a0-7d58-11d8-2558-d24057383d0e@ilande.co.uk>
Date: Fri, 6 Mar 2020 18:42:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003061221220.10004@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.162.6.80
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/2020 12:06, BALATON Zoltan wrote:

> On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
>> On 05/03/2020 23:35, BALATON Zoltan wrote:
>>> On real hardware this may be true but in QEMU how would it otherwise raise the
>>> correct interrupt line the guest expects? This probably does not matter for pegasos2
>>> but I think is needed for 100% native mode used with the fulong2e so it gets the IRQ
>>> it expects.
>>
>> That's easy - remember that both the PCI and IRQ interrupts are separate pins on the
>> chip, so all that needs to be done is expose the legacy IRQ via qdev and use that to
>> wire it up to your interrupt controller.
> 
> This "chip" is part of an integrated southbridge/superio/everything chip the also
> includes the two PICs and how they are internally connected is not known so we would
> be guessing here anyway. I don't see a need to make it more complicated than it is
> now by modeling internal pins but how would I wire up gpio to the i8259 model and
> where should I connect the PCI irq?

For now I would say not to worry about the PCI IRQ: the reason for discussing this
before was because we believed that if the controller was in native mode it must be
using the IRQ in PCI_INTERRUPT_LINE. But from yesterday's read of the specification
we know that PCI_INTERRUPT_LINE is never used by the device itself, and so given that
the existing via-ide device doesn't currently attempt to use the PCI IRQ in
via_ide_set_irq() then we should be good.

If someone had a machine somewhere that did use the PCI IRQ then it would need
investigation, but since there isn't then I don't see any need to do this now.

>> Okay so this is interesting: I've been switching between the VT8231 and the VT82C686B
>> datasheets, and there is a difference here. You are correct in what you say above in
>> that the 8231 docs specify that this is set to 1, but on the 686B this is clearly not
>> the case.
> 
> The 82C686B says this reg can be 0 or 1, where 0 is legacy interrupt routing and 1 is
> native mode. Given that we only model native mode of the chip it does not make sense
> to set it to anything else than 1 and setting it to 0 confuses MorphOS and Linux on
> pegasos2 while setting it to 1 works with everything I've tried both on pegasos2 and
> fulong2e even if that may not completely match how it's implemented in hardware.
> 
>> What is rather unusual here is that both the 8231 and 686B have exactly the same
>> device and vendor ids, so I'm not sure how you'd distinguish between them?
> 
> Guests distinguish by looking at the parent device (function 0) which is the chip
> this IDE device is part of (on function 1).

Okay thanks, that's useful to know.

I've done a quick grep of the source tree and AFAICT the only IDE controller that
tries to use the PCI_INTERRUPT_LINE register is via-ide, which means this should be
fairly easy. In short:

1) Add qemu_irq legacy_irqs[2] into PCIIDEState

(You could argue that it should belong in a separate VIAIDEState, however quite a few
of the BMDMA controllers in QEMU don't have their own device state and just use
PCIIDEState. And whilst via-ide is the only one that currently needs support for
legacy IRQs, I think it's good to put it there in case other controllers need it in
future)

2) Add via_ide_initfn() to hw/ide/via.c and add qdev_init_gpio_out_named() with a
name of "legacy-irq" to it

3) Inline via_ide_init() into hw/mips/mips_fulong2e.c, changing pci_create_simple()
to pci_create() because the device shouldn't be realised immediately

4) In vt82c686b_southbridge_init use qdev_connect_gpio_out_named() to connect
legacy_irq[0] to 8259 IRQ 14 and legacy_irq[1] to 8259 IRQ 15, and then realise the
device

5) Remove the PCI_INTERRUPT_LINE logic from via_ide_set_irq() and instead just do
qemu_set_irq() on legacy_irq[0] (in theory I guess it should be legacy_irq[n] but it
seems that both drives on MIPS and Pegasos both use IRQ 14).


ATB,

Mark.

