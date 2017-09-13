Received: from eggs.gnu.org ([2001:4830:134:3::10]:49744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1vD-0005bn-3d
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1v7-0002oz-1D
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:36334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds1v6-0002o4-Qq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:17:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds1v5-0008S5-IC
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:17:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 88B882E8047
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:17:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 06:57:53 -0000
From: Thomas Huth <453617@bugs.launchpad.net>
Reply-To: Bug 453617 <453617@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20091017002811.3816.18618.malonedeb@gangotri.canonical.com>
Message-Id: <150528587329.29505.17064144548460780449.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 453617] Re: kvm hangs at 100% cpu when connecting
 to forwarded ports (when listed incorrectly on the command line)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There hasn't been any comment about upstream QEMU within the last
months, so I assume this has been fixed there, too. Closing...

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/453617

Title:
  kvm hangs at 100% cpu when connecting to forwarded ports (when listed
  incorrectly on the command line)

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in qemu-kvm source package in Lucid:
  Fix Released

Bug description:
  Binary package hint: qemu-kvm

  If kvm is started using two separate "-net user,hostfwd=3D<forwarding
  rule>" arguments to forward ports from the host to the client, it
  won't complain, but will return a connection refused error and hang at
  100% cpu when trying to connect to either forwarded port.

  However, if kvm is started with the hostfwd rules combined together
  into a single "-net user" argument, it works fine.

  As an example, this command line doesn't generate any warnings or
  errors, but causes kvm to hang for me:

  kvm -net nic -net user,hostfwd=3Dtcp:127.0.0.1:8888-:80 -net
  user,hostfwd=3Dtcp:127.0.0.1:2222-:22 -m 128 -smp 1 -drive
  file=3Ddisk0.qcow2

  ... but this command line works fine:

  kvm -net nic -net
  user,hostfwd=3Dtcp:127.0.0.1:8888-:80,hostfwd=3Dtcp:127.0.0.1:2222-:22 -m
  128 -smp 1 -drive file=3Ddisk0.qcow2

  ProblemType: Bug
  Architecture: amd64
  Date: Fri Oct 16 17:19:59 2009
  DistroRelease: Ubuntu 9.10
  KvmCmdLine: Error: command ['ps', '-C', 'kvm', '-F'] failed with exit cod=
e 1: UID        PID  PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
  MachineType: Sony Corporation VGN-SZ650N
  NonfreeKernelModules: nvidia
  Package: kvm (not installed)
  PccardctlIdent:
   Socket 0:
     no product info available
  PccardctlStatus:
   Socket 0:
     no card
  ProcCmdLine: root=3DUUID=3D3ee4953e-48f0-497c-ae78-18cbb18cfef8 ro quiet =
splash
  ProcEnviron:
   LANGUAGE=3Den_US.UTF-8
   PATH=3D(custom, user)
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  ProcVersionSignature: Ubuntu 2.6.31-14.47-generic
  SourcePackage: qemu-kvm
  Uname: Linux 2.6.31-14-generic x86_64
  dmi.bios.date: 07/12/2007
  dmi.bios.vendor: Phoenix Technologies LTD
  dmi.bios.version: R0081S5
  dmi.board.asset.tag: N/A
  dmi.board.name: VAIO
  dmi.board.vendor: Sony Corporation
  dmi.board.version: N/A
  dmi.chassis.type: 10
  dmi.chassis.vendor: Sony Corporation
  dmi.chassis.version: N/A
  dmi.modalias: dmi:bvnPhoenixTechnologiesLTD:bvrR0081S5:bd07/12/2007:svnSo=
nyCorporation:pnVGN-SZ650N:pvrJ002VXGP:rvnSonyCorporation:rnVAIO:rvrN/A:cvn=
SonyCorporation:ct10:cvrN/A:
  dmi.product.name: VGN-SZ650N
  dmi.product.version: J002VXGP
  dmi.sys.vendor: Sony Corporation

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/453617/+subscriptions
