Received: from eggs.gnu.org ([2001:4830:134:3::10]:50821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqBSP-0003H9-U5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqBSL-0001KQ-A9
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:31:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:46502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqBSL-0001I0-4k
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 00:31:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqBSJ-0003jZ-77
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 04:31:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A8D542E81A6
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 04:31:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Mar 2017 04:17:31 -0000
From: Launchpad Bug Tracker <618533@bugs.launchpad.net>
Reply-To: Bug 618533 <618533@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100816065520.4924.74848.malonedeb@gandwana.canonical.com>
Message-Id: <20170321041731.27578.27082.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 618533] Re: OpenSolaris guest fails to see the
 Solaris partitions of a physical disk in qemu-kvm-9999 (GIT)
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
https://bugs.launchpad.net/bugs/618533

Title:
  OpenSolaris guest fails to see the Solaris partitions of a physical
  disk in qemu-kvm-9999 (GIT)

Status in QEMU:
  Expired

Bug description:
  # qemu-kvm --version
  QEMU emulator version 0.13.50 (qemu-kvm-devel), Copyright (c) 2003-2008 F=
abrice Bellard

  The following disk is presented to guest as IDE disk with /dev/sdd as
  path.

  # fdisk -l /dev/sdd

  Disk /dev/sdd: 750.2 GB, 750156374016 bytes
  255 heads, 63 sectors/track, 91201 cylinders, total 1465149168 sectors
  Units =3D sectors of 1 * 512 =3D 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disk identifier: 0x7f3a03aa

     Device Boot      Start         End      Blocks   Id  System
  /dev/sdd1              63     7887914     3943926   1b  Hidden W95 FAT32
  /dev/sdd2         7887915   980736119   486424102+  83  Linux
  /dev/sdd3   *   980736120  1083150494    51207187+  bf  Solaris
  /dev/sdd4      1083150495  1465144064   190996785    5  Extended
  /dev/sdd5      1083150558  1107746009    12297726   83  Linux
  /dev/sdd6      1107746073  1465144064   178698996    7  HPFS/NTFS

  The prtvtoc output is attached from both VirtualBox and Qemu-KVM. As
  can be seen in the screenshots, a valid Solaris partition table (which
  is inside the /dev/sdd3, marked 'bf' in Linux fdisk output) is not
  seen in Qemu but seen in Virtualbox.

  This makes the guest unbootable in Qemu because the root FS is not
  found but its bootable in Virtualbox.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/618533/+subscriptions
