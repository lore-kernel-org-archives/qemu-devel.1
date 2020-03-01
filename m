Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0A3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254C5246D4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254C5246D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8TOz-00016e-4f
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 13:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8TON-0000aB-IL
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8TOM-00065Y-5Q
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:32:43 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:49766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j8TOI-00064J-Pb; Sun, 01 Mar 2020 13:32:39 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1BB1E746381;
 Sun,  1 Mar 2020 19:32:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E433174637E; Sun,  1 Mar 2020 19:32:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E1FAC74569F;
 Sun,  1 Mar 2020 19:32:34 +0100 (CET)
Date: Sun, 1 Mar 2020 19:32:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <57ff6676-5054-d3f6-f4fc-6ff02b09019f@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003011902490.28669@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <32bb2eab213344151ca342bab5db2cf8c2758fb7.1583017348.git.balaton@eik.bme.hu>
 <f7f6bca9-ce20-cc3d-5366-1e947d729c21@ilande.co.uk>
 <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011731130.95594@zero.eik.bme.hu>
 <57ff6676-5054-d3f6-f4fc-6ff02b09019f@ilande.co.uk>
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

On Sun, 1 Mar 2020, Mark Cave-Ayland wrote:
> On 01/03/2020 16:42, BALATON Zoltan wrote:
>
>>> The other part I'm not sure about is that I can't see how via_ide_set_irq() can ever
>>> raise a native PCI IRQ - comparing with my experience on cmd646, should there not be
>>> a pci_set_irq(d, level) at the end?
>>
>> According to my tests with several guests it seems the via-ide does not seem to use
>> PCI interrupts as described in the previous reply, only either legacy IRQ14 and 15 or
>> one ISA IRQ line set by a config reg in native mode (except on Pegasos2). This may be
>> due to how it's internally connected in the southbridge chip it's part of or some
>> other platform specific quirk, I'm not sure.
>
> I think this is the key part here: how does via-ide switch between legacy and native
> mode? For CMD646 this is done by setting a bit in PCI configuration space, and I'd
> expect to see something similar here.
>
> It might be that the BIOS sets legacy mode on startup, and unless the OS explicitly
> switches to native mode then the interrupt routing remains at IRQ 14/15 (or whatever
> value is in PCI_INTERRUPT_LINE). Is there a datasheet available for the VIA chip to
> check this?

Yes, searching for datasheets for the southbridge chips containing this 
IDE controller such as VT82C686B and VT8231 might turn up something but 
the docs are not too detailed regarding IRQ mapping. Switching between 
modes is done the same way as on CMD646 via bits of the PROG_IF config reg 
but as it's also noted in Linux fixup func the firmware on pegasos2 does 
set it up as native mode and also writes to the interrupt line reg to set 
it to 9, yet it seems to remain set to 14 (this is confirmed by reg dump 
from Linux on real hardware) and IRQs are expected on 14 and 15 as in 
legacy mode (shown by expectation of Amiga like OSes, regardless of what's 
in config regs). Docs say that in legacy mode io addresses should be 
legacy io ports assigned to IDE, yet firmware and OSes use PCI BARs as in 
native mode but expect interrupts on legacy IRQ as in legacy mode so I 
think it's kind of half-native mode.

This is what the log shows on real PegasosII (using Debian 5 because later 
versions seems to have problems with radeon driver so have no display):

[    0.000000] Linux version 2.6.26-2-powerpc (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 06:19:00 UTC 2012

[    0.000000] chrp type = 6 [Genesi Pegasos]

[    1.562960] Fixing VIA IDE, force legacy mode on '0000:00:0c.1'

[ 7.203599] VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at PCI slot 0000:00:0c.1
[ 7.211068] VP_IDE: not 100% native mode: will probe irqs later
[ 7.218300] VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:0c.1
[ 7.225534] ide0: BM-DMA at 0x1060-0x1067
[ 7.232794] ide1: BM-DMA at 0x1068-0x106f
[ 7.239927] Probing IDE interface ide0...
[here detects devices attached to ide channels]

[    9.013151] ide0 at 0x1040-0x1047,0x104e on irq 14
[    9.020384] ide1 at 0x1050-0x1057,0x105e on irq 15

lspci says:

0000:00:0c.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin ? routed to IRQ 14
         Region 0: [virtual] I/O ports at 1040 [size=8]
         Region 1: [virtual] I/O ports at 104c [size=4]
         Region 2: [virtual] I/O ports at 1050 [size=8]
         Region 3: [virtual] I/O ports at 105c [size=4]
         Region 4: I/O ports at 1060 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: VIA_IDE
         Kernel modules: via82cxxx

If this was legacy mode io ports should not be what seem to be coming from 
PCI BARs so either docs are not correct about how legacy mode works or 
this is not legacy mode but "not 100% native mode". The prog-if is set to 
0x8a which corresponds to native mode but this is what the Linux fixup 
function does, firmware sets it to 0x8f which means native mode.

Regards,
BALATON Zoltan

