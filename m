Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98901C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C42020714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C42020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v51-00035U-Me
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1v4O-0002Mq-LZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1v4N-0000xz-9s
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:35594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1v4N-0000x9-4W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:40:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1v4L-0008SU-1z
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 16:40:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0C4062E8078
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 16:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2020 16:23:54 -0000
From: Faisal Al-Humaimidi <1862979@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: falhumai96
X-Launchpad-Bug-Reporter: Faisal Al-Humaimidi (falhumai96)
X-Launchpad-Bug-Modifier: Faisal Al-Humaimidi (falhumai96)
Message-Id: <158152463419.28848.6286969532824555776.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1862979] [NEW] Cannot Create Socket Networking in Windows Host
 using Multicast
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8c5d9572cbc7f00c8acf1afc255f560fd1d8f693
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
Reply-To: Bug 1862979 <1862979@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello QEMU devs,

I am trying to create a simulated VLAN using socket networking, and the
only way to connect multiple networks in QEMU using socket networking is
by using the multicast `mcast` option of the `socket` network backend.

However, when I try use the following arguments in QEMU to create a
multicast socket network:

`-device e1000,id=3Dsock-0 -netdev id=3Dsock-0,mcast=3D230.0.0.1:1234`

it fails with:

`can't bind ip address=3D230.0.0.1: unknown error` in my Windows host.

I would like to know if this is a bug, or if I am missing a prerequisite
before running the QEMU command.

By the way, I am using Windows 10, and running a cross-compiled QEMU
4.2.0.

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Hello QEMU devs,
  =

  I am trying to create a simulated VLAN using socket networking, and the
  only way to connect multiple networks in QEMU using socket networking is
  by using the multicast `mcast` option of the `socket` network backend.
  =

  However, when I try use the following arguments in QEMU to create a
  multicast socket network:
  =

  `-device e1000,id=3Dsock-0 -netdev id=3Dsock-0,mcast=3D230.0.0.1:1234`
  =

  it fails with:
  =

  `can't bind ip address=3D230.0.0.1: unknown error` in my Windows host.
  =

  I would like to know if this is a bug, or if I am missing a prerequisite
  before running the QEMU command.
+ =

+ By the way, I am using Windows 10.

** Description changed:

  Hello QEMU devs,
  =

  I am trying to create a simulated VLAN using socket networking, and the
  only way to connect multiple networks in QEMU using socket networking is
  by using the multicast `mcast` option of the `socket` network backend.
  =

  However, when I try use the following arguments in QEMU to create a
  multicast socket network:
  =

  `-device e1000,id=3Dsock-0 -netdev id=3Dsock-0,mcast=3D230.0.0.1:1234`
  =

  it fails with:
  =

  `can't bind ip address=3D230.0.0.1: unknown error` in my Windows host.
  =

  I would like to know if this is a bug, or if I am missing a prerequisite
  before running the QEMU command.
  =

- By the way, I am using Windows 10.
+ By the way, I am using Windows 10, and running a cross-compiled QEMU
+ 4.2.0.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1862979

Title:
  Cannot Create Socket Networking in Windows Host using Multicast

Status in QEMU:
  New

Bug description:
  Hello QEMU devs,

  I am trying to create a simulated VLAN using socket networking, and
  the only way to connect multiple networks in QEMU using socket
  networking is by using the multicast `mcast` option of the `socket`
  network backend.

  However, when I try use the following arguments in QEMU to create a
  multicast socket network:

  `-device e1000,id=3Dsock-0 -netdev id=3Dsock-0,mcast=3D230.0.0.1:1234`

  it fails with:

  `can't bind ip address=3D230.0.0.1: unknown error` in my Windows host.

  I would like to know if this is a bug, or if I am missing a
  prerequisite before running the QEMU command.

  By the way, I am using Windows 10, and running a cross-compiled QEMU
  4.2.0.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1862979/+subscriptions

