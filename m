Received: from eggs.gnu.org ([2001:4830:134:3::10]:45915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gBY8R-00035f-Ql
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 00:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gBY3g-0003m0-8w
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 00:31:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:48322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gBY3f-0003lg-UF
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 00:31:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gBY3e-0000mX-1I
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 04:31:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 083302E80CC
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 04:31:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Oct 2018 04:17:46 -0000
From: Launchpad Bug Tracker <1488212@bugs.launchpad.net>
Reply-To: Bug 1488212 <1488212@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150824184834.27301.31811.malonedeb@chaenomeles.canonical.com>
Message-Id: <153949066676.21058.18041159642355909799.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1488212] Re: 16bit appcrash on W2K8 32bit and
 Vista 32bit guests
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
https://bugs.launchpad.net/bugs/1488212

Title:
  16bit appcrash on W2K8 32bit and Vista 32bit guests

Status in QEMU:
  Expired

Bug description:
  16 bit appcrash on 32bit windows 2008 and Vista guest. Used git bisect
  and determined the problem has occurred since vgabios update included
  in commit 6eefccc0bb9c34051b1e21880fc3a1c1c8686edd in qemu.git. Using
  a vgabios before this commit works.

  To reproduce boot a Vista or Windows 2008 guest and start a command
  window. In the command window type command.com . Notice ntvdm
  appcrash.

  =

  qemu-system-x86_64 -name eccovm9 -M pc-i440fx-2.1 -cpu SandyBridge -enabl=
e-kvm -m 4096 -smp 4,sockets=3D4,cores=3D1,threads=3D1 -usb -drive file=3D/=
home/libvirt/images/eccovm9.img,if=3Dnone,id=3Ddrive-virtio-disk0,format=3D=
raw,cache=3Ddirectsync -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x4,drive=
=3Ddrive-virtio-disk0,id=3Dvirtio-disk0 -device usb-tablet,id=3Dinput0 -vnc=
 127.0.0.1:0 -vga cirrus

  qemu-system-x86_64 -version
  QEMU emulator version 2.4.50, Copyright (c) 2003-2008 Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1488212/+subscriptions
