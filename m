Received: from eggs.gnu.org ([2001:4830:134:3::10]:46892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fC2gf-0000XN-JG
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fC2ga-0003J1-Ob
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:41:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:52180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fC2ga-0003Fq-Hx
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:41:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fC2gY-0007bo-FO
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 12:41:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7249C2E80CE
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 12:41:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Apr 2018 12:27:36 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1704658 <1704658@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150022185647.5906.17655055691802268187.malonedeb@gac.canonical.com>
Message-Id: <152483205628.21735.11356468534562850542.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1704658] Re: O_CLOEXEC not handled in dup3 system
 call in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Confirmed: It's fixed in qemu-2.12.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1704658

Title:
  O_CLOEXEC not handled in dup3 system call in user mode

Status in QEMU:
  Fix Released

Bug description:
  In qemu user mode, for hppa and sparc64 targets, the parameter of the
  dup3 is not passed correctly when it contains the O_CLOEXEC flag.

  When the attached program runs, the expected output is:
  errno=3D9=3DEBADF

  How to reproduce on hppa:
  - Compile the program: hppa-linux-gnu-gcc-5 -O -Wall -static testdup3.c -=
o testdup3-hppa
  - Set environment variables for running qemu-hppa.
  - ~/inst-qemu/2.9.0/bin/qemu-hppa testdup3-hppa
  errno=3D22=3DEINVAL
  testdup3.c:54: assertion 'errno =3D=3D EBADF' failed

  How to reproduce on sparc64:
  - Compile the program: sparc64-linux-gnu-gcc-5 -O -Wall -static testdup3.=
c -o testdup3-sparc64
  - Set environment variables for running qemu-sparc64.
  - ~/inst-qemu/2.9.0/bin/qemu-sparc64 testdup3-sparc64
  errno=3D22=3DEINVAL
  testdup3.c:54: assertion 'errno =3D=3D EBADF' failed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1704658/+subscriptions
