Received: from eggs.gnu.org ([2001:4830:134:3::10]:53035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDpX-0006Wz-3M
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDpW-0002Kt-43
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:38455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDpV-0002KN-UY
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDpU-0004sj-Dn
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CB9132E80CC
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 14:18:40 -0000
From: Thomas Huth <1066909@bugs.launchpad.net>
Reply-To: Bug 1066909 <1066909@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121015142611.16277.97828.malonedeb@wampee.canonical.com>
Message-Id: <20170119141842.25029.18760.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1066909] Re: App-level clone emulation for
 microblaze is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1066909

Title:
  App-level clone emulation for microblaze is broken

Status in QEMU:
  Fix Released

Bug description:
  When CLONE_THREAD is used, the new process starts with the program
  counter pointing to the system call instruction, rather than the
  instruction immediately following it. This causes an infinite cascade
  (linear growth, not exponential) of thread creation, which quickly
  crashes when the threads start running and they're all using the same
  stack.

  I'm using qemu 1.1.2 packaged with Debian, but I'm not aware of any
  fixes since then that would address the problem.

  I can provide a test program if needed; a short C program using
  syscall() directly or an even-shorter asm program can demonstrate the
  issue without need for debugging around pthread library routines.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1066909/+subscriptions
