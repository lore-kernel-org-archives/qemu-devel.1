Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB614C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A024E2468C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A024E2468C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uXq-0002rR-RE
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j6uXE-0002Pb-1u
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j6uX9-000870-Ev
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:07:23 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:57042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j6uX7-0007tc-V3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:07:19 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1977D747DFD;
 Wed, 26 Feb 2020 12:07:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DEA25747DFA; Wed, 26 Feb 2020 12:07:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DCC95747DF7;
 Wed, 26 Feb 2020 12:07:15 +0100 (CET)
Date: Wed, 26 Feb 2020 12:07:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2002261109290.39786@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
 <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
 <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
 <alpine.BSF.2.22.395.2002251515290.22173@zero.eik.bme.hu>
 <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com>
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

On Wed, 26 Feb 2020, jasper.lowell@bt.com wrote:
> > Problem with that patch is that it removes this clearing from the func 
> > that's also used to emulate ISA IDE ioports which according to their 
> > spec should clear irq on read so that function should be OK but maybe 
> > should not be called by PCI IDE code?
> 
> This might be it.
> 
> The patch I provided is definitely incorrect and deviates from the
> specification as Mark mentioned earlier. I misunderstood what
> ide_ioport_read/write were for and haven't been thinking about legacy
> mode. 
> 
> The bug that I believe exists is present when the CMD646 is operating
> in PCI native mode. Yeah, I think a possible solution might be to avoid
> using the ioport_read/write functions from the PCI code if they have
> side effects that assume the device is in legacy mode. I'll have to
> spend more time reading through the code and documentation.

Since both the generic PCI IDE and CMD646 Linux drivers mention irq is 
cleared on reading status I think using ide_ioport_read in hw/ide/pci.c 
may be correct for the generic case. Not sure if the CMD646 has some 
pecularity but maybe the difference in drivers is to avoid bugs not 
because of CMD646 not clearing irq. The wikipedia page of CMD640:

https://en.wikipedia.org/wiki/CMD640

mentions some versions of it has a bug similar to RZ-1000 for which 
there's a doc referenced that says the problem is that it forgets last 
data word after raising (or clearing?) IRQ and a workaround is to avoid 
checking status until all data transferred. This may explain why Linux 
checks alt status and clears interrupt instead of reading status register.

> According to the CMD646U2 specification:
> "When an IDE port is in PCI IDE Legacy Mode, the PCI646U2 is compatible
> with standard ISA IDE. The IDE task file registers are mapped to the
> standard ISA port addresses, and IDE drive interrupts occur at IRQ14
> (primary) or IRQ15 (secondary)."
> 
> In legacy mode, IRQ14 and IRQ15 mirror the state of INTRQ on each of
> the selected IDE devices. QEMU appears to emulate this correctly.
> 
> In PCI native mode, INTRQ is not mirrored or given a single IRQ.
> Interrupts are provided by the PCI IDE controller depending on the
> controller's logic. For instance, an IDE device can raise an interrupt
> but the CMD646 may not propagate that interrupt if MRDMODE has certain
> bits set. I'm thinking that maybe the controller does not have logic to
> unset the interrupt bits in CFR and ARTTIM23 when the IDE device lowers
> INTRQ. This might mean that the controller will continue to assert an
> interrupt while bits in CFR and ARTTIM23 remain set, even if the IDE
> device lowers INTRQ. This would explain why the CMD646 documentation
> instructs developers to lower them explicitly.

I don't know but sounds plausible that reading the status reg clears irq 
but reading the pci config words that mirrors it won't clear it. But the 
traces you had show that ide_ioport_read was called so driver was likely 
reading status and not the config regs?

I've found some further logs:

https://forums.gentoo.org/viewtopic-t-270357.html
https://www.redhat.com/archives/axp-list/2000-October/msg00070.html
https://www.linuxtopia.org/online_books/linux_beginner_books/debian_linux_desktop_survival_guide/Docking_Station.shtml

These show Linux messages for early CMD646 revisions that had bugs but 
what I've noticed is that they say something about not 100% native mode 
which seems to be similar to what I had with via-ide when it uses IRQ14-15 
even in native mode. Could your problem be similar? Maybe you could search 
for more such logs for Linux booting on Sun Ultra machines and see what 
those say and check how it determines which IRQ number it should use. This 
may depend on some setting that's not emulated correctly.

> The Linux driver code appears to be consistent with the behaviour that
> I'm seeing from Solaris 10.
> 
> The following appears to be used to initialise the CMD646U.
> 
> {	/* CMD 646U with broken UDMA */
> 	.flags = ATA_FLAG_SLAVE_POSS,
> 	.pio_mask = ATA_PIO4,
> 	.mwdma_mask = ATA_MWDMA2,
> 	.port_ops = &cmd646r3_port_ops
> },
> 
> The port operations it uses are defined as so:
> 
> static struct ata_port_operations cmd646r3_port_ops = {
> 	.inherits	= &cmd64x_base_ops,
> 	.sff_irq_check	= cmd648_sff_irq_check,
> 	.sff_irq_clear	= cmd648_sff_irq_clear,
> 	.cable_detect	= ata_cable_40wire,
> }
> 
> As you mention, cmd648_sff_irq_clear clears interrupts explicitly by
> setting bits in MRDMODE - consistent with the CMD646U2 documentation.
> This behaviour is very similar to Solaris 10.

I think this may be to avoid bug with CMD646U.

> > Although if I got 
> > that correctly Linux thinks revisions over 5 are OK and QEMU has 7.
> 
> I'm not sure how revision numbers work with these chips. Do CMD646 and
> CMD646U2 refer to different revisions of the CMD646 chip?

I'm not sure either but from what I've seen so far I think CMD646 either 
refers to the whole family (i.e. all versions) or early versions depending 
on context while there are at least two more newer versions referred to as 
CMD646U and CMD646U2 but probably there are more revisions within these as 
U2 seems to be rev5. QEMU sets the revision field to 7 but I'm not sure 
that's the same Linux checks for. There's some more info on this here:

https://ata.wiki.kernel.org/index.php/Pata_cmd64x

Regards,
BALATON Zoltan


