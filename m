Received: from eggs.gnu.org ([2001:4830:134:3::10]:40446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsi1-0003ey-2k
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsi0-0008Rc-2T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:19:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:53780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePshz-0008QJ-SG
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:19:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePshy-0004jE-W8
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:19:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F25362E80CB
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:19:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:05:33 -0000
From: Thomas Huth <916720@bugs.launchpad.net>
Reply-To: Bug 916720 <916720@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120115095715.18770.20465.malonedeb@chaenomeles.canonical.com>
Message-Id: <151335393304.9602.4116014671004296045.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 916720] Re: select fails on windows because a
 non-socket fd is in the rfds set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: Fix Committed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/916720

Title:
  select fails on windows because a non-socket fd is in the rfds set

Status in QEMU:
  Incomplete

Bug description:
  The select call in file main_loop.c at line 460 fails on windows
  because a non-socket fd is in the rfds set. As a result, gdb remote
  connections will never be accepted by qemu. The select function
  returns with -1. WSAGetLastError returns code 10038 (WSAENOTSOCK).

  I start qemu as follows:
  qemu-system-arm -cpu cortex-m3 -M lm3s6965evb -nographic -monitor null -s=
erial null -semihosting -kernel test1.elf -S -gdb tcp:127.0.0.1:2200

  qemu is configure with:
  CFLAGS=3D"-O4 -march=3Di686"
  configure --target-list=3D"i386-softmmu arm-softmmu sparc-softmmu ppc-sof=
tmmu" --prefix=3D/home/qemu/install --cc=3Dmingw32-gcc --host-cc=3Dmingw32-=
gcc --audio-drv-list=3D"dsound sdl" --audio-card-list=3D"ac97 es1370 sb16 c=
s4231a adlib gus"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/916720/+subscriptions
