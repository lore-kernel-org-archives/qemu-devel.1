Received: from eggs.gnu.org ([2001:4830:134:3::10]:34724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNy4s-0001xg-L0
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNy4o-0004NA-KR
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:34:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:53614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cNy4o-0004KJ-Dm
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:34:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cNy4l-00053O-NW
	for <qemu-devel@nongnu.org>; Mon, 02 Jan 2017 08:34:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 993E72E80C3
	for <qemu-devel@nongnu.org>; Mon,  2 Jan 2017 08:34:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jan 2017 08:22:13 -0000
From: Paolo Bonzini <bonzini@gnu.org>
Reply-To: Bug 1523246 <1523246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151206150708.14182.82430.malonedeb@wampee.canonical.com>
Message-Id: <20170102082215.3340.77828.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1523246] Re: Cannot TRIM with VirtIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
   Importance: Undecided =3D> Wishlist

** Summary changed:

- Cannot TRIM with VirtIO
+ VirtIO does not support TRIM

** Summary changed:

- VirtIO does not support TRIM
+ Virtio-blk does not support TRIM

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1523246

Title:
  Virtio-blk does not support TRIM

Status in QEMU:
  Confirmed

Bug description:
  When model=3Dvirtio is used, TRIM is not supported.

  # mount -o discard /dev/vda4 /mnt
  # mount | tail -1
  /dev/vda4 on /mnt type fuseblk (rw,nosuid,nodev,relatime,user_id=3D0,grou=
p_id=3D0,allow_other,blksize=3D4096)
  # fstrim /mnt/
  fstrim: /mnt/: the discard operation is not supported

  Booting without model=3Dvirtio allows using TRIM (in Windows as well).

  Full QEMU line:

  qemu-system-x86_64 -enable-kvm -cpu host -bios
  /usr/share/ovmf/ovmf_x64.bin -smp 2 -m 7G -vga qxl -usbdevice tablet
  -net nic,model=3Dvirtio -net user -drive discard=3Dunmap,detect-
  zeroes=3Dunmap,cache=3Dnone,file=3Dvms/win10.hd.img.vmdk,format=3Dvmdk,if=
=3Dvirtio

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1523246/+subscriptions
