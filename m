Received: from eggs.gnu.org ([2001:4830:134:3::10]:34356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7gR-0000gY-9A
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL7gN-0006PL-Bg
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:50:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:51450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fL7gN-0006P5-3Z
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:50:31 -0400
Received: from gac.canonical.com ([91.189.90.20])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fL7gM-00009B-5d
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:50:30 +0000
Received: from gac.canonical.com (localhost [IPv6:::1])
	by gac.canonical.com (Postfix) with ESMTPS id 1FD2E5C01E6
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:50:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 13:50:29 -0000
From: Launchpad Bug Tracker <1175513@bugs.launchpad.net>
Reply-To: Bug 1175513 <1175513@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130502091433.32599.11761.malonedeb@soybean.canonical.com>
Message-Id: <152699702979.2438.10778640740570613372.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1175513] [NEW] Qemu 1.5-git gpu clock control
 doesn`t work after guest reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You have been subscribed to a public bug:

I run qemu from git with such command:

qemu-system-x86_64 -nodefaults -m 4096 -smp 8,cores=3D4,threads=3D2,sockets=
=3D1 -cpu 'kvm64' -device usb-mouse -M q35 -vga qxl -no-hpet -boot once=3Dc=
,menu=3Don -device vfio-pci,host=3D02:00.0,x-vga=3Don \
-enable-kvm -monitor stdio -chardev socket,path=3D/tmp/qga.sock,server,nowa=
it,id=3Dqga0 -device virtio-serial -device virtserialport,chardev=3Dqga0,na=
me=3Dorg.qemu.guest_agent.0 -net nic,vlan=3D0,model=3De1000 -net tap,ifname=
=3Dtap0,script=3D/etc/guest-ifup -usb -device intel-hda -device hda-duplex \
-drive file=3D'/home/<user>/qemu/win7',if=3Dnone,id=3Ddrive-virtio-disk0,ca=
che=3Dwriteback,aio=3Dnative,format=3Dqed,discard=3Don -device virtio-blk-p=
ci,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk \
-drive file=3D'/dev/sr0',if=3Dnone,id=3Ddrive-ide1-0-0,media=3Dcdrom,snapsh=
ot=3Doff,format=3Draw -device ide-drive,bus=3Dide.1,unit=3D0,drive=3Ddrive-=
ide1-0-0,id=3Dide1-0-0 \
-spice port=3D5930,disable-ticketing

Before guest (Windows 7) reboot, videocard works in 3D mode with full
frequency. But after reboot videocard works in 3D only with powersafe
frequency. Then I must reboot host for recover gpu clock control.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: vfio-pci
-- =

Qemu 1.5-git gpu clock control doesn`t work after guest reboot
https://bugs.launchpad.net/bugs/1175513
You received this bug notification because you are a member of qemu-devel-m=
l, which is subscribed to QEMU.
