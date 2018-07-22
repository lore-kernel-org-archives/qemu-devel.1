Received: from eggs.gnu.org ([2001:4830:134:3::10]:50905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60i-0002oE-J5
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60h-0007Jq-3Y
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:50042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fh60g-0007JH-RQ
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fh60g-0007S6-2R
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0D3942E80C3
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Jul 2018 04:17:24 -0000
From: Launchpad Bug Tracker <1175513@bugs.launchpad.net>
Reply-To: Bug 1175513 <1175513@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130502091433.32599.11761.malonedeb@soybean.canonical.com>
Message-Id: <153223304484.12964.6068630200955699182.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1175513] Re: Qemu 1.5-git gpu clock control
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1175513

Title:
  Qemu 1.5-git gpu clock control doesn`t work after guest reboot

Status in QEMU:
  Expired

Bug description:
  I run qemu from git with such command:

  qemu-system-x86_64 -nodefaults -m 4096 -smp 8,cores=3D4,threads=3D2,socke=
ts=3D1 -cpu 'kvm64' -device usb-mouse -M q35 -vga qxl -no-hpet -boot once=
=3Dc,menu=3Don -device vfio-pci,host=3D02:00.0,x-vga=3Don \
  -enable-kvm -monitor stdio -chardev socket,path=3D/tmp/qga.sock,server,no=
wait,id=3Dqga0 -device virtio-serial -device virtserialport,chardev=3Dqga0,=
name=3Dorg.qemu.guest_agent.0 -net nic,vlan=3D0,model=3De1000 -net tap,ifna=
me=3Dtap0,script=3D/etc/guest-ifup -usb -device intel-hda -device hda-duple=
x \
  -drive file=3D'/home/<user>/qemu/win7',if=3Dnone,id=3Ddrive-virtio-disk0,=
cache=3Dwriteback,aio=3Dnative,format=3Dqed,discard=3Don -device virtio-blk=
-pci,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk \
  -drive file=3D'/dev/sr0',if=3Dnone,id=3Ddrive-ide1-0-0,media=3Dcdrom,snap=
shot=3Doff,format=3Draw -device ide-drive,bus=3Dide.1,unit=3D0,drive=3Ddriv=
e-ide1-0-0,id=3Dide1-0-0 \
  -spice port=3D5930,disable-ticketing

  Before guest (Windows 7) reboot, videocard works in 3D mode with full
  frequency. But after reboot videocard works in 3D only with powersafe
  frequency. Then I must reboot host for recover gpu clock control.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1175513/+subscriptions
