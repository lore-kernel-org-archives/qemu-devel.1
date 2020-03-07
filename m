Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0951FC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 15:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BA120674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 15:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BA120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAbpC-0004qU-0c
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 10:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jAboZ-0004KJ-R7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 10:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jAboX-0006To-2w
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 10:56:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:61249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jAboR-00066n-72; Sat, 07 Mar 2020 10:56:27 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5362374637D;
 Sat,  7 Mar 2020 16:56:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 00B3674637C; Sat,  7 Mar 2020 16:56:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F2C187461AE;
 Sat,  7 Mar 2020 16:56:14 +0100 (CET)
Date: Sat, 7 Mar 2020 16:56:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <26a04588-fdb0-a000-98be-2615ce89e2f0@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003071236410.55749@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
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
 <alpine.BSF.2.22.395.2003062306560.78331@zero.eik.bme.hu>
 <26a04588-fdb0-a000-98be-2615ce89e2f0@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Sat, 7 Mar 2020, Mark Cave-Ayland wrote:
> On 06/03/2020 22:59, BALATON Zoltan wrote:
>>>>> I've done a quick grep of the source tree and AFAICT the only IDE controller that
>>>>> tries to use the PCI_INTERRUPT_LINE register is via-ide, which means this should be
>>>>> fairly easy. In short:
>>>>>
>>>>> 1) Add qemu_irq legacy_irqs[2] into PCIIDEState
>>>>>
>>>>> (You could argue that it should belong in a separate VIAIDEState, however quite a
>>>>> few
>>>>> of the BMDMA controllers in QEMU don't have their own device state and just use
>>>>> PCIIDEState. And whilst via-ide is the only one that currently needs support for
>>>>> legacy IRQs, I think it's good to put it there in case other controllers need it in
>>>>> future)
>>>>>
>>>>> 2) Add via_ide_initfn() to hw/ide/via.c and add qdev_init_gpio_out_named() with a
>>>>> name of "legacy-irq" to it
>>>>
>>>> I don't like this. This adds two via-ide specific data to to common PCI IDE code
>>>> where it does not belong and subclassing it just for this also seems to be more
>>>> changes than really needed. Reusing the existing CMD646 field and generalising it to
>>>> allow implementation specific feature flags seems much less intrusive and not less
>>>> clean than your proposal.
>>> It's not VIA-specific though: the ISA legacy and PCI buses have different electrical
>>> characteristics and so by definition their signals must be driven by separate
>>> physical pins. Have a look at the CMD646 datasheet for example, and you will see that
>>> separate pins exist for legacy and PCI native IRQs.
>>
>> For CMD646 we only use PCI interrupt which is in PCIDevice. Its legacy mode and thus
>> those pins are not modelled so not needed now.
>
> Correct. It seems to me that having it there in PCIIDEState provides a convenient
> place for all controllers that support legacy mode to store the IRQ in case someone
> would like to add legacy support to the device at a later date.

Why introduce it now and not only when someone would like to add legacy 
mode? I guess nobody needs legacy mode so we can avoid complexity 
modelling that unused detail now and only add it when needed.

> If you really object to this then as I mentioned above, you'll need to add a
> VIAIDEState or similar and have the legacy IRQs there for the qdev gpio connector.
>
>> For via-ide we only use ISA interrupts
>> because even if we don't model legacy mode, boards expect ISA interrupts also in
>> native mode maybe because this controller is not a separate PCI device only found
>> embedded in southbridge/superio chips where they connect to the also embedded ISA
>> PICs so even in native mode it should raise one of the ISA IRQs.
>
> I certainly agree with your analysis here, and that is borne out by the fact that you
> are able to boot your OSs using your current hack with no PCI interrupts.
>
>> My patch accesses
>> ISA irqs with isa_get_irq() so no gpios and legacy irqs in PCIIDEState is neeeded and
>> I don't see the need to introduce this complexity here.
>
> This isn't complexity though, it is just normal qdev usage. In fact if you look at

Then qdev is probably overly complex for simple things.

> isa_get_irq() it contains this large comment above the function itself:
>
> /*
> * isa_get_irq() returns the corresponding qemu_irq entry for the i8259.
> *
> * This function is only for special cases such as the 'ferr', and
> * temporary use for normal devices until they are converted to qdev.
> */
>
> It was a temporary hack to allow old devices to access the 8259 IRQs before devices
> were converted to qdev. And via-ide is a qdev device, so that's how you need to wire
> it up.
>
>> Also newer PCI ATA and SATA
>> controllers such as sii3112 do not have a legacy mode so I'd keep things related to
>> that out of common PCI IDE code and model it instead in the controllers that have
>> this as this does not seem to belong to PCI IDE.
>
> Like I said above: if you really don't want to put the legacy IRQs there then you
> need to create a VIAIDEState for the qdev gpio connector.

I still think what you propose is more complex than my patch and does not 
achieve any cleaner model. If you object to using isa_get_irq here I can 
go the piix way and embed the PIC array as well (or set a pointer to that 
with a property somehow) so I can use isa_irq[n] rather than adding 
non-existing pins for this. I won't do anything though until IDE and QEMU 
maintainers indicate what their preference is.

>>>>> 3) Inline via_ide_init() into hw/mips/mips_fulong2e.c, changing pci_create_simple()
>>>>> to pci_create() because the device shouldn't be realised immediately
>>>>>
>>>>> 4) In vt82c686b_southbridge_init use qdev_connect_gpio_out_named() to connect
>>>>> legacy_irq[0] to 8259 IRQ 14 and legacy_irq[1] to 8259 IRQ 15, and then realise the
>>>>> device
>>>>
>>>> How do I connect gpios to 8259 interrupts? That seems to be internal state of 8259
>>>> that I'm not sure how to access cleanly from code instantiating it. Is this better
>>>> than my patch? It seems it achieves the same via-ide specific behaviour just in a
>>>> more complicated way and would still need the feature bit to know when to use
>>>> legacy_irq[1].
>>>
>>> We know from the PCI specification that the existing code for via-ide is incorrect,
>>> and given that none of the other IDE controllers in QEMU use PCI_INTERRUPT_LINE in
>>> this way then both of these strongly suggest that current via-ide implementation is
>>> wrong. Rather than add a hack on top of a hack then the simplest solution is to
>>> physically wire the IRQ pin using qdev at the board level, as is done on real
>>> hardware.
>>
>> But it's not done that way on real hardware and via-ide is not a PCI device but all
>> this is internal to the VT8231 chip, the PICs, via-ide and a lot of other things
>> which are modelled in QEMU by reusing existing components but I think we don't want
>> to model the internal of the chip down to the smallest detail.
>
> That's not what I'm suggesting though.

I think you did not like emulating the interrupt selection in via-ide that 
decides which irq to raise (which is really just one if() ) and would like 
to push it out to board code instead connecting it via gpios. But that's 
also not quite correct and would not even get rid of the feature bit you 
also disliked. In fact we don't actually have a qdev model for the 
VT82C686B where all this probably belongs but I don't plan to make a 
detailed qdevified model for that now (could be done later in a clean up 
patch maybe when I'll clean up pegasos2 patches for inclusion) and since 
via-ide is considered part of that southbridge (and reused in similar 
VT8231 model) we can include the interrupt controller emulation (this one 
if() ) as well for now and not worry about PCI specs that don't really 
apply to a "chip" that's not a standalone PCI IDE controller but part of a 
bigger southbridge chip. It's just reuses PCI IDE emulation from QEMU 
where appropriate.

>> In via-ide's case the
>> PCI_INTERRUPT_LINE is probably not used by the IDE controller function but is used by
>> some other function of the southbridge chip that implements interrupt controller
>
> What evidence do you have for this?

The datasheet (of the IDE function) says that PCI_INTERRUPT_LINE selects 
the ISA interrupt that's raised in native mode for both channels and 
guests work if we emulate that. Since via-ide is part of the southbridge 
that also includes the PICs they are somehow connected inside and 
something selects the interrupt line within the chip but I don't know how 
exactly that's implemented in hardware. If not the ide part directly as 
you propose then some other interrupt controller part has to do this and 
we need to do the same somewhere in our model. Since we don't emulate the 
southbridge in more detail I've just put it in via-ide which seems to be a 
good place as it's only used in these southbridges and this could be 
changed later if via-ide were used elsewhere. No need to be more complex 
now than that I think.

>> but
>> we don't have a separate model of that in QEMU so we can just emulate this function
>> within via-ide which I think is OK as this IDE controller is part of these
>> southbridges and not used anywhere else. This partly mixes IDE controller function
>> and interrupt controller function but probably OK until we want to model this
>> southbridge in more detail which could be done in later clean up patches. The piix
>> model seems to do the same embedding a 8259 which even less belongs to an IDE
>> controller and acceses irqs array directly.
>>
>>> Looking at the code it seems that i8259_init() returns the PIC IRQ array so it should
>>> just be a case of returning the nth entry and using that with
>>> qdev_init_gpio_out_named().
>>>
>>>>> 5) Remove the PCI_INTERRUPT_LINE logic from via_ide_set_irq() and instead just do
>>>>> qemu_set_irq() on legacy_irq[0] (in theory I guess it should be legacy_irq[n] but it
>>>>> seems that both drives on MIPS and Pegasos both use IRQ 14).
>>>>
>>>> According to the 8231 datasheet in legacy mode (and on pegasos2's half-native mode)
>>>> the interrupts should be 14 and 15 so legacy_irq[n] with your way but in 100% native
>>>> mode (used on the fulong2e) it should be the one set in PCI_INTERRUPT_LINE. The 686B
>>>> datasheet does not detail this but I believe it works the same. Since we currently
>>>> fixed the native mode interrupt to 14 to work around pegasos2 firmware and QEMU PCI
>>>> reset interactions using legacy_irq[0] might work but is not correct, the current way
>>>> using PCI_INTERRUPT_LINE is better modelling what hardware does in my opinion.
>>>
>>> This is not correct though: please re-read my previous email which quotes from the
>>> PCI specification itself that defines PCI_INTERRUPT_LINE has *no effect* upon the
>>> device itself, and is merely advisory to the OS. Possibly the MIPS BIOS could be
>>> placing a value other than 14 there, but if it does then that suggests the board IRQs
>>> are physically wired differently which again should be handled at board level by qdev.
>>
>> Correct or not or follows the spec or not this is how it works on real hardware and
>> to get guests running we need to emulate this.
>
> This may be a separate issue. As you mentioned in your email most guest OSs on
> Pegasos blindly ignore the PCI_INTERRUPT_LINE register since they know that the IRQs
> are hardwired. However you may also be getting caught out by the bug that the current
> implementation will try and use the PCI_INTERRUPT_LINE IRQ for routing which is
> incorrect.

It's not incorrect. It follows what the datasheet says at least for 
VT8231, the 686B does not detail this but the Linux driver also works on 
fulong2e with this so I think it's correct for that as well.

> Both the 8231 and 636B datasheets mark PCI_INTERRUPT_LINE as read-only with a default
> value of 0xe, so I believe that once you've done the qdev gpio part, keeping this
> part of your patchset as a separate patch should fix this.

I don't get this. My patch emulates that already, what do you want to be 
changed here?

>> Again, this controller is embedded in
>> the 868B and 8231 southbridge chips so they may not completely confirm to PCI spec
>> but their own datasheets. We can argue in how much detail do we want to model the
>> internals of these chips (which we don't know for sure) but I think this patch is
>> good enough for now and could be refined later or we likely won't be able to finish
>> this before the freeze.
>>
>> Another way to look at it is that this patch gets some guests running and does not
>> break anything as far as I know so is there anything in it that's unacceptable now
>> and needs to be changed for it to be merged? Unless you can propose a way to achieve
>> the same in a simpler way now I think we could go with this and you can submit follow
>> up patches to clean it up as you like later.
>
> I don't know what else to say except other than what I have already said: both the
> current via-ide IRQ implementation and the changes in your patchset are incorrect.

Why do you think so? You base this on PCI docs but those don't necessarily 
apply to via-ide which is not a standalone PCI device but embedded in 
integrated southbridges whose datasheets say what I've implemented and 
guests are happy with that. So I don't think it's incorrect maybe just not 
to your taste.

> I've given you the outline of what you need to do to switch the device over to qdev
> which agrees with the datasheet, the PCI specification, comments within the QEMU code
> itself and the results of your experiments. The proposed change is also simple to
> implement (less than an hour's work) using standard APIs.

Then please do that and submit alternative patches. I don't understand all 
of your proposals so it's easier if you can do it in less than an hour. It 
would probably take me more time. I'll test them with the clients if you 
provide patches or I've pushed my working version now to

https://osdn.net/projects/qmiga/scm/git/qemu/tree/pegasos2/

so you can try as well.

> At this time I don't see any point in continuing to repeat myself over and over
> again: if you can make the qdev change and post an updated patchset then I'm happy to
> review and continue this discussion, but otherwise I don't see any purpose in
> continuing this thread.

I also think we're not getting anywhere so I hope John and Peter can give 
some advice here what is needed to get these patches merged. I've run out 
of time for now so I won't have time to make extensive changes to these 
patches and can only make reasonable changes or test what you provide.

You seem to want to force me again to qdevify everything now which I don't 
have time for. You did the same to my OpenBIOS patches too where you 
wanted me to clean up PCI code and implement handling of multiple PCI 
buses when I just wanted to include a simple workaround to get MorphOS 
running until the bigger clean up is eventually done. Even though some 
years have passed you did still not come around to do the OpenBIOS PCI 
clean up but also not accepted my workaround in the meantime so I need to 
use patched OpenBIOS for MorphOS ever since. I think we'd end up in the 
same situation with these patches. (It would be OK if OpenBIOS were 
otherwise very clean but it's full of other workarounds like patching 
device tree and installing QEMU VGA driver to any VGA card it sees and 
others that are much worse than what I've proposed and you don't seem to 
mind those which come from you just those that someone else propose.) 
Don't get this wrong, we don't have any personal problem with each other, 
at least I don't have anything against you but your habit of forcing 
people to do much more additional work just to satisfy your pedantry is 
not something I have time to comply with. If you propose changes that make 
the patches simpler or in some way better I'd do that but otherwise I'll 
only do what QEMU maintainers also think is necessary.

Regards,
BALATON Zoltan

