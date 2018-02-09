Received: from eggs.gnu.org ([2001:4830:134:3::10]:36578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ekDGs-0003TC-Vx
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ekDGn-0001IJ-N2
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:19:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:57848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ekDGn-0001Gp-G2
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:19:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ekDGk-0004We-EE
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 18:19:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2659B2E80E2
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 18:19:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2018 18:09:39 -0000
From: LocutusOfBorg <costamagnagianfranco@yahoo.it>
Reply-To: Bug 1350435 <1350435@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140730162025.27276.9650.malonedeb@soybean.canonical.com>
Message-Id: <151819977969.29764.1567502511141852094.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1350435] Re: tcg.c:1693: tcg fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello, this seems to be still an issue
W: Failure while unpacking required packages.  This will be attempted up to=
 five times.
W: See //debootstrap/debootstrap.log for details (possibly the package /var=
/cache/apt/archives/bash_4.4.18-1ubuntu1_arm64.deb is at fault)


dpkg -l |grep qemu
ii  ipxe-qemu                                                        1.0.0+=
git-20161027.b991c67+really20150424.a25a16d-1ubuntu2 all          PXE boot =
firmware - ROM images for qemu
ii  ipxe-qemu-256k-compat-efi-roms                                   1.0.0+=
git-20150424.a25a16d-0ubuntu2                        all          PXE boot =
firmware - Compat EFI ROM images for qemu
ii  qemu                                                             1:2.11=
+dfsg-1ubuntu1                                       amd64        fast proc=
essor emulator
ii  qemu-block-extra:amd64                                           1:2.11=
+dfsg-1ubuntu1                                       amd64        extra blo=
ck backend modules for qemu-system and qemu-utils
rc  qemu-kvm                                                         1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU Full=
 virtualization on x86 hardware
ii  qemu-slof                                                        201707=
24+dfsg-1ubuntu0.1                                   all          Slimline =
Open Firmware -- QEMU PowerPC version
ii  qemu-system                                                      1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries
ii  qemu-system-arm                                                  1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (arm)
ii  qemu-system-common                                               1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (common files)
ii  qemu-system-mips                                                 1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (mips)
ii  qemu-system-misc                                                 1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (miscellaneous)
ii  qemu-system-ppc                                                  1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (ppc)
ii  qemu-system-s390x                                                1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (s390x)
ii  qemu-system-sparc                                                1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (sparc)
ii  qemu-system-x86                                                  1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU full=
 system emulation binaries (x86)
ii  qemu-user                                                        1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU user=
 mode emulation binaries
ii  qemu-user-static                                                 1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU user=
 mode emulation binaries (static version)
ii  qemu-utils                                                       1:2.11=
+dfsg-1ubuntu1                                       amd64        QEMU util=
ities


to reproduce: pbuilder-dist bionic arm64 create

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1350435

Title:
  tcg.c:1693: tcg fatal error

Status in launchpad-buildd:
  Won't Fix
Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  this started happening after the launchpad buildd trusty deploy
  https://code.launchpad.net/~costamagnagianfranco/+archive/ubuntu/firefox/=
+build/6224439

  =

  debconf-updatepo
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)
  /build/buildd/qemu-2.0.0+dfsg/tcg/tcg.c:1693: tcg fatal error
  /build/buildd/qemu-2.0.0+dfsg/tcg/tcg.c:1693: tcg fatal error

  this seems to be the patch needed
  https://patches.linaro.org/32473/

To manage notifications about this bug go to:
https://bugs.launchpad.net/launchpad-buildd/+bug/1350435/+subscriptions
