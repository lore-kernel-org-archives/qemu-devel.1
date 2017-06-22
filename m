Received: from eggs.gnu.org ([2001:4830:134:3::10]:53319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dO77K-0004ur-GH
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dO77G-000569-GD
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:46:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:41642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dO77G-00055s-9A
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:46:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dO77E-0007O5-7I
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:46:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 33DD02E80E8
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:46:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2017 18:34:57 -0000
From: Thomas Huth <1037606@bugs.launchpad.net>
Reply-To: Bug 1037606 <1037606@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120816144502.14385.65707.malonedeb@soybean.canonical.com>
Message-Id: <149815649764.2605.18399835956044738511.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1037606] Re: vmwgfx does not work with kvm vmware
 vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OK, got your point ... but AFAIK the vmware display device in QEMU is
pretty much unmaintened anyway, so unless someone steps up and takes
care of this device, I think the WONT-FIX status is appropriate for this
bug.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1037606

Title:
  vmwgfx does not work with kvm vmware vga

Status in Linux:
  Confirmed
Status in QEMU:
  Won't Fix
Status in linux package in Ubuntu:
  Triaged

Bug description:
  vmwgfx driver fails to initialize inside kvm.

  tried: kvm -m 2048 -vga vmware -cdrom RebeccaBlackLinux.iso (Ubuntu
  based, any Ubuntu live CD would do)

  Apport data collected with qantal alpha live CD (somewhat older
  kernel).

  The error is shjown in CurrentDmesg.txt
  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1037606/+attachment/=
3265235/+files/CurrentDmesg.txt

  ---
  ApportVersion: 2.4-0ubuntu8
  Architecture: amd64
  AudioDevicesInUse: Error: command ['fuser', '-v', '/dev/snd/seq', '/dev/s=
nd/timer'] failed with exit code 1:
  CRDA: Error: command ['iw', 'reg', 'get'] failed with exit code 1: nl8021=
1 not found.
  CasperVersion: 1.320
  DistroRelease: Ubuntu 12.10
  IwConfig:
  =C2=A0eth0      no wireless extensions.

  =C2=A0lo        no wireless extensions.
  LiveMediaBuild: Ubuntu 12.10 "Quantal Quetzal" - Alpha amd64 (20120724.2)
  Lsusb: Error: command ['lsusb'] failed with exit code 1: unable to initia=
lize libusb: -99
  MachineType: Bochs Bochs
  Package: linux (not installed)
  ProcEnviron:
  =C2=A0TERM=3Dlinux
  =C2=A0PATH=3D(custom, no user)
  =C2=A0LANG=3Den_US.UTF-8
  =C2=A0SHELL=3D/bin/bash
  ProcFB:

  ProcKernelCmdLine: file=3D/cdrom/preseed/hostname.seed boot=3Dcasper init=
rd=3D/casper/initrd.lz quiet splash -- maybe-ubiquity
  ProcVersionSignature: Ubuntu 3.5.0-6.6-generic 3.5.0
  PulseList: Error: command ['pacmd', 'list'] failed with exit code 1: No P=
ulseAudio daemon running, or not running as session daemon.
  RelatedPackageVersions:
  =C2=A0linux-restricted-modules-3.5.0-6-generic N/A
  =C2=A0linux-backports-modules-3.5.0-6-generic  N/A
  =C2=A0linux-firmware                           1.85
  RfKill:

  Tags:  quantal
  Uname: Linux 3.5.0-6-generic x86_64
  UpgradeStatus: No upgrade log present (probably fresh install)
  UserGroups:

  dmi.bios.date: 01/01/2007
  dmi.bios.vendor: Bochs
  dmi.bios.version: Bochs
  dmi.chassis.type: 1
  dmi.chassis.vendor: Bochs
  dmi.modalias: dmi:bvnBochs:bvrBochs:bd01/01/2007:svnBochs:pnBochs:pvr:cvn=
Bochs:ct1:cvr:
  dmi.product.name: Bochs
  dmi.sys.vendor: Bochs
  --- =

  ApportVersion: 2.0.1-0ubuntu12
  Architecture: i386
  DistroRelease: Ubuntu 12.04
  InstallationMedia: Ubuntu 10.10 "Maverick Meerkat" - Release i386 (201010=
07)
  Package: linux (not installed)
  ProcEnviron:
   TERM=3Dxterm
   PATH=3D(custom, no user)
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  Tags:  precise running-unity
  Uname: Linux 3.6.0-030600rc3-generic i686
  UnreportableReason: The running kernel is not an Ubuntu kernel
  UpgradeStatus: Upgraded to precise on 2012-08-30 (0 days ago)
  UserGroups: adm admin cdrom dialout lpadmin plugdev sambashare

To manage notifications about this bug go to:
https://bugs.launchpad.net/linux/+bug/1037606/+subscriptions
