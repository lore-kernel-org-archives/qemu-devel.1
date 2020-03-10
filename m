Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6616C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8B2208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8B2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBb0z-00072C-Oq
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBazb-0005ZN-Si
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBaza-00051r-KO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:16:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:39992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBaza-0004yh-EE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:16:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBazX-0003rR-Kh
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:15:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 966A32E80CC
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:15:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Mar 2020 09:05:48 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=rth@twiddle.net; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jfreche laurent-vivier rth
X-Launchpad-Bug-Reporter: Julien Freche (jfreche)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158198492915.29307.8701397558481624318.malonedeb@chaenomeles.canonical.com>
Message-Id: <158383114847.12489.11813086117101605103.malone@soybean.canonical.com>
Subject: [Bug 1863685] Re: ARM: HCR.TSW traps are not implemented
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5bdb02ed7c215359ef8e72e503de2583900955a2
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
Reply-To: Bug 1863685 <1863685@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D1803d2713b29

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863685

Title:
  ARM: HCR.TSW traps are not implemented

Status in QEMU:
  Fix Committed

Bug description:
  On 32-bit and 64-bit ARM platforms, setting HCR.TSW is supposed to
  "Trap data or unified cache maintenance instructions that operate by
  Set/Way." Quoting the ARM manual:

  If EL1 is using AArch64 state, accesses to DC ISW, DC CSW, DC CISW are tr=
apped to EL2, reported using EC syndrome value 0x18.
  If EL1 is using AArch32 state, accesses to DCISW, DCCSW, DCCISW are trapp=
ed to EL2, reported using EC syndrome value 0x03.

  However, QEMU does not trap those instructions/registers. This was
  tested on the branch master of the git repo.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863685/+subscriptions

