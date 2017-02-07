Received: from eggs.gnu.org ([2001:4830:134:3::10]:37419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caxPm-0002Jk-A1
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 23:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1caxPj-0000YY-Bo
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 23:30:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:55054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1caxPj-0000YA-5o
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 23:29:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1caxPh-00030U-Uy
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 04:29:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4B7112E818A
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 04:29:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 04:17:38 -0000
From: Launchpad Bug Tracker <613529@bugs.launchpad.net>
Reply-To: Bug 613529 <613529@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100804164344.4635.76028.malonedeb@wampee.canonical.com>
Message-Id: <20170207041738.8669.21119.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 613529] Re: qemu does not accept regular disk
 geometry
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
https://bugs.launchpad.net/bugs/613529

Title:
  qemu does not accept regular disk geometry

Status in QEMU:
  Expired

Bug description:
  Hi,

  I am currently hunting a strange bug in qemu/kvm:

  I am using an lvm logical volume as a virtual hard disk for a virtual
  machine.

  I use fdisk or parted to create a partition table and partitions,
  kpartx to generate the device entries for the partitions, then install
  linux on ext3/ext4 with grub or msdos filesystem with syslinux.

  But then, in most cases even the boot process fails or behaves
  strangely, sometimes even mounting the file system in the virtual
  machine fails. It seems as if there is a problem with the virtual disk
  geometry. The problem does not seem to occur if I reboot the host
  system after creating the partition table on the logical volume. I
  guess the linux kernel needs to learn the disk geometry by reboot. A
  blkdev --rereadpt does not work on lvm volumes.

  The first approach to test/fix the problem would be to pass the disk
  geometry to qemu/lvm with the -drive option. Unfortunately, qemu/kvm
  does not accept the default geometry with 255 heads and 63 sectors.
  Seems to limit the number of heads to 16, thus limiting the disk size.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/613529/+subscriptions
