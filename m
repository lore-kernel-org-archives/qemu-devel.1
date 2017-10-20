Received: from eggs.gnu.org ([2001:4830:134:3::10]:55088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e5aMS-0007dX-J8
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e5aMO-000693-4c
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:41:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:35714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e5aMN-00068M-UR
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:41:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e5aMM-0002Yv-TK
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:41:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DC9B02E80C8
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:41:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Oct 2017 16:26:05 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1725267 <1725267@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150850189101.17148.14929440782690831821.malonedeb@wampee.canonical.com>
Message-Id: <150851676608.27683.13242762132871843350.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1725267] Re: armeb regression since qemu version
 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "instrumented source testcase"
   https://bugs.launchpad.net/qemu/+bug/1725267/+attachment/4979333/+files/=
atomic-exchange-4.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1725267

Title:
  armeb regression since qemu version 2.8

Status in QEMU:
  New

Bug description:
  Hi,

  I have noticed a regression when I upgraded from qemu-armeb 2.7 to
  2.8, and the problem is still present with version 2.10.1.

  I am using qemu for GCC validation, noticed problems with testcases
  involving atomics, I'm attaching here atomic-exchange-4.exe.

  # with 2.7:
  $ qemu-armeb -cpu any -R 0 -L $PWD -E LD_LIBRARY_PATH=3D$PWD/lib $PWD/ato=
mic-exchange-4.exe
  $ echo $?
  0
  # with 2.8, 2.10.1:
  $ qemu-armeb -cpu any -R 0 -L $PWD -E LD_LIBRARY_PATH=3D$PWD/lib $PWD/ato=
mic-exchange-4.exe
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted (core dumped)
  $ echo $?
  134

  The source code is gcc/testsuite/gcc.dg/atomic-exchange-4.c

  Running with -d in_asm shows a difference early in the startup code:
  IN: _dl_sysdep_start
  [...]
  0x40a17790:  908ff103      addls	pc, pc, r3, lsl #2

  and then the next address is not the same with qemu 2.7 and 2.10.1

  I hope you have enough data/information to reproduce and confirm/fix
  the problem.

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1725267/+subscriptions
