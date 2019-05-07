Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0307AC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7B620825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7B620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNz1m-0004Bs-8J
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:16:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <S.E.Harris@kent.ac.uk>) id 1hNyv0-0006e8-1N
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <S.E.Harris@kent.ac.uk>) id 1hNyuz-0001ZE-5u
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:09:58 -0400
Received: from mx0.kent.ac.uk ([129.12.21.32]:39952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
	id 1hNyuy-0001VL-Vi
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:09:57 -0400
Received: from edue375.kent.ac.uk ([129.12.227.117] helo=cadance)
	by mx0.kent.ac.uk with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
	(envelope-from <S.E.Harris@kent.ac.uk>)
	id 1hNyuu-000IVk-Oo; Tue, 07 May 2019 13:09:52 +0100
Date: Tue, 7 May 2019 13:10:44 +0100
From: Sarah Harris <S.E.Harris@kent.ac.uk>
To: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190507131044.132119028123a748e4278add@kent.ac.uk>
In-Reply-To: <CAK4993h0yCqpjBFzPy7GHt3kbSK43nLD6EXh4WFd_STHu15DTA@mail.gmail.com>
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-9-S.E.Harris@kent.ac.uk>
	<c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
	<CAK4993h0yCqpjBFzPy7GHt3kbSK43nLD6EXh4WFd_STHu15DTA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 129.12.21.32
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: E.J.C.Robbins@kent.ac.uk, Sarah Harris <S.E.Harris@kent.ac.uk>,
	Michael Rolnik <mrolnik@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, A.M.King@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

I've raised this with my colleagues, we'll discuss tomorrow whether we have the funding and person resources to provide maintenance and get back to you.

I've noted the issues you and Eric raised, I'll wait until I know where things are going before I look at fixing them.

Kind regards,
Sarah Harris

On Sun, 5 May 2019 09:10:00 -0700
Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi Richard.
> 
> I can maintain it
> 
> Sent from my cell phone, please ignore typos
> 
> On Sun, May 5, 2019, 8:57 AM Richard Henderson <richard.henderson@linaro.org>
> wrote:
> 
> > On 5/4/19 1:36 AM, Sarah Harris wrote:
> > > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > ...
> > >
> > > +AVR
> > > +M: Michael Rolnik <mrolnik@gmail.com>
> > > +S: Odd Fixes
> > > +F: target-avr/
> > > +F: hw/avr/
> > > +
> >
> > This is not how things work.  Michael wasn't up to maintaining the code 2
> > years
> > ago; that's why it was never committed.
> >
> > You would need to maintain this yourself, and for more than "Odd Fixes".
> >
> >
> > r~
> >

