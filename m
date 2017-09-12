Received: from eggs.gnu.org ([2001:4830:134:3::10]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drqWB-0007t4-RM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drqW6-0007wt-Gk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 15:06:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:45063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1drqW6-0007tM-8H
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 15:06:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1drqW4-0001uf-4w
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 19:06:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 06EA22E848A
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 19:06:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Sep 2017 18:51:29 -0000
From: Maciej Piechotka <uzytkownik2@gmail.com>
Reply-To: Bug 1716510 <1716510@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150516743999.32018.10984089018227997839.malonedeb@soybean.canonical.com>
Message-Id: <150524228980.31433.17704877315158276454.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1716510] Re: qemu 2.10.0 cannot boot Windows 10
 familly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ok. It looks like EDK was added to my distro and using it fixed it -
https://packages.gentoo.org/packages/sys-firmware/edk2-ovmf (at least
W16 - I'll try W10 tonight).

Unfortunately when I run strings on edk I haven't seen anything which
looked like version.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716510

Title:
  qemu 2.10.0 cannot boot Windows 10 familly

Status in QEMU:
  New

Bug description:
  On qemu 2.10.0 Windows 10 and Windows Server 2016 hangs during boot.
  Below is setup of Windows Server 2016. Downgrading to 2.9 fixes the
  problem.

  /usr/bin/qemu-system-x86_64 -name guest=3D<name>,debug-threads=3Don -S
  -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-2=
-<name
  >/master-key.aes -machine pc-q35-2.8,accel=3Dkvm,usb=3Doff,dump-guest-
  core=3Doff -cpu
  host,nx=3Don,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1000,hv_vpindex,hv_runt=
ime,hv_synic,hv_reset,kvm=3Doff
  -drive file=3D/usr/local/share/edk2.git/ovmf-x64/OVMF-pure-
  efi.fd,if=3Dpflash,format=3Draw,unit=3D0 -drive
  file=3D/var/lib/libvirt/qemu/nvram/<name>_VARS.fd,if=3Dpflash,format=3Dra=
w,unit=3D1
  -m 4096 -realtime mlock=3Doff -smp 12,sockets=3D1,cores=3D6,threads=3D2
  -object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -object
  iothread,id=3Diothread3 -object iothread,id=3Diothread4 -object
  iothread,id=3Diothread5 -object iothread,id=3Diothread6 -object
  iothread,id=3Diothread7 -object iothread,id=3Diothread8 -object
  iothread,id=3Diothread9 -object iothread,id=3Diothread10 -object
  iothread,id=3Diothread11 -object iothread,id=3Diothread12 -uuid <uuid>
  -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-2-<name>/moni=
tor.sock,server,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,clock=3Dvm,driftfix=3Dslew -no-shutdown -boot strict=3Don
  -device
  ioh3420,port=3D0x10,chassis=3D1,id=3Dpci.1,bus=3Dpcie.0,multifunction=3Do=
n,addr=3D0x2
  -device ioh3420,port=3D0x11,chassis=3D2,id=3Dpci.2,bus=3Dpcie.0,addr=3D0x=
2.0x1
  -device ioh3420,port=3D0x12,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,addr=3D0x=
2.0x2
  -device ioh3420,port=3D0x13,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x=
2.0x3
  -device ioh3420,port=3D0x14,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x=
2.0x4
  -device ioh3420,port=3D0x15,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x=
2.0x5
  -device nec-usb-xhci,id=3Dusb,bus=3Dpci.3,addr=3D0x0 -drive
  if=3Dnone,media=3Dcdrom,id=3Ddrive-sata0-0-0,readonly=3Don -device ide-
  cd,bus=3Dide.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootindex=3D2 -drive
  if=3Dnone,media=3Dcdrom,id=3Ddrive-sata0-0-1,readonly=3Don -device ide-
  cd,bus=3Dide.1,drive=3Ddrive-sata0-0-1,id=3Dsata0-0-1,bootindex=3D1 -drive
  file=3D/dev/mapper/<boot disk>,format=3Draw,if=3Dnone,id=3Ddrive-sata0-0-2
  -device ide-hd,bus=3Dide.2,drive=3Ddrive-
  sata0-0-2,id=3Dsata0-0-2,bootindex=3D3 -netdev
  tap,fd=3D21,id=3Dhostnet0,vhost=3Don,vhostfd=3D23 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D<mac>,bus=3Dpci.1,addr=3D0x0 -netdev
  tap,fd=3D24,id=3Dhostnet1,vhost=3Don,vhostfd=3D25 -device virtio-net-
  pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D<mac>,bus=3Dpci.2,addr=3D0x0 -devic=
e usb-
  tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -spice
  unix,addr=3D/var/lib/libvirt/qemu/domain-2-<name>/spice.sock,disable-
  ticketing,image-compression=3Dauto_glz,seamless-migration=3Don -vnc
  127.0.0.1:0 -device qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D16777216,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpcie.0,addr=3D0x1
  -device vhost-scsi-
  pci,wwpn=3D<wwpn>,vhostfd=3D26,id=3Dhostdev0,bus=3Dpcie.0,addr=3D0x9 -dev=
ice
  virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.4,addr=3D0x0 -object rng-
  random,id=3Dobjrng0,filename=3D/dev/random -device virtio-rng-
  pci,rng=3Dobjrng0,id=3Drng0,max-bytes=3D1024,period=3D1000,bus=3Dpci.5,ad=
dr=3D0x0
  -msg timestamp=3Do

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1716510/+subscriptions
