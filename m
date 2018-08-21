Received: from eggs.gnu.org ([2001:4830:134:3::10]:54979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Le-0001Zw-FW
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0Lb-0000js-AR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:41:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:38828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0Lb-0000jO-3o
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:40:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0LZ-00031w-Th
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:40:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D7FEF2E8524
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:40:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:26:18 -0000
From: Thomas Huth <1780928@bugs.launchpad.net>
Reply-To: Bug 1780928 <1780928@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153121318079.13203.2840846134376544024.malonedeb@gac.canonical.com>
Message-Id: <153483277913.31294.11082510107205452127.launchpad@soybean.canonical.com>
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1780928

Title:
  v2.12.0-2321-gb34181056c: vcpu hotplug crashes qemu-kvm with segfault

Status in QEMU:
  Fix Released

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
