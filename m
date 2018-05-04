Received: from eggs.gnu.org ([2001:4830:134:3::10]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEVZi-0001ZG-IJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fEVZe-0001u2-Jv
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:56:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:42226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fEVZe-0001tB-DR
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:56:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fEVZc-0006tI-S6
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 07:56:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D0AB92E80C9
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 07:56:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 May 2018 07:44:10 -0000
From: ChristianEhrhardt <1769053@bugs.launchpad.net>
Reply-To: Bug 1769053 <1769053@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152541524728.557.4600864098110042577.malonedeb@gac.canonical.com>
Message-Id: <152541985049.7362.15270731972917808461.malone@wampee.canonical.com>
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

Hi Daniel,
might I ask what you expect now?

The changes to seabios are not even upstream yet in git://git.seabios.org/s=
eabios.git
The changes to qemu are neither upstream in git://git.qemu.org/qemu.git

The changes linked also are for a qemu way++ back in time (like pre trusty)=
, so they just don't apply. Some of these changes are handled already, but =
different like the second qemu change of above mail is in qemu since "6c7c3=
c21 x86: implement la57 paging mode" which is qemu >=3D2.9.
That said - this one I could track, maybe the other changes are also upstre=
am but in a way different form.

At least for myself I currently have no >1TB system to even try this -
well I have done this on s390x and there it works fine already but you
need x86 here.

Even when all of the above would be resolved, the mail above states that
even if those are applied they still have issues when going >1TB.

I think you'd need a clear this is what I tried and this is what fails
with a setup as simple as possible. If it fails in Ubuntu we can build a
latest upstream build for you and if failing there we can work with
upstream to resolve properly. From there we can think about the
backportability of those changes. But the suggested "hey there are these
patches, won't work.

Please don't get me wrong (I want to help), but so far this appears to me s=
o far as a suggestion of a set of non-upstreamed, non-applicable, non-testa=
ble, non-working changes.
We need to better sort out how to handle this which is why I ask what you e=
xpect to happen now.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769053

Title:
  Cannot start a guest with more than 1TB of RAM

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  New

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
https://bugs.launchpad.net/qemu/+bug/1769053/+subscriptions
