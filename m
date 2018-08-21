Received: from eggs.gnu.org ([2001:4830:134:3::10]:60394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0ma-0001Dk-5t
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0je-0002ZJ-U4
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:05:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:48228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0je-0002Z3-O1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:05:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0jd-0000B1-56
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:05:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 24FDB2E851D
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:46:55 -0000
From: Thomas Huth <1180777@bugs.launchpad.net>
Reply-To: Bug 1180777 <1180777@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130516122510.15619.26740.malonedeb@chaenomeles.canonical.com>
Message-Id: <153483401671.30784.3040856612847920482.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1180777] Re: RDP traffic freeze on quiet network
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu-kvm (Ubuntu)
       Status: Confirmed =3D> Incomplete

** Changed in: debian
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1180777

Title:
  RDP traffic freeze on quiet network

Status in QEMU:
  Incomplete
Status in qemu-kvm package in Ubuntu:
  Incomplete
Status in Debian:
  Incomplete

Bug description:
  To summarize what I think has been found so far,

    1. The main symptom is that RDP connections hang after some time
    2. This bug affects qemu 1.0 .. 1.6.5
    3. This bug affects at least windows xp and windows 7 guests
    4. Keeping another network connection open, such as vnc, prevents the R=
DP connection from hanging.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Hi,

  I have recently setup a Windows 7 VM on KVM and started using it
  through remote desktop.

  What happens is that, after some hours of usage, the remote desktop
  connection freezes. I thought it was a remmina bug, as the it was
  enough to kill and restart it to successfully connect again to the VM.

  However, today I've switched to a different RDP client (2X Client
  chromium app) and the freeze just happened again!

  Some information:
  - the host and the VM are completely idle when the freeze occurs
  - I've tried sniffing the network packets toward the RDP port during the =
freeze and found that the client is sending packets but no packet is sent b=
ack

  Could this be a KVM issue? How can I further debug this one (I expect
  the freeze to happen again...)?

  ProblemType: Bug
  DistroRelease: Ubuntu 12.04
  Package: kvm 1:84+dfsg-0ubuntu16+1.0+noroms+0ubuntu14.8
  ProcVersionSignature: Ubuntu 3.2.0-41.66-generic 3.2.42
  Uname: Linux 3.2.0-41-generic x86_64
  ApportVersion: 2.0.1-0ubuntu17.2
  Architecture: amd64
  Date: Thu May 16 14:12:40 2013
  MachineType: Hewlett-Packard HP ProBook 4520s
  MarkForUpload: True
  ProcEnviron:
  =C2=A0TERM=3Dxterm
  =C2=A0PATH=3D(custom, no user)
  =C2=A0LANG=3Den_US.UTF-8
  =C2=A0SHELL=3D/bin/bash
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinuz-3.2.0-41-generic root=3DUUI=
D=3DD2E20BC3E20BAAB5 loop=3D/hostname/disks/root.disk ro quiet splash vt.ha=
ndoff=3D7
  SourcePackage: qemu-kvm
  UpgradeStatus: No upgrade log present (probably fresh install)
  dmi.bios.date: 08/26/2010
  dmi.bios.vendor: Hewlett-Packard
  dmi.bios.version: 68AZZ Ver. F.0A
  dmi.board.name: 1411
  dmi.board.vendor: Hewlett-Packard
  dmi.board.version: KBC Version 57.30
  dmi.chassis.type: 10
  dmi.chassis.vendor: Hewlett-Packard
  dmi.modalias: dmi:bvnHewlett-Packard:bvr68AZZVer.F.0A:bd08/26/2010:svnHew=
lett-Packard:pnHPProBook4520s:pvr:rvnHewlett-Packard:rn1411:rvrKBCVersion57=
.30:cvnHewlett-Packard:ct10:cvr:
  dmi.product.name: HP ProBook 4520s
  dmi.sys.vendor: Hewlett-Packard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1180777/+subscriptions
