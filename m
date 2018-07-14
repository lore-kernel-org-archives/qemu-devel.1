Received: from eggs.gnu.org ([2001:4830:134:3::10]:52235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1feCDJ-0007xf-1z
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 00:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1feCDF-0001m6-1a
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 00:31:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:54910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1feCDE-0001bo-QW
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 00:31:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1feCD9-0005dt-LX
	for <qemu-devel@nongnu.org>; Sat, 14 Jul 2018 04:31:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C5B252E81A0
	for <qemu-devel@nongnu.org>; Sat, 14 Jul 2018 04:31:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Jul 2018 04:17:54 -0000
From: Launchpad Bug Tracker <1575607@bugs.launchpad.net>
Reply-To: Bug 1575607 <1575607@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160427111619.24836.70047.malonedeb@wampee.canonical.com>
Message-Id: <153154187504.6644.2164973363441634380.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1575607] Re:  vm startup failed,
 qemu returned "kvm run failed Bad address"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1575607

Title:
   vm startup failed, qemu returned "kvm run failed Bad address"

Status in QEMU:
  Expired

Bug description:
    create a virtual machine and start by libvirt. vm startup failed, qemu =
returned "kvm run failed Bad address"
    the error log is :

  error: kvm run failed Bad address

  EAX=3D7ffc0000 EBX=3D7ffbffd0 ECX=3Dfffffff0 EDX=3D0000002c

  ESI=3D00006f5c EDI=3D7ffbffd0 EBP=3D7ffc0000 ESP=3D00006f34

  EIP=3D000dec7b EFL=3D00010046 [---Z-P-] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0

  ES =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]

  CS =3D0008 00000000 ffffffff 00c09b00 DPL=3D0 CS32 [-RA]

  SS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]

  DS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]

  FS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]

  GS =3D0010 00000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]

  LDT=3D0000 00000000 0000ffff 00008200 DPL=3D0 LDT

  TR =3D0000 00000000 0000ffff 00008b00 DPL=3D0 TSS32-busy

  GDT=3D     000f6a80 00000037

  IDT=3D     000f6abe 00000000

  CR0=3D60000011 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000

  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
  DR3=3D0000000000000000

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400

  EFER=3D0000000000000000

  Code=3Dc3 29 d3 21 cb 39 c3 77 27 3b 5e 0c 72 22 85 ff 75 02 89 df <89>
  5f 08 01 da 89 57 0c 89 47 10 89 5e 10 8b 56 04 89 f8 e8 8c fc ff ff
  89 d8 eb 06 8b 36

    we add numa in the vm, the numatune info is:
    <numatune>

      <memory mode=3D'strict' placement=3D'auto'/>

    </numatune>

   the version of qemu is 2.5.0.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1575607/+subscriptions
