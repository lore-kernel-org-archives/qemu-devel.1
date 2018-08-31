Received: from eggs.gnu.org ([2001:4830:134:3::10]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvbfV-0005UH-Bz
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 01:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvbSE-0008C1-Tn
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 00:54:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:54686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvbSE-0008BE-NF
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 00:54:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvbSD-0004Ew-BV
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 04:54:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4E5862E80DC
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 04:54:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Aug 2018 04:43:23 -0000
From: Thomas Huth <1448985@bugs.launchpad.net>
Reply-To: Bug 1448985 <1448985@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150427111811.22499.8079.malonedeb@soybean.canonical.com>
Message-Id: <153569060393.20411.5173011735910909305.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1448985] Re: llvmpipe i386 crashes when running
 on qemu64 cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest upstream version of QEMU? Or could we close this ticket
nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

** Changed in: llvm-toolchain-3.6 (Ubuntu)
       Status: New =3D> Incomplete

** Changed in: qemu (Ubuntu)
       Status: Confirmed =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1448985

Title:
  llvmpipe i386 crashes when running on qemu64 cpu

Status in QEMU:
  Incomplete
Status in llvm-toolchain-3.6 package in Ubuntu:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  STEPS TO REPRODUCE:
  =C2=A0=C2=A0=C2=A01. Install Ubuntu 14.04.2 LTS or Ubuntu 14.10 or Ubuntu=
 15.04 with all updates (it is a host system).
  =C2=A0=C2=A0=C2=A02. Download one (or all) isos:
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Ubuntu 14.0.4.2 i386 iso (ubuntu-14=
.04.2-desktop-i386.iso, MD5SUM =3D a8a14f1f92c1ef35dae4966a2ae1a264).
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Ubuntu 14.10 i386 iso (ubuntu-14.10=
-desktop-i386.iso, MD5SUM =3D 4a3c4b8421af51c29c84fb6f4b3fe109)
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Ubuntu 15.04 i386 iso (ubuntu-15.04=
-desktop-i386.iso, MD5SUM =3D 6ea04093b767ad6778aa245d53625612)
  =C2=A0=C2=A0=C2=A03. Boot one (or all) isos with as QEMU-KVM guest with t=
he following commands:
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* sudo kvm -m 1536 -cdrom ubuntu-*-de=
sktop-i386.iso
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* sudo kvm -m 1536 -cdrom ubuntu-*-de=
sktop-i386.iso -vga std
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* sudo kvm -m 1536 -cdrom ubuntu-*-de=
sktop-i386.iso -vga vmware
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*  or from usb-creator-gtk via "Test =
disk" button
  =C2=A0=C2=A0=C2=A04. Click on "Try Ubuntu"

  EXPECTED RESULTS:
  =C2=A0=C2=A0=C2=A0=C2=A0ISO is booted to Unity desktop, user can test and=
 use it.

  ACTUAL RESULTS:
  =C2=A0=C2=A0=C2=A0In 14.04 and 14.10 guests can see empty purple desktop =
or purple desktop with two shortcuts ("Examples" and "Install Ubuntu ...").
  =C2=A0=C2=A0=C2=A015.10 guest does not boot or boot to safe graphic mode =
(it is bug 1437740).

  The reason for this is that unity requires gfx acceleration which is
  done via llvmpipe on non accelerated gfx chipsets (as VMs use by
  default). The error message is hidden away but is:

  LLVM ERROR: Do not know how to split the result of this operator!

  The cause is that KVM VMs by default use the qemu64 cpu model which
  seems to be inconsistent in some way between claimed features and
  actual results when using those features. A work-around for running
  i386 isos is to use a cpu model like core2duo or kvm64.

  This bug should be confirmed and fixed.
  Users may want to run Ubuntu in QEMU/KVM, not just VirtualBox.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1448985/+subscriptions
