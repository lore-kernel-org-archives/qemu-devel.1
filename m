Received: from eggs.gnu.org ([209.51.188.92]:60920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giA0u-0003zW-4g
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 22:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gi9uf-0005nk-7a
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 22:24:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gi9uf-0005nL-29
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 22:24:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gi9ud-0002n7-Fn
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 03:24:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6D1FF2E80CD
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 03:24:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Jan 2019 03:12:54 -0000
From: James Harvey <jamespharvey20@gmail.com>
Reply-To: Bug 1523246 <1523246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151206150708.14182.82430.malonedeb@wampee.canonical.com>
Message-Id: <154726277476.20153.7045391250665026143.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1523246] Re: Virtio-blk does not support TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I believe this feature was just merged by Linus about a week ago, and is
in linux 5.0-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dd548e65904ae43b0637d200a2441fc94e0589c30

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
