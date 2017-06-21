Received: from eggs.gnu.org ([2001:4830:134:3::10]:58908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNjwH-0004tb-IQ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNjwE-0004rQ-GN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:01:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:46048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dNjwE-0004r0-Ap
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 14:01:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dNjwC-0000LU-7X
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 18:01:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1D10E2E8190
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 18:01:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2017 17:51:53 -0000
From: Anatol Pomozov <1699567@bugs.launchpad.net>
Reply-To: Bug 1699567 <1699567@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149806751311.22103.16824316715266267682.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1699567] [NEW] Qemu does not force SSE data
 alignment
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

I have an OS that tries to use SSE operations. It works fine in qemu.
But it crashes when I try to run the OS at the host cpu using KVM.

The instruction that crahes with #GP(0) is
 movaps ADDR,%xmm0

The documentation says ADDR has to be 16-bytes alignment otherwise #GP
is generated. And indeed the problem was with the data alignment. After
adjusting it at my side the OS works fine both with Qemu and KVM.

It would be great if QEMU followed specification more closely and forced
SSE data alignment requirements. It will help to catch alignment issues
early and debug it easier.


$ qemu-system-x86_64 -version
QEMU emulator version 2.9.50 (v2.9.0-1363-g95eef1c68b)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1699567

Title:
  Qemu does not force SSE data alignment

Status in QEMU:
  New

Bug description:
  I have an OS that tries to use SSE operations. It works fine in qemu.
  But it crashes when I try to run the OS at the host cpu using KVM.

  The instruction that crahes with #GP(0) is
   movaps ADDR,%xmm0

  The documentation says ADDR has to be 16-bytes alignment otherwise #GP
  is generated. And indeed the problem was with the data alignment.
  After adjusting it at my side the OS works fine both with Qemu and
  KVM.

  It would be great if QEMU followed specification more closely and
  forced SSE data alignment requirements. It will help to catch
  alignment issues early and debug it easier.

  =

  $ qemu-system-x86_64 -version
  QEMU emulator version 2.9.50 (v2.9.0-1363-g95eef1c68b)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1699567/+subscriptions
