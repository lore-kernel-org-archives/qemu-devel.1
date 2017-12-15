Received: from eggs.gnu.org ([2001:4830:134:3::10]:42596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePjS8-0000jG-Ql
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePjS4-0002FG-Pl
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:26:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:37780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePjS4-0002E1-JU
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:26:32 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePjS1-0000nQ-Hq
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 06:26:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7D2C82E80CB
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 06:26:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 06:19:28 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701973 <1701973@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149903774730.26446.16010024608153544843.malonedeb@chaenomeles.canonical.com>
Message-Id: <151331876820.9602.7505910011870121947.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701973] Re: pread does not work right under
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

With qemu-2.11:
$ ~/inst-qemu/2.11.0/bin/qemu-sh4 test-pread
ret=3D1 errno=3D2

The value of errno is actually irrelevant here. So, the bug is fixed.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701973

Title:
  pread does not work right under qemu-sh4

Status in QEMU:
  Fix Released

Bug description:
  The pread system call returns a wrong value in some case, in a program
  running under qemu-sh4 (version 2.9.0).

  How to reproduce:
  - Compile the program:
    sh4-linux-gnu-gcc-5 -O -Wall -static -o test-pread test-pread.c
  - Set environment variable for using qemu-sh4 (actually not needed, since=
 the program is statically linked here).
  - ~/inst-qemu/2.9.0/bin/qemu-sh4 test-pread

  Expected output:
  ret=3D1 errno=3D0

  Actual output:
  ret=3D0 errno=3D2
  test-pread.c:44: assertion 'ret =3D=3D 1' failed
  qemu: uncaught target signal 6 (Aborted) - core dumped

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701973/+subscriptions
