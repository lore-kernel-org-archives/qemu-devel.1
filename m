Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55894C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293342072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293342072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHraL-0000jp-2l
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jHrZY-0000E3-Lv
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jHrZV-0005nH-UQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:11:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:51102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jHrZV-0005iP-KX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:11:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jHrZS-0004Z7-7w
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 16:10:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3171B2E80CF
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 16:10:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Mar 2020 16:00:12 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: linux-user syscall-abi
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dflogeras2 liuke manuel-reimer marcin-konarski+u1
 philippe-vaucher pmaydell schneiderit
X-Launchpad-Bug-Reporter: Kan Li (liuke)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <154353638253.10384.17899256838547579767.malonedeb@chaenomeles.canonical.com>
Message-Id: <158532481268.21262.16578298070728808952.malone@gac.canonical.com>
Subject: [Bug 1805913] Re: readdir() returns NULL (errno=EOVERFLOW) for 32-bit
 user-static qemu on 64-bit host
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4fabb8b3a7797a4d80496cfa3567ee53f29fb32f
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
Reply-To: Bug 1805913 <1805913@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, using a 32-bit host QEMU process will also work. You might run into
a few guest programs that don't work with that -- a 64-bit QEMU process
allows us to give the guest the full address space it might need, while
a 32-bit QEMU process means that QEMU itself must share with the guest,
so if the guest uses a lot of virtual memory or is picky about where it
maps things then it might fail to mmap() things where it wants them. But
it's probably overall the least-bad workaround at the current time.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1805913

Title:
  readdir() returns NULL (errno=3DEOVERFLOW) for 32-bit user-static qemu
  on 64-bit host

Status in QEMU:
  Confirmed

Bug description:
  This can be simply reproduced by compiling and running the attached C
  code (readdir-bug.c) under 32-bit user-static qemu, such as qemu-arm-
  static:

  # Setup docker for user-static binfmt
  docker run --rm --privileged multiarch/qemu-user-static:register --reset
  # Compile the code and run (readdir for / is fine, so create a new direct=
ory /test).
  docker run -v /path/to/qemu-arm-static:/usr/bin/qemu-arm-static -v /path/=
to/readdir-bug.c:/tmp/readdir-bug.c -it --rm arm32v7/ubuntu:18.10 bash -c '=
{ apt update && apt install -y gcc; } >&/dev/null && mkdir -p /test && cd /=
test && gcc /tmp/readdir-bug.c && ./a.out'
  dir=3D0xff5b4150
  readdir(dir)=3D(nil)
  errno=3D75: Value too large for defined data type

  Do remember to replace the /path/to/qemu-arm-static and /path/to
  /readdir-bug.c to the actual paths of the files.

  The root cause is in glibc:
  https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/=
linux/getdents.c;h=3D6d09a5be7057e2792be9150d3a2c7b293cf6fc34;hb=3Da5275ba5=
378c9256d18e582572b4315e8edfcbfb#l87

  By C standard, the return type of readdir() is DIR*, in which the
  inode number and offset are 32-bit integers, therefore, glibc calls
  getdents64() and check if the inode number and offset fits the 32-bit
  range, and reports EOVERFLOW if not.

  The problem here is for 32-bit user-static qemu running on 64-bit
  host, getdents64 simply passing through the inode number and offset
  from underlying getdents64 syscall (from 64-bit kernel), which is very
  likely to not fit into 32-bit range. On real hardware, the 32-bit
  kernel creates 32-bit inode numbers, therefore works properly.

  The glibc code makes sense to do the check to be conformant with C
  standard, therefore ideally it should be a fix on qemu side. I admit
  this is difficult because qemu has to maintain a mapping between
  underlying 64-bit inode numbers and 32-bit inode numbers, which would
  severely hurt the performance. I don't expect this could be fix
  anytime soon (or even there would be a fix), but it would be
  worthwhile to surface this issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1805913/+subscriptions

