Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ACFC35671
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 15:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF12E2067D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 15:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF12E2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5t0h-0000dK-0v
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 10:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j5t00-0000B5-Jl
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 10:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j5szy-0007Mk-C0
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 10:16:51 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:51492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j5szw-0007KX-I8
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 10:16:50 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9089374637C;
 Sun, 23 Feb 2020 16:16:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0C3DF745953; Sun, 23 Feb 2020 16:16:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 096C974569F;
 Sun, 23 Feb 2020 16:16:46 +0100 (CET)
Date: Sun, 23 Feb 2020 16:16:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
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
Cc: jsnow@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Feb 2020, jasper.lowell@bt.com wrote:
> ide_exec_cmd 0.461 pid=147030 bus=0x55b77f922d10 state=0x55b77f922d98 cmd=0xef

The command is run here if I'm not mistaken Does this set the irq right 
away on QEMU where on real hadware this may take some time? Not sure if 
that's a problem but trying to understand what's happening.

> pci_cfg_read 53.231 pid=147030 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x4
> ide_ioport_read 35.577 pid=147030 addr=0x7 reg=b'Status' val=0x50 bus=0x55b77f922d10 s=0x55b77f922d98
> ide_ioport_read 29.095 pid=147030 addr=0x7 reg=b'Status' val=0x50 bus=0x55b77f922d10 s=0x55b77f922d98

So these ide_ioport_read calls clear the irq bit...

> ide_ioport_write 19.146 pid=147030 addr=0x6 reg=b'Device/Head' val=0xe0 bus=0x55b77f922d10 s=0x55b77f922d98
> pci_cfg_read 9.468 pid=147030 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x0
> pci_cfg_read 127.712 pid=147030 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x0
> pci_cfg_read 101.942 pid=147030 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x0

...that would be checked here?

> It looks like I've made mistakes in previous comments about the error
> and what the problem might be. Excuse my inexperience. Rather than
> spinning on ARTTIM23_INTR_CH1 it might be the case that Solaris 10 is
> spinning on CFR_INTR_CH0. I think this because of the following trace:
>
> pci_cfg_read 53.231 pid=147030 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x4
>
> The two reads on the io status register show that DRDY (drive ready
> indicator bit) and DSC (drive seek complete bit). This doesn't look
> unusual to me. The error bit is also not set which is reassuring.

What I don't get is why ide_ioport_read is called at all and from where if 
that's meant to emulate legacy ide ISA ioport reads and we have a PCI 
device accessed via PCI regs? Should the device behave differently in 
legacy and native mode with respect of clearing irq bit on register reads?

> I read through some of
> ftp://ftp.seagate.com/pub/acrobat/reference/111-1c.pdf and I'm confused
> by the discussion regarding interrupts and the status register.
>
>> INTRQ is cleared when the host reads the status register.
>
> My understand is that INTRQ is the signal from pin 31 on the drive and
> that the status register is on the drive. I understand the quoted
> statement as when the host (CMD646) reads the status register of the
> drive, the drive will lower the interrupt on this pin.
>
> The CMD646 has CFR_INTR_CH0 and ARTTIM23_INTR_CH1 in it's PCI
> configuration space. This is necessary to determine the source of an
> interrupt when the CMD646 ports are in PCI IDE Native Mode. Are we
> saying that when the drive lowers the interrupt, the CMD646 sees this
> and then clears CFR_INTR_CH0 and ARTTIM23_INTR_CH1 automatically? If
> this were the case then I don't know why there is an interface to clear
> them by writing to them.

There's a possibility that software may want to clear bits without reading 
the current value so having a way to do that can be explained.

> Also, if reading the ioport status register was enough to clear
> CFR_INTR_CH0 and ARTTIM23_INTR_CH1 (specific to CMD646) I can't reason
> why Linux, Solaris, and OpenBSD would have specific routines to clear
> them (following the CMD646 documentation) rather than just reading the
> ioport status register.

But the doc not mentioning irq bits should be cleared on read and drivers 
do it by writing after reading is sufficient evidence that CMD646 likely 
does not clear bits on read.

> With the patch, the tracing output changes to this:
> ide_ioport_read 128.512 pid=162907 addr=0x7 reg=b'Status' val=0x0 bus=0x55909512bd10 s=0x55909512c168
> ide_ioport_write 22.622 pid=162907 addr=0x6 reg=b'Device/Head' val=0xe0 bus=0x55909512bd10 s=0x55909512c168
> ide_ioport_write 21.330 pid=162907 addr=0x1 reg=b'Features' val=0x3 bus=0x55909512bd10 s=0x55909512bd98
> ide_ioport_write 13.926 pid=162907 addr=0x2 reg=b'Sector Count' val=0x42 bus=0x55909512bd10 s=0x55909512bd98
> ide_ioport_write 9.278 pid=162907 addr=0x7 reg=b'Command' val=0xef bus=0x55909512bd10 s=0x55909512bd98
> ide_exec_cmd 0.921 pid=162907 bus=0x55909512bd10 state=0x55909512bd98 cmd=0xef
> pci_cfg_read 40.647 pid=162907 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x4
> ide_ioport_read 40.445 pid=162907 addr=0x7 reg=b'Status' val=0x50 bus=0x55909512bd10 s=0x55909512bd98
> ide_ioport_read 31.580 pid=162907 addr=0x7 reg=b'Status' val=0x50 bus=0x55909512bd10 s=0x55909512bd98
> ide_ioport_write 17.923 pid=162907 addr=0x6 reg=b'Device/Head' val=0xe0 bus=0x55909512bd10 s=0x55909512bd98
> pci_cfg_read 10.931 pid=162907 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x4
> pci_cfg_read 19.136 pid=162907 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x4
> pci_cfg_write 26.650 pid=162907 dev=b'cmd646-ide' devid=0x3 fnid=0x0 offs=0x50 val=0x4

The difference here is that status bits still there after ide_ioport_read 
when it gets it via pci_cfg_read than writes to that reg to clear it.

> Now there is no fatal error and Solaris does the expected by setting
> CFR_INTR_CH0 to clear it. QEMU then updates the interrupt status in
> cmd646_pci_config_write.
>
> I'm still unconvinced that we should be lowering interrupts when the
> ide ioport status register is read. I might be misunderstanding the
> documentation though (definitely possible). If I am misunderstanding
> the documentation, could you or Mark clarify what I'm getting wrong
> here.

I'm afraid I don't understand the problem enough either to be able to 
help. Maybe you could try to find out where is ide_ioport_read called in 
the above and if that's correct to call it there. Also the CMD646U docs 
mention irq in a lot of regs (all say write to clear) but I don't 
understand their relation to each other and irq raised by the drive. I've 
found these:

0x3c INTLINE R/W Interrupt line default=14

0x50 CFR R Configuration register
      bit2 1=interrupt pending, write 1 will clear this bit (in read only reg?)

0x57 ARTTIM23 R/W Drive2/3 Control/Status Register
      bit4 IDE drive 2/3 interrupt status (write 1 to clear)

0x71 or BAR4+1 MRDMODE DMA Master Read Mode Select
      bit2 Primary channel IDE interrupt (write 1 to clear)
      bit3 Secondary channel IDE interrupt (write 1 to clear)
      bit4 Primary channel interrupt enable
           0 = propagate primary channel IDE interrupts to IRQ14 or INTA# pin (default)
           1 = block primary channel IDE interrupts (NOTE: this does not affect the function of bit 2)
      bit5 same as bit4 for but for Secondary channel and IRQ15

0x72 or BAR4+2 R/W BMIDESR0 Bus Master IDE Status Reg 0 for primary channel
      bit2 interrupt generated on IDE bus for DMA transfer (write 1 to clear)

0x7a or BAR4+0xa R/W BMIDESR1 Bus Master IDE Status Reg 0 for secondary channel
      bit2 like BMIDESR0 but for channel 1 I think

So maybe in DMA mode the BM* regs should be used and in legacy mode these 
interrupts would go to ISA IRQ14 and 15 and cleared on read as per the IDE 
spec while in native mode PCI INTA is raised and not cleared but the chip 
docs don't say anything about this so it's only guessing. Does anyone have 
more info on this?

Regards,
BALATON Zoltan

