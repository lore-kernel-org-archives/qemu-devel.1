Received: from eggs.gnu.org ([2001:4830:134:3::10]:42359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cLN0h-0008MJ-5N
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 23:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cLN0e-0006BO-2T
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 23:35:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:52048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cLN0d-0006Al-Qf
	for qemu-devel@nongnu.org; Sun, 25 Dec 2016 23:35:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cLN0c-0000Lu-1N
	for <qemu-devel@nongnu.org>; Mon, 26 Dec 2016 04:35:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DCC432E80CA
	for <qemu-devel@nongnu.org>; Mon, 26 Dec 2016 04:35:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Dec 2016 04:17:18 -0000
From: Launchpad Bug Tracker <705931@bugs.launchpad.net>
Reply-To: Bug 705931 <705931@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110121152557.9687.39583.malonedeb@palladium.canonical.com>
Message-Id: <20161226041719.31686.97659.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 705931] Re: make ui sdl error 1 on git devel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/705931

Title:
  make ui sdl error 1 on git devel

Status in QEMU:
  Expired

Bug description:
  after clone git devel, try compile on slackware 13.1 32 bit machine
  got error:

  ui/sdl.c:809:1: error: expected '=3D', ',', ';', 'asm' or '__attribute__'=
 before '{' token
  ui/sdl.c:815:36: error: expected ')' before '*' token
  /usr/include/X11/Xlib.h:3575:14: error: old-style parameter declarations =
in prototyped function definition
  /usr/include/X11/Xlib.h:3576:5: error: parameter name omitted
  ui/sdl.c:883:1: error: expected '{' at end of input
  ui/sdl.c:883:1: error: control reaches end of non-void function
  make: *** [ui/sdl.o] Error 1

  =

  root@darkstar:/usr/src/qemu/qemu# gcc -v
  Reading specs from /usr/lib/gcc/i486-slackware-linux/4.5.1/specs
  COLLECT_GCC=3Dgcc
  COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/i486-slackware-linux/4.5.1/lto-wra=
pper
  Target: i486-slackware-linux
  Configured with: ../gcc-4.5.1/configure --prefix=3D/usr --libdir=3D/usr/l=
ib --mandir=3D/usr/man --infodir=3D/usr/info --enable-shared --enable-boots=
trap --enable-languages=3Dada,c,c++,fortran,java,objc,lto --enable-threads=
=3Dposix --enable-checking=3Drelease --with-system-zlib --with-python-dir=
=3D/lib/python2.6/site-packages --disable-libunwind-exceptions --enable-__c=
xa_atexit --enable-libssp --enable-lto --with-gnu-ld --verbose --with-arch=
=3Di486 --target=3Di486-slackware-linux --build=3Di486-slackware-linux --ho=
st=3Di486-slackware-linux
  Thread model: posix
  gcc version 4.5.1 (GCC) =


  =

  root@darkstar:/usr/src/qemu/qemu# uname -a
  Linux darkstar 2.6.35.7-smp #2 SMP Mon Oct 11 14:52:09 CDT 2010 i686 Inte=
l(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz GenuineIntel GNU/Linux
  root@darkstar:/usr/src/qemu/qemu# cat /etc/slackware-version =

  Slackware 13.1.0

  thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/705931/+subscriptions
