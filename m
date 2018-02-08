Received: from eggs.gnu.org ([2001:4830:134:3::10]:47092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejr70-0004jW-9S
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejr6x-0007Ln-3X
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:39:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:38176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejr6w-0007K7-6w
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 13:39:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejr6v-0004et-3R
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 18:39:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0535B2E80CB
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 18:39:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 18:26:05 -0000
From: Thomas Huth <1254786@bugs.launchpad.net>
Reply-To: Bug 1254786 <1254786@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131125163240.27695.53246.malonedeb@chaenomeles.canonical.com>
Message-Id: <151811436553.29730.9026982009524726099.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1254786] Re: qemu-m68k-static: illegal
 instruction ebc0 during debootstrap second stage
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
latest version of QEMU? There should now be support for "normal" 68k
CPUs, too...

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254786

Title:
  qemu-m68k-static: illegal instruction ebc0 during debootstrap second
  stage

Status in QEMU:
  Incomplete
Status in qemu-linaro package in Ubuntu:
  New

Bug description:
  Host: Ubuntu Precise amd64
  Guest: Debian (ports) sid m68k

  $ sudo qemu-debootstrap --no-check-gpg --arch=3Dm68k sid m68k http://ftp.=
debian-ports.org/debian
  I: Running command: debootstrap --arch m68k --foreign --no-check-gpg sid =
m68k http://ftp.debian-ports.org/debian
  [...]
  I: Running command: chroot m68k /debootstrap/debootstrap --second-stage
  qemu: fatal: Illegal instruction: ebc0 @ f67e5662
  D0 =3D 6ffffef5   A0 =3D f67fbf58   F0 =3D 0000000000000000 (           0)
  D1 =3D 0000010a   A1 =3D 00000000   F1 =3D 0000000000000000 (           0)
  D2 =3D 0000000f   A2 =3D 00000000   F2 =3D 0000000000000000 (           0)
  D3 =3D 00000000   A3 =3D f67e0000   F3 =3D 0000000000000000 (           0)
  D4 =3D 00000000   A4 =3D 00000000   F4 =3D 0000000000000000 (           0)
  D5 =3D 00000000   A5 =3D f67fc000   F5 =3D 0000000000000000 (           0)
  D6 =3D 00000000   A6 =3D f6fff7cc   F6 =3D 0000000000000000 (           0)
  D7 =3D 00000000   A7 =3D f6fff580   F7 =3D 0000000000000000 (           0)
  PC =3D f67e5662   SR =3D 0000 ----- FPRESULT =3D            0
  Aborted (core dumped)

  ProblemType: Bug
  DistroRelease: Ubuntu 12.04
  Package: qemu-user-static 1.0.50-2012.03-0ubuntu2.1
  ProcVersionSignature: Ubuntu 3.8.0-33.48~precise1-generic 3.8.13.11
  Uname: Linux 3.8.0-33-generic x86_64
  NonfreeKernelModules: wl
  ApportVersion: 2.0.1-0ubuntu17.6
  Architecture: amd64
  Date: Mon Nov 25 16:08:26 2013
  Dependencies:
   =

  InstallationMedia: Ubuntu 12.04.3 LTS "Precise Pangolin" - Release amd64 =
(20130820.1)
  MarkForUpload: True
  ProcEnviron:
   LANGUAGE=3Den_GB:en
   TERM=3Dxterm
   PATH=3D(custom, no user)
   LANG=3Den_GB.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: qemu-linaro
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1254786/+subscriptions
