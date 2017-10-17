Received: from eggs.gnu.org ([2001:4830:134:3::10]:44666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4O3e-00024T-3t
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4O3a-0003R0-RZ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:21:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4O3a-0003OJ-KX
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 05:21:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4O3Y-0001Um-0P
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 09:21:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 35A6D2E80D4
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 09:20:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Oct 2017 09:06:31 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1723927 <1723927@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150815318241.964.13154685786789289008.malonedeb@chaenomeles.canonical.com>
Message-Id: <150823119194.17029.15853456396323360271.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1723927] Re: Linux or windows guest boot failed
 by uefi on CPU of Intel Xeon X5675
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

"-bios /usr/share/qemu-kvm/OVMF_CODE.fd" is *never* a correct option to
boot OVMF.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1723927

Title:
  Linux or windows guest boot failed by uefi  on CPU of  Intel Xeon
  X5675

Status in QEMU:
  New

Bug description:
  Hi,

  I started windows server 2012 DC or redhat7.0, but boot failed by UEFI, a=
nd start process stop on
  "TianoCore" image by looking at VNCviewer.

  VM using the command:(redhat7.0)
  /usr/bin/kvm -name guest=3Dytest,debug-threads=3Don -S -object secret,id=
=3DmasterKey0,format=3Draw,file=3D/run/lib/libvirt/qemu/domain-40-ytest/mas=
ter-key.aes -machine pc-i440fx-2.7,accel=3Dkvm,usb=3Doff,system=3Dwindows,d=
ump-guest-core=3Doff -bios /usr/share/qemu-kvm/OVMF_CODE.fd -m size=3D83886=
08k,slots=3D10,maxmem=3D34359738368k -realtime mlock=3Doff -smp 1,maxcpus=
=3D24,sockets=3D24,cores=3D1,threads=3D1 -numa node,nodeid=3D0,cpus=3D0-23,=
mem=3D8192 -uuid 8cf40bd6-258a-4550-ba4e-b38230547a11 -no-user-config -node=
faults -chardev socket,id=3Dcharmonitor,path=3D/run/lib/libvirt/qemu/domain=
-40-ytest/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonito=
r,mode=3Dcontrol -chardev socket,id=3Dcharmonitor_cas,path=3D/run/lib/libvi=
rt/qemu/domain-40-ytest/monitor.sock.cas,server,nowait -mon chardev=3Dcharm=
onitor_cas,id=3Dmonitor_cas,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -gl=
obal PIIX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D1 -boot strict=
=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device us=
b-ehci,id=3Dusb1,bus=3Dpci.0,addr=3D0x3 -device nec-usb-xhci,id=3Dusb2,bus=
=3Dpci.0,addr=3D0x4 -device virtio-scsi-pci,id=3Dscsi1,bus=3Dpci.0,addr=3D0=
x6 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x7 -de=
vice usb-hub,id=3Dhub0,bus=3Dusb.0,port=3D1 -drive file=3D/vms/hw235/ytest,=
format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Ddirectsync,aio=3Dn=
ative -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x8,pci_hotplugg=
able=3Don,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive=
 if=3Dnone,id=3Ddrive-fdc0-0-0,readonly=3Don -global isa-fdc.driveA=3Ddrive=
-fdc0-0-0 -global isa-fdc.bootindexA=3D2 -netdev tap,fd=3D48,id=3Dhostnet0,=
vhost=3Don,vhostfd=3D50 -device virtio-net-pci,pci_hotpluggable=3Don,netdev=
=3Dhostnet0,id=3Dnet0,mac=3D0c:da:41:1d:67:6f,bus=3Dpci.0,addr=3D0x5,bootin=
dex=3D4 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharseri=
al0,id=3Dserial0 -chardev socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/=
qemu/ytest.agent,server,nowait -device virtserialport,bus=3Dvirtio-serial0.=
0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0=
 -vnc 0.0.0.0:9 -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -devi=
ce virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x9 -msg timestamp=
=3Don

  qemu version: 2.7.1
  edk2 version: git://git.code.sf.net/p/tianocore/edk2.git, commit: cc0b456=
a05f8dd1ebfb9be485465be37e96999e7
  server: ProLiant BL460c G7, CPU: Intel(R) Xeon(R) CPU X5675  @ 3.07GHz

  Another, last version of edk2(compiled by myself) start guest is
  failed, too. But r15214 of edk2 start guest is ok(Download from
  http://sourceforge.net/projects/edk2/files/OVMF/, OVMF-X64-r15214.zip)

  Thanks in Advance

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1723927/+subscriptions
