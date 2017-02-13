Received: from eggs.gnu.org ([2001:4830:134:3::10]:49215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdN6C-0003MP-Vh
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdN69-0002w4-Qr
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:19:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:52292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdN69-0002vw-L9
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:19:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdN68-0007LL-60
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:19:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 22C0F2E80D6
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:19:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Feb 2017 20:05:19 -0000
From: Thomas Huth <1018530@bugs.launchpad.net>
Reply-To: Bug 1018530 <1018530@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120627183440.4107.29777.malonedeb@gac.canonical.com>
Message-Id: <20170213200519.4535.89400.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1018530] Re: No write access in a 9p/virtfs
 shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sounds like this was an Ubuntu- or libvirt-specific bug ... so closing
this in the upstream QEMU bug tracker.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1018530

Title:
  No write access in a 9p/virtfs shared folder

Status in QEMU:
  Invalid
Status in qemu-kvm package in Ubuntu:
  Fix Released

Bug description:
  Ubuntu version:  Ubuntu 12.04 LTS
  Kernel: 3.2.0-25-generic
  Version of qemu-kvm: 1.0+noroms-0ubuntu13

  I have created an shared folder for an virtual machine which is
  managed by libvirt.

  <filesystem type=3D'mount' accessmode=3D'passthrough'>
  <source dir=3D'/storage/data'/>
  <target dir=3D'data'/>
  <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x08' functi=
on=3D'0x0'/>
  </filesystem>

  I mounted it in the virtual machine with this command:  mount -t 9p -o tr=
ans=3Dvirtio,version=3D9p2000.L data /data
  The filesystem permissions of all files an folders in the shared folder a=
re set to 777. I expected that I have the full permissions also in the virt=
ual machine.

  Regardless of the permissions on the filesystem I cannot write or create =
files and folders in the virtual machine. The original filesystem (/storage=
) is XFS.
  In another shared folder (similar config in libvirt) which is originally =
NTFS I have no problems.

  ProblemType: Bug
  DistroRelease: Ubuntu 12.04
  Package: qemu-kvm 1.0+noroms-0ubuntu13
  ProcVersionSignature: Ubuntu 3.2.0-25.40-generic 3.2.18
  Uname: Linux 3.2.0-25-generic x86_64
  ApportVersion: 2.0.1-0ubuntu8
  Architecture: amd64
  Date: Wed Jun 27 20:15:20 2012
  InstallationMedia: Ubuntu-Server 12.04 LTS "Precise Pangolin" - Beta amd6=
4 (20120409)
  MachineType: To be filled by O.E.M. To be filled by O.E.M.
  ProcEnviron:
   TERM=3Dxterm
   LANG=3Dde_DE.UTF-8
   SHELL=3D/bin/bash
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-3.2.0-25-generic root=3D/dev/map=
per/system-root ro
  SourcePackage: qemu-kvm
  UpgradeStatus: No upgrade log present (probably fresh install)
  dmi.bios.date: 04/18/2012
  dmi.bios.vendor: American Megatrends Inc.
  dmi.bios.version: 1208
  dmi.board.asset.tag: To be filled by O.E.M.
  dmi.board.name: M5A99X EVO
  dmi.board.vendor: ASUSTeK COMPUTER INC.
  dmi.board.version: Rev 1.xx
  dmi.chassis.asset.tag: To Be Filled By O.E.M.
  dmi.chassis.type: 3
  dmi.chassis.vendor: To Be Filled By O.E.M.
  dmi.chassis.version: To Be Filled By O.E.M.
  dmi.modalias: dmi:bvnAmericanMegatrendsInc.:bvr1208:bd04/18/2012:svnTobef=
illedbyO.E.M.:pnTobefilledbyO.E.M.:pvrTobefilledbyO.E.M.:rvnASUSTeKCOMPUTER=
INC.:rnM5A99XEVO:rvrRev1.xx:cvnToBeFilledByO.E.M.:ct3:cvrToBeFilledByO.E.M.:
  dmi.product.name: To be filled by O.E.M.
  dmi.product.version: To be filled by O.E.M.
  dmi.sys.vendor: To be filled by O.E.M.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1018530/+subscriptions
