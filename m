Received: from eggs.gnu.org ([2001:4830:134:3::10]:46489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esHVl-0006B9-Va
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 19:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esHVi-0007GO-RB
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 19:28:21 -0500
Received: from indium.canonical.com ([91.189.90.7]:56350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1esHVi-0007G2-KQ
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 19:28:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1esH5C-0001i4-FY
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 00:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F3D82E8054
	for <qemu-devel@nongnu.org>; Sun,  4 Mar 2018 00:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Mar 2018 23:55:16 -0000
From: schmittlauch <t.schmittlauch+ubuntu@orlives.de>
Reply-To: Bug 1753186 <1753186@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152012131660.6957.17826936817192816521.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1753186] [NEW] qemu-nbd: always first snapshot
 loaded from VDI images with snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When mounting a virtual box disk image of a VM with snapshots, always
the state of the first snapshot is shown.

How to reproduce:
1. Create a new VirtualBox VM or use an existing one, while choosing VDI as=
 the disk image format.
2. Create a snapshot of the VM.
3. Modify the file system from within the VM enough that differences to the=
 snapshotted version are apparent.
4. Create another snapshot.
5. Shut down the VM.
6. Mount the partition from the disk image with `qemu-nbd -c /dev/nbd0 /pat=
h/to/disk.vdi; mount /dev/nbd0pX /mnt`

Expected result: The mounted disk image shall represent the latest state of=
 the VM
Actual result: The mounted disk image represents the VM state at the first =
snapshot

version information: qemu-nbd-2.11.1(openSUSE Tumbleweed)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753186

Title:
  qemu-nbd: always first snapshot loaded from VDI images with snapshots

Status in QEMU:
  New

Bug description:
  When mounting a virtual box disk image of a VM with snapshots, always
  the state of the first snapshot is shown.

  How to reproduce:
  1. Create a new VirtualBox VM or use an existing one, while choosing VDI =
as the disk image format.
  2. Create a snapshot of the VM.
  3. Modify the file system from within the VM enough that differences to t=
he snapshotted version are apparent.
  4. Create another snapshot.
  5. Shut down the VM.
  6. Mount the partition from the disk image with `qemu-nbd -c /dev/nbd0 /p=
ath/to/disk.vdi; mount /dev/nbd0pX /mnt`

  Expected result: The mounted disk image shall represent the latest state =
of the VM
  Actual result: The mounted disk image represents the VM state at the firs=
t snapshot

  version information: qemu-nbd-2.11.1(openSUSE Tumbleweed)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1753186/+subscriptions
