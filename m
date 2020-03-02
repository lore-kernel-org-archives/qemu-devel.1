Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E7BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783D22465D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 21:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783D22465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8soB-0007bb-LZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 16:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8snZ-00078E-VH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8snY-0006ol-6x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 16:40:25 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:27477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8snR-0006lj-1d; Mon, 02 Mar 2020 16:40:19 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 52141747E04;
 Mon,  2 Mar 2020 22:40:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 152B2747DCF; Mon,  2 Mar 2020 22:40:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 12F96747DFE;
 Mon,  2 Mar 2020 22:40:14 +0100 (CET)
Date: Mon, 2 Mar 2020 22:40:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <9ce6d135-4169-96ae-c457-1131b4510c49@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003022145430.47473@zero.eik.bme.hu>
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

On Mon, 2 Mar 2020, Mark Cave-Ayland wrote:
> On 01/03/2020 21:30, BALATON Zoltan wrote:
>> On Sun, 1 Mar 2020, Mark Cave-Ayland wrote:
>>> On 01/03/2020 18:53, BALATON Zoltan wrote:
>>>> On Sun, 1 Mar 2020, BALATON Zoltan wrote:
>>>>> is not legacy mode but "not 100% native mode". The prog-if is set to 0x8a which
>>>>> corresponds to native mode but this is what the Linux fixup function does, firmware
>>>>> sets it to 0x8f which means native mode.
>>>>
>>>> I mean, 0x8a legacy mode and 0x8f native mode, I see firmware poking 0x8f and Amiga
>>>> like OSes reading that yet expecting legacy interrupts. Linux fixes up prog-if so its
>>>> driver detects legacy interrupts but still uses ioports from PCI BARs.
>>>
>>> I see. Note that it is also possible to have a prog-if value of 0x80 which is where
>>> the hardware is locked into legacy mode via a pull-down resistor. Perhaps this is the
>>> case for Pegasos, since it would explain why attempts to switch the mode via prog-if
>>> are ignored?
>>
>> I've seen such option in CMD646 docs but couldn't find similar in VT8231. Genesi has
>> published the schematics of Pegasos II (linked from my
>> https://osdn.net/projects/qmiga/wiki/SubprojectPegasos2 page) so we could check if
>> you can tell which pin is that. But we get 0x8a in Linux lspci output on real
>> hardware for prog-if which is explained by firmare setting it to 0x8f then Linux
>> fixup function clearing bits 0 and 2 so does not seem it started as 0x80 because then
>> firmware should not be able to set it to 0x8f either.
>
> I had a quick look at the schematics linked from the page above, and they confirm
> that the VIA IDE interface is connected directly to IRQs 14 and 15 and not to the PCI
> interrupt pins.

Where did you see that? What I got from trying to look this up in the 
schematics was that VT8231 has two pins named IRQ14 and IRQ15 (but 
described as Primary and Secondary Channel Interrupt Request in doc) where 
the interrupt lines of the two IDE ports/channels are connected but how 
they are routed within the chip after that was not clear. The chip doc 
says that in native mode the interrupt should be configurable and use a 
single interrupt for both channels and in legacy mode they use the usual 
14 and 15 but this is not what guest drivers expect so I think not how 
really works on PegasosII. It is true however that connection to PCI 
interrupts aren't mentioned so it always uses ISA IRQ numbers, it just 
depends on legacy vs. native mode which line is raised. But that was never 
really a question for VT8231 and maybe only CMD646 could have such 
interconnection with PCI interrupts. (Proabable reason is that via-ide is 
part of a southbridge chip where it has connections to ISA bus while 
CMD646 is a PCI IDE controller but I could be wrong as my knowledge is 
limited about these.)

> So on that basis the best explanation as to what is happening is the
> comment in the link you provided here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/powerpc/platforms/chrp/pci.c?h=v4.14.172#n353
>
> /* Pegasos2 firmware version 20040810 configures the built-in IDE controller
> * in legacy mode, but sets the PCI registers to PCI native mode.
> * The chip can only operate in legacy mode, so force the PCI class into legacy
> * mode as well. The same fixup must be done to the class-code property in
> * the IDE node /pci@80000000/ide@C,1
> */

I'm not sure that it makes much sense that the firmware configures the 
chip one way then puts info about a different way in the device tree. 
There could be bugs but this is not likely. Especially because I see in 
traces that the firmware does try to configure the device in native mode. 
These are the first few accesses of the firmware to via-ide:

pci_cfg_write via-ide 12:1 @0x9 <- 0xf
pci_cfg_write via-ide 12:1 @0x40 <- 0xb
pci_cfg_write via-ide 12:1 @0x41 <- 0xf2
pci_cfg_write via-ide 12:1 @0x43 <- 0x35
pci_cfg_write via-ide 12:1 @0x44 <- 0x18
pci_cfg_write via-ide 12:1 @0x45 <- 0x1c
pci_cfg_write via-ide 12:1 @0x46 <- 0xc0
pci_cfg_write via-ide 12:1 @0x50 <- 0x17171717
pci_cfg_write via-ide 12:1 @0x54 <- 0x14
pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
pci_cfg_read via-ide 12:1 @0x0 -> 0x5711106
pci_cfg_read via-ide 12:1 @0x8 -> 0x1018f06
pci_cfg_read via-ide 12:1 @0xc -> 0x0
pci_cfg_read via-ide 12:1 @0x2c -> 0x11001af4
pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
pci_cfg_read via-ide 12:1 @0x4 -> 0x2800080
pci_cfg_read via-ide 12:1 @0x3c -> 0x10e
pci_cfg_write via-ide 12:1 @0x3c <- 0x109

The very first write is to turn on native mode, so I think it's not about 
what the firmware does but something about how hardware is wired on 
Pegasos II or the VT8231 chip itself that only allows legacy interrupts 
instead of 100% native mode for IDE.

> Given that the DT is wrong, then we should assume that all OSs would have to
> compensate for this in the same way as Linux, and therefore this should be handled
> automatically.
>
> AFAICT this then only leaves the question: why does the firmware set
> PCI_INTERRUPT_LINE to 9, which is presumably why you are seeing problems running
> MorphOS under QEMU.

Linux does try to handle both true native mode and half-native mode. It 
only uses half-native mode if finds IRQ14 on Pegasos, otherwise skips 
Pegasos specific fixup and uses true native mode setup. I don't know what 
MorphOS does but I think it justs knows that Pegasos2 has this quirk and 
does not look at the device tree at all.

> Could it be that setting prog-if to 0x8a legacy mode also resets PCI_INTERRUPT_LINE
> to 14? You should be able to confirm this easily on real hardware using the Forth
> config-* words on the IDE node and reading the prog-if byte before and after.

I don't have direct access to real hardware and would also need to come up 
with some Forth to verify that but given the above trace that the firmware 
does before we can enter any Forth we would likely find @0x9 = 0x8f and 
@0x3c = 0x0e because after booting Linux we see 0x8a and 0x0e and Linux 
only touches the two mode bits.

So I don't know the ultimate reason why it works that way but I'm quite 
sure that this emulation is close enough and guests are happy with it too.

Regards,
BALATON Zoltan

