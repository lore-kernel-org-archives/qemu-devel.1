Received: from eggs.gnu.org ([2001:4830:134:3::10]:39973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRHYA-0002Fx-Gu
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 08:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRHY7-0003yC-CJ
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 08:30:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:54878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRHY7-0003xf-5P
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 08:30:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRHY5-0007Bl-UC
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 12:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D65EE2E8195
	for <qemu-devel@nongnu.org>; Sat,  1 Jul 2017 12:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Jul 2017 12:24:35 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701808 <1701808@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149891130681.24932.1838110700653893581.malonedeb@soybean.canonical.com>
Message-Id: <149891187530.6077.6493674534463008420.malone@gac.canonical.com>
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

Likewise for 32-bit arm:
$ ~/inst-qemu/2.9.0/bin/qemu-arm ./a.arm =

*** stack smashing detected ***: ./a.arm terminated
qemu: uncaught target signal 6 (Aborted) - core dumped


** Attachment added: "Statically compiled test program for arm"
   https://bugs.launchpad.net/qemu/+bug/1701808/+attachment/4907353/+files/=
a.arm

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
