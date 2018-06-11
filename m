Received: from eggs.gnu.org ([2001:4830:134:3::10]:42280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSJKg-0004FT-23
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSJKb-0005mu-28
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:41:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:34776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fSJKa-0005m5-SR
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 05:41:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fSJKW-0001eA-Si
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 09:41:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4104D2E8917
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 09:41:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Jun 2018 09:30:41 -0000
From: =?utf-8?b?7oO/IENocmlzdGlhbiBFaHJoYXJkdCDug78=?=
	<1769053@bugs.launchpad.net>
Reply-To: Bug 1769053 <1769053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
Message-Id: <152870944201.21801.16024007241932261301.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769053] Re: Cannot start a guest with more than
 1TB of RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since all but the libvirt task to expose these are set to invalid in
regard to the issue here I'm changing the title accordingly.

As a short term solution for Ubuntu users I forked bug 1776189 to
provide a machine type based solution until this here is implemented and
widely available and exploited.

** Summary changed:

- Cannot start a guest with more than 1TB of RAM
+ Ability to control phys-bits through libvirt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769053

Title:
  Ability to control phys-bits through libvirt

Status in libvirt:
  Unknown
Status in QEMU:
  Invalid
Status in libvirt package in Ubuntu:
  Triaged
Status in qemu package in Ubuntu:
  Invalid

Bug description:
  Attempting to start a KVM guest with more than 1TB of RAM fails.

  It looks like we might need some extra patches:
  https://lists.gnu.org/archive/html/qemu-discuss/2017-12/msg00005.html

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: qemu-system-x86 1:2.11+dfsg-1ubuntu7
  ProcVersionSignature: Ubuntu 4.15.0-20.21-generic 4.15.17
  Uname: Linux 4.15.0-20-generic x86_64
  ApportVersion: 2.20.9-0ubuntu7
  Architecture: amd64
  CurrentDesktop: Unity:Unity7:ubuntu
  Date: Fri May  4 16:21:14 2018
  InstallationDate: Installed on 2017-04-05 (393 days ago)
  InstallationMedia: Ubuntu 16.10 "Yakkety Yak" - Release amd64 (20161012.2)
  MachineType: Dell Inc. XPS 13 9360
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.15.0-20-generic root=3D/dev/ma=
pper/ubuntu--vg-root ro quiet splash transparent_hugepage=3Dmadvise vt.hand=
off=3D1
  SourcePackage: qemu
  UpgradeStatus: Upgraded to bionic on 2018-04-30 (3 days ago)
  dmi.bios.date: 02/26/2018
  dmi.bios.vendor: Dell Inc.
  dmi.bios.version: 2.6.2
  dmi.board.name: 0PF86Y
  dmi.board.vendor: Dell Inc.
  dmi.board.version: A00
  dmi.chassis.type: 9
  dmi.chassis.vendor: Dell Inc.
  dmi.modalias: dmi:bvnDellInc.:bvr2.6.2:bd02/26/2018:svnDellInc.:pnXPS1393=
60:pvr:rvnDellInc.:rn0PF86Y:rvrA00:cvnDellInc.:ct9:cvr:
  dmi.product.family: XPS
  dmi.product.name: XPS 13 9360
  dmi.sys.vendor: Dell Inc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/1769053/+subscriptions
