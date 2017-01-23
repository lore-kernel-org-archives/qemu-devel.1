Received: from eggs.gnu.org ([2001:4830:134:3::10]:56250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVckU-0005CZ-6K
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:25:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cVckT-00048M-2m
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:25:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:45565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cVckS-00047x-TN
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:25:21 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cVckS-0000VO-0A
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:25:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EFA262E80C2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:25:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Jan 2017 11:08:25 -0000
From: Thomas Huth <804517@bugs.launchpad.net>
Reply-To: Bug 804517 <804517@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110701200216.25071.79043.malonedeb@gac.canonical.com>
Message-Id: <20170123110826.20325.69605.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 804517] Re: qemu crashes on Darwin in
 qemu_iohandler_poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this issue with the latest version of QEMU, or
could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/804517

Title:
  qemu crashes on Darwin in qemu_iohandler_poll

Status in QEMU:
  Incomplete

Bug description:
  I have an issue when I try to run qemu-system-arm on Mac OS X. =

  Sometime between 1 and 15 secs after qemu is started it crashes
  as shown bellow.

  Same thing on linux host works fine.

  Is anybody else experiencing this?
  Any Hints?

  Thanks,

  Damjan


  (gdb) run
  Starting program: /opt/arm-qemu/bin/qemu-system-arm -M verdex -pflash fla=
sh.img -nographic -monitor null -m 289
  Reading symbols for shared libraries .++++++++++++++.....................=
................................................................... done
  pxa2xx_clkpwr_write: CPU frequency change attempt

  =

  U-Boot 1.2.0 (May 10 2008 - 21:17:19) - PXA270@400 MHz - 1604

  *** Welcome to Gumstix ***

  DRAM:  256 MB
  Flash: 32 MB
  Using default environment

  Hit any key to stop autoboot:  1 =

  Program received signal EXC_BAD_ACCESS, Could not access memory.
  Reason: KERN_PROTECTION_FAILURE at address: 0x00007fff5fbfed30
  0x00007fff5fbfed30 in ?? ()
  (gdb) =

  (gdb) bt
  #0  0x00007fff5fbfed30 in ?? ()
  #1  0x00000001000c26f4 in qemu_iohandler_poll ()
  #2  0x00000001001975ae in main_loop_wait ()
  #3  0x00000001001976e2 in main_loop ()
  #4  0x000000010019bfbc in qemu_main ()
  #5  0x00000001000d63a5 in main ()
  (gdb)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/804517/+subscriptions
