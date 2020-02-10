Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC45C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F41F20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F41F20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1HdR-0003yU-KK
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 17:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j1Hbt-0003I3-VA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j1Hbr-0006p1-3I
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:32:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12005)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j1Hbq-0006jV-Od
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:32:55 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 64F1D747DF8;
 Mon, 10 Feb 2020 23:32:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2552E747D5D; Mon, 10 Feb 2020 23:32:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 23D5174638A;
 Mon, 10 Feb 2020 23:32:51 +0100 (CET)
Date: Mon, 10 Feb 2020 23:32:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: John Snow <jsnow@redhat.com>
Subject: Missing IRQ with bmdma on ppc/mips/sparc? (was: Re: Emulating Solaris
 10 on SPARC64 sun4u)
In-Reply-To: <078a89dc-3e5f-2152-8783-1f22483c4603@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2002102242040.67831@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <20200205173326.GA3256@work-vm>
 <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
 <alpine.BSF.2.22.395.2002080030360.88696@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2002101546080.56058@zero.eik.bme.hu>
 <078a89dc-3e5f-2152-8783-1f22483c4603@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1333592929-1581373971=:67831"
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
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, dgilbert@redhat.com,
 atar4qemu@gmail.com, jasper.lowell@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1333592929-1581373971=:67831
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

I've changed title to avoid derailing the original thread as this is more=
=20
about pegasos2 issue now but left cc list for now. Let me know if you=20
don't want to be cc'd.

On Mon, 10 Feb 2020, John Snow wrote:
> On 2/10/20 10:38 AM, BALATON Zoltan wrote:
>> On Sat, 8 Feb 2020, BALATON Zoltan wrote:
>>> Not sure if my problem I see on other machine emulation I'm working o=
n
>>> is related at all but there's a possibility it might be. I got this
>>> with different arch (ppc but could also reproduce something similar
>>> with mips) and ide controller emulation (via-ide) but the PCI bmdma
>>> code is shared by CMD646, via-ide and sii3112 and also the ide-cdrom
>>> emulation is the same so if there's a bug in these that could cause
>>> similar problems for different components. Or it could be that we get
>>> similar symptoms due to different reasons in which case sorry for the
>>> distracion but maybe we can learn from the experience of each other
>>> even in that case.
>>>
>>> What I get is tracked here:
>>>
>>> https://osdn.net/projects/qmiga/ticket/38949

I've updated this ticket now with more detailed AmigaOS4 logs that also=20
contains PIO regs except ide_data* to keep it managable. I've lost some o=
f=20
the driver debug messages as it seems QEMU debug messages overwrite those=
=20
when both are directed to stdout so I can't capture them both but added=20
comments to explain what stage they are at.

>>> (background on emulated machine:
>>> https://osdn.net/projects/qmiga/wiki/SubprojectPegasos2 )

(There's also board schematics linked from that page in case someone is=20
interested about how IRQs are connected, it's not impossible I've got tha=
t=20
wrong in my model as I don't really know what real hardware does. The=20
work in progress patches implementing pegasos2 are in the git branch also=
=20
linked from above.)

>>> Originally I had both Linux and MorphOS fail after enabling BMDMA
>>> before I had interrupt controller emulation (so that means it could b=
e
>>> a problem with that in your case as well so something to check). Now
>>> that I've implemented interrupts Linux boots with DMA from CDROM but
>>> MorphOS is still not happy.
>>
>> I could now also reproduce the same with AmigaOS4 on pegasos2 where I
>> got same missing interrupt problem:
>>
>> ---> Port 1
>> IOBase 00001010, AltBase 0000101E
>> bmcr_base 00001028
>> MMIOBase 00000000
>> Config not forced, scanning ...
>> 1 device(s) on port
>> =A00 Master : 'ATAPI'
>
> "unit 2", I assume
>
>> =A01 Slave=A0 : 'unknown type'
>
> "unit 3", I assume

Yes, there was also a "---> Port 0" before that, checking for primary=20
master and slave devices that were unit 0 and 1 but I did not include tha=
t=20
for brevity. Thus secondary master and slave devices are numbered 2 and 3=
.

>> So there's definitely a problem with interrupts but not sure where. Al=
so
>> don't know why it detects an unknown slave device which then it decide=
s
>> is invalid. Maybe this is normal on an IDE bus with only one device or
>> is it a problem in emulation?
>>
>
> I don't actually know myself. We *do* always have two IDEState objects
> per port, but maybe we're letting some unknown state sneak through --
> filling in a register improperly, perhaps?

To make it clear, the problem I have that prevents it from working is the=
=20
missing interrupt after switching to UDMA. The unknown slave device is=20
only causing a delay in detection but then it determines that the=20
secondary device is not working and goes further so I've only reported=20
that as a potential problem in emulation that could be investigated and=20
fixed but it's not the main problem that prevents working.

> It's probably not ide_ioport_read -- but I see complaints about the
> reset signature too, so maybe we've gotten that wrong.
>
> You can look at ide_set_signature to see how we set the drive
> signatures; called from ide_reset (and many other places too)

Unfortunately I don't know much about IDE so likely I would not find=20
out much there.

> I think ide_init_drive is only meant to be called on devices that
> actually exist and are plugged in. It initializes drive_kind to one of
> IDE_HD, IDE_CD, or IDE_CFATA -- empty or missing isn't an option here.
>
> (Hm, this means it defaults to IDE_HD actually.)

From the logs I've seen it does seem to expect an ATA device i.e. HDD as=20
unit 3 but after trying to identify it it gets an error and finds that=20
there's no working device there and goes with just the CD drive. MorphOS=20
does the same but trying a few times before giving up, there are some log=
s=20
showing that in the above ticket,

> The tricky thing is that IDEState belongs to the parent bus -- not the
> drive object itself -- and the bus always has two slots.
>
> We select between the two by setting bus->unit; and we don't appear to
> do any kind of actual guarding that the drive actually exists.
>
> (I suppose guests are free to issue commands to non-existant drives if
> they want to, but they're not going to be able to perform work.)
>
> ...but ide_reset_bus calls ide_reset on both slots regardless of the
> presence of a device or not.

I remember seeing log messages from guest that said it reset the ide bus=20
before trying to probe to avoid hangs that probably happen on real=20
hardware but I don't find them now. But it's possible there was a bus=20
reset before the above probing. I think it wants to get the bus to a know=
n=20
state to avoid problems due to firmware or something else leaving the bus=
=20
and devices in some weird state.

> (This is probably just a side effect of the interrupt getting lost and
> having the guest try to reset the controller, then noticing weird state
> after the reset.)
>
> It sounds like the real problem is either in the bmdma controller (or
> its unique interaction with hw/ide/core.c -- which is possible) or in
> the interrupt routing somewhere else.

Despite being able to reproduce similar problems on ppc mips and sparc64=20
emulations with two different ide controllers (sharing bmdma code) it=20
could well be that all of these have some kind of IRQ routing problem as=20
neither of these are finished and stable yet so I'm not sure the missing=20
IRQ is coming from IDE code. Especially because in the sii3112 case it=20
seems to be generated and only get lost in the last step in the IRQ=20
conroller but don't see why. The guest should have enabled the=20
corresponding interrupt I think. For via-ide it's not obvious where the=20
IRQ gets lost, it seems to be generated later so I don't understand that=20
completely either.

> If you have any IDE traces from a hang, feel free to throw them up on a
> pastebin for me to take a peek at; it might help for me to see the exac=
t
> sequence that causes a hang in QEMU's IDE terms to see if I can't
> "reverse engineer" what the guest is hoping to have happen. Maybe I can
> trace this to a bad register value.

See more logs in the ticket, let me know if you'd need me to check=20
something else. Thanks a lot for looking into this, I'd need to look up=20
all of these IDE interactions to try to make sense of the logs which woul=
d=20
take too much time. Maybe you can spot something easier.

> (Hm, it's failing on pio_in? It's using PIO on an IDE drive with a DMA
> controller? Is it failing to enable DMA and then failing to use PIO as =
a
> backup too? Maybe there are two bugs.)

Before getting to this point where it hangs waiting for the IRQ after=20
switching on UDMA the firmware did find all devices and loaded the OS fro=
m=20
the CD all right and the OS also can talk to ide devices as long as it=20
uses only PIO. The IRQ problem only happens after DMA is enabled but I'm=20
not sure it uses IRQ in PIO at all.

AmigaOS and MorphOS really want to use UDMA only (or highest DMA mode the=
=20
device reports) as otherwise it would be too slow on real hardware so I=20
don't think it wants to fall back, just failing the drive if it does not=20
work in the DMA mode it reports.

Linux may do fallback I'm not sure but booting from a=20
debian-8.11.0-powerpc-netinst.iso seems to work even after it says=20
enabling DMA, whereas I got the same problem with Linux before I hooked u=
p=20
IRQs correctly. Linux logs I get now with via-ide:

[    0.858497] pata_via 0000:00:0c.1: version 0.3.4

[    0.905257] scsi0 : pata_via

[    0.925207] scsi1 : pata_via
[    0.925722] ata1: PATA max UDMA/100 cmd 0x1000 ctl 0x100c bmdma 0x1020=
 irq 9
[    0.925906] ata2: PATA max UDMA/100 cmd 0x1010 ctl 0x101c bmdma 0x1028=
 irq 9

[    1.297537] ata2.01: NODEV after polling detection
[    1.298650] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.318205] ata2.00: configured for UDMA/100
[    1.330427] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     =
2.5+ PQ: 0 ANSI: 5
[    1.401652] sr0: scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    1.401851] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.404116] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.410853] sr 1:0:0:0: Attached scsi generic sg0 type 5

And if boots all right. I think Linux can use DMA and I see interrupts=20
with Linux so maybe the drivers work differently and only the=20
AmigaOS/MorphOS drivers do something that does not work with QEMU or=20
depend on some features on hardware that I did not model correctly.

Regards,
BALATON Zoltan
--3866299591-1333592929-1581373971=:67831--

