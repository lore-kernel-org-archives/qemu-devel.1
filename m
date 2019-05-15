Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C51C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 07:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E2C20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 07:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E2C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQoO6-0007eH-P1
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 03:31:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQoNC-00070K-Eo
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQoNB-0000jy-Ar
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:30:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:59030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hQoNB-0000f1-56
	for qemu-devel@nongnu.org; Wed, 15 May 2019 03:30:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hQoN8-0004ny-Ca
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 07:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5E25E2E80C8
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 07:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 May 2019 07:25:25 -0000
From: Thomas Huth <1829079@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: insspir philmd th-huth
X-Launchpad-Bug-Reporter: =?utf-8?q?Dariusz_Zyza=C5=84ski_=28insspir=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155787117310.15024.60120190997628985.malonedeb@gac.canonical.com>
Message-Id: <155790512564.21554.11012555551742465426.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 1d3d73f2b66901ea23a4e8f6cee62901b39302cb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829079] Re: Can't build static on ARM (Raspbian)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1829079 <1829079@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I agree with Philippe - if you have to symlink your libraries like this,
it is certainly not a bug in QEMU, but a problem of your distro. So
please report this issue in your distro bugtracker instead.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829079

Title:
  Can't build static on ARM (Raspbian)

Status in QEMU:
  Invalid

Bug description:
  I am trying to build static QEMU on Raspbian, chrooted into using systemd=
-nspawn with QEMU 4.0.0.
  This is how my compiling looks:
  https://pastebin.com/PYZYeRCN
  Just the problematic part:
  https://pastebin.com/7LxWPMxA
  How I do the compiling:
  https://pastebin.com/pYM17A6R (I plan to share this tutorial when it will=
 work)
  It is a coincidence, or the build fails because it cannot find lp11-kit. =
I did some symlinks:
  ln -s /usr/lib/arm-linux-gnueabihf/libp11-kit.so.0 /usr/lib/libp11-kit.so=
.0
  ln -s /usr/lib/arm-linux-gnueabihf/libp11-kit.so /usr/lib/libp11-kit.so
  (should I also symlink libp11.so and libp11.so.2? I think I have installe=
d all required p11 packages!

  Git commit hash: git rev-parse HEAD
  e329ad2ab72c43b56df88b34954c2c7d839bb373

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829079/+subscriptions

