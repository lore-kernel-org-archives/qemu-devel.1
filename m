Received: from eggs.gnu.org ([2001:4830:134:3::10]:58784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRodc-0001Ce-MH
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRodZ-00069y-Kt
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:32986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRodZ-000693-DQ
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:50:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRodX-00031I-UJ
	for <qemu-devel@nongnu.org>; Sun, 02 Jul 2017 23:50:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CB7C52E819D
	for <qemu-devel@nongnu.org>; Sun,  2 Jul 2017 23:50:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Jul 2017 23:32:25 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701974 <1701974@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149903834521.26763.979428508609659400.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701974] [NEW] pwrite does not work right under
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

Public bug reported:

The pwrite system call has no effect when writing to a non-zero file
position, in a program running under qemu-sh4 (version 2.9.0).

How to reproduce:
- Compile the program:
  sh4-linux-gnu-gcc-5 -O -Wall -static -o test-pwrite test-pwrite.c
- Set environment variable for using qemu-sh4 (actually not needed, since t=
he program is statically linked here).
- ~/inst-qemu/2.9.0/bin/qemu-sh4 test-pwrite

Expected output:
buf =3D 01W3456789

Actual output:
buf =3D 0123456789
test-pwrite.c:56: assertion 'strcmp ("01W3456789",buf) =3D=3D 0' failed
qemu: uncaught target signal 6 (Aborted) - core dumped

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "source code of test program"
   https://bugs.launchpad.net/bugs/1701974/+attachment/4908131/+files/test-=
pwrite.c

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
