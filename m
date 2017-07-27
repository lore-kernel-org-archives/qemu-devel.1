Received: from eggs.gnu.org ([2001:4830:134:3::10]:40033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dae6m-0003cP-31
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dae6j-0004sa-DM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:24 -0400
Received: from indium.canonical.com ([91.189.90.7]:60115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dae6j-0004sG-7M
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dae6h-0007mE-RU
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:25:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CDFDA2E80C9
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:25:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jul 2017 08:10:59 -0000
From: Thomas Huth <1610368@bugs.launchpad.net>
Reply-To: Bug 1610368 <1610368@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160805180451.16941.90864.malonedeb@chaenomeles.canonical.com>
Message-Id: <150114305971.31388.15144530073908007888.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1610368] Re: qemu-system-x86_64 read acces DENIED
 in apparmor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** No longer affects: qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1610368

Title:
  qemu-system-x86_64 read acces DENIED in apparmor

Status in qemu package in Ubuntu:
  New

Bug description:
  When starting a win8.1 VM in virt-manager I see theses errors in dmesg

  [  185.210435] audit: type=3D1400 audit(1470419576.704:27): apparmor=3D"S=
TATUS" operation=3D"profile_replace" profile=3D"unconfined" name=3D"libvirt=
-d694857f-577a-45d4-81d2-4f3672ae7bd4" pid=3D4885 comm=3D"apparmor_parser"
  [  185.220800] audit: type=3D1400 audit(1470419576.716:28): apparmor=3D"S=
TATUS" operation=3D"profile_replace" profile=3D"unconfined" name=3D"libvirt=
-d694857f-577a-45d4-81d2-4f3672ae7bd4//qemu_bridge_helper" pid=3D4885 comm=
=3D"apparmor_parser"
  [  185.356159] audit: type=3D1400 audit(1470419576.848:29): apparmor=3D"D=
ENIED" operation=3D"open" profile=3D"libvirt-d694857f-577a-45d4-81d2-4f3672=
ae7bd4" name=3D"/run/udev/data/c189:1" pid=3D4912 comm=3D"qemu-system-x86" =
requested_mask=3D"r" denied_mask=3D"r" fsuid=3D123 ouid=3D0
  [  185.356244] audit: type=3D1400 audit(1470419576.848:30): apparmor=3D"D=
ENIED" operation=3D"open" profile=3D"libvirt-d694857f-577a-45d4-81d2-4f3672=
ae7bd4" name=3D"/run/udev/data/c189:129" pid=3D4912 comm=3D"qemu-system-x86=
" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D123 ouid=3D0
  [  185.356317] audit: type=3D1400 audit(1470419576.848:31): apparmor=3D"D=
ENIED" operation=3D"open" profile=3D"libvirt-d694857f-577a-45d4-81d2-4f3672=
ae7bd4" name=3D"/run/udev/data/c189:130" pid=3D4912 comm=3D"qemu-system-x86=
" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D123 ouid=3D0
  [  185.356396] audit: type=3D1400 audit(1470419576.848:32): apparmor=3D"D=
ENIED" operation=3D"open" profile=3D"libvirt-d694857f-577a-45d4-81d2-4f3672=
ae7bd4" name=3D"/run/udev/data/c189:131" pid=3D4912 comm=3D"qemu-system-x86=
" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D123 ouid=3D0
  [  185.356486] audit: type=3D1400 audit(1470419576.852:33): apparmor=3D"D=
ENIED" operation=3D"open" profile=3D"libvirt-d694857f-577a-45d4-81d2-4f3672=
ae7bd4" name=3D"/run/udev/data/c189:257" pid=3D4912 comm=3D"qemu-system-x86=
" requested_mask=3D"r" denied_mask=3D"r" fsuid=3D123 ouid=3D0
  [  185.356545] audit: type=3D1400 audit(1470419576.852:34): apparmor=3D"D=
ENIED" operation=3D"open" profile=3D"libvirt-d694857f-577a-45d4-81d2-4f3672=
ae7bd4" name=3D"/run/udev/data/c189:0" pid=3D4912 comm=3D"qemu-system-x86" =
requested_mask=3D"r" denied_mask=3D"r" fsuid=3D123 ouid=3D0

  =

  the process 4912 is : =


  libvirt+  4912     1 36 19:52 ?        00:00:51 qemu-system-x86_64
  -enable-kvm -name win8.1 -S -machine pc-i440fx-2.5,accel=3Dkvm,usb=3Doff
  -cpu Broadwell-noTSX,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff
  -m 4096 -realtime mlock=3Doff -smp 2,sockets=3D2,cores=3D1,threads=3D1 -u=
uid
  d694857f-577a-45d4-81d2-4f3672ae7bd4 -no-user-config -nodefaults
  -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-
  win8.1/monitor.sock,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dlocaltime,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddisca=
rd
  -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
  PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device nec-usb-
  xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x5 -device virtio-serial-pci,id=3Dvirti=
o-
  serial0,bus=3Dpci.0,addr=3D0x6 -drive
  file=3D/TEMPO/VMS/win81.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-ide0-0-0
  -device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-
  ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -netdev tap,fd=3D26,id=3Dhostnet0 -d=
evice
  rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:9d:db:21,bus=3Dpci.0,a=
ddr=3D0x3
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialport,bus
  =3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dcom.redhat.s=
pice.0
  -device usb-tablet,id=3Dinput0 -spice port=3D5900,addr=3D127.0.0.1,disabl=
e-
  ticketing,image-compression=3Doff,seamless-migration=3Don -k fr -device
  qxl-
  vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,vgamem_mb=3D16,b=
us=3Dpci.0,addr=3D0x2
  -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-
  duplex,id=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0 -chardev
  spicevmc,id=3Dcharredir0,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir0,id=3Dredir0 -chardev
  spicevmc,id=3Dcharredir1,name=3Dusbredir -device usb-
  redir,chardev=3Dcharredir1,id=3Dredir1 -device usb-
  host,hostbus=3D2,hostaddr=3D10,id=3Dhostdev0 -device virtio-balloon-
  pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 -msg timestamp=3Don

  =

  I have no visible problems with the VM but just wanted to signal this to =
developpers in case this is not normal behaviour.

  ProblemType: Bug
  DistroRelease: Ubuntu 16.04
  Package: qemu-system-x86 1:2.5+dfsg-5ubuntu10.3
  ProcVersionSignature: Ubuntu 4.4.0-31.50-generic 4.4.13
  Uname: Linux 4.4.0-31-generic x86_64
  ApportVersion: 2.20.1-0ubuntu2.1
  Architecture: amd64
  CurrentDesktop: KDE
  Date: Fri Aug  5 19:57:37 2016
  InstallationDate: Installed on 2016-05-14 (83 days ago)
  InstallationMedia: Kubuntu 16.04 LTS "Xenial Xerus" - Release amd64 (2016=
0420.1)
  ProcKernelCmdLine: BOOT_IMAGE=3D/@/boot/vmlinuz-4.4.0-31-generic root=3DU=
UID=3D54def8c1-2495-44c4-b760-f8dbc15e25b1 ro rootflags=3Dsubvol=3D@ quiet =
splash vt.handoff=3D7
  SourcePackage: qemu
  UpgradeStatus: No upgrade log present (probably fresh install)
  dmi.bios.date: 02/24/2016
  dmi.bios.vendor: Intel Corporation
  dmi.bios.version: RYBDWi35.86A.0355.2016.0224.1501
  dmi.board.name: NUC5i5RYB
  dmi.board.vendor: Intel Corporation
  dmi.board.version: H40999-504
  dmi.chassis.type: 3
  dmi.modalias: dmi:bvnIntelCorporation:bvrRYBDWi35.86A.0355.2016.0224.1501=
:bd02/24/2016:svn:pn:pvr:rvnIntelCorporation:rnNUC5i5RYB:rvrH40999-504:cvn:=
ct3:cvr:

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1610368/+subscriptions
