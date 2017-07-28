Received: from eggs.gnu.org ([2001:4830:134:3::10]:53585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dbB3H-0006bS-Py
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dbB3E-0000s6-Jq
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:35:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:39079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dbB3E-0000rd-Aw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:35:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dbB3C-0000Ye-6L
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 19:35:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D4DB62E80D4
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 19:35:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Jul 2017 19:25:31 -0000
From: DocMAX <docmax@gmx.de>
Reply-To: Bug 1707274 <1707274@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150126934441.26478.867768267013949093.malonedeb@chaenomeles.canonical.com>
Message-Id: <150126993126.21038.2732783104846006815.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1707274] Re: Segfaults inside QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  I'm running a server with QEMU emulator version 2.9.0. Although i gave
  the machine plenty RAM it begins segfaulting some processes after some
  hours which ends in a complete crash.
  =

- This is the commandline from libvirt and i also attached the QEMU log:
- =

- /usr/bin/qemu-system-x86_64-nameguest=3Dserver,debug-
- threads=3Don-S-objectsecret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/=
libvirt/qemu/domain-2-server
- /master-key.aes-machinepc-i440fx-2.9,accel=3Dkvm,usb=3Doff,dump-guest-core
- =3Doff-cpuhost-m8192-realtimemlock=3Doff-
- smp4,sockets=3D4,cores=3D1,threads=3D1-uuid5329bfd3-b947-473b-9880-d95b4c=
a78f28
- -no-user-config-nodefaults-
- chardevsocket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-2-serv=
er/monitor.sock,server
- ,nowait-monchardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol-
- rtcbase=3Dutc,driftfix=3Dslew-globalkvm-pit.lost_tick_policy=3Ddelay-no-h=
pet-
- no-shutdown-
- globalPIIX4_PM.disable_s3=3D1-globalPIIX4_PM.disable_s4=3D1-bootstrict=3D=
on-
- deviceich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x9.0x7-deviceich9-usb-
- uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x9-deviceich9
- -usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=3D0x9.0x1-dev=
iceich9
- -usb-
- uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=3D0x9.0x2-deviceah=
ci,id=3Dsata0,bus=3Dpci.0,addr=3D0x6
- -devicevirtio-serial-pci,id=3Dvirtio-
- serial0,bus=3Dpci.0,addr=3D0x5-drivefile=3D/mnt/htpc/windows/VM/disks/qco=
w2
- /server-boot.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0
- -devicevirtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xa,drive=3Ddrive-vir=
tio-
- disk0,id=3Dvirtio-
- disk0,bootindex=3D1-drivefile=3D/dev/sda,format=3Draw,if=3Dnone,id=3Ddriv=
e-virtio-
- disk1-devicevirtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xb,drive=3Ddriv=
e-
- virtio-disk1,id=3Dvirtio-
- disk1-netdevtap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhostfd=3D26-devicevirti=
o-net-
- pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:12:34:56,bus=3Dpci.0,addr=
=3D0x3-spiceport=3D5902,addr=3D127.0.0.1
- ,disable-ticketing,image-compression=3Doff,seamless-migration=3Don-
- deviceqxl-
- vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=
=3D0,vgamem_mb=3D16,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2
- -devicevirtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8-msgtimesta=
mp=3Don
+ I've attached the QEMU log. I can't see something special when the
+ segfaults begin.

** Attachment removed: "server.log"
   https://bugs.launchpad.net/qemu/+bug/1707274/+attachment/4923250/+files/=
server.log.1

** Description changed:

  I'm running a server with QEMU emulator version 2.9.0. Although i gave
  the machine plenty RAM it begins segfaulting some processes after some
  hours which ends in a complete crash.
  =

- I've attached the QEMU log. I can't see something special when the
- segfaults begin.
+ I can't see something special in the log when the segfaults begins.
+ =

+ 2017-07-28 11:45:01.027+0000: starting up libvirt version: 3.5.0, qemu ve=
rsion: 2.9.0, hostname: htpc.lan
+ LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_=
AUDIO_DRV=3Dspice /usr/bin/qemu-system-x86_64 -name guest=3Dserver,debug-th=
reads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/l=
ibvirt/qemu/domain-1-server/master-key.aes -machine pc-i440fx-2.9,accel=3Dk=
vm,usb=3Doff,dump-guest-core=3Doff -cpu host -m 8192 -realtime mlock=3Doff =
-smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid 5329bfd3-b947-473b-9880-d95b=
4ca78f28 -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=
=3D/var/lib/libvirt/qemu/domain-1-server/monitor.sock,server,nowait -mon ch=
ardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3D=
slew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global=
 PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don =
-device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x9.0x7 -device ich9-usb=
-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x9 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,a=
ddr=3D0x9.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3D=
pci.0,addr=3D0x9.0x2 -device ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0x6 -device=
 virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -drive file=
=3D/mnt/htpc/windows/VM/disks/qcow2/server-boot.qcow2,format=3Dqcow2,if=3Dn=
one,id=3Ddrive-virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,a=
ddr=3D0xa,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive=
 file=3D/dev/sda,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk1 -device vir=
tio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xb,drive=3Ddrive-virtio-disk1,id=
=3Dvirtio-disk1 -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhostfd=3D26 -=
device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:12:34:56,b=
us=3Dpci.0,addr=3D0x3 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing=
,image-compression=3Doff,seamless-migration=3Don -device qxl-vga,id=3Dvideo=
0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D1=
6,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -device virtio-balloon-pci,id=3Dba=
lloon0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3Don
+ 2017-07-28 11:45:01.032+0000: Domain id=3D1 is tainted: host-cpu
+ 2017-07-28 18:55:28.270+0000: shutting down, reason=3Dcrashed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1707274

Title:
  Segfaults inside QEMU

Status in QEMU:
  New

Bug description:
  I'm running a server with QEMU emulator version 2.9.0. Although i gave
  the machine plenty RAM it begins segfaulting some processes after some
  hours which ends in a complete crash.

  I can't see something special in the log when the segfaults begins.

  2017-07-28 11:45:01.027+0000: starting up libvirt version: 3.5.0, qemu ve=
rsion: 2.9.0, hostname: htpc.lan
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_=
AUDIO_DRV=3Dspice /usr/bin/qemu-system-x86_64 -name guest=3Dserver,debug-th=
reads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/l=
ibvirt/qemu/domain-1-server/master-key.aes -machine pc-i440fx-2.9,accel=3Dk=
vm,usb=3Doff,dump-guest-core=3Doff -cpu host -m 8192 -realtime mlock=3Doff =
-smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid 5329bfd3-b947-473b-9880-d95b=
4ca78f28 -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=
=3D/var/lib/libvirt/qemu/domain-1-server/monitor.sock,server,nowait -mon ch=
ardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3D=
slew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet -no-shutdown -global=
 PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=3Don =
-device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x9.0x7 -device ich9-usb=
-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=
=3D0x9 -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,a=
ddr=3D0x9.0x1 -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3D=
pci.0,addr=3D0x9.0x2 -device ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0x6 -device=
 virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5 -drive file=
=3D/mnt/htpc/windows/VM/disks/qcow2/server-boot.qcow2,format=3Dqcow2,if=3Dn=
one,id=3Ddrive-virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,a=
ddr=3D0xa,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive=
 file=3D/dev/sda,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk1 -device vir=
tio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xb,drive=3Ddrive-virtio-disk1,id=
=3Dvirtio-disk1 -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhostfd=3D26 -=
device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:12:34:56,b=
us=3Dpci.0,addr=3D0x3 -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing=
,image-compression=3Doff,seamless-migration=3Don -device qxl-vga,id=3Dvideo=
0,ram_size=3D67108864,vram_size=3D67108864,vram64_size_mb=3D0,vgamem_mb=3D1=
6,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 -device virtio-balloon-pci,id=3Dba=
lloon0,bus=3Dpci.0,addr=3D0x8 -msg timestamp=3Don
  2017-07-28 11:45:01.032+0000: Domain id=3D1 is tainted: host-cpu
  2017-07-28 18:55:28.270+0000: shutting down, reason=3Dcrashed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1707274/+subscriptions
