Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A7C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AEB20842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AEB20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cal-0001IX-PM
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j9cZs-0000po-UM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j9cZq-0006LW-Fs
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:33:20 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:38932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j9cZj-00064x-Ic; Wed, 04 Mar 2020 17:33:13 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 36AA7747E00;
 Wed,  4 Mar 2020 23:33:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E19D4747DF7; Wed,  4 Mar 2020 23:33:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DFCAA747DFF;
 Wed,  4 Mar 2020 23:33:08 +0100 (CET)
Date: Wed, 4 Mar 2020 23:33:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <a579c016-fd6c-ad4f-c091-2286265c9a57@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003042227190.70853@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <32bb2eab213344151ca342bab5db2cf8c2758fb7.1583017348.git.balaton@eik.bme.hu>
 <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
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
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Wed, 4 Mar 2020, Mark Cave-Ayland wrote:
> On 04/03/2020 00:22, BALATON Zoltan wrote:
>>>>> So on that basis the best explanation as to what is happening is the
>>>>> comment in the link you provided here:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/powerpc/platforms/chrp/pci.c?h=v4.14.172#n353
>>>>>
>>>>> /* Pegasos2 firmware version 20040810 configures the built-in IDE controller
>>>>> * in legacy mode, but sets the PCI registers to PCI native mode.
>>>>> * The chip can only operate in legacy mode, so force the PCI class into legacy
>>>>> * mode as well. The same fixup must be done to the class-code property in
>>>>> * the IDE node /pci@80000000/ide@C,1
>>>>> */
>>>>
>>>> I'm not sure that it makes much sense that the firmware configures the chip one way
>>>> then puts info about a different way in the device tree. There could be bugs but this
>>>> is not likely. Especially because I see in traces that the firmware does try to
>>>> configure the device in native mode. These are the first few accesses of the firmware
>>>> to via-ide:
>>>
>>> But that is exactly what is happening! The comment above clearly indicates the
>>> firmware incorrectly sets the IDE controller in native mode which is in exact
>>> agreement with the trace you provide below. And in fact if you look at
>>
>> I may be reading the comment wrong but to me that says that "firmware configures IDE
>> in _legacy_ mode" whereas the trace shows it actually configures it in _native_ mode
>> which is complying to the CHRP doc above. But since it cannot comply to the "native
>> devices using OpenPIC" part it probably tries to apply the "ISA devices embedded in
>> PCI" part and locks IRQ to 14 and 15. Or it just wants to avoid sharing IRQs as much
>> as possible and the designers decided they will use IRQ14 and 15 for IDE.
>
> Interesting. My interpretation of the comment was that the hardware can only operate
> in legacy mode, even though the firmware configures the PCI registers to enable
> native mode (which is why the class-code and IRQ routing are wrong).

I think you may give more significance to this comment than it really has. 
I don't know who put it there but maybe was also guessing what really 
happens and it's not really an authorative answer why it behaves like 
that. It seems to come from this commit and not from Genesi/bPlan but 
sounds more like a bugfix from some user:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/powerpc/platforms/chrp/pci.c?h=v3.16.82&id=556ecf9be66f4d493e19bc71a7ce84366d512b71

I give more credibility to what MorphOS expects because the developers of 
that were closely cooperating with the board designers:

https://en.wikipedia.org/wiki/Bplan#Community_support
https://en.wikipedia.org/wiki/Pegasos#Operating_system_support

>>> https://www.powerdeveloper.org/platforms/pegasos/devicetree you can see the nvramrc
>>> hack that was released in order to fix the device tree to boot Linux which alters the
>>> class-code and sets interrupts to 14 (which I believe is invalid, but seemingly good
>>> enough here).
>>
>> Isn't this the same fixup that newer Linux kernels already include? Maybe this was
>> needed before Linux properly supported Pegasos2 but later kernels will do this
>> anyway. This does not give us any new info we did not have before I think maybe just
>> easier to see all fixups in one place.
>>
>>>> pci_cfg_write via-ide 12:1 @0x9 <- 0xf
>>>> pci_cfg_write via-ide 12:1 @0x40 <- 0xb
>>>> pci_cfg_write via-ide 12:1 @0x41 <- 0xf2
>>>> pci_cfg_write via-ide 12:1 @0x43 <- 0x35
>>>> pci_cfg_write via-ide 12:1 @0x44 <- 0x18
>>>> pci_cfg_write via-ide 12:1 @0x45 <- 0x1c
>>>> pci_cfg_write via-ide 12:1 @0x46 <- 0xc0
>>>> pci_cfg_write via-ide 12:1 @0x50 <- 0x17171717
>>>> pci_cfg_write via-ide 12:1 @0x54 <- 0x14
>>>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>>>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>>>> pci_cfg_read via-ide 12:1 @0x8 -> 0x1018f06
>>>> pci_cfg_read via-ide 12:1 @0xc -> 0x0
>>>> pci_cfg_read via-ide 12:1 @0x2c -> 0x11001af4
>>>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>>>> pci_cfg_read via-ide 12:1 @0x4 -> 0x2800080
>>>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>>>> pci_cfg_write via-ide 12:1 @0x3c <- 0x109
>>>>
>>>> The very first write is to turn on native mode, so I think it's not about what the
>>>> firmware does but something about how hardware is wired on Pegasos II or the VT8231
>>>> chip itself that only allows legacy interrupts instead of 100% native mode for IDE.
>>>>
>>>>> Given that the DT is wrong, then we should assume that all OSs would have to
>>>>> compensate for this in the same way as Linux, and therefore this should be handled
>>>>> automatically.
>>>>>
>>>>> AFAICT this then only leaves the question: why does the firmware set
>>>>> PCI_INTERRUPT_LINE to 9, which is presumably why you are seeing problems running
>>>>> MorphOS under QEMU.
>>>>
>>>> Linux does try to handle both true native mode and half-native mode. It only uses
>>>> half-native mode if finds IRQ14 on Pegasos, otherwise skips Pegasos specific fixup
>>>> and uses true native mode setup. I don't know what MorphOS does but I think it justs
>>>> knows that Pegasos2 has this quirk and does not look at the device tree at all.
>
> I think this is the other way around? From the code above:
>
> 	if (viaide->irq != 14)
> 		return;
>
> Doesn't this suggest that chrp_pci_fixup_vt8231_ata() exits without applying the fix
> if it finds PCI_INTERRUPT_LINE set to 9 from the firmware above?

Yes but the fixup is clearing the bits saying the controller is in native 
mode so code detecting IRQ lines later will use the legacy 14 and 15 
because that decides based on this config value. This corresponds to 
half-native mode, as io addresses are still from BARs not the legacy IDE 
ports as can be seen from the dmesg output about ide addresses. If irq is 
not set to 14, fixup function leaves config in native mode and Linux will 
try to use the single IRQ line set by PCI_INTERRUPT_LINE (which the 
firmware sets to 9) for both channels. This works with Linux both ways as 
long as we emulate the same but doesn't with other OSes which always use 
PCI BARs to access io regs but expect interrupts on 14 and 15 regardless 
of the mode (and they leave it in native mode don't try setting to legacy) 
so I think they just know Pegasos2 has this half-native mode and use that 
without trying to fix up anything. From this I think we know how it works 
on real hardware and this patch tries to emulate that which also seems to 
work with all OSes. What else is needed?

> Do you have a copy of the full DT and the firmware revision number that was used to
> generate your Linux boot output on real hardware?

Firmware dumps are also linked from

https://osdn.net/projects/qmiga/wiki/SubprojectPegasos2

in the section about firmware and also show mode set to 0x8f by firmware 
20040810.

>>> Again to summarise: this is a known bug in Pegasos2 firmware and the VIA is a
>>> standard chip, so let's try and figure out exactly what is happening using a real
>>> firmware and emulate that behaviour in QEMU. This should then make all guests happy,
>>> regardless of architecture, without requiring the introduction of feature bits or
>>> risk of introducing other incompatibilities.
>>
>> I think I've already done that with this patch (within the limits possible in QEMU).
>> The Pegasos2 seems to always use IRQ14 and 15 even when IDE is set to native mode
>> (which the firmware does immediately, I'm using a real firmware to test) and all
>> guests are happy with this. This behaviour is confirmed by excpectations of AmigaOS
>> and MorphOS drivers and also Linux comments (although those comments may get the
>> reason wrong, they confirm the behaviour). I'm not sure how real hardware implements
>> this behaviour and also not sure if it's a bug in the firmware or rather a peculiar
>> design choice for Pegasos2. But that probably does not matter for the fact that it's
>> how it works which is all we need to emulate it.
>>
>> Also consider that QEMU via-ide is only emulating native mode of the chip because we
>> can't switch between the two modes so it's either legacy only or native only because
>> all other implemented controllers are either ISA or native PCI so QEMU does not have
>> way to deregister ISA IDE and PCI code does not have way to use io BARs despite not
>> being enabled via PCI config which could be needed to use them when device is in
>> legacy mode. Previously via-ide was emulating legacy only and that worked with Linux
>> but not with anything else. I'm not planning to rewrite large parts of the IDE and
>> PCI code to allow switching back and forth which is not even needed. Unless you know
>> a better way to implement this I think the proposed patch is achieving this with
>> minimal changes. I don't see a need to more exactly emulate some kind of hardware bug
>> or peculiar design choices of a board than what's needed to make clients happy and boot.
>>
>> Is this series good enough now to be merged or are any changes needed? I'd like to
>> not miss the deadline for the freeze and get this delayed for months for not good
>> reason because I'm not sure when will I have time to work on it again.
>
> I think there's still time to get something done before freeze, however I'm not
> convinced that we understand the actual problem correctly (and also the use of
> feature bits feels somewhat odd to me).

There may be some time until the freeze but not sure I'll have much time 
until maybe Easter or later so I'd rather get over this now if possible 
than do it in the last minute. The feature bit was needed because the 
fulong2e does not seem to have this behaviour (although Linux has a 
different set of fixups for that board but not about IDE IRQs) so we need 
to emulate two different behaviours: half-native mode for pegasos2 (which 
I think is confirmed by evidence in multiple OSes even if we don't know 
the exact reason behind it) and 100% native mode for fulong2e hence we 
need a way to tell the device emulation which board's expectations it 
should fulfil for which introducing a flag seemed to be the simplest 
solution.

> One more thing I don't understand: I had a glance over the logs you posted over at
> https://osdn.net/projects/qmiga/ticket/38949 and you mention that everything works up
> to the point where BMDMA is enabled.
>
> From memory working with cmd646 both the BMDMA and non-BMDMA interrupts end up
> calling into the same *_set_irq() function in the emulated controller. So what is the
> difference between the initial state where IRQs function enough to start to load an
> OS, and at the point where BMDMA is enabled by the OS driver and things stop working?
> How does the IRQ routing compare?

I'm not sure either why that's the case but maybe the firmware does not 
use interrupts and MorphOS also only enables it when enabling BMDMA. 
Before that they could just poll the PIO regs?

What other OSes are we interested in running on pegasos2 than Linux, 
MorphOS and AmigaOS? Once these are happy do we need to spend more time on 
this until an actual problem comes up? I think there's no need to further 
refine this relatively rarely used device model now. Unless you can 
propose a better solution that works with these OSes, otherwise that could 
be addressed in a later patch and the current one is good enough to enable 
these guests for now.

Regards,
BALATON Zoltan

