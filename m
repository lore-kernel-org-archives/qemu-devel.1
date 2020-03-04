Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE03C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE97220870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE97220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9PiT-00084j-Rl
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j9Php-0007fb-Li
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j9Phn-0003ob-V2
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:48:40 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:58534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j9Phn-0003do-PD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:48:39 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1AA34747E0F;
 Wed,  4 Mar 2020 09:48:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D3DEB747E0E; Wed,  4 Mar 2020 09:48:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D20CB747E0D;
 Wed,  4 Mar 2020 09:48:35 +0100 (CET)
Date: Wed, 4 Mar 2020 09:48:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <06be591e667c6b72c78ae3a33e3092ab323fdb8b.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2003040924320.59033@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
 <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
 <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
 <alpine.BSF.2.22.395.2002251515290.22173@zero.eik.bme.hu>
 <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com> 
 <alpine.BSF.2.22.395.2003011847220.28669@zero.eik.bme.hu>
 <06be591e667c6b72c78ae3a33e3092ab323fdb8b.camel@bt.com>
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

On Wed, 4 Mar 2020, jasper.lowell@bt.com wrote:
>> cmd646_update_irq() only seems to raise PCI interrupt, should it also
>> have
>> an option to use INT 14 and 15 in legacy mode similar to what my
>> patch
>> does for via-ide?
>
> Looking through /qemu/hw/ide/cmd646.c it doesn't look like QEMU has
> support for legacy mode. At the very least, it looks like we default to
> PCI native mode:
>
> static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
> 	...
> 	pci_conf[PCI_CLASS_PROG] = 0x8f;
> 	...
>
> To add support for legacy mode it would require changing
> cmd646_update_irq() and maybe cmd646_set_irq() so that interrupts are
> conditionally raised on IRQ14 and/or IRQ15 when the ports are in legacy
> mode.

Ah yes, same problem as with via-ide. With current ISA IDE and PCI device 
emulation code in QEMU it's not easy to emulate both modes but maybe we 
don't need that either. (So we can avoid changing ISA and PCI QEMU parts 
that are widely used and risk breaking something else by that.) The 
Solaris driver does seem to use native mode because it could find io 
addresses in PCI BARs to talk to the controller just did not get 
interrupts if I got that right. Then maybe PCI interrupts are not routed 
as expected by the driver which could be due to

- difference in PCI bridge emulation,
- where the controller is connected
- or how firmware describes it in device tree
- or how it configures it

compared to real hardware. Unless it also has some pecularity similar to 
pegasos2 with native mode and ISA interrupts. Checking on real hardware 
should reveal these differences so maybe that's the best way to find out. 
As for seeing what the firmware does Sun's OpenBoot is open sourced so 
maybe what that does could be checked but probably not easy to find out in 
Forth.

Here are a few Linux logs I've found that suggest on a Sun Ultra 5/10 IDE 
is on irq 4 for both channels, but not sure how PCI interrupt ends up 
there though. Does that match what QEMU does?

http://gavinduley.org/interests/computing/sundmesg.html
https://lists.debian.org/debian-boot/2004/10/msg00864.html
https://forums.gentoo.org/viewtopic-t-473614-start-0.html

Regards,
BALATON Zoltan

