Received: from eggs.gnu.org ([2001:4830:134:3::10]:47510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWf4C-0006GU-Pw
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cWf4B-0003nH-LE
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:06:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:49379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cWf4B-0003n9-Fi
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 03:05:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cWf4A-0005vm-4O
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 08:05:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1C4412E81C8
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 08:05:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2017 07:49:00 -0000
From: Thomas Huth <1254828@bugs.launchpad.net>
Reply-To: Bug 1254828 <1254828@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131125184515.27602.72317.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170126074900.8713.26292.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1254828] Re: qemu-sparc64-static: Segmentation
 Fault during debootstrap second stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This sounds like a distribution specific bug to me, so moving the bug to
QEMU-Ubuntu.

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1254828

Title:
  qemu-sparc64-static: Segmentation Fault during debootstrap second
  stage

Status in Linaro QEMU:
  New
Status in qemu package in Ubuntu:
  New
Status in qemu-linaro package in Ubuntu:
  New

Bug description:
  Host: Ubuntu Precise amd64
  Guest: Debian Sid (ports) sparc64

  When attempting the second stage of a debootstrap for a sparc64 Debian
  Sid guest, a segmentation fault occurs.

  $ sudo qemu-debootstrap --no-check-gpg --arch=3Dsparc64 sid sparc64 http:=
//ftp.debian-ports.org/debian
  I: Running command: debootstrap --arch sparc64 --foreign --no-check-gpg s=
id sparc64 http://ftp.debian-ports.org/debian
  [...]
  I: Running command: chroot sparc64 /debootstrap/debootstrap --second-stage
  /debootstrap/debootstrap: 22: .: Can't open /usr/share/debootstrap/functi=
ons
  Segmentation fault (core dumped)

  Running a simple "sudo chroot sparc64" exits silently on amd64, and
  reports a segfault on i386.

  ProblemType: Bug
  DistroRelease: Ubuntu 12.04
  Package: qemu-user-static 1.0.50-2012.03-0ubuntu2.1
  ProcVersionSignature: Ubuntu 3.8.0-33.48~precise1-generic 3.8.13.11
  Uname: Linux 3.8.0-33-generic x86_64
  NonfreeKernelModules: wl
  ApportVersion: 2.0.1-0ubuntu17.6
  Architecture: amd64
  Date: Mon Nov 25 17:49:34 2013
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
https://bugs.launchpad.net/qemu-linaro/+bug/1254828/+subscriptions
