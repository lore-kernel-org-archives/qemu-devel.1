Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A87AC4BA00
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 22:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C61921927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 22:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C61921927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6iRx-0007My-Ek
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 17:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j6iRD-0006uF-9q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 17:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j6iRB-000852-Li
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 17:12:22 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:27223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1j6iRB-00080s-FF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 17:12:21 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E4D2974637F;
 Tue, 25 Feb 2020 23:12:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B846874637C; Tue, 25 Feb 2020 23:12:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B62A374569F;
 Tue, 25 Feb 2020 23:12:18 +0100 (CET)
Date: Tue, 25 Feb 2020 23:12:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: RE: Emulating Solaris 10 on SPARC64 sun4u
In-Reply-To: <alpine.BSF.2.22.395.2002101546080.56058@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2002252307210.87116@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <20200205173326.GA3256@work-vm>
 <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
 <alpine.BSF.2.22.395.2002080030360.88696@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2002101546080.56058@zero.eik.bme.hu>
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
Cc: John Snow <jsnow@redhat.com>, mark.cave-ayland@ilande.co.uk,
 dgilbert@redhat.com, atar4qemu@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Feb 2020, BALATON Zoltan wrote:
> This suggests the common IDE bmdma and ide-cd code is likely OK and problem 
> is somewhere in irq routing. What's relevant for this thread and sparc64 is 
> that then you should also check interrupt controller and routing if an 
> interrupt raised by the IDE controller could get to the CPU in your case as 
> that could be where the problem is and maybe not in common code as I've 
> suspected before.

I can now confirm that my problem was related to IRQ routing as noted 
here:

https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg07225.html

so any similar problem for Solaris is not related to this and common IDE 
and BMDMA code are likely OK so you may want to check IRQ handling in 
board and chipset emulation in case the cause is similar to what I had.

Regards,
BALATON Zoltan

