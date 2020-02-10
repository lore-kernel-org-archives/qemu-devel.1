Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FFEC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FA620715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FA620715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B9f-00012W-0v
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j1B90-0000JP-Hd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j1B8y-0006d4-4b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:38:41 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:35272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j1B8x-0006WI-RN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:38:40 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 97A6C74638A;
 Mon, 10 Feb 2020 16:38:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 00ED8745953; Mon, 10 Feb 2020 16:38:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F348074569F;
 Mon, 10 Feb 2020 16:38:28 +0100 (CET)
Date: Mon, 10 Feb 2020 16:38:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: RE: Emulating Solaris 10 on SPARC64 sun4u
In-Reply-To: <alpine.BSF.2.22.395.2002080030360.88696@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2002101546080.56058@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <20200205173326.GA3256@work-vm>
 <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
 <alpine.BSF.2.22.395.2002080030360.88696@zero.eik.bme.hu>
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
Cc: mark.cave-ayland@ilande.co.uk, John Snow <jsnow@redhat.com>,
 dgilbert@redhat.com, atar4qemu@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020, BALATON Zoltan wrote:
> Not sure if my problem I see on other machine emulation I'm working on is 
> related at all but there's a possibility it might be. I got this with 
> different arch (ppc but could also reproduce something similar with mips) and 
> ide controller emulation (via-ide) but the PCI bmdma code is shared by 
> CMD646, via-ide and sii3112 and also the ide-cdrom emulation is the same so 
> if there's a bug in these that could cause similar problems for different 
> components. Or it could be that we get similar symptoms due to different 
> reasons in which case sorry for the distracion but maybe we can learn from 
> the experience of each other even in that case.
>
> What I get is tracked here:
>
> https://osdn.net/projects/qmiga/ticket/38949
>
> (background on emulated machine: 
> https://osdn.net/projects/qmiga/wiki/SubprojectPegasos2 )
>
> Originally I had both Linux and MorphOS fail after enabling BMDMA before I 
> had interrupt controller emulation (so that means it could be a problem with 
> that in your case as well so something to check). Now that I've implemented 
> interrupts Linux boots with DMA from CDROM but MorphOS is still not happy.

I could now also reproduce the same with AmigaOS4 on pegasos2 where I got 
same missing interrupt problem:

---> Port 1
IOBase 00001010, AltBase 0000101E
bmcr_base 00001028
MMIOBase 00000000
Config not forced, scanning ...
1 device(s) on port
  0 Master : 'ATAPI'
  1 Slave  : 'unknown type'
Starting 'peg2ide.device - chip 0 port 1' task
bmdma_addr_write data: 0x0000000002290000
Trying to configure unit 2

Hangs here waiting for interrupt which does not seem to arrive, then:

[peg2ide/irq_wait] timed out
[peg2ide/exec_pio_data_in_cmd] <- here
[peg2ide/ata_read_drive_properties] unit 2 returned error 255, failbits 00000000h, timeout 0
Trying to configure unit 3
[peg2ide/ata_read_drive_properties] After-reset signature invalid for unit 3

So there's definitely a problem with interrupts but not sure where. Also 
don't know why it detects an unknown slave device which then it decides is 
invalid. Maybe this is normal on an IDE bus with only one device or is it 
a problem in emulation?

To locate the problem further I've then tried the same with ide-cd 
connected to the sii3112 SATA emulation that also shares the same IDE 
BMDMA code with CMD646 and via-ide but as a PCI card the interrupt routing 
is different. So if I don't get the problem with it then that can prove 
common code is correct. If I get the problem it may come from common code 
or be another interrupt routing problem.

I did not have PCI interrupts correctly implemented in pegasos2 yet so I 
had to fix that first but I'm not sure it's correct yet. I got similar 
results but the interrupt seems to fire in this case but does not get to 
the CPU as it does not seem to be enabled:

sii3112ide.device 53.3 (05.02.2009)
Found chip #0
---> Port 0
IOBase 00001030, AltBase 0000103A
bmcr_base 00001090
MMIOBase 81004000
Config not forced, scanning ...
sii3112_write bmdma: write (size 1) 0x8a : 0x02
sii3112_write bmdma: write (size 1) 0x86 : 0x00
sii3112_write bmdma: write (size 1) 0x82 : 0x55
sii3112_write bmdma: write (size 1) 0x83 : 0xaa
sii3112_write bmdma: write (size 1) 0x82 : 0xaa
sii3112_write bmdma: write (size 1) 0x83 : 0x55
sii3112_write bmdma: write (size 1) 0x82 : 0x55
sii3112_write bmdma: write (size 1) 0x83 : 0xaa
sii3112_read bmdma: read (size 1) 0x82 : 0x55
sii3112_read bmdma: read (size 1) 0x83 : 0xaa
sii3112_write bmdma: write (size 1) 0x86 : 0x00
sii3112_write bmdma: write (size 1) 0x8a : 0x06
sii3112_write bmdma: write (size 1) 0x8a : 0x02
sii3112_set_irq channel 0 level 0
sii3112_read bmdma: read (size 1) 0x87 : 0x00
sii3112_write bmdma: write (size 1) 0x86 : 0x00
sii3112_write bmdma: write (size 1) 0x86 : 0x00
sii3112_write bmdma: write (size 1) 0x86 : 0x00
sii3112_read bmdma: read (size 1) 0x82 : 0x01
sii3112_read bmdma: read (size 1) 0x83 : 0x01
sii3112_read bmdma: read (size 1) 0x84 : 0x14
sii3112_read bmdma: read (size 1) 0x85 : 0xeb
sii3112_set_irq channel 0 level 0
sii3112_read bmdma: read (size 1) 0x87 : 0x00
sii3112_write bmdma: write (size 1) 0x86 : 0x00
1 device(s) on port
  0 Master : 'ATAPI'
Starting 'sii3112ide.device - chip 0 port 0' task
sii3112_write bmdma: write (size 4) 0x4 : 0x22c0000
bmdma_addr_write data: 0x00000000022c0000
Installing handler for irq 25
mv64361_gpp_irq(0x5654b950c1a0, 31, 1) levels=80000000 mask=80000000
mv64361_update_irq(0x5654b950c1a0, 59, 1)
mv64361_gpp_irq(0x5654b950c1a0, 31, 0) levels=0
mv64361_update_irq(0x5654b950c1a0, 59, 0)
Unassigned mem read 00000000810040a1
Trying to configure unit 0
sii3112_write bmdma: write (size 1) 0x86 : 0x00
sii3112_set_irq channel 0 level 0
sii3112_read bmdma: read (size 1) 0x87 : 0x00
sii3112_write bmdma: write (size 1) 0x8a : 0x00
sii3112_write bmdma: write (size 1) 0x81 : 0x00
sii3112_write bmdma: write (size 1) 0x82 : 0x00
sii3112_write bmdma: write (size 1) 0x83 : 0x00
sii3112_write bmdma: write (size 1) 0x84 : 0x00
sii3112_write bmdma: write (size 1) 0x85 : 0x00
sii3112_write bmdma: write (size 1) 0x86 : 0x40
sii3112_write bmdma: write (size 1) 0x87 : 0xa1
sii3112_set_irq channel 0 level 1
mv64361_pcihost_set_irq(0x5654b950ce00, 1, 1)
mv64361_gpp_irq(0x5654b950c1a0, 13, 1) levels=2000 mask=80000000

[sii3112ide/irq_wait] timed out
[sii3112ide/exec_pio_data_in_cmd] <- here
sii3112_set_irq channel 0 level 0
mv64361_pcihost_set_irq(0x5654b950ce00, 1, 0)
mv64361_gpp_irq(0x5654b950c1a0, 13, 0) levels=0
mv64361_update_irq(0x5654b950c1a0, 57, 0)
sii3112_read bmdma: read (size 1) 0x87 : 0x58
[sii3112ide/ata_read_drive_properties] unit 0 returned error 255, failbits 00000000h, timeout 0

So here I see there's an interrupt raised by the card which does also get 
to the mv64361 system controller that's also the interrupt controller on 
pegasos2 but CPU IRQ is not raised because the corresponding mask bit is 
not set for some reason.

This suggests the common IDE bmdma and ide-cd code is likely OK and 
problem is somewhere in irq routing. What's relevant for this thread and 
sparc64 is that then you should also check interrupt controller and 
routing if an interrupt raised by the IDE controller could get to the CPU 
in your case as that could be where the problem is and maybe not in 
common code as I've suspected before.

For my case I'm not sure. On pegasos2 irqs come in via the mv64361 gpio 
ports, the irq pin of the VIA south bridge (containing via-ide and the 16 
isa interrupts) is connected to gpp_irq 31 while the PCI INTA-D lines are 
connected to gpp_irq 12-15. These are mapped to interrupt cause bits 56-59 
so that gpp0-7 gets 56, gpp8-15 57, gpp16-23 58 and gpp 24-31 gets 59. 
Thus the IRQ numbers seem correct in the above but the expected interrupt 
on 59 is only raised when the sii3112 driver is insalling its interrupt 
handler (not sure why does it call that irq 25?). This should have been 
raised when talking to device on via-ide much earlier. Then when talking 
to device on sii3112 the interrupt arrives from PCI on the expected 57 but 
CPU IRQ is not raised because it is masked, only gpp 31 is enabled. This 
supposedly works on real hardware but don't get why it doesn't on my 
emulation. It's probably a bug in the IRQ controller emulation then and 
topic for another thread and other platforms that similar error happens 
may also have bugs in their IRQ routing.

Regards,
BALATON Zoltan

