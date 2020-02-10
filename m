Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66919C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18AB12080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVODwhkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AB12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ENy-0006hM-78
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j1EMr-00064W-DM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j1EMn-0007Uz-Hw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:05:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j1EMn-0007S0-7P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581361507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eSWm4aGZXVW0Xcyf7AhtN4wBwh+PLiKpU4IQtb2IPPk=;
 b=MVODwhkgJDX1UQoHoPpZ/fCwuFojfuuRJ3CONZ0MzStGC1UFq1W61H/qVzvNzPWFih7m3J
 bQoxbbb/auHy8TmyEU9Gh8f3lwjn5EdJd3IWK8zvQw2EsQqA2HeXHsTqwpsQd/bnGxCmqe
 BVyKGaz2Pr6xCwCgQnuMXur7Kacz52Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-PBjciJF1OLmtp9ruFEyAbA-1; Mon, 10 Feb 2020 14:04:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D4D918A8C82;
 Mon, 10 Feb 2020 19:04:55 +0000 (UTC)
Received: from [10.18.17.116] (dhcp-17-116.bos.redhat.com [10.18.17.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1D695C28D;
 Mon, 10 Feb 2020 19:04:53 +0000 (UTC)
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
To: BALATON Zoltan <balaton@eik.bme.hu>, jasper.lowell@bt.com
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <20200205173326.GA3256@work-vm>
 <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
 <alpine.BSF.2.22.395.2002080030360.88696@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2002101546080.56058@zero.eik.bme.hu>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <078a89dc-3e5f-2152-8783-1f22483c4603@redhat.com>
Date: Mon, 10 Feb 2020 14:04:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2002101546080.56058@zero.eik.bme.hu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: PBjciJF1OLmtp9ruFEyAbA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: mark.cave-ayland@ilande.co.uk, dgilbert@redhat.com, atar4qemu@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/10/20 10:38 AM, BALATON Zoltan wrote:
> On Sat, 8 Feb 2020, BALATON Zoltan wrote:
>> Not sure if my problem I see on other machine emulation I'm working on
>> is related at all but there's a possibility it might be. I got this
>> with different arch (ppc but could also reproduce something similar
>> with mips) and ide controller emulation (via-ide) but the PCI bmdma
>> code is shared by CMD646, via-ide and sii3112 and also the ide-cdrom
>> emulation is the same so if there's a bug in these that could cause
>> similar problems for different components. Or it could be that we get
>> similar symptoms due to different reasons in which case sorry for the
>> distracion but maybe we can learn from the experience of each other
>> even in that case.
>>
>> What I get is tracked here:
>>
>> https://osdn.net/projects/qmiga/ticket/38949
>>
>> (background on emulated machine:
>> https://osdn.net/projects/qmiga/wiki/SubprojectPegasos2 )
>>
>> Originally I had both Linux and MorphOS fail after enabling BMDMA
>> before I had interrupt controller emulation (so that means it could be
>> a problem with that in your case as well so something to check). Now
>> that I've implemented interrupts Linux boots with DMA from CDROM but
>> MorphOS is still not happy.
>=20
> I could now also reproduce the same with AmigaOS4 on pegasos2 where I
> got same missing interrupt problem:
>=20
> ---> Port 1
> IOBase 00001010, AltBase 0000101E
> bmcr_base 00001028
> MMIOBase 00000000
> Config not forced, scanning ...
> 1 device(s) on port
> =A00 Master : 'ATAPI'

"unit 2", I assume

> =A01 Slave=A0 : 'unknown type'

"unit 3", I assume

> Starting 'peg2ide.device - chip 0 port 1' task
> bmdma_addr_write data: 0x0000000002290000
> Trying to configure unit 2
>=20
> Hangs here waiting for interrupt which does not seem to arrive, then:
>=20
> [peg2ide/irq_wait] timed out
> [peg2ide/exec_pio_data_in_cmd] <- here
> [peg2ide/ata_read_drive_properties] unit 2 returned error 255, failbits
> 00000000h, timeout 0
> Trying to configure unit 3
> [peg2ide/ata_read_drive_properties] After-reset signature invalid for
> unit 3
>=20
> So there's definitely a problem with interrupts but not sure where. Also
> don't know why it detects an unknown slave device which then it decides
> is invalid. Maybe this is normal on an IDE bus with only one device or
> is it a problem in emulation?
>=20

I don't actually know myself. We *do* always have two IDEState objects
per port, but maybe we're letting some unknown state sneak through --
filling in a register improperly, perhaps?

It's probably not ide_ioport_read -- but I see complaints about the
reset signature too, so maybe we've gotten that wrong.

You can look at ide_set_signature to see how we set the drive
signatures; called from ide_reset (and many other places too)

I think ide_init_drive is only meant to be called on devices that
actually exist and are plugged in. It initializes drive_kind to one of
IDE_HD, IDE_CD, or IDE_CFATA -- empty or missing isn't an option here.

(Hm, this means it defaults to IDE_HD actually.)

The tricky thing is that IDEState belongs to the parent bus -- not the
drive object itself -- and the bus always has two slots.

We select between the two by setting bus->unit; and we don't appear to
do any kind of actual guarding that the drive actually exists.

(I suppose guests are free to issue commands to non-existant drives if
they want to, but they're not going to be able to perform work.)

...but ide_reset_bus calls ide_reset on both slots regardless of the
presence of a device or not.

(This is probably just a side effect of the interrupt getting lost and
having the guest try to reset the controller, then noticing weird state
after the reset.)

It sounds like the real problem is either in the bmdma controller (or
its unique interaction with hw/ide/core.c -- which is possible) or in
the interrupt routing somewhere else.

If you have any IDE traces from a hang, feel free to throw them up on a
pastebin for me to take a peek at; it might help for me to see the exact
sequence that causes a hang in QEMU's IDE terms to see if I can't
"reverse engineer" what the guest is hoping to have happen. Maybe I can
trace this to a bad register value.

(Hm, it's failing on pio_in? It's using PIO on an IDE drive with a DMA
controller? Is it failing to enable DMA and then failing to use PIO as a
backup too? Maybe there are two bugs.)

--js

> To locate the problem further I've then tried the same with ide-cd
> connected to the sii3112 SATA emulation that also shares the same IDE
> BMDMA code with CMD646 and via-ide but as a PCI card the interrupt
> routing is different. So if I don't get the problem with it then that
> can prove common code is correct. If I get the problem it may come from
> common code or be another interrupt routing problem.
>=20
> I did not have PCI interrupts correctly implemented in pegasos2 yet so I
> had to fix that first but I'm not sure it's correct yet. I got similar
> results but the interrupt seems to fire in this case but does not get to
> the CPU as it does not seem to be enabled:
>=20
> sii3112ide.device 53.3 (05.02.2009)
> Found chip #0
> ---> Port 0
> IOBase 00001030, AltBase 0000103A
> bmcr_base 00001090
> MMIOBase 81004000
> Config not forced, scanning ...
> sii3112_write bmdma: write (size 1) 0x8a : 0x02
> sii3112_write bmdma: write (size 1) 0x86 : 0x00
> sii3112_write bmdma: write (size 1) 0x82 : 0x55
> sii3112_write bmdma: write (size 1) 0x83 : 0xaa
> sii3112_write bmdma: write (size 1) 0x82 : 0xaa
> sii3112_write bmdma: write (size 1) 0x83 : 0x55
> sii3112_write bmdma: write (size 1) 0x82 : 0x55
> sii3112_write bmdma: write (size 1) 0x83 : 0xaa
> sii3112_read bmdma: read (size 1) 0x82 : 0x55
> sii3112_read bmdma: read (size 1) 0x83 : 0xaa
> sii3112_write bmdma: write (size 1) 0x86 : 0x00
> sii3112_write bmdma: write (size 1) 0x8a : 0x06
> sii3112_write bmdma: write (size 1) 0x8a : 0x02
> sii3112_set_irq channel 0 level 0
> sii3112_read bmdma: read (size 1) 0x87 : 0x00
> sii3112_write bmdma: write (size 1) 0x86 : 0x00
> sii3112_write bmdma: write (size 1) 0x86 : 0x00
> sii3112_write bmdma: write (size 1) 0x86 : 0x00
> sii3112_read bmdma: read (size 1) 0x82 : 0x01
> sii3112_read bmdma: read (size 1) 0x83 : 0x01
> sii3112_read bmdma: read (size 1) 0x84 : 0x14
> sii3112_read bmdma: read (size 1) 0x85 : 0xeb
> sii3112_set_irq channel 0 level 0
> sii3112_read bmdma: read (size 1) 0x87 : 0x00
> sii3112_write bmdma: write (size 1) 0x86 : 0x00
> 1 device(s) on port
> =A00 Master : 'ATAPI'
> Starting 'sii3112ide.device - chip 0 port 0' task
> sii3112_write bmdma: write (size 4) 0x4 : 0x22c0000
> bmdma_addr_write data: 0x00000000022c0000
> Installing handler for irq 25
> mv64361_gpp_irq(0x5654b950c1a0, 31, 1) levels=3D80000000 mask=3D80000000
> mv64361_update_irq(0x5654b950c1a0, 59, 1)
> mv64361_gpp_irq(0x5654b950c1a0, 31, 0) levels=3D0
> mv64361_update_irq(0x5654b950c1a0, 59, 0)
> Unassigned mem read 00000000810040a1
> Trying to configure unit 0
> sii3112_write bmdma: write (size 1) 0x86 : 0x00
> sii3112_set_irq channel 0 level 0
> sii3112_read bmdma: read (size 1) 0x87 : 0x00
> sii3112_write bmdma: write (size 1) 0x8a : 0x00
> sii3112_write bmdma: write (size 1) 0x81 : 0x00
> sii3112_write bmdma: write (size 1) 0x82 : 0x00
> sii3112_write bmdma: write (size 1) 0x83 : 0x00
> sii3112_write bmdma: write (size 1) 0x84 : 0x00
> sii3112_write bmdma: write (size 1) 0x85 : 0x00
> sii3112_write bmdma: write (size 1) 0x86 : 0x40
> sii3112_write bmdma: write (size 1) 0x87 : 0xa1
> sii3112_set_irq channel 0 level 1
> mv64361_pcihost_set_irq(0x5654b950ce00, 1, 1)
> mv64361_gpp_irq(0x5654b950c1a0, 13, 1) levels=3D2000 mask=3D80000000
>=20
> [sii3112ide/irq_wait] timed out
> [sii3112ide/exec_pio_data_in_cmd] <- here
> sii3112_set_irq channel 0 level 0
> mv64361_pcihost_set_irq(0x5654b950ce00, 1, 0)
> mv64361_gpp_irq(0x5654b950c1a0, 13, 0) levels=3D0
> mv64361_update_irq(0x5654b950c1a0, 57, 0)
> sii3112_read bmdma: read (size 1) 0x87 : 0x58
> [sii3112ide/ata_read_drive_properties] unit 0 returned error 255,
> failbits 00000000h, timeout 0
>=20
> So here I see there's an interrupt raised by the card which does also
> get to the mv64361 system controller that's also the interrupt
> controller on pegasos2 but CPU IRQ is not raised because the
> corresponding mask bit is not set for some reason.
>=20
> This suggests the common IDE bmdma and ide-cd code is likely OK and
> problem is somewhere in irq routing. What's relevant for this thread and
> sparc64 is that then you should also check interrupt controller and
> routing if an interrupt raised by the IDE controller could get to the
> CPU in your case as that could be where the problem is and maybe not in
> common code as I've suspected before.
>=20
> For my case I'm not sure. On pegasos2 irqs come in via the mv64361 gpio
> ports, the irq pin of the VIA south bridge (containing via-ide and the
> 16 isa interrupts) is connected to gpp_irq 31 while the PCI INTA-D lines
> are connected to gpp_irq 12-15. These are mapped to interrupt cause bits
> 56-59 so that gpp0-7 gets 56, gpp8-15 57, gpp16-23 58 and gpp 24-31 gets
> 59. Thus the IRQ numbers seem correct in the above but the expected
> interrupt on 59 is only raised when the sii3112 driver is insalling its
> interrupt handler (not sure why does it call that irq 25?). This should
> have been raised when talking to device on via-ide much earlier. Then
> when talking to device on sii3112 the interrupt arrives from PCI on the
> expected 57 but CPU IRQ is not raised because it is masked, only gpp 31
> is enabled. This supposedly works on real hardware but don't get why it
> doesn't on my emulation. It's probably a bug in the IRQ controller
> emulation then and topic for another thread and other platforms that
> similar error happens may also have bugs in their IRQ routing.
>=20


