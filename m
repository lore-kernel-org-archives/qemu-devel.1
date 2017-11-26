Received: from eggs.gnu.org ([2001:4830:134:3::10]:38162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eJ3Y0-0001Aa-Ac
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 15:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eJ3Xw-0007VR-3H
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 15:29:04 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1eJ3Xv-0007Ue-Sd
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 15:29:00 -0500
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
Date: Sun, 26 Nov 2017 21:28:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] glibc "linux: spawni.c: simplify error reporting to
 parent" breaks qemu-user/Windows Service For Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.com>, James Clarke <jrtc27@jrtc27.com>, Michael Karcher <debian@mkarcher.dialup.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>

Hi Rasmus!

Your recent commit "linux: spawni.c: simplify error reporting to parent" apparently
broke both qemu-user and Microsoft's Windows Services for Linux which both fail
with:

dpkg: warning: ignoring pre-dependency problem!
Preparing to unpack .../archives/bash_4.4-5_m68k.deb ...
preinst: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `ec >= 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
dpkg: error processing archive /var/cache/apt/archives/bash_4.4-5_m68k.deb (--unpack):
 new bash package pre-installation script subprocess was killed by signal (Aborted)
Selecting previously unselected package bsdutils.
dpkg: regarding .../bsdutils_1%3a2.30.2-0.1_m68k.deb containing bsdutils, pre-dependency problem:
 bsdutils pre-depends on libsystemd0
  libsystemd0 is not installed.

I'm not sure yet what the actual problem is but I thought it should be necessary
to point you at the problem.

Cheers,
Adrian

> [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=4b4d4056bb154603f36c6f8845757c1012758158;hp=8d3bd947483f50b57aee7c35c07dc1927d6e8a27
> [2] https://github.com/Microsoft/WSL/issues/1878

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
