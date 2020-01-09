Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A142C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E39C20661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E39C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipY67-00084j-GD
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipY3P-0004bl-GH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipY3O-0004f9-36
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:33904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipY3N-0004dX-Rk
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:40:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipY3M-00017N-Nd
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 13:40:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AF30B2E8074
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 13:40:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jan 2020 13:35:28 -0000
From: Thomas Huth <1829779@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cleber-gnu th-huth
X-Launchpad-Bug-Reporter: Cleber Rosa (cleber-gnu)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155837363818.14706.8629235118425908874.malonedeb@gac.canonical.com>
Message-Id: <157857692854.5393.4618483627713197030.malone@gac.canonical.com>
Subject: [Bug 1829779] Re: qemu-system-arm and qemu-system-aarch64 QMP hangs
 after kernel boots
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 842a2c0b45c0e320a06f293c28b260bf2920e3ec
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
Reply-To: Bug 1829779 <1829779@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A patch for this bug has been merged here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D085809670201c6d3a33e3
... can we close this ticket now?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829779

Title:
  qemu-system-arm and qemu-system-aarch64 QMP hangs after kernel boots

Status in QEMU:
  Confirmed

Bug description:
  After booting a Linux kernel on both arm and aarch64, the QMP sockets get=
s unresponsive. Initially, this was thought to be limited to "quit" command=
s, but it reproduced with others (such as in this
  reproducer).  This is a partial log output:

  =C2=A0=C2=A0=C2=A0>>> {'execute': 'qmp_capabilities'}
  =C2=A0=C2=A0=C2=A0<<< {'return': {}}
  =C2=A0=C2=A0=C2=A0Booting Linux on physical CPU 0x0000000000 [0x410fd034]
  =C2=A0=C2=A0=C2=A0Linux version 4.18.16-300.fc29.aarch64 (mockbuild@build=
vm-aarch64-02.arm.fedoraproject.org) (gcc version 8.2.1 20180801 (Red Hat 8=
.2.1-2) (GCC)) #1 SMP Sat Oct 20 23:12:22 UTC 2018
  =C2=A0=C2=A0=C2=A0...
  =C2=A0=C2=A0=C2=A0Policy zone: DMA32
  =C2=A0=C2=A0=C2=A0Kernel command line: printk.time=3D0 console=3DttyAMA0
  =C2=A0=C2=A0=C2=A0>>> {'execute': 'stop'}
  =C2=A0=C2=A0=C2=A0<<< {'timestamp': {'seconds': 1558370331, 'microseconds=
': 470173}, 'event': 'STOP'}
  =C2=A0=C2=A0=C2=A0<<< {'return': {}}
  =C2=A0=C2=A0=C2=A0>>> {'execute': 'cont'}
  =C2=A0=C2=A0=C2=A0<<< {'timestamp': {'seconds': 1558370331, 'microseconds=
': 470849}, 'event': 'RESUME'}
  =C2=A0=C2=A0=C2=A0<<< {'return': {}}
  =C2=A0=C2=A0=C2=A0>>> {'execute': 'stop'}

  Sometimes it takes just the first "stop" command.  Overall, I was able
  to reproduce 100% of times when applied on top of
  6d8e75d41c58892ccc5d4ad61c4da476684c1c83.

  The reproducer test can be seen/fetched at:
  =C2=A0- https://github.com/clebergnu/qemu/commit/c778e28c24030c4a36548b71=
4293b319f4bf18df

  And test results from Travis CI can be seen at:
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669

  For convenience purposes, here's qemu-system-aarch64 launching and hangin=
g on the first "stop":
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3634
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3664

  And here's qemu-system-arm hanging the very same way:
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3799
  =C2=A0- https://travis-ci.org/clebergnu/qemu/jobs/534915669#L3819

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829779/+subscriptions

