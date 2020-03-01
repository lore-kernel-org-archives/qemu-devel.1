Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A56C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87696246BE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87696246BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8SvO-0002z2-OU
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 13:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j8Sul-0002ZR-Cz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j8Suj-0004J3-Lq
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:02:06 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:32646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j8Suj-0004Hi-Ft
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:02:05 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DDDD3746383;
 Sun,  1 Mar 2020 19:02:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B530D746381; Sun,  1 Mar 2020 19:02:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B28E874637E;
 Sun,  1 Mar 2020 19:02:02 +0100 (CET)
Date: Sun, 1 Mar 2020 19:02:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2003011847220.28669@zero.eik.bme.hu>
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

Hello,

On Wed, 26 Feb 2020, jasper.lowell@bt.com wrote:
> According to the CMD646U2 specification:
> "When an IDE port is in PCI IDE Legacy Mode, the PCI646U2 is compatible
> with standard ISA IDE. The IDE task file registers are mapped to the
> standard ISA port addresses, and IDE drive interrupts occur at IRQ14
> (primary) or IRQ15 (secondary)."
>
> In legacy mode, IRQ14 and IRQ15 mirror the state of INTRQ on each of
> the selected IDE devices. QEMU appears to emulate this correctly.

So CMD646 also seems to have a legacy mode. I've also seen a CMD PCI0640B 
spec which is proabably a similar chip which says for interrupt handling:

"When DSA1 is pulled low during reset, both IDE ports are in PCI IDE 
Legacy Mode. When DSA1 has no pull-down during reset, each IDE port may 
independently be set to PCI IDE Legacy Mode or Native Mode via the 
Programming Interface Byte (configuration register PROGIF, Index 9h). When 
an IDE port is in PCI IDE Legacy Mode, the PCI-0640B is compatible with 
standard ISA IDE. The IDE task file registers are mapped to the standard 
ISA port addresses, and IDE drive interrupts occur at IRQ14 (primary) or 
IRQ15 (secondary).

When an IDE port is in PCI IDE Native Mode, the IDE task file registers 
may be mapped to non-standard port addresses, and IDE drive interrupts 
occur at PCI INTA. Therefore, if both IDE ports are in PCI IDE Native 
Mode, drive interrupts from both IDE ports are multiplexed into PCI INTA. 
In this case, the interrupt status bits must be polled to determine which 
IDE port generated the interrupt, or whether the interrupt was generated 
by another PCI device sharing INTA on the bus."

This same explanation also appears in CMD646 doc. So what mode is the 
PROG_IF config reg set to and do the interrupts raised match that? 
cmd646_update_irq() only seems to raise PCI interrupt, should it also have 
an option to use INT 14 and 15 in legacy mode similar to what my patch 
does for via-ide?

Additionally Solaris may also get info from the OF device tree so that may 
also have to match the device config.

I'm not sure this helps but I don't have any better idea.

Regards,
BALATON Zoltan


