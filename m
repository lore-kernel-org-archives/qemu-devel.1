Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB7C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 22:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2092166E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 22:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2092166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQfYz-0000gY-P9
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 18:06:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQfYE-000056-IB
	for qemu-devel@nongnu.org; Tue, 14 May 2019 18:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQfYD-0005PZ-Bf
	for qemu-devel@nongnu.org; Tue, 14 May 2019 18:05:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:47456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hQfYD-0005NZ-6W
	for qemu-devel@nongnu.org; Tue, 14 May 2019 18:05:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hQfYC-0001BC-1I
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 22:05:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F2F602E80C7
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 22:05:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 May 2019 21:59:33 -0000
From: =?utf-8?q?Dariusz_Zyza=C5=84ski?= <1829079@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: insspir
X-Launchpad-Bug-Reporter: =?utf-8?q?Dariusz_Zyza=C5=84ski_=28insspir=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Dariusz_Zyza=C5=84ski_=28insspir=29?=
Message-Id: <155787117310.15024.60120190997628985.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e319800e8cdc9fc5559cd7fb2788fc55778684c3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1829079] [NEW] Can't build static on ARM
 (Raspbian)
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

Public bug reported:

I am trying to build static QEMU on Raspbian, chrooted into using systemd-n=
spawn with QEMU 4.0.0.
This is how my compiling looks:
https://pastebin.com/PYZYeRCN
Just the problematic part:
https://pastebin.com/7LxWPMxA
How I do the compiling:
https://pastebin.com/pYM17A6R (I plan to share this tutorial when it will w=
ork)
It is a coincidence, or the build fails because it cannot find lp11-kit. I =
did some symlinks:
ln -s /usr/lib/arm-linux-gnueabihf/libp11-kit.so.0 /usr/lib/libp11-kit.so.0
ln -s /usr/lib/arm-linux-gnueabihf/libp11-kit.so /usr/lib/libp11-kit.so
(should I also symlink libp11.so and libp11.so.2? I think I have installed =
all required p11 packages!

Git commit hash: git rev-parse HEAD
e329ad2ab72c43b56df88b34954c2c7d839bb373

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829079

Title:
  Can't build static on ARM (Raspbian)

Status in QEMU:
  New

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

