Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F29C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 23:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829B8206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 23:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829B8206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jALxq-0001gB-JR
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 18:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jALwm-000148-S1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 18:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jALwk-0005vJ-UW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 18:00:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:62770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jALwc-0005A6-31; Fri, 06 Mar 2020 17:59:54 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CDD94746383;
 Fri,  6 Mar 2020 23:59:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 84D9C74637E; Fri,  6 Mar 2020 23:59:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 819167461AE;
 Fri,  6 Mar 2020 23:59:47 +0100 (CET)
Date: Fri, 6 Mar 2020 23:59:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <5380d048-8224-78a5-04b6-d946987fef08@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003062306560.78331@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
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
 <alpine.BSF.2.22.395.2003062008070.34226@zero.eik.bme.hu>
 <5380d048-8224-78a5-04b6-d946987fef08@ilande.co.uk>
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
> On 06/03/2020 19:38, BALATON Zoltan wrote:
>> On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
>>> On 06/03/2020 12:06, BALATON Zoltan wrote:
>>>> On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
>>>>> On 05/03/2020 23:35, BALATON Zoltan wrote:
>>>>>> On real hardware this may be true but in QEMU how would it otherwise raise the
>>>>>> correct interrupt line the guest expects? This probably does not matter for
>>>>>> pegasos2
>>>>>> but I think is needed for 100% native mode used with the fulong2e so it gets the
>>>>>> IRQ
>>>>>> it expects.
>>>>>
>>>>> That's easy - remember that both the PCI and IRQ interrupts are separate pins on the
>>>>> chip, so all that needs to be done is expose the legacy IRQ via qdev and use that to
>>>>> wire it up to your interrupt controller.
>>>>
>>>> This "chip" is part of an integrated southbridge/superio/everything chip the also
>>>> includes the two PICs and how they are internally connected is not known so we would
>>>> be guessing here anyway. I don't see a need to make it more complicated than it is
>>>> now by modeling internal pins but how would I wire up gpio to the i8259 model and
>>>> where should I connect the PCI irq?
>>>
>>> For now I would say not to worry about the PCI IRQ: the reason for discussing this
>>> before was because we believed that if the controller was in native mode it must be
>>> using the IRQ in PCI_INTERRUPT_LINE. But from yesterday's read of the specification
>>> we know that PCI_INTERRUPT_LINE is never used by the device itself, and so given that
>>> the existing via-ide device doesn't currently attempt to use the PCI IRQ in
>>> via_ide_set_irq() then we should be good.
>>>
>>> If someone had a machine somewhere that did use the PCI IRQ then it would need
>>> investigation, but since there isn't then I don't see any need to do this now.
>>>
>>>>> Okay so this is interesting: I've been switching between the VT8231 and the
>>>>> VT82C686B
>>>>> datasheets, and there is a difference here. You are correct in what you say above in
>>>>> that the 8231 docs specify that this is set to 1, but on the 686B this is clearly
>>>>> not
>>>>> the case.
>>>>
>>>> The 82C686B says this reg can be 0 or 1, where 0 is legacy interrupt routing and 1 is
>>>> native mode. Given that we only model native mode of the chip it does not make sense
>>>> to set it to anything else than 1 and setting it to 0 confuses MorphOS and Linux on
>>>> pegasos2 while setting it to 1 works with everything I've tried both on pegasos2 and
>>>> fulong2e even if that may not completely match how it's implemented in hardware.
>>>>
>>>>> What is rather unusual here is that both the 8231 and 686B have exactly the same
>>>>> device and vendor ids, so I'm not sure how you'd distinguish between them?
>>>>
>>>> Guests distinguish by looking at the parent device (function 0) which is the chip
>>>> this IDE device is part of (on function 1).
>>>
>>> Okay thanks, that's useful to know.
>>>
>>> I've done a quick grep of the source tree and AFAICT the only IDE controller that
>>> tries to use the PCI_INTERRUPT_LINE register is via-ide, which means this should be
>>> fairly easy. In short:
>>>
>>> 1) Add qemu_irq legacy_irqs[2] into PCIIDEState
>>>
>>> (You could argue that it should belong in a separate VIAIDEState, however quite a few
>>> of the BMDMA controllers in QEMU don't have their own device state and just use
>>> PCIIDEState. And whilst via-ide is the only one that currently needs support for
>>> legacy IRQs, I think it's good to put it there in case other controllers need it in
>>> future)
>>>
>>> 2) Add via_ide_initfn() to hw/ide/via.c and add qdev_init_gpio_out_named() with a
>>> name of "legacy-irq" to it
>>
>> I don't like this. This adds two via-ide specific data to to common PCI IDE code
>> where it does not belong and subclassing it just for this also seems to be more
>> changes than really needed. Reusing the existing CMD646 field and generalising it to
>> allow implementation specific feature flags seems much less intrusive and not less
>> clean than your proposal.
>
> It's not VIA-specific though: the ISA legacy and PCI buses have different electrical
> characteristics and so by definition their signals must be driven by separate
> physical pins. Have a look at the CMD646 datasheet for example, and you will see that
> separate pins exist for legacy and PCI native IRQs.

For CMD646 we only use PCI interrupt which is in PCIDevice. Its legacy 
mode and thus those pins are not modelled so not needed now. For via-ide 
we only use ISA interrupts because even if we don't model legacy mode, 
boards expect ISA interrupts also in native mode maybe because this 
controller is not a separate PCI device only found embedded in 
southbridge/superio chips where they connect to the also embedded ISA PICs 
so even in native mode it should raise one of the ISA IRQs. My patch 
accesses ISA irqs with isa_get_irq() so no gpios and legacy irqs in 
PCIIDEState is neeeded and I don't see the need to introduce this 
complexity here. Also newer PCI ATA and SATA controllers such as sii3112 
do not have a legacy mode so I'd keep things related to that out of common 
PCI IDE code and model it instead in the controllers that have this as 
this does not seem to belong to PCI IDE.

>>> 3) Inline via_ide_init() into hw/mips/mips_fulong2e.c, changing pci_create_simple()
>>> to pci_create() because the device shouldn't be realised immediately
>>>
>>> 4) In vt82c686b_southbridge_init use qdev_connect_gpio_out_named() to connect
>>> legacy_irq[0] to 8259 IRQ 14 and legacy_irq[1] to 8259 IRQ 15, and then realise the
>>> device
>>
>> How do I connect gpios to 8259 interrupts? That seems to be internal state of 8259
>> that I'm not sure how to access cleanly from code instantiating it. Is this better
>> than my patch? It seems it achieves the same via-ide specific behaviour just in a
>> more complicated way and would still need the feature bit to know when to use
>> legacy_irq[1].
>
> We know from the PCI specification that the existing code for via-ide is incorrect,
> and given that none of the other IDE controllers in QEMU use PCI_INTERRUPT_LINE in
> this way then both of these strongly suggest that current via-ide implementation is
> wrong. Rather than add a hack on top of a hack then the simplest solution is to
> physically wire the IRQ pin using qdev at the board level, as is done on real hardware.

But it's not done that way on real hardware and via-ide is not a PCI 
device but all this is internal to the VT8231 chip, the PICs, via-ide and 
a lot of other things which are modelled in QEMU by reusing existing 
components but I think we don't want to model the internal of the chip 
down to the smallest detail. In via-ide's case the PCI_INTERRUPT_LINE is 
probably not used by the IDE controller function but is used by some other 
function of the southbridge chip that implements interrupt controller but 
we don't have a separate model of that in QEMU so we can just emulate this 
function within via-ide which I think is OK as this IDE controller is part 
of these southbridges and not used anywhere else. This partly mixes IDE 
controller function and interrupt controller function but probably OK 
until we want to model this southbridge in more detail which could be done 
in later clean up patches. The piix model seems to do the same embedding a 
8259 which even less belongs to an IDE controller and acceses irqs array 
directly.

> Looking at the code it seems that i8259_init() returns the PIC IRQ array so it should
> just be a case of returning the nth entry and using that with qdev_init_gpio_out_named().
>
>>> 5) Remove the PCI_INTERRUPT_LINE logic from via_ide_set_irq() and instead just do
>>> qemu_set_irq() on legacy_irq[0] (in theory I guess it should be legacy_irq[n] but it
>>> seems that both drives on MIPS and Pegasos both use IRQ 14).
>>
>> According to the 8231 datasheet in legacy mode (and on pegasos2's half-native mode)
>> the interrupts should be 14 and 15 so legacy_irq[n] with your way but in 100% native
>> mode (used on the fulong2e) it should be the one set in PCI_INTERRUPT_LINE. The 686B
>> datasheet does not detail this but I believe it works the same. Since we currently
>> fixed the native mode interrupt to 14 to work around pegasos2 firmware and QEMU PCI
>> reset interactions using legacy_irq[0] might work but is not correct, the current way
>> using PCI_INTERRUPT_LINE is better modelling what hardware does in my opinion.
>
> This is not correct though: please re-read my previous email which quotes from the
> PCI specification itself that defines PCI_INTERRUPT_LINE has *no effect* upon the
> device itself, and is merely advisory to the OS. Possibly the MIPS BIOS could be
> placing a value other than 14 there, but if it does then that suggests the board IRQs
> are physically wired differently which again should be handled at board level by qdev.

Correct or not or follows the spec or not this is how it works on real 
hardware and to get guests running we need to emulate this. Again, this 
controller is embedded in the 868B and 8231 southbridge chips so they may 
not completely confirm to PCI spec but their own datasheets. We can argue 
in how much detail do we want to model the internals of these chips (which 
we don't know for sure) but I think this patch is good enough for now and 
could be refined later or we likely won't be able to finish this before 
the freeze.

Another way to look at it is that this patch gets some guests running and 
does not break anything as far as I know so is there anything in it that's 
unacceptable now and needs to be changed for it to be merged? Unless you 
can propose a way to achieve the same in a simpler way now I think we 
could go with this and you can submit follow up patches to clean it up as 
you like later.

Regards,
BALATON Zoltan

