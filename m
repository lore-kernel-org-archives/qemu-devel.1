Received: from eggs.gnu.org ([2001:4830:134:3::10]:58777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKM2D-0003QX-Qb
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKM2B-0001aZ-VO
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:25:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:50118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eKM2B-0001a3-Op
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:25:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eKM2A-0002fa-Rq
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 10:25:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D18472E8059
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 10:25:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Nov 2017 10:16:37 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1701974 <1701974@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149903834521.26763.979428508609659400.malonedeb@chaenomeles.canonical.com>
Message-Id: <151203699752.20166.8673096787512674664.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701974] Re: pwrite does not work right under
 qemu-sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This might be related to this fix:

>
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D8bf8e9df4a7d82c7a47cc961c=
9cdee1615595de0

FWIW, if you're interested in sh4, please join #debian-ports on OFTC and
subscribe to the debian-superh mailing list. We're doing lots of sh4
development and testing QEMU in Debian.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701974

Title:
  pwrite does not work right under qemu-sh4

Status in QEMU:
  New

Bug description:
  The pwrite system call has no effect when writing to a non-zero file
  position, in a program running under qemu-sh4 (version 2.9.0).

  How to reproduce:
  - Compile the program:
    sh4-linux-gnu-gcc-5 -O -Wall -static -o test-pwrite test-pwrite.c
  - Set environment variable for using qemu-sh4 (actually not needed, since=
 the program is statically linked here).
  - ~/inst-qemu/2.9.0/bin/qemu-sh4 test-pwrite

  Expected output:
  buf =3D 01W3456789

  Actual output:
  buf =3D 0123456789
  test-pwrite.c:56: assertion 'strcmp ("01W3456789",buf) =3D=3D 0' failed
  qemu: uncaught target signal 6 (Aborted) - core dumped

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701974/+subscriptions
