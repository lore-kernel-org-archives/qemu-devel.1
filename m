Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B4CA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 10:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C4920842
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 10:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C4920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRCi9-000103-9u
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 05:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iRCgr-0000UG-Ap
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iRCgp-0002dZ-Hq
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:00:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:54446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iRCgp-0002cs-CC
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:00:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iRCgn-0005Pl-TY
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2019 10:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DA08F2E80BA
 for <qemu-devel@nongnu.org>; Sun,  3 Nov 2019 10:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Nov 2019 09:52:45 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell scientes
X-Launchpad-Bug-Reporter: Shawn Landden (scientes)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <157275520880.19702.5640428141206739403.malonedeb@wampee.canonical.com>
Message-Id:
 <CAFEAcA9R99t05Yr3hjUukJJK-L5SjTJqh0FD0xcjRCbLvnHpgg@mail.gmail.com>
Subject: Re: [Bug 1851095] [NEW] [feature request] awareness of instructions
 that are well emulated
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 009553feaefb9cc47abcc28c5ddc58a8d3d7764a
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
Reply-To: Bug 1851095 <1851095@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191103095245.KRnD4GiKb-wdZUmm6nX6LiH7TkLhHAKepZgqk-CVmzY@z>

On Sun, 3 Nov 2019 at 04:41, Shawn Landden <1851095@bugs.launchpad.net> wro=
te:
> While qemu's scalar emulation tends to be excellent, qemu's SIMD
> emulation tends to be incorrect (except for arm64 from x86_64)--i have
> found this both for mipsel and arm32. Until these code paths are
> audited, which is probably a large job, it would be nice if qemu knew
> its emulation of this class of instructions was not very good, and thus
> it would give up on finding these instructions if a "careful" operation
> is passed.

I'm not sure how this could work. If QEMU reports (via ID regs
etc) to the guest that it supports instruction class X when it
does not, that's a bug and we should fix it. If QEMU implements
an instruction but gets it wrong, that's also a bug and we should
fix it. In both cases, we'd need to have specific bug reports,
ideally with reproduce-cases. But we don't really have "known
areas where the emulation is incorrect" that we could somehow
differentiate and disable (except at a very vague level, eg
"probably better not to rely on the x86 emulation").

You might be able by careful selection of the cpu type to avoid
CPUs which implement vector operations. Some architectures
also allow individual CPU features to be disabled with extra
'-foo' qualifiers on the -cpu argument.

For Arm in particular (32 or 64 bit) I believe our implementation
should be correct and am happy to look at bug reports for that.

thanks
-- PMM

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1851095

Title:
  [feature request] awareness of instructions that are well emulated

Status in QEMU:
  New

Bug description:
  While qemu's scalar emulation tends to be excellent, qemu's SIMD
  emulation tends to be incorrect (except for arm64 from x86_64)--i have
  found this both for mipsel and arm32. Until these code paths are
  audited, which is probably a large job, it would be nice if qemu knew
  its emulation of this class of instructions was not very good, and
  thus it would give up on finding these instructions if a "careful"
  operation is passed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1851095/+subscriptions

