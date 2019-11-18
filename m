Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3609920727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3609920727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWclp-0001p8-7C
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iWck5-0000As-61
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iWck3-0004Cf-UM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:50:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:57046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iWck3-0004C2-Ob
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:50:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iWck2-0005Ta-Dn
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 08:50:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 675AE2E80C8
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 08:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Nov 2019 08:40:35 -0000
From: Thomas Huth <1852781@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: colin-king paelzer th-huth
X-Launchpad-Bug-Reporter: Colin Ian King (colin-king)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <157384084797.7162.9983011521410421204.malonedeb@gac.canonical.com>
Message-Id: <157406643584.31832.13192632503149493051.malone@wampee.canonical.com>
Subject: [Bug 1852781] Re: qemu s390x on focal - applications breaking
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9cc25e0dd6a71c75b03ccd11abb7a1900ff2ef41
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
Reply-To: Bug 1852781 <1852781@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can you please test again with the latest QEMU 4.2 RC? There have been
quite a lot of fixes in this area in the past months, so maybe this
issue has already been resolved in 4.2.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852781

Title:
  qemu s390x on focal - applications breaking

Status in QEMU:
  Incomplete

Bug description:
  Running qemu-system-s390x (1:4.0+dfsg-0ubuntu10) on an x86-64 Focal
  host with an upgrade of a Eoan s390x VM to a Focal s390x is triggering
  random breakage, for example:

  sudo apt-get update && sudo apt-get dist-upgrade

  ...
  ...

  Unpacking debianutils (4.9) over (4.8.6.3) ...
  Setting up debianutils (4.9) ...
  Use of uninitialized value $ARGV[0] in string ne at /usr/sbin/update-mime=
 line 43.
  (Reading database ... 83640 files and directories currently installed.)
  Preparing to unpack .../bash_5.0-5ubuntu1_s390x.deb ...
  Unpacking bash (5.0-5ubuntu1) over (5.0-4ubuntu1) ...
  Setting up bash (5.0-5ubuntu1) ...
  [12124.788618] User process fault: interruption code 0007 ilc:3 in bash[2=
aa3d780000+149000]
  dpkg: error processing package bash (--configure):
   installed bash package post-installation script subprocess was killed by=
 signal (Floating point exception), core du
  mped
  Errors were encountered while processing:
   bash
  E: Sub-process /usr/bin/dpkg returned an error code (1)

  And now bash is completely broken:

  cking@eoan-s390x:~$ bash
  [12676.204389] User process fault: interruption code 0007 ilc:3 in bash[2=
aa14780000+149000]

  Floating point exception (core dumped)

  The upgrade works OK on a s390x, so I'm assuming it's something to do
  with the qemu emulation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1852781/+subscriptions

