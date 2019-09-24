Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F28C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444002064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444002064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCdyD-0000Tx-GB
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCdxT-0008D5-VX
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCdxS-0003JY-UD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:05:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:47018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCdxS-0003JE-Oc
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:05:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCdxR-0004Qj-Q4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:05:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C0C802E80C3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:05:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2019 05:58:15 -0000
From: mustafa <1824704@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: drjs5x th-huth
X-Launchpad-Bug-Reporter: mustafa (drjs5x)
X-Launchpad-Bug-Modifier: mustafa (drjs5x)
References: <155524844990.21262.8108456842078597088.malonedeb@chaenomeles.canonical.com>
 <156930383152.4548.11951777620383164964.malone@chaenomeles.canonical.com>
Message-Id: <CAE5RSKJ4ezfg6yK9mW=dRqQ61c=-j8Qo6jpFA5WCQ-R-ZiDB1A@mail.gmail.com>
Subject: Re: [Bug 1824704] Re: -k tr not working after v20171217! turkish
 keyboard dont working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6928ee273138f398f7fdf2d8aa4b19b92e35a96c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1824704 <1824704@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24 Eyl=C3=BCl 2019 Sal=C4=B1 tarihinde Thomas Huth <1824704@bugs.launchpad.=
net>
yazd=C4=B1:

> Can you find out which commit broke the keyboard for you? (By using "git
> bisect" for example)
>
> ** Information type changed from Private Security to Public
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1824704
>
> Title:
>   -k tr not working after v20171217! turkish keyboard dont working
>
> Status in QEMU:
>   New
>
> Bug description:
>   hi qemu
>
>   -k tr not working after v20171217! turkish keyboard dont working
>
>   last working without proplem at v20171217!
>
>   after this version  tr keyboard proplem.
>   freedos  , winpe  ,  linux images   all dont working tr  turkish
> keyboard.
>
>   example   press key " =C3=A7 "  show " , "
>   example 2 press key " . "  show " =C3=A7 "
>
>   tr keyboard work  always "en-us" kbd.
>   :((((((((
>
>   please fix this critical bug.
>
>   Sincerely
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1824704/+subscriptions
>


Not working turkish q keyboard

=C3=87 pres result,
. Press. Result =C3=A7

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824704

Title:
  -k tr not working after v20171217! turkish keyboard dont working

Status in QEMU:
  New

Bug description:
  hi qemu

  -k tr not working after v20171217! turkish keyboard dont working

  last working without proplem at v20171217!

  after this version  tr keyboard proplem.
  freedos  , winpe  ,  linux images   all dont working tr  turkish keyboard.

  example   press key " =C3=A7 "  show " , "
  example 2 press key " . "  show " =C3=A7 "

  tr keyboard work  always "en-us" kbd.
  :((((((((

  please fix this critical bug.

  Sincerely

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824704/+subscriptions

