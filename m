Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D8C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C84920842
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 00:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C84920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9HoZ-0000as-LQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 19:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j9Hnq-000077-9O
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j9Hno-0006lE-9o
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 19:22:22 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:13855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j9Hnh-0006TC-TH; Tue, 03 Mar 2020 19:22:15 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 93A547476D5;
 Wed,  4 Mar 2020 01:22:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4C92D74637C; Wed,  4 Mar 2020 01:22:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 49A8974569F;
 Wed,  4 Mar 2020 01:22:02 +0100 (CET)
Date: Wed, 4 Mar 2020 01:22:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <2a39ccab-e4d4-8172-9a1d-0bc089e0104c@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003032356230.41934@zero.eik.bme.hu>
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

On Tue, 3 Mar 2020, Mark Cave-Ayland wrote:
> On 02/03/2020 21:40, BALATON Zoltan wrote:
>>> I had a quick look at the schematics linked from the page above, and they confirm
>>> that the VIA IDE interface is connected directly to IRQs 14 and 15 and not to the PCI
>>> interrupt pins.
>>
>> Where did you see that? What I got from trying to look this up in the schematics was
>> that VT8231 has two pins named IRQ14 and IRQ15 (but described as Primary and
>> Secondary Channel Interrupt Request in doc) where the interrupt lines of the two IDE
>> ports/channels are connected but how they are routed within the chip after that was
>> not clear. The chip doc says that in native mode the interrupt should be configurable
>> and use a single interrupt for both channels and in legacy mode they use the usual 14
>> and 15 but this is not what guest drivers expect so I think not how really works on
>> PegasosII. It is true however that connection to PCI interrupts aren't mentioned so
>> it always uses ISA IRQ numbers, it just depends on legacy vs. native mode which line
>> is raised. But that was never really a question for VT8231 and maybe only CMD646
>> could have such interconnection with PCI interrupts. (Proabable reason is that
>> via-ide is part of a southbridge chip where it has connections to ISA bus while
>> CMD646 is a PCI IDE controller but I could be wrong as my knowledge is limited about
>> these.)
>
> Presumably the VIA southbridge has its own internal pair of cascaded 8259s so the IRQ
> line from the drive is connected to IRQ14/15 as per an typical ISA PC. You can see
> this in the "Common Hardware Reference Platform: I/O Device Reference" PDF section 4.1.

Yes the VIA southbridge chip integrates all usual PC devices including 
PICs so these may have connection internally. I haven't checked these docs 
before but now I think another chapter in the doc you referenced and its 
companion "Common Hardware Reference Platform: A System Architecture" may 
explain the unusal combination of PCI like io regs with legacy interrupts 
the Pegasos2 seems to have. In the I/O Device Reference, chapter 11 about 
IDE says that the device must be addressed only with PCI I/O addresses 
where io addresses are completely relocatable and that when OpenFirmware 
passes control to the OS IDE must be configured as a PCI device. So this 
probably means io addresses coming from PCI BARs. But the CHRP System 
Architecture, chapter 9.2 about ISA devices says that "ISA devices 
included in a PCI part must route their interrupt signals to the legacy 
interrupt controller" and this is what the Pegasos2 seems to do. This may 
be a misinterpretation of the spec because elsewhere (I've lost the exact 
reference and have no time to find it again) it also says something about 
native devices must be using OpenPIC but Pegasos2 does not have OpenPIC so 
that part surely cannot apply anyway.

>>> So on that basis the best explanation as to what is happening is the
>>> comment in the link you provided here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/powerpc/platforms/chrp/pci.c?h=v4.14.172#n353
>>>
>>>
>>> /* Pegasos2 firmware version 20040810 configures the built-in IDE controller
>>> * in legacy mode, but sets the PCI registers to PCI native mode.
>>> * The chip can only operate in legacy mode, so force the PCI class into legacy
>>> * mode as well. The same fixup must be done to the class-code property in
>>> * the IDE node /pci@80000000/ide@C,1
>>> */
>>
>> I'm not sure that it makes much sense that the firmware configures the chip one way
>> then puts info about a different way in the device tree. There could be bugs but this
>> is not likely. Especially because I see in traces that the firmware does try to
>> configure the device in native mode. These are the first few accesses of the firmware
>> to via-ide:
>
> But that is exactly what is happening! The comment above clearly indicates the
> firmware incorrectly sets the IDE controller in native mode which is in exact
> agreement with the trace you provide below. And in fact if you look at

I may be reading the comment wrong but to me that says that "firmware 
configures IDE in _legacy_ mode" whereas the trace shows it actually 
configures it in _native_ mode which is complying to the CHRP doc above. 
But since it cannot comply to the "native devices using OpenPIC" part it 
probably tries to apply the "ISA devices embedded in PCI" part and locks 
IRQ to 14 and 15. Or it just wants to avoid sharing IRQs as much as 
possible and the designers decided they will use IRQ14 and 15 for IDE.

> https://www.powerdeveloper.org/platforms/pegasos/devicetree you can see the nvramrc
> hack that was released in order to fix the device tree to boot Linux which alters the
> class-code and sets interrupts to 14 (which I believe is invalid, but seemingly good
> enough here).

Isn't this the same fixup that newer Linux kernels already include? Maybe 
this was needed before Linux properly supported Pegasos2 but later kernels 
will do this anyway. This does not give us any new info we did not have 
before I think maybe just easier to see all fixups in one place.

>> pci_cfg_write via-ide 12:1 @0x9 <- 0xf
>> pci_cfg_write via-ide 12:1 @0x40 <- 0xb
>> pci_cfg_write via-ide 12:1 @0x41 <- 0xf2
>> pci_cfg_write via-ide 12:1 @0x43 <- 0x35
>> pci_cfg_write via-ide 12:1 @0x44 <- 0x18
>> pci_cfg_write via-ide 12:1 @0x45 <- 0x1c
>> pci_cfg_write via-ide 12:1 @0x46 <- 0xc0
>> pci_cfg_write via-ide 12:1 @0x50 <- 0x17171717
>> pci_cfg_write via-ide 12:1 @0x54 <- 0x14
>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>> pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
>> pci_cfg_read via-ide 12:1 @0x8 -> 0x1018f06
>> pci_cfg_read via-ide 12:1 @0xc -> 0x0
>> pci_cfg_read via-ide 12:1 @0x2c -> 0x11001af4
>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>> pci_cfg_read via-ide 12:1 @0x4 -> 0x2800080
>> pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
>> pci_cfg_write via-ide 12:1 @0x3c <- 0x109
>>
>> The very first write is to turn on native mode, so I think it's not about what the
>> firmware does but something about how hardware is wired on Pegasos II or the VT8231
>> chip itself that only allows legacy interrupts instead of 100% native mode for IDE.
>>
>>> Given that the DT is wrong, then we should assume that all OSs would have to
>>> compensate for this in the same way as Linux, and therefore this should be handled
>>> automatically.
>>>
>>> AFAICT this then only leaves the question: why does the firmware set
>>> PCI_INTERRUPT_LINE to 9, which is presumably why you are seeing problems running
>>> MorphOS under QEMU.
>>
>> Linux does try to handle both true native mode and half-native mode. It only uses
>> half-native mode if finds IRQ14 on Pegasos, otherwise skips Pegasos specific fixup
>> and uses true native mode setup. I don't know what MorphOS does but I think it justs
>> knows that Pegasos2 has this quirk and does not look at the device tree at all.
>>
>>> Could it be that setting prog-if to 0x8a legacy mode also resets PCI_INTERRUPT_LINE
>>> to 14? You should be able to confirm this easily on real hardware using the Forth
>>> config-* words on the IDE node and reading the prog-if byte before and after.
>>
>> I don't have direct access to real hardware and would also need to come up with some
>> Forth to verify that but given the above trace that the firmware does before we can
>> enter any Forth we would likely find @0x9 = 0x8f and @0x3c = 0x0e because after
>> booting Linux we see 0x8a and 0x0e and Linux only touches the two mode bits.
>
> Again to summarise: this is a known bug in Pegasos2 firmware and the VIA is a
> standard chip, so let's try and figure out exactly what is happening using a real
> firmware and emulate that behaviour in QEMU. This should then make all guests happy,
> regardless of architecture, without requiring the introduction of feature bits or
> risk of introducing other incompatibilities.

I think I've already done that with this patch (within the limits possible 
in QEMU). The Pegasos2 seems to always use IRQ14 and 15 even when IDE is 
set to native mode (which the firmware does immediately, I'm using a real 
firmware to test) and all guests are happy with this. This behaviour is 
confirmed by excpectations of AmigaOS and MorphOS drivers and also Linux 
comments (although those comments may get the reason wrong, they confirm 
the behaviour). I'm not sure how real hardware implements this behaviour 
and also not sure if it's a bug in the firmware or rather a peculiar 
design choice for Pegasos2. But that probably does not matter for the fact 
that it's how it works which is all we need to emulate it.

Also consider that QEMU via-ide is only emulating native mode of the chip 
because we can't switch between the two modes so it's either legacy only 
or native only because all other implemented controllers are either ISA or 
native PCI so QEMU does not have way to deregister ISA IDE and PCI code 
does not have way to use io BARs despite not being enabled via PCI config 
which could be needed to use them when device is in legacy mode. 
Previously via-ide was emulating legacy only and that worked with Linux 
but not with anything else. I'm not planning to rewrite large parts of the 
IDE and PCI code to allow switching back and forth which is not even 
needed. Unless you know a better way to implement this I think the 
proposed patch is achieving this with minimal changes. I don't see a need 
to more exactly emulate some kind of hardware bug or peculiar design 
choices of a board than what's needed to make clients happy and boot.

Is this series good enough now to be merged or are any changes needed? I'd 
like to not miss the deadline for the freeze and get this delayed for 
months for not good reason because I'm not sure when will I have time to 
work on it again.

Regards,
BALATON Zoltan

