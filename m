Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC6BC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F20B2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F20B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hECTu-00025P-Vt
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 08:37:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hECSN-00011X-Ix
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hECSM-0004hu-3R
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:35:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:45304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hECSL-0004fP-RF
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:35:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hECSI-0000wM-LR
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:35:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95A2B2E80C9
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:35:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2019 12:17:12 -0000
From: Thomas Huth <1525676@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
	status=Incomplete; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: halfdog paelzer sdeziel smb th-huth
X-Launchpad-Bug-Reporter: halfdog (halfdog)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20151213173042.25355.35514.malonedeb@soybean.canonical.com>
Message-Id:
 <155489863276.21303.3473631160504038546.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: f3574735812ae4e5b5822486d496f2a937ac5281
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1525676] Re: qemu runas and sandbox option
 incompatible, process will hang in futex after setgid
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
Reply-To: Bug 1525676 <1525676@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410121712.iFRXu-qTeQ-3Xre2Fcm5YHFPnaU0bme80aj7LlK7Qn4@z>

I haven't tried, but I think this should be fixed now with the new
elevateprivileges parameter of the -sandbox option. Have you tried to
reproduce the problem with the latest version of QEMU already?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1525676

Title:
  qemu runas and sandbox option incompatible, process will hang in futex
  after setgid

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  With -runas [user] and -sandbox on, qemu process will fail in the
  process of dropping privileges. While setgid() is done (see below),
  setuid() is not attempted. Instead process blocks waiting for a futex
  never to come.

  [pid 21769] +++ killed by SIGSYS +++
  [pid 21767] <... tgkill resumed> )      =3D 0
  [pid 21767] tgkill(21767, 21768, SIGRT_1 <unfinished ...>
  [pid 21768] <... nanosleep resumed> {0, 7284187}) =3D ? ERESTART_RESTARTB=
LOCK (Interrupted by signal)
  [pid 21768] --- SIGRT_1 {si_signo=3DSIGRT_1, si_code=3DSI_TKILL, si_pid=
=3D21767, si_uid=3D0} ---
  [pid 21768] setgid(100)                 =3D 0
  [pid 21768] futex(0x7f7f0f53fd1c, FUTEX_WAKE_PRIVATE, 1) =3D 0
  [pid 21768] rt_sigreturn()              =3D -1 EINTR (Interrupted system =
call)
  [pid 21768] nanosleep({0, 7284187},  <unfinished ...>
  [pid 21767] <... tgkill resumed> )      =3D 0
  [pid 21767] futex(0x7ffd5a9b6890, FUTEX_WAIT_PRIVATE, 3, NULL <unfinished=
 ...>
  [pid 21768] <... nanosleep resumed> 0x7f7f0f53eb00) =3D 0
  [pid 21768] futex(0x55f52acd1f44, FUTEX_WAIT, 4294967295, NULL

  This bug might be addresses in the discussion/patchset
  http://qemu.11.n7.nabble.com/PATCH-Add-syscalls-for-runas-and-chroot-
  to-the-seccomp-sandbox-td359588.html

  # lsb_release -rd
  Description:    Ubuntu 15.10
  Release:        15.10

  # apt-cache policy qemu-system-x86
  qemu-system-x86:
    Installed: 1:2.3+dfsg-5ubuntu9.1
    Candidate: 1:2.3+dfsg-5ubuntu9.1
    Version table:
   *** 1:2.3+dfsg-5ubuntu9.1 0
          500 http://archive.ubuntu.com/ubuntu/ wily-updates/main amd64 Pac=
kages
          500 http://archive.ubuntu.com/ubuntu/ wily-security/main amd64 Pa=
ckages
          100 /var/lib/dpkg/status
       1:2.3+dfsg-5ubuntu9 0
          500 http://archive.ubuntu.com/ubuntu/ wily/main amd64 Packages

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1525676/+subscriptions

