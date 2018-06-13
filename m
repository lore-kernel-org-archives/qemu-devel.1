Received: from eggs.gnu.org ([2001:4830:134:3::10]:44468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQZ-0005ov-Nh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fSxQY-0003c7-OY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:55920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fSxQY-0003aj-Et
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:30:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fSxQX-0001rb-JE
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8C0272E8031
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 04:30:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Jun 2018 04:17:33 -0000
From: Launchpad Bug Tracker <1190525@bugs.launchpad.net>
Reply-To: Bug 1190525 <1190525@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130613093337.13816.43323.malonedeb@soybean.canonical.com>
Message-Id: <152886345349.16396.2758216153968049369.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1190525] Re: fdisk still shows the "/dev/sdb"
 partitions even after the removal of scsi disk
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
https://bugs.launchpad.net/bugs/1190525

Title:
  fdisk still shows the "/dev/sdb" partitions even after the removal of
  scsi disk

Status in QEMU:
  Expired

Bug description:
  RHEL guest shows the partittions even after the removal of scsi disk:
  fdisk still shows the "/dev/sdb" partitions even after the removal of scs=
i disk.

  Guest details:
  -------------------
  Kernel : 2.6.32-358

  =

  Host Details :

  Upstream Kernel, Qemu, Libvirt and virt-manager
  ---------------------------------------------------------------------

  kernel version : 3.9.0+
  qemu version : QEMU emulator version 1.5.0
  libvirt version : 1.0.5
  virt-install : 0.600.3

  =

  Steps to reproduce the issue:

  I. Add the SCSI disk through the virt-manager.
  2. Create the partition using fdisk  (eg: /dev/sbb) =

  3. Create a filesystem and format using mkfs.ext3 or mkfs.ext4 =

  4. Remove the scsi disk  through the virt-manager. =

  5. Again run the fdisk /dev/sdb, the guests still shows the partition eve=
n after the removal of the disk.

  This issue is not seen with virt-io disk.

  This issue is also reproducible without even creating the partitions.

  Expected Result:

  The output of fdisk /dev/sd*  should not show the enties after the
  removal of scsi disks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1190525/+subscriptions
