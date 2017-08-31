Received: from eggs.gnu.org ([2001:4830:134:3::10]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnXgl-0007XU-Ky
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 18:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dnXgh-0007Q0-FO
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 18:11:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dnXgh-0007PH-9h
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 18:11:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dnXgg-0006Fu-F5
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 22:11:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8060D2E80D2
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 22:11:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Aug 2017 22:01:36 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701973 <1701973@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149903774730.26446.16010024608153544843.malonedeb@chaenomeles.canonical.com>
Message-Id: <150421689618.19681.18417972015155106158.malone@chaenomeles.canonical.com>
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

The behaviour in qemu-2.10 is the same as in qemu-2.9.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701973

Title:
  pread does not work right under qemu-sh4

Status in QEMU:
  New

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
