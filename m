Received: from eggs.gnu.org ([2001:4830:134:3::10]:55640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fi7Jg-0003Rf-TY
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 20:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fi7Jd-0002uq-Mh
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 20:06:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:33414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fi7Jd-0002tf-Fq
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 20:06:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fi7Jc-0002bc-4o
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 00:06:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1CB0A2E80C7
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 00:06:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Jul 2018 23:58:29 -0000
From: Fabian Hemmer <1783437@bugs.launchpad.net>
Reply-To: Bug 1783437 <1783437@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153247670930.31632.15065752803528835886.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1783437] [NEW] read-modify-write page faults
 error code has write bit unset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Consider the attached C file, which does a read-modify-write of the form
`add [mem], reg`, where `mem` points to a non-present page. In the
resulting page fault, the W/R bit is not set, while real hardware does
set this bit.

% gcc -m32 qemu-bug1.c&& ./a.out && qemu-i386 ./a.out
page fault: addr=3D0x70000000 err=3D0x6
page fault: addr=3D0x70000000 err=3D0x4

Tested on the qemu-3.0.0-rc1 release.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "qemu-bug1.c"
   https://bugs.launchpad.net/bugs/1783437/+attachment/5167345/+files/qemu-=
bug1.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1783437

Title:
  read-modify-write page faults error code has write bit unset

Status in QEMU:
  New

Bug description:
  Consider the attached C file, which does a read-modify-write of the
  form `add [mem], reg`, where `mem` points to a non-present page. In
  the resulting page fault, the W/R bit is not set, while real hardware
  does set this bit.

  % gcc -m32 qemu-bug1.c&& ./a.out && qemu-i386 ./a.out
  page fault: addr=3D0x70000000 err=3D0x6
  page fault: addr=3D0x70000000 err=3D0x4

  Tested on the qemu-3.0.0-rc1 release.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1783437/+subscriptions
