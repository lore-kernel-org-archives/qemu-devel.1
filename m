Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56DDC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DBA206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DBA206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozKe-0000lX-8j
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iozK3-0000L9-0r
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iozJx-0005fF-MC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:35:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:58396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iozJx-0005dV-8u
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:35:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iozJu-000415-K1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 00:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 93A5E2E80C3
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 00:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2020 00:30:21 -0000
From: "Edgar E. Iglesias" <1856706@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: mips
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dcb314 edgar-iglesias
X-Launchpad-Bug-Reporter: dcb (dcb314)
X-Launchpad-Bug-Modifier: Edgar E. Iglesias (edgar-iglesias)
References: <157658912470.5706.7275804988501900768.malonedeb@gac.canonical.com>
Message-Id:
 <CAJy5ezqveu3i_YC6hhS9yBipycFWUqNOBbmJuRmw2reqeYhUXA@mail.gmail.com>
Subject: Re: [Bug 1856706] [NEW] target/mips/op_helper.c:971:duplicated
 branches ?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c01345826377ba5ccdac445697da15b2e437607a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1856706 <1856706@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200108003021.LMjg0hwtR52MX2JoZCkih_OvD3X3EQOkpdg_P1HYji8@z>

On Tue, 17 Dec. 2019, 09:28 Thomas Huth, <thuth@redhat.com> wrote:

> On 17/12/2019 14.25, dcb wrote:
> > Public bug reported:
> >
> > qemu-4.2.0/target/mips/op_helper.c:971:8: warning: this condition has
> > identical branches [-Wduplicated-branches]
> >
> > Source code is
> >
> >    if (other_tc =3D=3D other->current_tc) {
> >         tccause =3D other->CP0_Cause;
> >     } else {
> >         tccause =3D other->CP0_Cause;
> >     }
> >
> > Possible cut'n'paste error ?
>
>  Hi Edgar,
>
> you added the code in 2011 ... do you still remember the details here,
> whether that was on purpose or whether it should look differently?
>
>  Thomas
>


Hi Thomas,

Sorry but I barely recall yesterday, 2011 was a long time ago... It does
look weird.

IIRC smp was kinda of working but the multithreading support wasn't. Some
of these paths were probably not tested too much at the time.

Cheers,
Edgar

>
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856706

Title:
  target/mips/op_helper.c:971:duplicated branches ?

Status in QEMU:
  New

Bug description:
  qemu-4.2.0/target/mips/op_helper.c:971:8: warning: this condition has
  identical branches [-Wduplicated-branches]

  Source code is

     if (other_tc =3D=3D other->current_tc) {
          tccause =3D other->CP0_Cause;
      } else {
          tccause =3D other->CP0_Cause;
      }

  Possible cut'n'paste error ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856706/+subscriptions

