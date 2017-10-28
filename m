Received: from eggs.gnu.org ([2001:4830:134:3::10]:37192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RUf-00055c-B9
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RUe-0007E5-40
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:49:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:55130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RUd-0007Cp-TO
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:49:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RUb-000692-Mq
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:49:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 53E922E80D0
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:49:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:39:38 -0000
From: Thomas Huth <1288259@bugs.launchpad.net>
Reply-To: Bug 1288259 <1288259@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140305135708.26975.81256.malonedeb@chaenomeles.canonical.com>
Message-Id: <150919798035.4382.15609732335722332895.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1288259] Re: KVM vms are paused and cannot be
 deleted due to hardware error 0x0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1288259

Title:
  KVM vms are paused and cannot be deleted due to hardware error 0x0

Status in qemu package in Ubuntu:
  New

Bug description:
  Upon creation of instances via OpenStack nova api instances got stuck
  in spawning state. Then, after trying to delete instances they got
  stuck in deleting state. After investigation the following error was
  found:

  KVM: entry failed, hardware error 0x0
  EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00000623
  ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D00000000
  EIP=3D0000fff0 EFL=3D00000002 [-------] CPL=3D3 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0000 00000000 0000ffff 00009300
  CS =3Df000 000f0000 0000ffff 0000f300
  SS =3D0000 00000000 0000ffff 0000f300
  DS =3D0000 00000000 0000ffff 00009300
  FS =3D0000 00000000 0000ffff 00009300
  GS =3D0000 00000000 0000ffff 00009300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0000 00000000 0000ffff 00008b00
  GDT=3D     00000000 0000ffff
  IDT=3D     00000000 0000ffff
  CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D28 95 66 ba 01 4a 03 00 66 89 d8 66 5b 66 5e e9 15 79 66 c3 <ea> 5=
b e0 00 f0 30 36 2f 32 33 2f 39 39 00 fc 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00

  All instances were in paused state:
  root@node-7:~# virsh list
  setlocale: No such file or directory
   Id    Name                           State
  ----------------------------------------------------
   4     instance-00000004              paused
   5     instance-00000005              paused
   6     instance-00000006              paused
   7     instance-00000007              paused
   8     instance-00000008              paused
   9     instance-00000009              paused

  The only way to delete VM is to reset it and then resume it. After this, =
VM is deleted properly. =

  OpenStack version: Havana on Ubuntu 12.04
  KVM version: QEMU emulator version 1.2.0 (qemu-kvm-1.2.0+noroms-0ubuntu7.=
12.10, Debian), Copyright (c) 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1288259/+subscriptions
