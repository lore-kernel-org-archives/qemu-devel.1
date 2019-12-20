Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35545C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 23:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083C42082E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 23:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083C42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiRbY-0001e4-8A
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 18:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iiRav-0000gU-J3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 18:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iiRat-0006bH-Uo
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 18:22:05 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47666)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iiRat-0006Vb-PE; Fri, 20 Dec 2019 18:22:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 0307A28D35;
 Fri, 20 Dec 2019 18:21:58 -0500 (EST)
Date: Sat, 21 Dec 2019 10:22:00 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
In-Reply-To: <067319c3-b426-bb83-56da-6612180d35c5@vivier.eu>
Message-ID: <alpine.LNX.2.21.1.1912210941150.53@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=jN-8zEnCvxq4actoBcrjBviqfxBjGCTT7mBxmSPhiF3w@mail.gmail.com>
 <067319c3-b426-bb83-56da-6612180d35c5@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Herve Poussineau <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019, Laurent Vivier wrote:

> Le 20/12/2019 ? 12:38, Aleksandar Markovic a ?crit?:
> > On Sat, Dec 14, 2019 at 2:29 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> >>
> >> Hi All,
> >>
> >> There is a bug in the DP8393X emulation that can stop packet reception.
> >>
> >> Whilst debugging that issue I found that the receiver algorithm differs
> >> from the one described in the National Semiconductor datasheet.
> >>
> > 
> > Finn, could you please provide the link to the exact datasheet that
> > you used for reference, so that we are on the same page while looking
> > at your code?
> 
> According to his comments ,"National Semiconductor DP83932C" and
> sections seem to be the same, I think the datasheet is:
> 
> https://www.eit.lth.se/fileadmin/eit/courses/datablad/Periphery/Communication/DP83932C.pdf
> 

Yes. I know of 3 datasheets from National Semiconductor,

11719  DP83934CVUL-20/25 MHz SONIC-T Systems-Oriented Network Interface 
Controller with Twisted Pair Interface
10492  DP83932C-20/25/33 MHz SONIC Systems-Oriented Network Interface 
Controller
11722  DP83916 SONIC-16 Systems-Oriented Network Interface Controller

The publication numbered 10492 is the one that Laurent linked to. It and 
11722 both have the same table of contents. The references I gave in the 
patch descriptions are applicable to these. (Having said that, I see now 
that I did mess up one reference. I'll fix it.)

The "1995 National Ethernet Databook" on bitsavers has more information. 
https://mirrorservice.org/sites/www.bitsavers.org/components/national/_dataBooks/1995_National_Ethernet_Databook.pdf

-- 

> Thanks,
> Laurent
> 

