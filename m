Received: from eggs.gnu.org ([2001:4830:134:3::10]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fu9Hk-0002nl-9w
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fu9EK-0008Q3-6M
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:34:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:55294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fu9EK-0008Ph-0B
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 00:34:20 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fu9EH-0002Lu-Mo
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 04:34:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 070002E817B
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 04:34:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Aug 2018 04:17:57 -0000
From: Launchpad Bug Tracker <474968@bugs.launchpad.net>
Reply-To: Bug 474968 <474968@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20091105012553.4800.9352.malonedeb@gangotri.canonical.com>
Message-Id: <153534347818.22848.4139412864973475949.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 474968] Re: kvm smb server hogs cpu guest freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for qemu-kvm (Ubuntu) because there has been no activity for 60
days.]

** Changed in: qemu-kvm (Ubuntu)
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/474968

Title:
  kvm smb server hogs cpu guest freeze

Status in QEMU:
  Won't Fix
Status in qemu-kvm package in Ubuntu:
  Expired

Bug description:
  Binary package hint: qemu-kvm

  kvm hogs the CPU reproducibly. I installed an Ubuntu using KVM. I run
  the machine with -net nic,model=3Drtl8139,macaddr=3Df0:00:BA:12:34:56 -net
  user,hostfwd=3Dtcp::2223-:22,smb=3D/tmp/share, sshed into the machine and
  typed "telnet 10.0.2.4 139" to try whether the SMB server works. KVM
  then hogs the CPU.

  ProblemType: Bug
  Architecture: amd64
  Date: Thu Nov  5 01:23:09 2009
  DistroRelease: Ubuntu 9.10
  KvmCmdLine: Error: command ['ps', '-C', 'kvm', '-F'] failed with exit cod=
e 1: UID        PID  PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
  MachineType: LENOVO 766636G
  Package: kvm 1:84+dfsg-0ubuntu16+0.11.0+0ubuntu6.3
  PccardctlIdent:
   Socket 0:
     no product info available
  PccardctlStatus:
   Socket 0:
     no card
  ProcCmdLine: root=3D/dev/mapper/cryptroot source=3DUUID=3D9c3d5596-27c6-4=
fd5-bfcd-fa8eef6f1230 ro quiet splash  crashkernel=3D384M-2G:64M,2G-:128M
  SourcePackage: qemu-kvm
  Uname: Linux 2.6.32-999-generic x86_64
  dmi.bios.date: 07/01/2008
  dmi.bios.vendor: LENOVO
  dmi.bios.version: 7NETB6WW (2.16 )
  dmi.board.name: 766636G
  dmi.board.vendor: LENOVO
  dmi.board.version: Not Available
  dmi.chassis.asset.tag: No Asset Information
  dmi.chassis.type: 10
  dmi.chassis.vendor: LENOVO
  dmi.chassis.version: Not Available
  dmi.modalias: dmi:bvnLENOVO:bvr7NETB6WW(2.16):bd07/01/2008:svnLENOVO:pn76=
6636G:pvrThinkPadX61s:rvnLENOVO:rn766636G:rvrNotAvailable:cvnLENOVO:ct10:cv=
rNotAvailable:
  dmi.product.name: 766636G
  dmi.product.version: ThinkPad X61s
  dmi.sys.vendor: LENOVO

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/474968/+subscriptions
