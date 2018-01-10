Received: from eggs.gnu.org ([2001:4830:134:3::10]:53355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOpX-0006gv-2e
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOpT-0004CV-0G
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:51674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZOpS-0004AH-Jb
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:26:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZOpO-0002kZ-9B
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:26:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 108462E858D
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:19:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 22:06:47 -0000
From: Thomas Huth <1175089@bugs.launchpad.net>
Reply-To: Bug 1175089 <1175089@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130501082935.389.58262.malonedeb@soybean.canonical.com>
Message-Id: <151562200789.32264.14967227175556538438.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1175089] Re: Crash why dragon fly 3.4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1175089

Title:
  Crash why dragon fly 3.4.1

Status in QEMU:
  Incomplete

Bug description:
  Hello, all is here (kernel 3.8, qemu 1.2.2-r3):
  /usr/bin/qemu-system-x86_64 -k fr -alt-grab -m 2048 -vga vmware -net nic,=
vlan=3D0,model=3Dvirtio -net user -rtc base=3Dlocaltime -smp 4,cores=3D4,so=
ckets=3D1 -boot once=3Dd -cdrom dfly-x86_64-gui-3.4.1_REL.iso =

  KVM internal error. Suberror: 1
  emulation failure
  EAX=3D00000010 EBX=3D00009338 ECX=3D00000000 EDX=3D00000000
  ESI=3D000017fc EDI=3D000017c8 EBP=3D000364a0 ESP=3D000017b8
  EIP=3D00009318 EFL=3D00003002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HL=
T=3D0
  ES =3D0010 00000000 ffffffff 00c09300
  CS =3D0018 00000000 0000ffff 00009b00
  SS =3D0010 00000000 ffffffff 00c09300
  DS =3D0010 00000000 ffffffff 00c09300
  FS =3D0033 0000a000 ffffffff 00c0f300
  GS =3D0033 0000a000 ffffffff 00c0f300
  LDT=3D0000 00000000 0000ffff 00008200
  TR =3D0038 00005f98 00002067 00008b00
  GDT=3D     00009590 0000003f
  IDT=3D     00005e00 00000197
  CR0=3D00000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
  DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=
=3D0000000000000000 =

  DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
  EFER=3D0000000000000000
  Code=3D00 a3 ea 5d 00 00 66 ea 10 93 18 00 0f 20 c0 fe c8 0f 22 c0 <ea> 1=
d 93 00 00 31 c0 8e d8 8e d0 0f 01 1e dc 95 66 07 66 1f 66 0f a1 66 0f a9 6=
6 61 bc ea

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1175089/+subscriptions
