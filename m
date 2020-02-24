Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1AEC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC6520578
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC6520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6EJ4-00087H-7c
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j6EIB-0007GB-5D
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j6EI5-0003GH-Vy
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:01:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:45546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j6EI5-0003G1-PI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:00:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j6EI3-0006g8-C1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5A0CB2E80C9
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Feb 2020 13:54:01 -0000
From: Alex <1829242@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h nevilad
X-Launchpad-Bug-Reporter: Alex (nevilad)
X-Launchpad-Bug-Modifier: Alex (nevilad)
References: <155792850856.14868.18260779757728395853.malonedeb@gac.canonical.com>
Message-Id: <158255244180.29460.15691340714937998156.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1829242] Re: qemu on windows host exits after savevm command
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4cace0a3717c2c6d0afb76f897f7f1e201f9d1ee
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
Reply-To: Bug 1829242 <1829242@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829242

Title:
  qemu on windows host exits after savevm command

Status in QEMU:
  Fix Committed

Bug description:
  I'm running qemu-system-i386.exe 3.1.0 with this command line:
  "C:\Program Files\qemu\qemu-system-i386.exe"  -L C:\user\qemu\pc-bios\ -n=
ame win7 -m 4G -uuid 564db62e-e031-b5cf-5f34-a75f8cefa98e -rtc base=3Dlocal=
time -accel hax -hdd C:\VirtualMachines\Dev\Win10x64_VS17\swap.qcow "C:\Vir=
tualMachines\qemu\qemu_win7.qcow"
  Host OS Windows 10 x64, guest OS Wondows 7 x86.

  Wait till the OS loads, go to compat_monitor0 tab and enter command:
  savevm loaded_win
  After a few seconds qemu exits, running it another time and entering comm=
and:
  info snapshots
  says "There is no snapshot available". I've tried rinning it with -accel =
tcg, with same results. I've tried less memory (1G), same results.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829242/+subscriptions

