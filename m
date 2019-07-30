Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF915C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E25720693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E25720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsYXf-00008j-SR
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 16:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsYXG-0008Bf-Ud
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsYXF-0002hq-Ol
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:15:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:54668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsYXF-0002hH-IU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 16:15:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsYXC-0006dr-6u
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 20:15:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2FD842E80D6
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 20:15:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jul 2019 20:02:46 -0000
From: _ <1838465@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: s4s
X-Launchpad-Bug-Reporter: _ (s4s)
X-Launchpad-Bug-Modifier: _ (s4s)
Message-Id: <156451696673.6584.7291488800307870571.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19012";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d1c365da73849aef0f1ff2f11199b31ca94595f9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838465] [NEW] qemu-system-x86_64 kernel panic
 30% of the time starting up VM
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
Reply-To: Bug 1838465 <1838465@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I have created a Fedora Core 5 x86_64 VM image. When I run the image
using QEMU on Windows the VM hangs while loading the kernel about 30% of
the time. I am trying to use this VM with a CI software, looking at the
history the build failed 27 out of 79 attempts. QEMU 3.0.0 is installed
on the CI machine. I have tried using the exact same image using QEMU on
Linux (Ubuntu) and found the image boot successful every time (40+
attempts). The VM image is fairly old it was created using QEMU 0.11.1.

I have tried multiple versions on QEMU on windows; 0.11.1, 2.12.1, and
3.0.0 all of them fail randomly. I can reproduce the issue on several
different Windows 10 computers.

The command I am using to start the VM is =E2=80=9Cqemu-system-x86_64.exe -=
cpu
qemu64 -smp cores=3D2 -device e1000,netdev=3Dnet0 -boot menu=3Doff -m 1G
-drive `"file=3DC:\qimages\Fedora-Core-5-x64.qcow2,index=3D0,media=3Ddisk`"
-snapshot -netdev user,id=3Dnet0,hostfwd=3Dtcp::10022-:22=E2=80=9D

I can provide the qcow image but it is somewhat large coming it at
4.15GB so I=E2=80=99m not sure what would be the best way to transfer it.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "kernelpanic.jpg"
   https://bugs.launchpad.net/bugs/1838465/+attachment/5280085/+files/kerne=
lpanic.jpg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838465

Title:
  qemu-system-x86_64 kernel panic 30% of the time starting up VM

Status in QEMU:
  New

Bug description:
  I have created a Fedora Core 5 x86_64 VM image. When I run the image
  using QEMU on Windows the VM hangs while loading the kernel about 30%
  of the time. I am trying to use this VM with a CI software, looking at
  the history the build failed 27 out of 79 attempts. QEMU 3.0.0 is
  installed on the CI machine. I have tried using the exact same image
  using QEMU on Linux (Ubuntu) and found the image boot successful every
  time (40+ attempts). The VM image is fairly old it was created using
  QEMU 0.11.1.

  I have tried multiple versions on QEMU on windows; 0.11.1, 2.12.1, and
  3.0.0 all of them fail randomly. I can reproduce the issue on several
  different Windows 10 computers.

  The command I am using to start the VM is =E2=80=9Cqemu-system-x86_64.exe=
 -cpu
  qemu64 -smp cores=3D2 -device e1000,netdev=3Dnet0 -boot menu=3Doff -m 1G
  -drive `"file=3DC:\qimages\Fedora-Core-5-x64.qcow2,index=3D0,media=3Ddisk=
`"
  -snapshot -netdev user,id=3Dnet0,hostfwd=3Dtcp::10022-:22=E2=80=9D

  I can provide the qcow image but it is somewhat large coming it at
  4.15GB so I=E2=80=99m not sure what would be the best way to transfer it.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838465/+subscriptions

