Received: from eggs.gnu.org ([2001:4830:134:3::10]:50464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJG7H-0003fA-9n
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJG7D-0007rQ-GB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:26:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:46592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fJG7D-0007qV-99
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:26:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fJG7C-00054d-Cq
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:26:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5C9F72E8F39
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:26:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 May 2018 10:13:41 -0000
From: Thomas Huth <1459622@bugs.launchpad.net>
Reply-To: Bug 1459622 <1459622@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150528110403.25663.72948.malonedeb@soybean.canonical.com>
Message-Id: <152655202116.8948.13999989099027069929.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1459622] Re: firefox hang with virtfs
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
with the latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1459622

Title:
  firefox hang with virtfs

Status in QEMU:
  Incomplete

Bug description:
  Firefox hangs once it starts to load pages. I tried to delete
  .cache/mozilla/ and .mozilla/ but it doesn't help. But if I mount
  tmpfs on to .mozilla (not necessary for .cache/mozilla/), pages loads
  fine.

  I started the vm as root (sudo) with the following command: qemu-
  system-x86_64 -enable-kvm -m 4G -virtfs
  local,mount_tag=3Dqemu,security_model=3Dpassthrough,path=3D/mnt/qemu/
  -kernel /mnt/qemu/boot/vmlinuz-linux -initrd /mnt/qemu/boot/initramfs-
  linux-fallback.img -append 'rw root=3Dqemu fstype=3D9p' -usbdevice tablet
  -vga qxl -spice port=3D12345,disable-ticketing

  /mnt/qemu is a btrfs snapshot of the subvolume used as the host root

  Arch Linux, qemu 2.3.0, firefox 38.0.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1459622/+subscriptions
