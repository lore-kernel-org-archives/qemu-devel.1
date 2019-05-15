Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9400BC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DFC20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DFC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvxc-00008j-ME
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:36:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQvwa-0007cN-GQ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hQvwZ-0004bJ-7M
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:35:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:58292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hQvwY-0004XF-93
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:35:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hQvwU-0003t5-5Z
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 15:35:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9A0802E80EA
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 15:35:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 May 2019 15:27:13 -0000
From: =?utf-8?q?Dariusz_Zyza=C5=84ski?= <1829079@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: insspir philmd pmaydell th-huth
X-Launchpad-Bug-Reporter: =?utf-8?q?Dariusz_Zyza=C5=84ski_=28insspir=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Dariusz_Zyza=C5=84ski_=28insspir=29?=
References: <155787117310.15024.60120190997628985.malonedeb@gac.canonical.com>
Message-Id: <155793403369.26555.15624529499560439956.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18962";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ebb7a7168506f49cf1b25aa7105a521e0fc0dfc9
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

Well, the symlinks didn't resolve the issue. I just tried them to see if
this will solve the issue.

And I installed a lot of packages, blindly trying to solve this issue.
Using full Raspbian instead of Raspbian Lite was also an attempt to do
so. I'm just an advanced Linux user, not a developer! I will cut the
list down to the necessary ones when I get it to compile!

pmaydell: Thank you a lot, it compiles successfully with --disable-tools
in configure. I have one question... does it affect how QEMU static
binary works in any way? I'm just curious.

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

