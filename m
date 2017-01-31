Received: from eggs.gnu.org ([2001:4830:134:3::10]:46655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYUm1-0007AR-3f
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cYUlw-00040r-6d
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:30:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:39625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cYUlw-00040Z-0n
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 04:30:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cYUlt-0008K4-Hg
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 09:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6BD4D2E80AE
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 09:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2017 09:14:08 -0000
From: Thomas Huth <1031920@bugs.launchpad.net>
Reply-To: Bug 1031920 <1031920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120801202321.9879.66283.malonedeb@wampee.canonical.com>
Message-Id: <20170131091408.16745.48502.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1031920] Re: Linux user gdbserver does not
 respond to remote `Ctrl-C' interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Has the fix mentioned in comment #1 been included in the QEMU
repository?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1031920

Title:
  Linux user gdbserver does not respond to remote  `Ctrl-C' interrupts

Status in QEMU:
  Incomplete

Bug description:
  The bug was reproduced in a recent mainline build for ARM Linux by
  starting emulation with a gdbserver:

  $ qemu-arm -g 1234 a.out

  and then connecting from gdb:

  (gdb) target remote :1234
  Remote debugging using :1234
  [New Remote target]
  [Switching to Remote target]
  0x00008ba8 in _start ()
  (gdb) b main
  Breakpoint 1 at 0x8cb0: file hello.c, line 5.
  (gdb) cont
  Continuing.

  Breakpoint 1, main (argc=3D1, argv=3D0xf6fff24c) at hello.c:5
  5	  int n =3D 0;
  (gdb) l
  1	#include <stdio.h>
  2
  3	int main (int argc, char **argv)
  4	{
  5	  int n =3D 0;
  6
  7	  for (;;) {
  8	     printf ("Hello, World!\n");
  9	     sleep (5);
  10	  }
  (gdb) cont
  Continuing.
  ^C^CInterrupted while waiting for the program.
  Give up (and stop debugging it)? (y or n) y

  Notice that the `Ctrl-C' interrupts are ignored.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1031920/+subscriptions
