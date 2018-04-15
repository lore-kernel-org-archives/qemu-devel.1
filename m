Received: from eggs.gnu.org ([2001:4830:134:3::10]:36977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7ZJs-0004Dv-7A
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f7ZJq-00033x-0a
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:48992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f7ZJp-00033X-QM
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 00:31:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f7ZJo-0003CQ-Ry
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 04:31:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D101F2E80C8
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 04:31:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Apr 2018 04:17:28 -0000
From: Launchpad Bug Tracker <1397157@bugs.launchpad.net>
Reply-To: Bug 1397157 <1397157@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141128021917.32359.93361.malonedeb@gac.canonical.com>
Message-Id: <152376584856.25258.11634303917416374885.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1397157] Re: cpu high with ps2 keyboard on
 multi-core win7 guest os
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
https://bugs.launchpad.net/bugs/1397157

Title:
  cpu high with ps2 keyboard on multi-core win7 guest os

Status in QEMU:
  Expired

Bug description:
  =

  qemu ver: 1.5.3-Latest =


  guest os: window 7 64bit with 2 cpu and ps2 keybord.

  problem: Use virt-viwer as client to connect, When input quickly, the
  guest and host cpu will high and the input-char will display later.
  but when only 1 cpu on the vm, the problem will not display or When
  qemu ver is 0.12.1, the problem will not display.

  qemu cmd:
  /usr/libexec/qemu-kvm -name xx_win7 -machine pc-i440fx-rhel7.0.0,accel=3D=
kvm,usb=3Doff -cpu qemu64,+sse4.2,+sse4.1,+ssse3,-svm,hv_relaxed,hv_vapic,h=
v_spinlocks=3D0x1000 -m 4096 -realtime mlock=3Doff -smp 2,sockets=3D1,cores=
=3D2,threads=3D1 -uuid 0860a434-6560-591b-f92f-c13c5caaf52d -rtc base=3Dloc=
altime -no-shutdown -boot strict=3Don -device ich9-usb-ehci1,id=3Dusb,bus=
=3Dpci.0,addr=3D0x5.0x7 -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=
=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D0x5 -device ich9-usb-uhci2,maste=
rbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x5.0x1 -device ich9-usb-uhci=
3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x5.0x2 -device virtio=
-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/lfs/x=
x_win7/xx_win7.vda,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=
=3Dwriteback -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=
=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D2 -drive if=3Dnone,id=
=3Ddrive-ide0-0-0,readonly=3Don,format=3Draw -device ide-cd,bus=3Dide.0,uni=
t=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -chardev spicevmc,=
id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus=3Dvirtio-serial=
0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.spice.0 -=
device usb-tablet,id=3Dinput0 -spice port=3D5900,addr=3D::,disable-ticketin=
g,plaintext-channel=3Dmain,plaintext-channel=3Ddisplay,plaintext-channel=3D=
inputs,plaintext-channel=3Dcursor,plaintext-channel=3Dplayback,plaintext-ch=
annel=3Drecord,plaintext-channel=3Dusbredir,image-compression=3Dauto_glz,jp=
eg-wan-compression=3Dauto,zlib-glz-wan-compression=3Dauto,playback-compress=
ion=3Don,disable-copy-paste,seamless-migration=3Don -vga qxl -global qxl-vg=
a.ram_size=3D268435456 -global qxl-vga.vram_size=3D67108864 -device intel-h=
da,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-duplex,id=3Dsound0-codec0=
,bus=3Dsound0.0,cad=3D0 -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir -=
device usb-redir,chardev=3Dcharredir0,id=3Dredir0 -chardev spicevmc,id=3Dch=
arredir1,name=3Dusbredir -device usb-redir,chardev=3Dcharredir1,id=3Dredir1=
 -chardev spicevmc,id=3Dcharredir2,name=3Dusbredir -device usb-redir,charde=
v=3Dcharredir2,id=3Dredir2 -chardev spicevmc,id=3Dcharredir3,name=3Dusbredi=
r -device usb-redir,chardev=3Dcharredir3,id=3Dredir3 -device virtio-balloon=
-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1397157/+subscriptions
