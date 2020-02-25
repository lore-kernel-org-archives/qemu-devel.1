Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12010C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5DD21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5DD21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bq6-00034c-1p
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j6bpN-0002ed-8i
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j6bpL-0007vy-1o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:08:52 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:37414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j6bpK-0007v5-Od
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:08:50 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 495967475F6;
 Tue, 25 Feb 2020 16:08:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 08AAD74637F; Tue, 25 Feb 2020 16:08:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0738F74637C;
 Tue, 25 Feb 2020 16:08:47 +0100 (CET)
Date: Tue, 25 Feb 2020 16:08:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2002251515290.22173@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
 <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
 <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
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
Cc: jsnow@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020, jasper.lowell@bt.com wrote:
> I don't believe the quick interrupt here is the problem. Solaris 10
> will spin for a short time while waiting for the interrupt bit to be
> set before continuing with its routine. If it doesn't see the interrupt
> bit is set before some timeout, it will print an error about the
> missing interrupt and give up loading the driver.

I don't think missing delay should cause any problem either just pointed 
this out as a difference from real controller which may have an effect but 
I agree this is probably not a problem.

>>> pci_cfg_read 53.231 pid=147030 dev=b'cmd646-ide' devid=0x3 fnid=0x0
>>> offs=0x50 val=0x4
>>> ide_ioport_read 35.577 pid=147030 addr=0x7 reg=b'Status' val=0x50
>>> bus=0x55b77f922d10 s=0x55b77f922d98
>>> ide_ioport_read 29.095 pid=147030 addr=0x7 reg=b'Status' val=0x50
>>> bus=0x55b77f922d10 s=0x55b77f922d98
>>
>> So these ide_ioport_read calls clear the irq bit...
>
> That's right. The line that I proposed removing in the patch clears
> CFG_INTR_CH0 on ide_ioport_read.

Problem with that patch is that it removes this clearing from the func 
that's also used to emulate ISA IDE ioports which according to their spec 
should clear irq on read so that function should be OK but maybe should 
not be called by PCI IDE code?

>>> ide_ioport_write 19.146 pid=147030 addr=0x6 reg=b'Device/Head'
>>> val=0xe0 bus=0x55b77f922d10 s=0x55b77f922d98
>>> pci_cfg_read 9.468 pid=147030 dev=b'cmd646-ide' devid=0x3 fnid=0x0
>>> offs=0x50 val=0x0
>>> pci_cfg_read 127.712 pid=147030 dev=b'cmd646-ide' devid=0x3
>>> fnid=0x0 offs=0x50 val=0x0
>>> pci_cfg_read 101.942 pid=147030 dev=b'cmd646-ide' devid=0x3
>>> fnid=0x0 offs=0x50 val=0x0
>>
>> ...that would be checked here?
>
> That's right.
>
> Solaris is performing pci_cfg_read on offs=0x50 until it either sees
> the interrupt bit set or times out. If it times out, you get a fatal
> error for the driver. The behaviour is not expected and aggressively
> checked against by the Solaris kernel. From what I can tell, Linux and
> OpenBSD don't check if the bit is set before clearing it.
>
>> What I don't get is why ide_ioport_read is called at all and from where 
>> if that's meant to emulate legacy ide ISA ioport reads and we have a 
>> PCI device accessed via PCI regs?

What I meant was where is ide_ioport_read() is called in this case when we 
have a PCI IDE controller? Searching for it I think it may come from 
pci_ide_data_read() in hw/ide/pci.c. This document:

http://www.bswd.com/pciide.pdf

has some info on this and there are mentions of status using Alternate 
Status (which does not clear interrupt bit) but I think that corresponds 
to pci_ide_cmd_read() which already uses ide_status_read() so that seems 
correct. I did not find anything about contents of the Command Block in 
this doc which the function with ide_ioport_read call implements so not 
sure if that's expected to clear interrupt in PCI native mode or should we 
change pci_ide_data_read() to avoid that.

>> mention irq in a lot of regs (all say write to clear) but I don't
>> understand their relation to each other and irq raised by the drive.
>
> I agree and I think that's part of the problem. The documentation does
> not explicitly mention their relation to each other. I can't see
> anything that suggests that reading the status register on the drive
> will unset bits in the pci configuration space of the controller. They
> are seperate devices.

Except the legacy IDE spec that does say reading status is clearing IRQ 
but not sure PCI native mode should do the same but it seems to use the 
same function in QEMU so it will clear IRQ as in legacy IDE mode. But this 
Linux driver says IRQ is cleared on read for PCI as well:

https://github.com/torvalds/linux/blob/master/drivers/ata/libata-sff.c

as does the CMD646 driver:

https://github.com/torvalds/linux/blob/master/drivers/ata/pata_cmd64x.c

in cmd64x_sff_irq_check() although for different chip revisions it uses 
cmd648_sff_irq_* functions which does this differently and avoids reading 
status reg and clears irq explicitely. It also has a warning at the 
beginning that UDMA mode is broken on most of these chips so it won't try 
to use it on anything below CMD646U2 so this suggests maybe there's a 
problem with clearing IRQs on at least some CMD646 chip revisions. I think 
the Sun Ultra 10 used CMD646U but not sure what the Solaris driver expects 
and if it can work with later chip revisions. Maybe we should either 
emulate the chip bugs or change something to identify as CMD646U2 which 
should behave more like stadard PCI IDE controllers? Although if I got 
that correctly Linux thinks revisions over 5 are OK and QEMU has 7.

I think we need advice from someone more knowledgeable about real hardware 
on this.

Regards,
BALATON Zoltan

