Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665DC35E0E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A736C20732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A736C20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6hFM-0002hg-P9
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 15:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j6hEj-0002BH-L6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j6hEe-00044r-VG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:55:24 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:38818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j6hEe-0003sq-I0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:55:20 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DD9FD74637F;
 Tue, 25 Feb 2020 21:55:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8ADA374637C; Tue, 25 Feb 2020 21:55:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 889F674569F;
 Tue, 25 Feb 2020 21:55:16 +0100 (CET)
Date: Tue, 25 Feb 2020 21:55:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: John Snow <jsnow@redhat.com>
Subject: IDE IRQ problem after UDMA enabled (was: Re: Emulating Solaris 10
 on SPARC64 sun4u)
In-Reply-To: <078a89dc-3e5f-2152-8783-1f22483c4603@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2002252041380.50551@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <20200205173326.GA3256@work-vm>
 <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
 <alpine.BSF.2.22.395.2002080030360.88696@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2002101546080.56058@zero.eik.bme.hu>
 <078a89dc-3e5f-2152-8783-1f22483c4603@redhat.com>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Mon, 10 Feb 2020, John Snow wrote:
> It sounds like the real problem is either in the bmdma controller (or
> its unique interaction with hw/ide/core.c -- which is possible) or in
> the interrupt routing somewhere else.
>
> If you have any IDE traces from a hang, feel free to throw them up on a
> pastebin for me to take a peek at; it might help for me to see the exact
> sequence that causes a hang in QEMU's IDE terms to see if I can't
> "reverse engineer" what the guest is hoping to have happen. Maybe I can
> trace this to a bad register value.

I've got some traces from Linux and MorphOS (both on my work in progress 
pegasos2 emulation using via-ide where I can most easily reproduce this) 
but I'm not sure what to look for in these. MorphOS starts booting, so 
firmware can read ide-cd connected to via-ide as well as MorphOS can 
before enabling UDMA 5 mode but stops after that and cannot read the drive 
any more. Linux works even after enabling DMA. I've gathered some logs in 
https://osdn.net/projects/qmiga/ticket/38949 previously but now I try to 
list here the part in more detail where drive is detected, enabling DMA 
and first command after that in case you can spot something in these that 
could explain why it fails with MorphOS driver.

First the working Linux case:

pci_cfg_read via-ide 12:1 @0x4 -> 0x87
pci_cfg_read via-ide 12:1 @0x3d -> 0x1
pci_cfg_read via-ide 12:1 @0x4 -> 0x87
pci_cfg_read via-ide 12:1 @0x40 -> 0xb
pci_cfg_read via-ide 12:1 @0x40 -> 0xb
bmdma_read_via bmdma: readb 0x2 : 0x00
bmdma_read_via bmdma: readb 0x2 : 0x00
pci_cfg_read via-ide 12:1 @0x4 -> 0x87
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x0a; bus 0x56229cb35600
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x00; bus 0x56229cb35600 IDEState 0x56229cb35a58
bmdma_read_via bmdma: readb 0x2 : 0x00
bmdma_write_via bmdma: writeb 0x2 : 0x00
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x0a; bus 0x56229cb35ef0
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
bmdma_read_via bmdma: readb 0x2 : 0x00
bmdma_write_via bmdma: writeb 0x2 : 0x00
pci_cfg_read via-ide 12:1 @0x9 -> 0x8f
[    2.589547] scsi0 : pata_via
[    2.590949] scsi1 : pata_via
[    2.591488] ata1: PATA max UDMA/100 cmd 0x1000 ctl 0x100c bmdma 0x1020 irq 9
[    2.591652] ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x101c bmdma 0x1028 irq 9

[...]

[    2.938174] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
pci_cfg_read via-ide 12:1 @0x4c -> 0xaa
pci_cfg_write via-ide 12:1 @0x4c <- 0xa2
pci_cfg_write via-ide 12:1 @0x4e <- 0x31
pci_cfg_write via-ide 12:1 @0x49 <- 0x31
pci_cfg_read via-ide 12:1 @0x51 -> 0x17
pci_cfg_write via-ide 12:1 @0x51 <- 0x17
pci_cfg_read via-ide 12:1 @0x4c -> 0xa2
pci_cfg_write via-ide 12:1 @0x4c <- 0xa2
pci_cfg_write via-ide 12:1 @0x4e <- 0x31
pci_cfg_write via-ide 12:1 @0x49 <- 0x31
pci_cfg_read via-ide 12:1 @0x51 -> 0x17
pci_cfg_write via-ide 12:1 @0x51 <- 0xf0
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x50; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x0a; bus 0x56229cb35ef0
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x1 (Features); val 0x03; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x2 (Sector Count); val 0x45; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x3 (Sector Number); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x4 (Cylinder Low); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x5 (Cylinder High); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x7 (Command); val 0xef; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_exec_cmd IDE exec cmd: bus 0x56229cb35ef0; state 0x56229cb35f78; cmd 0xef
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x50; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x08; bus 0x56229cb35ef0
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
bmdma_read_via bmdma: readb 0x2 : 0x00
bmdma_write_via bmdma: writeb 0x2 : 0x00
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x1 (Error); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x2 (Sector Count); val 0x45; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x3 (Sector Number); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x4 (Cylinder Low); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x5 (Cylinder High); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x6 (Device/Head); val 0x20; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x50; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x0a; bus 0x56229cb35ef0
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x1 (Features); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x2 (Sector Count); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x3 (Sector Number); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x4 (Cylinder Low); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x5 (Cylinder High); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x7 (Command); val 0xa1; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_exec_cmd IDE exec cmd: bus 0x56229cb35ef0; state 0x56229cb35f78; cmd 0xa1
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x58; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x50; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x08; bus 0x56229cb35ef0
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
bmdma_read_via bmdma: readb 0x2 : 0x00
bmdma_write_via bmdma: writeb 0x2 : 0x00
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x1 (Error); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x2 (Sector Count); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x3 (Sector Number); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x4 (Cylinder Low); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x5 (Cylinder High); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x6 (Device/Head); val 0x20; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
[    2.953806] ata2.00: configured for UDMA/100
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x50; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x1 (Features); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x2 (Sector Count); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x3 (Sector Number); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x4 (Cylinder Low); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x5 (Cylinder High); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_write IDE PIO wr @ 0x7 (Command); val 0xa0; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_exec_cmd IDE exec cmd: bus 0x56229cb35ef0; state 0x56229cb35f78; cmd 0xa0
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x58; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_atapi_cmd IDEState: 0x56229cb35f78; cmd: 0x00
ide_atapi_cmd_packet IDEState: 0x56229cb35f78; limit=0x0 packet: 00 00 00 00 00 00 00 00 00 00 00 00
mv64361_gpp_irq(0x56229c93a230, 31, 1) 80000000 80000000
mv64361_update_irq(0x56229c93a230, 59, 1)
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x50; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
mv64361_gpp_irq(0x56229c93a230, 31, 0) 0
mv64361_update_irq(0x56229c93a230, 59, 0)
ide_status_read IDE PIO rd @ 0x4 (Alt Status); val 0x50; bus 0x56229cb35ef0; IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
bmdma_read_via bmdma: readb 0x2 : 0x04
bmdma_write_via bmdma: writeb 0x2 : 0x04
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x56229cb35ef0 IDEState 0x56229cb35f78
ide_ioport_read IDE PIO rd @ 0x1 (Error); val 0x00; bus 0x56229cb35ef0 IDEState 0x56229cb35f78

While MorphOS stops after enabling DMA:

PCI ATA/ATAPI Driver-Driver_ScanBus@1: Identify succeed
PCI ATA/ATAPI Driver-Driver_ScanBus@1: Signature 0x0
PCI ATA/ATAPI Driver-Driver_ScanBus@1: Config 0x85c0
PCI ATA/ATAPI Driver-Driver_SetParam@2: Type 0x4
PCI ATA/ATAPI Driver-Driver_SetParam@2: Capabilities 0x300
PCI ATA/ATAPI Driver-Driver_SetParam@2: PIOMode 0x0
PCI ATA/ATAPI Driver-Driver_SetParam@2: ATAPI supports at least PioMode 3
PCI ATA/ATAPI Driver-Driver_SetParam@2: Old PIOMode 0x3 DMAMode 0x0
PCI ATA/ATAPI Driver-Driver_SetParam@2: New PIOMode/DMAMode fields are valid
PCI ATA/ATAPI Driver-Driver_SetParam@2: PIOMask 0x3 DMAMask 0x7
PCI ATA/ATAPI Driver-Driver_SetParam@2: Supported PIOMode 4 DMAMode 2 UDMAMode 5
PCI ATA/ATAPI Driver-Driver_SetParam@2: Version 30 Revision 0
PCI ATA/ATAPI Driver-Driver_SetParam@2: 12 byte cmds
PCI ATA/ATAPI Driver-Driver_SetParam@2: Max PIOMode 4
PCI ATA/ATAPI Driver-Driver_SetParam@2: Set PioMode 4
PCI ATA/ATAPI Driver-Driver_SetFeature@2: Code 0x3 SubCode 0xc
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x0a; bus 0x562c141a9840
ide_ioport_write IDE PIO wr @ 0x1 (Features); val 0x03; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x2 (Sector Count); val 0x0c; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x3 (Sector Number); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x5 (Cylinder High); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x7 (Command); val 0xef; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_exec_cmd IDE exec cmd: bus 0x562c141a9840; state 0x562c141a98c8; cmd 0xef
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x2 (Sector Count); val 0x0c; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x3 (Sector Number); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x5 (Cylinder High); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x6 (Device/Head); val 0xa0; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x00; bus 0x562c141a9840
PCI ATA/ATAPI Driver-Driver_SetFeature@2: done
PCI ATA/ATAPI Driver@2: PIO Mode 4
pci_cfg_write via-ide 12:1 @0x49 <- 0x20
PCI ATA/ATAPI Driver-Driver_SetParam@2: Set DmaMode 2
PCI ATA/ATAPI Driver-Driver_SetFeature@2: Code 0x3 SubCode 0x22
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x0a; bus 0x562c141a9840
ide_ioport_write IDE PIO wr @ 0x1 (Features); val 0x03; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x2 (Sector Count); val 0x22; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x3 (Sector Number); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x5 (Cylinder High); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x7 (Command); val 0xef; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_exec_cmd IDE exec cmd: bus 0x562c141a9840; state 0x562c141a98c8; cmd 0xef
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x2 (Sector Count); val 0x22; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x3 (Sector Number); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x5 (Cylinder High); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x6 (Device/Head); val 0xa0; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x00; bus 0x562c141a9840
PCI ATA/ATAPI Driver-Driver_SetFeature@2: done
bmdma_read_via bmdma: readb 0x2 : 0x00
bmdma_write_via bmdma: writeb 0x2 : 0x26
PCI ATA/ATAPI Driver-Driver_SetParam@2: Set UDmaMode 5
PCI ATA/ATAPI Driver-Driver_SetFeature@2: Code 0x3 SubCode 0x45
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x0a; bus 0x562c141a9840
ide_ioport_write IDE PIO wr @ 0x1 (Features); val 0x03; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x2 (Sector Count); val 0x45; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x3 (Sector Number); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x5 (Cylinder High); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0xa0; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x7 (Command); val 0xef; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_exec_cmd IDE exec cmd: bus 0x562c141a9840; state 0x562c141a98c8; cmd 0xef
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x50; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x2 (Sector Count); val 0x45; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x3 (Sector Number); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x5 (Cylinder High); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x6 (Device/Head); val 0xa0; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_cmd_write IDE PIO wr @ 0x4 (Device Control); val 0x00; bus 0x562c141a9840
PCI ATA/ATAPI Driver-Driver_SetFeature@2: done
PCI ATA/ATAPI Driver@2: UDMA Mode 5
pci_cfg_write via-ide 12:1 @0x51 <- 0xe0
bmdma_read_via bmdma: readb 0x2 : 0x20
bmdma_write_via bmdma: writeb 0x2 : 0x26
PCI ATA/ATAPI Driver-Driver_SetParam@2: CDROM..Set no WriteCache
PCI ATA/ATAPI Driver-Driver_SetParam@2: Cylinders 0
PCI ATA/ATAPI Driver-Driver_SetParam@2: Heads 0
PCI ATA/ATAPI Driver-Driver_SetParam@2: Sectors/Cyl 0
PCI ATA/ATAPI Driver-Driver_SetParam@2: TotalSectors 0
PCI ATA/ATAPI Driver-Driver_SetParam@2: TotalSectors48 0
PCI ATA/ATAPI Driver-Driver_SetParam@2: Support.Flags 0x200003

Then it tries to identify the phantom ATA drive that seems to be present 
on other port but not working; this was discussed before. Finally tries to 
read CD drive:
[...]

Dev_Inquiry@ide.device-2: DiskPort 0x140f8890
Dev_Inquiry@ide.device-2: ATAPI
Dev_InquirySCSI@ide.device-2:
Dev_InquirySCSI@ide.device-2: Send TestDrive
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a9c98
ide_ioport_write IDE PIO wr @ 0x1 (Features); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x2 (Sector Count); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x3 (Sector Number); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x5 (Cylinder High); val 0x80; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x6 (Device/Head); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_write IDE PIO wr @ 0x7 (Command); val 0xa0; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_exec_cmd IDE exec cmd: bus 0x562c141a9840; state 0x562c141a98c8; cmd 0xa0
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x2 (Sector Count); val 0x01; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x5 (Cylinder High); val 0x80; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x4 (Cylinder Low); val 0x00; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_ioport_read IDE PIO rd @ 0x7 (Status); val 0x58; bus 0x562c141a9840 IDEState 0x562c141a98c8
ide_atapi_cmd IDEState: 0x562c141a98c8; cmd: 0x00
ide_atapi_cmd_packet IDEState: 0x562c141a98c8; limit=0x8000 packet: 00 00 00 00 00 00 00 00 00 00 00 00
mv64361_gpp_irq(0x562c13faea60, 31, 1) 80000000 80000000
mv64361_update_irq(0x562c13faea60, 59, 1)
mv64361_gpp_irq(0x562c13faea60, 31, 0) 0
mv64361_update_irq(0x562c13faea60, 59, 0)
mv64361_gpp_irq(0x562c13faea60, 31, 1) 80000000 80000000
mv64361_update_irq(0x562c13faea60, 59, 1)
mv64361_gpp_irq(0x562c13faea60, 31, 0) 0
mv64361_update_irq(0x562c13faea60, 59, 0)

Then it stucks here not sending any more ATAPI commands despite interrupt 
is raised and lowered a few times afterwards but I don't see any more ide 
commands issued so it seems it may not get the expected interrupt? Do you 
see anything in the above logs that could explain this?

Thank you,
BALATON Zoltan

