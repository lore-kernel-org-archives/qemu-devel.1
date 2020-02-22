Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9948C3567C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 17:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75E4208C4
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 17:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75E4208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Ywc-0008PF-P2
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 12:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j5Yvn-0007tq-Fj
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 12:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j5Yvl-0001WY-Fd
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 12:51:10 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:39859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j5Yvl-0001Rw-8w
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 12:51:09 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A0E4874637E;
 Sat, 22 Feb 2020 18:50:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 82BAF745953; Sat, 22 Feb 2020 18:50:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8156B74569F;
 Sat, 22 Feb 2020 18:50:57 +0100 (CET)
Date: Sat, 22 Feb 2020 18:50:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <d805ea83320fdb2de626b0657e94a87bc0ea5015.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2002221821140.95119@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <alpine.BSF.2.22.395.2002211635360.45267@zero.eik.bme.hu>
 <d805ea83320fdb2de626b0657e94a87bc0ea5015.camel@bt.com>
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Feb 2020, jasper.lowell@bt.com wrote:
> I haven't found any documentation that mention that side effect either.
> As you say, it only mentions that you should set the bit to clear.
> While the side effect of clearing interrupts by reading the status
> register doesn't appear to be in documentation anywhere (to my

The PCI bus master IDE spec also only says the status register is read / 
write clear but does not mention clearing bits on read. I've also traced 
back the origin of this code in QEMU and looks like it was there forever 
since commit fc01f7e7f90 when IDE emulation was added. Interesting that 
only Solaris driver broke because of this so maybe there are hardware 
implementations which do clear this bit so drivers are prepared to handle 
that. I think based on at least two docs it would be correct to remove 
this but wonder what other drivers would this change break. Anyway:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> knowledge), I do see this side effect referenced in the source code of
> drivers occasionally.
>
> In /drivers/ide/ide-io.c of the Linux kernel:
> /*
> * Whack the status register, just in case
> * we have a leftover pending IRQ.
> */
> (void)hwif->tp_ops->read_status(hwif);
>
> Along with:
> *	There's nothing really useful we can do with an unexpected
> interrupt,
> *	other than reading the status register (to clear it), and
> logging it.
>
> The CMD64x specific code in the Linux kernel does explicitly set the
> IRQ bits in the bus master IDE status register to clear it. I'm not
> sure why, so maybe someone else can chime in explaining why Linux

It seems likely that CMD646 does not clear irq on read but some other 
controllers probably do.

Regards,
BALATON Zoltan

