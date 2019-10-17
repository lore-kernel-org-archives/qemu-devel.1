Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0DECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF8321D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF8321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6yM-0002ag-2N
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iL5uW-0003f8-EE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1iL5uU-000446-VB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:33:48 -0400
Received: from mx4.kent.ac.uk ([129.12.21.35]:37000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1iL5uU-00043g-PY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:33:46 -0400
Received: from mx5.kent.ac.uk ([129.12.21.36])
 by mx4.kent.ac.uk with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92.3) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1iL5W0-0007Xb-FI; Thu, 17 Oct 2019 14:08:28 +0100
Received: from 250.8.90.146.dyn.plus.net ([146.90.8.250] helo=cadance.lan)
 by mx5.kent.ac.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92.3) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1iL5W0-0005do-6e; Thu, 17 Oct 2019 14:08:28 +0100
Date: Thu, 17 Oct 2019 14:11:59 +0100
From: Sarah Harris <S.E.Harris@kent.ac.uk>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
Message-Id: <20191017141159.435deb1f636578eb7f65f8b9@kent.ac.uk>
In-Reply-To: <6dfd36cf-9d2f-d74a-2c8e-4b283973e8f7@redhat.com>
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
 <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
 <c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
 <CAK4993h0yCqpjBFzPy7GHt3kbSK43nLD6EXh4WFd_STHu15DTA@mail.gmail.com>
 <20190510121732.de0aa4075bcf6962a7414054@kent.ac.uk>
 <6dfd36cf-9d2f-d74a-2c8e-4b283973e8f7@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Kent-Spam-Score: -1.0
X-Kent-Spam-Bar: -
X-Kent-Spam-Report: No, tests=ALL_TRUSTED=-1,TVD_RCVD_IP=0.001
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 129.12.21.35
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 E.J.C.Robbins@kent.ac.uk, A.M.King@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

I've checked and yes, I can make time to review patches.
This is part of my current paid work, so when my contract eventually ends I=
 will likely have to step down as reviewer.
I'll have notice of that happening some time before, so I can pass that alo=
ng when it comes.

This message comes from my work email so the details should be correct, i.e=
. Sarah Harris <S.E.Harris@kent.ac.uk>

Kind regards,
Sarah Harris

On Sat, 12 Oct 2019 09:31:07 +0200
Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:

> Hi Sarah,
>=20
> On 5/10/19 1:17 PM, Sarah Harris wrote:
> > Hi Richard,
> >=20
> > Having discussed with my colleagues, we don't have the resources to mai=
ntain this.
> > If you wanted to take up Michael's offer then I'm happy to respond to q=
ueries and provide minor fixes.
> > Otherwise, we will make our repository publicly available in the near f=
uture for anyone who wants to use it.
>=20
> Would you agree to be listed as reviewer for AVR (Michael being the=20
> maintainer)?
>=20
>    M: Mail patches to: FullName <address@domain>
>       Maintainers are looking after a certain area and must be CCed on
>       patches. They are considered the main contact point.
>    R: Designated reviewer: FullName <address@domain>
>       These reviewers should be CCed on patches.
>       Reviewers are familiar with the subject matter and provide feedback
>       even though they are not maintainers.
>=20
> > Kind regards,
> > Sarah Harris
> >=20
> > On Sun, 5 May 2019 09:10:00 -0700
> > Michael Rolnik <mrolnik@gmail.com> wrote:
> >=20
> >> Hi Richard.
> >>
> >> I can maintain it
> >>
> >> Sent from my cell phone, please ignore typos
> >>
> >> On Sun, May 5, 2019, 8:57 AM Richard Henderson <richard.henderson@lina=
ro.org>
> >> wrote:
> >>
> >>> On 5/4/19 1:36 AM, Sarah Harris wrote:
> >>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> >>> ...
> >>>>
> >>>> +AVR
> >>>> +M: Michael Rolnik <mrolnik@gmail.com>
> >>>> +S: Odd Fixes
> >>>> +F: target-avr/
> >>>> +F: hw/avr/
> >>>> +
> >>>
> >>> This is not how things work.  Michael wasn't up to maintaining the co=
de 2
> >>> years
> >>> ago; that's why it was never committed.
> >>>
> >>> You would need to maintain this yourself, and for more than "Odd Fixe=
s".
> >>>
> >>>
> >>> r~
> >>>
> >=20
>=20

