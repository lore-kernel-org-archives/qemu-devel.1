Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56869C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB9D20848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB9D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABfo-0004Ue-UP
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jABf1-00043N-IT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jABez-0006mE-Nl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:00:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:36574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jABez-0006lD-Hg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:00:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jABex-00052f-6s
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 12:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2E19A2E80C9
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 12:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Mar 2020 11:52:01 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=Laurent@vivier.eu; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier rinigus-git
X-Launchpad-Bug-Reporter: rinigus (rinigus-git)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158033273927.19447.5685950954198072756.malonedeb@gac.canonical.com>
Message-Id: <158349552163.12437.15816009171631967135.malone@wampee.canonical.com>
Subject: [Bug 1861341] Re: ARM QEMU: Unknown syscall 397
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 810bfccf9a9f1a4cead645f66963f313cbad64de
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
Reply-To: Bug 1861341 <1861341@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New syscall definitions for ARM have been added lately by:

73209e1f15c6 ("linux-user: arm: Update syscall numbers to kernel 5.5
level")

It will available in QEMU 5.0

** Changed in: qemu
     Assignee: (unassigned) =3D> Laurent Vivier (laurent-vivier)

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861341

Title:
  ARM QEMU: Unknown syscall 397

Status in QEMU:
  Fix Committed

Bug description:
  QEMU is reporting

  ```
  Unknown syscall 397
  ```

  (statx if I read tables right) when used via flatpak for ARM images on
  x86_64. This has been reproduced on Fedora and Gentoo.

  To reproduce:

  - get flatpak KDE 5.12 for arm:

  flatpak install --user org.kde.Sdk/arm/5.12 org.kde.Platform/arm/5.12

  =

  - run qmake inside Sdk:

  QEMU_STRACE=3D1 flatpak run --filesystem=3Dhost --command=3Dqmake
  org.kde.Sdk/arm/5.12 .

  =

  You will get a host of messages with unknown syscall. In practice, qmake =
will fail to find .pro files if you have them in that folder and libraries =
in the system.

  As far as I understand, Flatpak images are built on AARCH64 hardware.

  My config on Gentoo:

  kernel: 4.19.86-gentoo x86_64
  app-emulation/qemu: ~4.2.0-r1 , same with 4.0.0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861341/+subscriptions

