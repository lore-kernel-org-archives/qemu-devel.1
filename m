Received: from eggs.gnu.org ([2001:4830:134:3::10]:45242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsF-0004qB-Am
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eTgsD-0000I3-J5
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:38708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eTgsD-0000HV-CG
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 23:29:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eTgsB-0001ER-A5
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 72EE42E80DC
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 04:29:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Dec 2017 04:17:33 -0000
From: Launchpad Bug Tracker <1062589@bugs.launchpad.net>
Reply-To: Bug 1062589 <1062589@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121005223015.15346.74592.malonedeb@chaenomeles.canonical.com>
Message-Id: <151426185403.1219.8900151121974474458.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1062589] Re: Xp guest disk is corrupted when the
 data size exceeds 4 GB
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
https://bugs.launchpad.net/bugs/1062589

Title:
  Xp guest disk is corrupted when the data size exceeds 4 GB

Status in QEMU:
  Expired

Bug description:
  Host :
  - 2.6.30.10 i686 pentium3 i386 GNU/Linux

  Guest :
  - XPsp3

  QEMU :
  - QEMU emulator version 1.2.0 and 1.2.50
  - sudo /sources/qemu/i386-softmmu/qemu-system-i386 \
          -runas user -enable-kvm -rtc base=3Dlocaltime -no-shutdown \
          -m 384 -usb -usbdevice tablet -vga std \
          -net nic,model=3Dne2k_pci -net tap,script=3Dno,downscript=3Dno \
          -drive file=3D/qemu/XP.img,index=3D0,media=3Ddisk,cache=3Dwriteba=
ck \
          -hdb /qemu/data.img \
          -drive index=3D2,media=3Dcdrom,file=3D/jukebox/iso/xpProSP2.iso

  - image: /qemu/XP.img (before problem)
  file format: qcow2
  virtual size: 10G (10737418240 bytes)
  disk size: 3.9G
  cluster_size: 65536

  - chkdsk on Guest (before problem)
  10474348 KB total disk space.
  3519880 KB in 16982 files.
  4440 KB in 898 indexes.
  0 KB in bad sectors.
  75980 KB in use by the system.
  54432 KB occupied by the log file.
  6874048 KB available on disk.

  4096 bytes in each allocation unit.
  2618587 total allocation units on disk.
  1718512 allocation units available on disk. =


  - qemu-img check
  Warning: cluster offset=3D0x42330b55100000 is after the end of the image =
file, can't properly check refcounts.
  Warning: cluster offset=3D0x42330b55120000 is after the end of the image =
file, can't properly check refcounts.
  ERROR l2_offset=3D42330b55110000: Table is not cluster aligned; L1 entry =
corrupted
  Warning: cluster offset=3D0xa4d26d66440000 is after the end of the image =
file, can't properly check refcounts.
  Warning: cluster offset=3D0xa4d26d66460000 is after the end of the image =
file, can't properly check refcounts.
  ERROR l2_offset=3Da4d26d66453300: Table is not cluster aligned; L1 entry =
corrupted
  ERROR: invalid cluster offset=3D0xad1f0047300000
  ERROR: invalid cluster offset=3D0xad1f0047320000
  ERROR l2_offset=3Dad1f0047309700: Table is not cluster aligned; L1 entry =
corrupted
  ERROR OFLAG_COPIED: l2_offset=3Dc452330b15090000 refcount=3D0
  Warning: cluster offset=3D0x52330b15080000 is after the end of the image =
file, can't properly check refcounts.
  Warning: cluster offset=3D0x52330b150a0000 is after the end of the image =
file, can't properly check refcounts.
  ERROR l2_offset=3D52330b15090000: Table is not cluster aligned; L1 entry =
corrupted
  ERROR OFLAG_COPIED: l2_offset=3Dcc5234077956330b refcount=3D0
  Warning: cluster offset=3D0x52340779560000 is after the end of the image =
file, can't properly check refcounts.
  Warning: cluster offset=3D0x52340779580000 is after the end of the image =
file, can't properly check refcounts.
  ERROR l2_offset=3D52340779563300: Table is not cluster aligned; L1 entry =
corrupted
  ERROR refcount block 0 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 1 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 2 is outside image
  ERROR refcount block 3 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 4 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 5 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 6 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 7 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 8 is not cluster aligned; refcount table entry corru=
pted
  ERROR refcount block 9 is not cluster aligned; refcount table entry corru=
pted
  .
  .
  .
  .
  .
  ERROR refcount block 16381 is not cluster aligned; refcount table entry c=
orrupted
  ERROR refcount block 16382 is outside image
  ERROR refcount block 16383 is not cluster aligned; refcount table entry c=
orrupted
  ERROR cluster 0 refcount=3D0 reference=3D1
  ERROR cluster 1 refcount=3D0 reference=3D1
  ERROR cluster 3 refcount=3D0 reference=3D1

  16396 errors were found on the image.
  Data may be corrupted, or further writes to the image may corrupt it.

  8 internal errors have occurred during the check.

  =

  Hi,

  Everything is running pretty good until data size on disk C exceeds 4
  GB. I Tried many options before figuring out that the problem occurs
  when data size exceeds 4 GB. I tried with QEMU 1.2.50, same problem.

  Best Regards.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1062589/+subscriptions
