Received: from eggs.gnu.org ([2001:4830:134:3::10]:34713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffHch-0002JH-Ss
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 00:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ffHce-0005ar-OB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 00:30:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:41056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ffHce-0005aN-IM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 00:30:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ffHcd-0007xe-As
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 04:29:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 477652E8083
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 04:29:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jul 2018 04:17:24 -0000
From: Launchpad Bug Tracker <1459626@bugs.launchpad.net>
Reply-To: Bug 1459626 <1459626@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150528112402.7427.77374.malonedeb@gac.canonical.com>
Message-Id: <153180104440.8289.7957471272383207836.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1459626] Re: emacs (gtk3) core dumped with -vga
 qxl
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
https://bugs.launchpad.net/bugs/1459626

Title:
  emacs (gtk3) core dumped with -vga qxl

Status in QEMU:
  Expired

Bug description:
  Emacs (gtk3) exited with bus error and core dumped with -vga qxl. If I
  use the builtin modesetting xorg driver, emacs could survive for a
  short while sometimes. If I use xf86-video-qxl (git r587.8babd05), it
  dies right away with the same error. It seems to corrupt xorg at some
  point as well, because sometimes I cannot exit i3 properly and gnome-
  terminal can go crazy afterwards (all letters become empty retangles).

  It doesn't seem to happen with other -vga driver.

  Error message is attached. Can also provide the core dumped but it's
  of 47M.

  I started the vm as root (sudo) with the following command: qemu-
  system-x86_64 -enable-kvm -m 4G -virtfs
  local,mount_tag=3Dqemu,security_model=3Dpassthrough,path=3D/mnt/qemu/
  -kernel /mnt/qemu/boot/vmlinuz-linux -initrd /mnt/qemu/boot/initramfs-
  linux-fallback.img -append 'rw root=3Dqemu fstype=3D9p' -usbdevice tablet
  -vga qxl -spice port=3D12345,disable-ticketing

  /mnt/qemu is a btrfs snapshot of the subvolume used as the host root

  Arch Linux, qemu 2.3.0, emacs 24.5, xorg-server 1.17.1, linux 4.0.4,
  gtk 3.16.3, glib 2.44.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1459626/+subscriptions
