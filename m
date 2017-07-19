Received: from eggs.gnu.org ([2001:4830:134:3::10]:37188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi7-0005Bk-Vf
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXgi6-0001oA-NV
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:37859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXgi6-0001nf-9n
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:35:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXgi5-0003pu-AB
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4AFFF2E8078
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 04:35:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 04:17:51 -0000
From: Launchpad Bug Tracker <796202@bugs.launchpad.net>
Reply-To: Bug 796202 <796202@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110612130357.689.11468.malonedeb@chaenomeles.canonical.com>
Message-Id: <150043787189.28289.7496555224005568624.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 796202] Re: Doing a 64 bit load from a 32 bit
 local APIC register is allowed
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
https://bugs.launchpad.net/bugs/796202

Title:
  Doing a 64 bit load from a 32 bit local APIC register is allowed

Status in QEMU:
  Expired

Bug description:
  Doing

  u64 lapic_idregister =3D (u64) fix_to_virt(FIX_APIC_BASE) + 0x20;

  and later in an interrupt handler

  movq (lapic_idregister), %rcx
  movq (%rcx), %rcx

  in a linux kernel module works in qemu 0.13.91 but not on real hardware (=
it simply reboots).
  On real hardware only

  movl (%rcx), %ecx

  works (also in qemu).

  Commandline:
  qemu-system-x86_64 \
  		-kernel $LINUXDIR/arch/x86_64/boot/bzImage \
  		-hda $BUILDROOTDIR/output/images/rootfs.ext2 \
  		-append "root=3D/dev/sda rw rootfstype=3Dext2 maxcpus=3D4" \
  		-cpu phenom \
  		-smp 4 \
  		-gdb tcp::1234 \
  		-net nic -net user

  Guest:
  Vanilla Linux Kernel 2.6.37.6 64-bit with buildroot

  Mikael Pettersson from the linux kernel mailinglist told me it's an
  accepts-invalid bug in qemu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/796202/+subscriptions
