Received: from eggs.gnu.org ([2001:4830:134:3::10]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJJsZ-0003kh-6L
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eJJsU-0000f5-V0
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:55:23 -0500
Received: from indium.canonical.com ([91.189.90.7]:33956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eJJsU-0000eV-Ml
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:55:18 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eJJsT-0000oB-Ot
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:55:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B98372E804B
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:55:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Nov 2017 13:43:05 -0000
From: Thomas Huth <1401798@bugs.launchpad.net>
Reply-To: Bug 1401798 <1401798@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141212081522.22342.50676.malonedeb@gac.canonical.com>
Message-Id: <151179018564.18387.11440738002105602598.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1401798] Re: Qemu 2.2.0 savevm crash.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1401798

Title:
  Qemu 2.2.0 savevm crash.

Status in QEMU:
  Incomplete

Bug description:
  qemu 2.1.2 is good.

  (gdb) bt
  #0  0x00007ffff4aae445 in raise () from /lib/x86_64-linux-gnu/libc.so.6
  #1  0x00007ffff4ab1bab in abort () from /lib/x86_64-linux-gnu/libc.so.6
  #2  0x0000555555997951 in qcow2_cache_find_entry_to_replace (c=3D0x555556=
389780) at block/qcow2-cache.c:262
  #3  0x0000555555997a1a in qcow2_cache_do_get (bs=3D0x5555563836f0, c=3D0x=
555556389780, offset=3D1094713344, table=3D0x7fffffffc528, =

      read_from_disk=3Dtrue) at block/qcow2-cache.c:285
  #4  0x0000555555997c45 in qcow2_cache_get (bs=3D0x5555563836f0, c=3D0x555=
556389780, offset=3D1094713344, table=3D0x7fffffffc528)
      at block/qcow2-cache.c:331
  #5  0x0000555555991ca9 in l2_allocate (bs=3D0x5555563836f0, l1_index=3D1,=
 table=3D0x7fffffffc5a0) at block/qcow2-cluster.c:247
  #6  0x000055555599290c in get_cluster_table (bs=3D0x5555563836f0, offset=
=3D549755813888, new_l2_table=3D0x7fffffffc610, =

      new_l2_index=3D0x7fffffffc62c) at block/qcow2-cluster.c:620
  #7  0x0000555555994213 in discard_single_l2 (bs=3D0x5555563836f0, offset=
=3D549755813888, nb_clusters=3D156, type=3DQCOW2_DISCARD_NEVER, =

      full_discard=3Dfalse) at block/qcow2-cluster.c:1425
  #8  0x0000555555994491 in qcow2_discard_clusters (bs=3D0x5555563836f0, of=
fset=3D549755813888, nb_sectors=3D638976, type=3DQCOW2_DISCARD_NEVER, =

      full_discard=3Dfalse) at block/qcow2-cluster.c:1516
  #9  0x00005555559965c8 in qcow2_snapshot_create (bs=3D0x5555563836f0, sn_=
info=3D0x7fffffffc830) at block/qcow2-snapshot.c:441
  #10 0x00005555559ad1ad in bdrv_snapshot_create (bs=3D0x5555563836f0, sn_i=
nfo=3D0x7fffffffc830) at block/snapshot.c:167
  #11 0x000055555565e90f in do_savevm (mon=3D0x555556992d20, qdict=3D0x5555=
599d5c00) at /vms/qemu/qemu-2.2.0/savevm.c:1126

  (gdb) show args
  Argument list to give program being debugged when it is started is "-name=
 u1404-01 -S -machine pc,accel=3Dkvm,usb=3Doff -m 1024 -smp 2,sockets=3D2,c=
ores=3D1,threads=3D1 -no-user-config -nodefaults -monitor stdio -rtc base=
=3Dutc -no-shutdown -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.=
0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -d=
rive file=3D/vms/images/u1404-01.img,if=3Dnone,id=3Ddrive-virtio-disk0,form=
at=3Dqcow2,cache=3Ddirectsync -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0=
,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0 -drive if=3Dnone,i=
d=3Ddrive-ide0-1-0,readonly=3Don,format=3Draw -device ide-cd,bus=3Dide.1,un=
it=3D0,drive=3Ddrive-ide0-1-0,id=3Dide0-1-0 -chardev pty,id=3Dcharserial0 -=
device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -device usb-tablet,id=
=3Dinput0 -vnc 0.0.0.0:0 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D=
0x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1401798/+subscriptions
