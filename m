Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7138C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985F9206B9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 11:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985F9206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP2Ms-0001cE-P1
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jP2Lz-0000hX-56
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jP2Ly-00057e-4R
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:06:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:52310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jP2Lx-00057S-Vi
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 07:06:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jP2Lx-0002HV-0I
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 11:06:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F351A2E8010
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 11:06:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2020 10:55:17 -0000
From: Alex <1829242@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h nevilad
X-Launchpad-Bug-Reporter: Alex (nevilad)
X-Launchpad-Bug-Modifier: Alex (nevilad)
References: <155792850856.14868.18260779757728395853.malonedeb@gac.canonical.com>
Message-Id: <158703451806.6321.6440595488498192107.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1829242] Re: qemu on windows host exits after savevm command
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ee5a51c98af368bc32f86efa841d7a21c1ec9fe3
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
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829242

Title:
  qemu on windows host exits after savevm command

Status in QEMU:
  Fix Released

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

