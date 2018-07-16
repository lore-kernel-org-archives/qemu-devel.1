Received: from eggs.gnu.org ([2001:4830:134:3::10]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ff5MX-0008Ka-P5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ff5MS-0004cp-Qz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:24:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:44406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ff5MS-0004cG-Je
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:24:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ff5MR-00076Q-Ck
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:24:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 19B402E80C3
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 15:15:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jul 2018 15:10:04 -0000
From: Greg Kurz <groug@kaod.org>
Reply-To: Bug 1780928 <1780928@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153121318079.13203.2840846134376544024.malonedeb@gac.canonical.com>
Message-Id: <153175380480.11706.14760583453256517809.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1780928] Re: v2.12.0-2321-gb34181056c: vcpu
 hotplug crashes qemu-kvm with segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixed by:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Db585395b655a6c1f9d9eb=
f1f0890e76d0708eed6

** Changed in: qemu
       Status: Confirmed =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1780928

Title:
  v2.12.0-2321-gb34181056c: vcpu hotplug crashes qemu-kvm with segfault

Status in QEMU:
  Fix Committed

Bug description:
  vcpu hotplug crashes upstream qemu(v2.12.0-2321-gb34181056c), vcpu
  hotplug works fine in v2.12.0-rc4.

  Host: Power8, kernel: 4.18.0-rc2-00037-g6f0d349d922b
  Guest: Power8, kernel: 4.18.0-rc3-00183-gc42c12a90545 (base image: fedora=
27 ppc64le)

  /usr/share/avocado-plugins-vt/build/qemu/ppc64-softmmu/qemu-system-ppc64 =
-M pseries,accel=3Dkvm,max-cpu-compat=3Dpower8 -m 8192 -device virtio-scsi-=
pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x2 -drive file=3D/var/lib/avocado/data/a=
vocado-vt/images/jeos-27-ppc64le.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive1=
 -device scsi-hd,drive=3Ddrive1,bus=3Dscsi0.0 -smp 1,cores=3D1,threads=3D1,=
sockets=3D1,maxcpus=3D8 -serial /dev/pts/0 -monitor stdio -vga none -nograp=
hic -kernel /home/kvmci/linux/vmlinux -append 'root=3D/dev/sda2 rw console=
=3Dtty0 console=3DttyS0,115200 init=3D/sbin/init initcall_debug' -nic user,=
model=3Dvirtio-net-pci =

  QEMU 2.12.50 monitor - type 'help' for more information
  (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
  Segmentation fault (core dumped)

  =

  Guest initial cpu:
  # lscpu
  Architecture:        ppc64le
  Byte Order:          Little Endian
  CPU(s):              1
  On-line CPU(s) list: 0
  Thread(s) per core:  1
  Core(s) per socket:  1
  Socket(s):           1
  NUMA node(s):        1
  Model:               2.1 (pvr 004b 0201)
  Model name:          POWER8 (architected), altivec supported
  Hypervisor vendor:   KVM
  Virtualization type: para
  L1d cache:           64K
  L1i cache:           32K
  NUMA node0 CPU(s):   0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1780928/+subscriptions
