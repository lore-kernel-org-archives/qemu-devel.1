Received: from eggs.gnu.org ([2001:4830:134:3::10]:34828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOmeK-00018b-3c
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fOmeF-00078I-16
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:11:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:60016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fOmeE-000769-Qb
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:11:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fOmeB-0007uw-Qz
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 16:11:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1086A2E88D7
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 16:11:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Jun 2018 16:02:18 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1772075 <1772075@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152666493053.16686.5820944431341933507.malonedeb@wampee.canonical.com>
Message-Id: <152786893842.4093.13132451720444822959.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1772075] Re: Segmentation fault on aarch64 vm at
 powerdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you provide the various image files and so on somewhere so that I
can reproduce, please? (My aarch64 test image shuts down cleanly, so it
may be something specific to the guest you're using.)


** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772075

Title:
  Segmentation fault on aarch64 vm at powerdown

Status in QEMU:
  New

Bug description:
  OS Arch Linux
  x86_64
  qemu version: 2.12

  cmdline:
  qemu-system-aarch64 -nographic -cpu cortex-a57 -m 2048 -M virt,gic_versio=
n=3D3 -machine virtualization=3Dtrue -bios /usr/share/ovmf/AARCH64/QEMU_EFI=
.fd -drive file=3Dfat:rw:/opt/simonpiemu/kernels/rpi-3,if=3Dnone,format=3Dr=
aw,cache=3Dnone,id=3Dhd0 -device virtio-blk-device,drive=3Dhd0 -drive file=
=3D/home/morfeo/.simonpi/sd-arch-rpi-3-qemu.img,if=3Dnone,format=3Draw,cach=
e=3Dnone,id=3Dhd1 -device virtio-blk-device,drive=3Dhd1 -kernel /opt/simonp=
iemu/kernels/rpi-3/Image -append "root=3D/dev/vda2 fstab=3Dno rootfstype=3D=
ext4 rw console=3DttyAMA0" -initrd /home/morfeo/.simonpi/rpi-3/boot/initram=
fs-linux.img -device virtio-net-device,mac=3D52:54:26:11:72:9b,netdev=3Dnet=
0 -netdev tap,id=3Dnet0,ifname=3Drasp-tap0,script=3Dno,downscript=3Dno

  error:

  qemu-system-aarch64: /build/qemu/src/qemu-2.12.0/block.c:3375:
  bdrv_close_all: Assertion `QTAILQ_EMPTY(&all_bdrv_states)' failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772075/+subscriptions
