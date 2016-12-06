Received: from eggs.gnu.org ([2001:4830:134:3::10]:56422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEEgu-0005mq-K5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEEgr-00053K-Fl
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:17:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:37684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEEgr-00053C-9n
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:17:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEEgn-0002oM-D7
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:17:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C06332E818F
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 11:55:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Dec 2016 11:43:20 -0000
From: Thomas Huth <1233225@bugs.launchpad.net>
Reply-To: Bug 1233225 <1233225@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130930150918.29090.41471.malonedeb@gac.canonical.com>
Message-Id: <20161206114320.28154.97605.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1233225] Re: mips/mipsel linux user float
 division problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looks like Petar's patch from comment #6 has been included here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D4d66261f71f2efa31e1052e
=3D=3D> Fix released

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1233225

Title:
  mips/mipsel linux user float division problem

Status in QEMU:
  Fix Released

Bug description:
  Hi,

  I tested the following with the qemu git HEAD as of 2013-09-30 on
  Debian stable and testing. My host runs amd64 but I also tried this
  out inside a i386 chroot with the same result. The problem occurs for
  mips and mipsel. Given the following program:

  #include <stdio.h>
  int main(int argc, char **argv)
  {
      int a =3D 1;
      double d =3D a/2.0;
      printf("%f\n", d);
      return 0;
  }

  Instead of printing 0.5, it will print 2.0 if executed in qemu user
  mode.

  $ mipsel-linux-gnu-gcc mipstest.c
  $ ~/qemu/mipsel-linux-user/qemu-mipsel ./a.out
  2.0

  Expecting this to be a problem with my cross compiler (gcc-4.4 from
  emdebian) I ran a fully emulated debian squeeze environment inside
  qemu. There, I compiled the same program natively with gcc and as
  expected got 0.5 as the output. I also copied the cross compiled
  binary inside the emulated environment and also got 0.5 when I ran it.
  So the same mips/mipsel binary produces different output depending on
  whether it is run in a fully emulated environment or qemu user mode.

  Can anybody else reproduce this problem?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1233225/+subscriptions
