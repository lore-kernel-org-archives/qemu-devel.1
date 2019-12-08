Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42CC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 20:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE716206D5
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 20:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE716206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie3bl-0000yN-SH
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 15:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ie3ad-0000UB-Cv
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 15:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ie3ac-0005IP-4w
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 15:55:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:46548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ie3ab-00057x-RM
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 15:55:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ie3aZ-0002cg-Ri
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 20:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C76622E80BA
 for <qemu-devel@nongnu.org>; Sun,  8 Dec 2019 20:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Dec 2019 20:45:40 -0000
From: Alex <1855617@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nevilad
X-Launchpad-Bug-Reporter: Alex (nevilad)
X-Launchpad-Bug-Modifier: Alex (nevilad)
Message-Id: <157583794032.6937.10802857034135783842.malonedeb@soybean.canonical.com>
Subject: [Bug 1855617] [NEW] savevm with hax saves wrong register state
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b029a8fb755afdf1ed6327320acc106420f99325
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
Reply-To: Bug 1855617 <1855617@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I use qemu-i386 with IntelHaxm on Windows 10 x64 host with Windows 7 x86 gu=
est. I run the guest till OS loads and create a snapshot with savevm, then =
close qemu, run it again and try to load the snapshot with loadvm. The gues=
t crashes or freezes. I dumped registers on snapshot creation and loading (=
in Haxm) and found that they are different.
When returning from Haxm in hax_vcpu_hax_exec, there is no regular register=
 read. I found hax_arch_get_registers function which reads registers from H=
axm and is called from a synchronization procedure. I placed a breakpoint o=
n it, ran qemu and found that it is hit one time during guest OS boot. Exac=
tly these registers where saved in the snapshot.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1855617

Title:
  savevm with hax saves wrong register state

Status in QEMU:
  New

Bug description:
  I use qemu-i386 with IntelHaxm on Windows 10 x64 host with Windows 7 x86 =
guest. I run the guest till OS loads and create a snapshot with savevm, the=
n close qemu, run it again and try to load the snapshot with loadvm. The gu=
est crashes or freezes. I dumped registers on snapshot creation and loading=
 (in Haxm) and found that they are different.
  When returning from Haxm in hax_vcpu_hax_exec, there is no regular regist=
er read. I found hax_arch_get_registers function which reads registers from=
 Haxm and is called from a synchronization procedure. I placed a breakpoint=
 on it, ran qemu and found that it is hit one time during guest OS boot. Ex=
actly these registers where saved in the snapshot.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1855617/+subscriptions

