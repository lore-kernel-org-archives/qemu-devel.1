Received: from eggs.gnu.org ([2001:4830:134:3::10]:35367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqQ26-0007pd-D7
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 16:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqQ23-0003Vi-6k
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 16:10:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:37938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eqQ23-0003VI-0H
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 16:09:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eqQ22-0007JF-4p
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 21:09:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 20FDE2E80C7
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 21:09:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Feb 2018 20:59:18 -0000
From: Thomas Huth <1428958@bugs.launchpad.net>
Reply-To: Bug 1428958 <1428958@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150306065030.11880.86550.malonedeb@gac.canonical.com>
Message-Id: <151967875859.6538.13368352045197909236.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1428958] Re: random IO errors / data corruption
 in VMs (created and executed via virt-manager)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing according to comment #2.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1428958

Title:
  random IO errors / data corruption in VMs (created and executed via
  virt-manager)

Status in QEMU:
  Fix Released

Bug description:
  I have recurring problems with VM installation and usage - data on VM dis=
k gets corrupted at some point and it causes all sorts of problems - someti=
mes I cannot even install base system, other times some .so files are corru=
pt after isntallation, etc - totally random.
  I use virt-manager to create and run VMs. I have also tried creating VMs =
via virt-install, result is identical.
  If I use VirtualBox I have no such problems.
  My OS is Fedora 20 upgraded to 21, qemu and libvirt are installed from Fe=
dora official repos.

  Here's an example qemu command-line:
  /usr/bin/qemu-system-x86_64
  -machine accel=3Dkvm
  -name fuel
  -S
  -machine pc-i440fx-2.1,accel=3Dkvm,usb=3Doff
  -cpu SandyBridge,+invpcid,+erms,+bmi2,+smep,+avx2,+bmi1,+fsgsbase,+abm,+p=
dpe1gb,+rdrand,+f16c,+osxsave,+movbe,+pcid,+pdcm,+xtpr,+fma,+tm2,+est,+smx,=
+vmx,+ds_cpl,+monitor,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme
  -m 3142
  -realtime mlock=3Doff
  -smp 2,sockets=3D2,cores=3D1,threads=3D1
  -uuid 27693a46-7a50-4a3c-bcaf-bf061ba469ed
  -no-user-config
  -nodefaults
  -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/fuel.monito=
r,server,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol
  -rtc base=3Dutc,driftfix=3Dslew
  -global kvm-pit.lost_tick_policy=3Ddiscard
  -no-hpet
  -no-shutdown
  -boot menu=3Don,strict=3Don
  -device ich9-usb-ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x6.0x7
  -device ich9-usb-uhci1,masterbus=3Dusb.0,firstport=3D0,bus=3Dpci.0,multif=
unction=3Don,addr=3D0x6
  -device ich9-usb-uhci2,masterbus=3Dusb.0,firstport=3D2,bus=3Dpci.0,addr=
=3D0x6.0x1
  -device ich9-usb-uhci3,masterbus=3Dusb.0,firstport=3D4,bus=3Dpci.0,addr=
=3D0x6.0x2
  -device lsi,id=3Dscsi0,bus=3Dpci.0,addr=3D0xa
  -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x7
  -drive file=3D/home/virtual-disks/fuel.vdi,if=3Dnone,id=3Ddrive-virtio-di=
sk0,format=3Dvdi
  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x8,drive=3Ddrive-vi=
rtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
  -drive file=3D/home/dsutyagin/Downloads/iso/MirantisOpenStack-6.0.iso,if=
=3Dnone,id=3Ddrive-scsi0-0-0,readonly=3Don,format=3Draw
  -device scsi-cd,bus=3Dscsi0.0,scsi-id=3D0,drive=3Ddrive-scsi0-0-0,id=3Dsc=
si0-0-0,bootindex=3D2
  -netdev tap,fd=3D23,id=3Dhostnet0,vhost=3Don,vhostfd=3D24
  -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:0d:42:2=
d,bus=3Dpci.0,addr=3D0x3
  -netdev tap,fd=3D25,id=3Dhostnet1,vhost=3Don,vhostfd=3D26
  -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:a4:8c:e=
f,bus=3Dpci.0,addr=3D0x4
  -chardev pty,id=3Dcharserial0
  -device isa-serial,chardev=3Dcharserial0,id=3Dserial0
  -chardev socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/channel/ta=
rget/fuel.org.qemu.guest_agent.0,server,nowait
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchanne=
l0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0
  -chardev spicevmc,id=3Dcharchannel1,name=3Dvdagent
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3Dcharchanne=
l1,id=3Dchannel1,name=3Dcom.redhat.spice.0
  -device usb-tablet,id=3Dinput0
  -spice port=3D5900,addr=3D127.0.0.1,disable-ticketing,seamless-migration=
=3Don
  -device qxl-vga,id=3Dvideo0,ram_size=3D67108864,vram_size=3D67108864,bus=
=3Dpci.0,addr=3D0x2
  -device intel-hda,id=3Dsound0,bus=3Dpci.0,addr=3D0x5 -device hda-duplex,i=
d=3Dsound0-codec0,bus=3Dsound0.0,cad=3D0
  -chardev spicevmc,id=3Dcharredir0,name=3Dusbredir
  -device usb-redir,chardev=3Dcharredir0,id=3Dredir0
  -chardev spicevmc,id=3Dcharredir1,name=3Dusbredir
  -device usb-redir,chardev=3Dcharredir1,id=3Dredir1
  -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x9
  -msg timestamp=3Don

  If this is not a bug, I'd be happy if you help me fix this problem. I
  am sorry if this is not the proper place to post such a problem.

  qemu-system-x86_64 --version
  QEMU emulator version 2.1.3 (qemu-2.1.3-2.fc21), Copyright (c) 2003-2008 =
Fabrice Bellard

  qemu-kvm --version
  QEMU emulator version 2.1.3 (qemu-2.1.3-2.fc21), Copyright (c) 2003-2008 =
Fabrice Bellard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1428958/+subscriptions
