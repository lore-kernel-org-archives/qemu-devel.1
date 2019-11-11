Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E738DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 06:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5328214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 06:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5328214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU3Y1-0006ko-Ua
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 01:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iU3XI-0006KK-U0
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 01:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iU3XH-0000El-Op
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 01:50:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:58550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iU3XH-0000EL-Je
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 01:50:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iU3XF-0002MS-F1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 06:50:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6CC3C2E80C9
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 06:50:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Nov 2019 06:40:55 -0000
From: Thomas Huth <1810105@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=xfce4-pulseaudio-plugin;
 component=universe; status=New; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: amd64 apport-bug bionic iso-testing
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lastonestanding leozinho29-eu th-huth ubuntuqa
X-Launchpad-Bug-Reporter: =?utf-8?q?Leonardo_M=C3=BCller_=28leozinho29-eu?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <154619733010.25184.13183315891827288064.malonedeb@gac.canonical.com>
Message-Id: <157345445596.22191.14785377701369129145.malone@soybean.canonical.com>
Subject: [Bug 1810105] Re: Hint showing volume never disappears,
 blocking buttons to minimize, maximize and close
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0b2e191697d11fb7b0395f90df9ced828a1cd387
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
Reply-To: Bug 1810105 <1810105@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If it's reproducible with real hardware, then it's definitely not a bug
of QEMU =3D=3D> Removing QEMU from this bug ticket.

** No longer affects: qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810105

Title:
  Hint showing volume never disappears, blocking buttons to minimize,
  maximize and close

Status in xfce4-pulseaudio-plugin package in Ubuntu:
  New

Bug description:
  When hovering the mouse over the volume indicator or changing its
  volume using the mouse wheel it shows the current volume set as a
  hint. For example:

  Volume 100%

  The problem is that the hint never disappears, not even clicking on
  it. On some occasions the hint can cover the minimize, maximize and
  close buttons, causing significant problems on using the desktop
  environment, as these three buttons won't be usable anymore with the
  hint over it.

  Where the hint appears it's no longer possible to interact with the
  screen.

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: xfce4-pulseaudio-plugin 0.4.1-0ubuntu1
  ProcVersionSignature: Ubuntu 4.15.0-43.46-generic 4.15.18
  Uname: Linux 4.15.0-43-generic x86_64
  ApportVersion: 2.20.9-0ubuntu7.5
  Architecture: amd64
  CurrentDesktop: XFCE
  Date: Sun Dec 30 17:09:23 2018
  InstallationDate: Installed on 2018-12-30 (0 days ago)
  InstallationMedia: Xubuntu 18.04.2 LTS "Bionic Beaver" - Beta amd64 (2018=
1230)
  SourcePackage: xfce4-pulseaudio-plugin
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/xfce4-pulseaudio-plugin/+bug/1810=
105/+subscriptions

