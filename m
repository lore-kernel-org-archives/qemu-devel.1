Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D5C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 19:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE198206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 19:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE198206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5aR1-0000TH-5H
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 14:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j5aQQ-0008TE-JO
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 14:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j5aQP-0002cT-2o
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 14:26:53 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:24134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j5aQO-0002bX-T0
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 14:26:53 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5297374637C;
 Sat, 22 Feb 2020 20:26:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 30675745953; Sat, 22 Feb 2020 20:26:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2EC0F74569F;
 Sat, 22 Feb 2020 20:26:50 +0100 (CET)
Date: Sat, 22 Feb 2020 20:26:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
In-Reply-To: <d805ea83320fdb2de626b0657e94a87bc0ea5015.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2002222021220.95119@zero.eik.bme.hu>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <alpine.BSF.2.22.395.2002211635360.45267@zero.eik.bme.hu>
 <d805ea83320fdb2de626b0657e94a87bc0ea5015.camel@bt.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Feb 2020, jasper.lowell@bt.com wrote:
> This patch doesn't solve all the problems for Solaris 10. It gets
> further in the boot process but it is still unable to mount the file
> system. I suspect that there are more bugs in the IDE/CMD646 emulation.
> I'm going to continue looking into it. It's still possible we are being

One more idea to check is if the irq of the IDE device is mapped at the 
same IRQ line and described correctly in the open firmware device tree. 
You may need info from a real machine for that, I've tried to search for 
it but could not find any device tree dumps or info on how irqs are mapped 
in the real hardware. Since Linux can find it it's probably OK but maybe 
Solaris expects the irq to be mapped somewhere else or gets the info on 
this from some other place than Linux and that could have a bug? Not sure 
if this helps but I have no better idea.

Regards,
BALATON Zoltan

