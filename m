Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C76C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 11:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0DE2070A
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 11:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0DE2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAXLg-0007Tw-0U
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 06:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAXL4-0006vm-FW
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 06:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1jAXL2-00010a-G1
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 06:09:50 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38054
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAXL2-0000tN-6A; Sat, 07 Mar 2020 06:09:48 -0500
Received: from host86-162-6-80.range86-162.btcentralplus.com ([86.162.6.80]
 helo=[192.168.1.65]) by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jAXLF-0006my-Dq; Sat, 07 Mar 2020 11:10:02 +0000
To: BALATON Zoltan <balaton@eik.bme.hu>
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
 <alpine.BSF.2.22.395.2003062306560.78331@zero.eik.bme.hu>
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
Message-ID: <26a04588-fdb0-a000-98be-2615ce89e2f0@ilande.co.uk>
Date: Sat, 7 Mar 2020 11:09:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003062306560.78331@zero.eik.bme.hu>
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

On 06/03/2020 22:59, BALATON Zoltan wrote:

>>>> I've done a quick grep of the source tree and AFAICT the only IDE controller that
>>>> tries to use the PCI_INTERRUPT_LINE register is via-ide, which means this should be
>>>> fairly easy. In short:
>>>>
>>>> 1) Add qemu_irq legacy_irqs[2] into PCIIDEState
>>>>
>>>> (You could argue that it should belong in a separate VIAIDEState, however quite a
>>>> few
>>>> of the BMDMA controllers in QEMU don't have their own device state and just use
>>>> PCIIDEState. And whilst via-ide is the only one that currently needs support for
>>>> legacy IRQs, I think it's good to put it there in case other controllers need it in
>>>> future)
>>>>
>>>> 2) Add via_ide_initfn() to hw/ide/via.c and add qdev_init_gpio_out_named() with a
>>>> name of "legacy-irq" to it
>>>
>>> I don't like this. This adds two via-ide specific data to to common PCI IDE code
>>> where it does not belong and subclassing it just for this also seems to be more
>>> changes than really needed. Reusing the existing CMD646 field and generalising it to
>>> allow implementation specific feature flags seems much less intrusive and not less
>>> clean than your proposal.
>> It's not VIA-specific though: the ISA legacy and PCI buses have different electrical
>> characteristics and so by definition their signals must be driven by separate
>> physical pins. Have a look at the CMD646 datasheet for example, and you will see that
>> separate pins exist for legacy and PCI native IRQs.
> 
> For CMD646 we only use PCI interrupt which is in PCIDevice. Its legacy mode and thus
> those pins are not modelled so not needed now.

Correct. It seems to me that having it there in PCIIDEState provides a convenient
place for all controllers that support legacy mode to store the IRQ in case someone
would like to add legacy support to the device at a later date.

If you really object to this then as I mentioned above, you'll need to add a
VIAIDEState or similar and have the legacy IRQs there for the qdev gpio connector.

> For via-ide we only use ISA interrupts
> because even if we don't model legacy mode, boards expect ISA interrupts also in
> native mode maybe because this controller is not a separate PCI device only found
> embedded in southbridge/superio chips where they connect to the also embedded ISA
> PICs so even in native mode it should raise one of the ISA IRQs.

I certainly agree with your analysis here, and that is borne out by the fact that you
are able to boot your OSs using your current hack with no PCI interrupts.

> My patch accesses
> ISA irqs with isa_get_irq() so no gpios and legacy irqs in PCIIDEState is neeeded and
> I don't see the need to introduce this complexity here.

This isn't complexity though, it is just normal qdev usage. In fact if you look at
isa_get_irq() it contains this large comment above the function itself:

/*
 * isa_get_irq() returns the corresponding qemu_irq entry for the i8259.
 *
 * This function is only for special cases such as the 'ferr', and
 * temporary use for normal devices until they are converted to qdev.
 */

It was a temporary hack to allow old devices to access the 8259 IRQs before devices
were converted to qdev. And via-ide is a qdev device, so that's how you need to wire
it up.

> Also newer PCI ATA and SATA
> controllers such as sii3112 do not have a legacy mode so I'd keep things related to
> that out of common PCI IDE code and model it instead in the controllers that have
> this as this does not seem to belong to PCI IDE.

Like I said above: if you really don't want to put the legacy IRQs there then you
need to create a VIAIDEState for the qdev gpio connector.

>>>> 3) Inline via_ide_init() into hw/mips/mips_fulong2e.c, changing pci_create_simple()
>>>> to pci_create() because the device shouldn't be realised immediately
>>>>
>>>> 4) In vt82c686b_southbridge_init use qdev_connect_gpio_out_named() to connect
>>>> legacy_irq[0] to 8259 IRQ 14 and legacy_irq[1] to 8259 IRQ 15, and then realise the
>>>> device
>>>
>>> How do I connect gpios to 8259 interrupts? That seems to be internal state of 8259
>>> that I'm not sure how to access cleanly from code instantiating it. Is this better
>>> than my patch? It seems it achieves the same via-ide specific behaviour just in a
>>> more complicated way and would still need the feature bit to know when to use
>>> legacy_irq[1].
>>
>> We know from the PCI specification that the existing code for via-ide is incorrect,
>> and given that none of the other IDE controllers in QEMU use PCI_INTERRUPT_LINE in
>> this way then both of these strongly suggest that current via-ide implementation is
>> wrong. Rather than add a hack on top of a hack then the simplest solution is to
>> physically wire the IRQ pin using qdev at the board level, as is done on real
>> hardware.
> 
> But it's not done that way on real hardware and via-ide is not a PCI device but all
> this is internal to the VT8231 chip, the PICs, via-ide and a lot of other things
> which are modelled in QEMU by reusing existing components but I think we don't want
> to model the internal of the chip down to the smallest detail.

That's not what I'm suggesting though.

> In via-ide's case the
> PCI_INTERRUPT_LINE is probably not used by the IDE controller function but is used by
> some other function of the southbridge chip that implements interrupt controller

What evidence do you have for this?

> but
> we don't have a separate model of that in QEMU so we can just emulate this function
> within via-ide which I think is OK as this IDE controller is part of these
> southbridges and not used anywhere else. This partly mixes IDE controller function
> and interrupt controller function but probably OK until we want to model this
> southbridge in more detail which could be done in later clean up patches. The piix
> model seems to do the same embedding a 8259 which even less belongs to an IDE
> controller and acceses irqs array directly.
> 
>> Looking at the code it seems that i8259_init() returns the PIC IRQ array so it should
>> just be a case of returning the nth entry and using that with
>> qdev_init_gpio_out_named().
>>
>>>> 5) Remove the PCI_INTERRUPT_LINE logic from via_ide_set_irq() and instead just do
>>>> qemu_set_irq() on legacy_irq[0] (in theory I guess it should be legacy_irq[n] but it
>>>> seems that both drives on MIPS and Pegasos both use IRQ 14).
>>>
>>> According to the 8231 datasheet in legacy mode (and on pegasos2's half-native mode)
>>> the interrupts should be 14 and 15 so legacy_irq[n] with your way but in 100% native
>>> mode (used on the fulong2e) it should be the one set in PCI_INTERRUPT_LINE. The 686B
>>> datasheet does not detail this but I believe it works the same. Since we currently
>>> fixed the native mode interrupt to 14 to work around pegasos2 firmware and QEMU PCI
>>> reset interactions using legacy_irq[0] might work but is not correct, the current way
>>> using PCI_INTERRUPT_LINE is better modelling what hardware does in my opinion.
>>
>> This is not correct though: please re-read my previous email which quotes from the
>> PCI specification itself that defines PCI_INTERRUPT_LINE has *no effect* upon the
>> device itself, and is merely advisory to the OS. Possibly the MIPS BIOS could be
>> placing a value other than 14 there, but if it does then that suggests the board IRQs
>> are physically wired differently which again should be handled at board level by qdev.
> 
> Correct or not or follows the spec or not this is how it works on real hardware and
> to get guests running we need to emulate this. 

This may be a separate issue. As you mentioned in your email most guest OSs on
Pegasos blindly ignore the PCI_INTERRUPT_LINE register since they know that the IRQs
are hardwired. However you may also be getting caught out by the bug that the current
implementation will try and use the PCI_INTERRUPT_LINE IRQ for routing which is
incorrect.

Both the 8231 and 636B datasheets mark PCI_INTERRUPT_LINE as read-only with a default
value of 0xe, so I believe that once you've done the qdev gpio part, keeping this
part of your patchset as a separate patch should fix this.

> Again, this controller is embedded in
> the 868B and 8231 southbridge chips so they may not completely confirm to PCI spec
> but their own datasheets. We can argue in how much detail do we want to model the
> internals of these chips (which we don't know for sure) but I think this patch is
> good enough for now and could be refined later or we likely won't be able to finish
> this before the freeze.
> 
> Another way to look at it is that this patch gets some guests running and does not
> break anything as far as I know so is there anything in it that's unacceptable now
> and needs to be changed for it to be merged? Unless you can propose a way to achieve
> the same in a simpler way now I think we could go with this and you can submit follow
> up patches to clean it up as you like later.

I don't know what else to say except other than what I have already said: both the
current via-ide IRQ implementation and the changes in your patchset are incorrect.

I've given you the outline of what you need to do to switch the device over to qdev
which agrees with the datasheet, the PCI specification, comments within the QEMU code
itself and the results of your experiments. The proposed change is also simple to
implement (less than an hour's work) using standard APIs.

At this time I don't see any point in continuing to repeat myself over and over
again: if you can make the qdev change and post an updated patchset then I'm happy to
review and continue this discussion, but otherwise I don't see any purpose in
continuing this thread.


ATB,

Mark.

