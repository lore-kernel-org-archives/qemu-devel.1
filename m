Received: from eggs.gnu.org ([2001:4830:134:3::10]:58783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRodc-0001Cd-MK
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRoda-0006Ag-8P
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:50:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:33027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRoda-00069r-2S
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 19:50:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRodZ-00032a-4e
	for <qemu-devel@nongnu.org>; Sun, 02 Jul 2017 23:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 201CD2E8194
	for <qemu-devel@nongnu.org>; Sun,  2 Jul 2017 23:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Jul 2017 23:36:40 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701973 <1701973@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149903774730.26446.16010024608153544843.malonedeb@chaenomeles.canonical.com>
Message-Id: <149903860076.24899.11924886596768319085.malone@soybean.canonical.com>
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

In case it matters: My host platform is Linux/x86_64.

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
