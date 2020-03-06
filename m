Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DC3C10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 19:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37ECF20674
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 19:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37ECF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAIoG-0000YD-Dh
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 14:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jAInd-0008WN-TU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 14:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jAInc-0004PN-GT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 14:38:21 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:54909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jAInY-0004D2-JE; Fri, 06 Mar 2020 14:38:16 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BC04474637E;
 Fri,  6 Mar 2020 20:38:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8127274637C; Fri,  6 Mar 2020 20:38:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7EBC97461AE;
 Fri,  6 Mar 2020 20:38:12 +0100 (CET)
Date: Fri, 6 Mar 2020 20:38:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <bb74c3a0-7d58-11d8-2558-d24057383d0e@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003062008070.34226@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
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
 <bb74c3a0-7d58-11d8-2558-d24057383d0e@ilande.co.uk>
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

On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
> On 06/03/2020 12:06, BALATON Zoltan wrote:
>> On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
>>> On 05/03/2020 23:35, BALATON Zoltan wrote:
>>>> On real hardware this may be true but in QEMU how would it otherwise raise the
>>>> correct interrupt line the guest expects? This probably does not matter for pegasos2
>>>> but I think is needed for 100% native mode used with the fulong2e so it gets the IRQ
>>>> it expects.
>>>
>>> That's easy - remember that both the PCI and IRQ interrupts are separate pins on the
>>> chip, so all that needs to be done is expose the legacy IRQ via qdev and use that to
>>> wire it up to your interrupt controller.
>>
>> This "chip" is part of an integrated southbridge/superio/everything chip the also
>> includes the two PICs and how they are internally connected is not known so we would
>> be guessing here anyway. I don't see a need to make it more complicated than it is
>> now by modeling internal pins but how would I wire up gpio to the i8259 model and
>> where should I connect the PCI irq?
>
> For now I would say not to worry about the PCI IRQ: the reason for discussing this
> before was because we believed that if the controller was in native mode it must be
> using the IRQ in PCI_INTERRUPT_LINE. But from yesterday's read of the specification
> we know that PCI_INTERRUPT_LINE is never used by the device itself, and so given that
> the existing via-ide device doesn't currently attempt to use the PCI IRQ in
> via_ide_set_irq() then we should be good.
>
> If someone had a machine somewhere that did use the PCI IRQ then it would need
> investigation, but since there isn't then I don't see any need to do this now.
>
>>> Okay so this is interesting: I've been switching between the VT8231 and the VT82C686B
>>> datasheets, and there is a difference here. You are correct in what you say above in
>>> that the 8231 docs specify that this is set to 1, but on the 686B this is clearly not
>>> the case.
>>
>> The 82C686B says this reg can be 0 or 1, where 0 is legacy interrupt routing and 1 is
>> native mode. Given that we only model native mode of the chip it does not make sense
>> to set it to anything else than 1 and setting it to 0 confuses MorphOS and Linux on
>> pegasos2 while setting it to 1 works with everything I've tried both on pegasos2 and
>> fulong2e even if that may not completely match how it's implemented in hardware.
>>
>>> What is rather unusual here is that both the 8231 and 686B have exactly the same
>>> device and vendor ids, so I'm not sure how you'd distinguish between them?
>>
>> Guests distinguish by looking at the parent device (function 0) which is the chip
>> this IDE device is part of (on function 1).
>
> Okay thanks, that's useful to know.
>
> I've done a quick grep of the source tree and AFAICT the only IDE controller that
> tries to use the PCI_INTERRUPT_LINE register is via-ide, which means this should be
> fairly easy. In short:
>
> 1) Add qemu_irq legacy_irqs[2] into PCIIDEState
>
> (You could argue that it should belong in a separate VIAIDEState, however quite a few
> of the BMDMA controllers in QEMU don't have their own device state and just use
> PCIIDEState. And whilst via-ide is the only one that currently needs support for
> legacy IRQs, I think it's good to put it there in case other controllers need it in
> future)
>
> 2) Add via_ide_initfn() to hw/ide/via.c and add qdev_init_gpio_out_named() with a
> name of "legacy-irq" to it

I don't like this. This adds two via-ide specific data to to common PCI 
IDE code where it does not belong and subclassing it just for this also 
seems to be more changes than really needed. Reusing the existing CMD646 
field and generalising it to allow implementation specific feature flags 
seems much less intrusive and not less clean than your proposal.

> 3) Inline via_ide_init() into hw/mips/mips_fulong2e.c, changing pci_create_simple()
> to pci_create() because the device shouldn't be realised immediately
>
> 4) In vt82c686b_southbridge_init use qdev_connect_gpio_out_named() to connect
> legacy_irq[0] to 8259 IRQ 14 and legacy_irq[1] to 8259 IRQ 15, and then realise the
> device

How do I connect gpios to 8259 interrupts? That seems to be internal 
state of 8259 that I'm not sure how to access cleanly from code 
instantiating it. Is this better than my patch? It seems it achieves the 
same via-ide specific behaviour just in a more complicated way and would 
still need the feature bit to know when to use legacy_irq[1].

> 5) Remove the PCI_INTERRUPT_LINE logic from via_ide_set_irq() and instead just do
> qemu_set_irq() on legacy_irq[0] (in theory I guess it should be legacy_irq[n] but it
> seems that both drives on MIPS and Pegasos both use IRQ 14).

According to the 8231 datasheet in legacy mode (and on pegasos2's 
half-native mode) the interrupts should be 14 and 15 so legacy_irq[n] with 
your way but in 100% native mode (used on the fulong2e) it should be the 
one set in PCI_INTERRUPT_LINE. The 686B datasheet does not detail this but 
I believe it works the same. Since we currently fixed the native mode 
interrupt to 14 to work around pegasos2 firmware and QEMU PCI reset 
interactions using legacy_irq[0] might work but is not correct, the 
current way using PCI_INTERRUPT_LINE is better modelling what hardware 
does in my opinion.

Before I spend time modifying this patch I'd really like to hear what John 
as the IDE maintainer prefers for this. John could you chime in and share 
your views please?

Regards,
BALATON Zoltan

