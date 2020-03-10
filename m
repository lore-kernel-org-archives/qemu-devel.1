Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA1C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D50720873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D50720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBagv-0008I5-I2
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBag0-0007Pe-CF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBafz-00011U-0x
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:55:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:37354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBafy-0000yy-RG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:55:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBafy-0002Bk-0J
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 08:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 013862E80C7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 08:55:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Mar 2020 08:48:08 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cleber-gnu th-huth
X-Launchpad-Bug-Reporter: Cleber Rosa (cleber-gnu)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <155837363818.14706.8629235118425908874.malonedeb@gac.canonical.com>
Message-Id: <158383008939.12830.17134143197911389759.launchpad@soybean.canonical.com>
Subject: [Bug 1829779] Re: qemu-system-arm and qemu-system-aarch64 QMP hangs
 after kernel boots
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 64328e108bf57de6d9002b5022dd384b58f67685
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
Reply-To: Bug 1829779 <1829779@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829779

Title:
  qemu-system-arm and qemu-system-aarch64 QMP hangs after kernel boots

Status in QEMU:
  Fix Released

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

