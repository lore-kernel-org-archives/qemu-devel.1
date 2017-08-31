Received: from eggs.gnu.org ([2001:4830:134:3::10]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnXNF-0002h9-9w
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 17:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnXNA-0005KL-Dx
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 17:51:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:56793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dnXNA-0005K0-0o
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 17:51:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dnXN7-0003KK-M2
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 21:51:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 240F22E80EC
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 21:51:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Aug 2017 21:39:07 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701808 <1701808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149891130681.24932.1838110700653893581.malonedeb@soybean.canonical.com>
Message-Id: <150421554751.19430.17661957336147654710.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701808] Re: stack smashing in or after recvmsg
 system call in aarch64 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The behaviour in qemu-2.10 is the same as in qemu-2.9.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701808

Title:
  stack smashing in or after recvmsg system call in aarch64 user mode

Status in QEMU:
  New

Bug description:
  A program that invokes recvmsg aborts with "*** stack smashing
  detected ***" when run in qemu-aarch64 (user mode), but works fine
  when running on native aarch64 hardware.

  How to reproduce:
  $ aarch64-linux-gnu-gcc-5 -O -Wall /media/develdata/devel/qemu-bug/testpa=
ssfd.c -static -DEXTRA_SPACE=3D0
  $ QEMU_LD_PREFIX=3D/usr/aarch64-linux-gnu ~/inst-qemu/2.9.0/bin/qemu-aarc=
h64 ./a.out
  *** stack smashing detected ***: ./a.out terminated
  qemu: uncaught target signal 6 (Aborted) - core dumped

  On native aarch64 hardware:
  $ ./a.out =

  $ echo $?
  0

  The parameter EXTRA_SPACE can be used to add additional space to the
  array that receives the recvmsg data. With -DEXTRA_SPACE=3D9 (or
  larger), the program runs fine. Which suggests that recvmsg is storing
  up to 9 bytes more than allowed in memory.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701808/+subscriptions
