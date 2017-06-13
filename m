Received: from eggs.gnu.org ([2001:4830:134:3::10]:43420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqXY-0006rv-MR
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKqXU-0005Km-NQ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:33803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKqXU-0005KX-IO
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:27:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKqXS-000424-JP
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:27:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7B0202E8195
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 18:27:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 18:10:59 -0000
From: Thomas Huth <1307281@bugs.launchpad.net>
Reply-To: Bug 1307281 <1307281@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140414031538.8963.42077.malonedeb@gac.canonical.com>
Message-Id: <149737745913.28601.2307365677999828160.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1307281] Re: qemu crash with assertion in
 usb_packet_complete_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... Can you still reproduce this problem with
the latest version of QEMU (currently v2.9.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1307281

Title:
  qemu crash with assertion in usb_packet_complete_one

Status in QEMU:
  Incomplete

Bug description:
  qemu release verison: 1.7.1
  guest os : win7 32bits
  qemu cmdline:
  /usr/bin/qemu-system-x86_64 -name hch_test -S -machine pc-i440fx-1.7,acce=
l=3Dkvm,usb=3Doff -cpu SandyBridge,+erms,+smep,+fsgsbase,+pdpe1gb,+rdrand,+=
f16c,+osxsave,+dca,+pcid,+pdcm,+xtpr,+tm2,+est,+smx,+vmx,+ds_cpl,+monitor,+=
dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme -m 2048 -realtime mlock=3Doff -smp 2=
,sockets=3D2,cores=3D12,threads=3D2 -uuid 5ad433c9-e490-42f3-b365-c30d756fb=
d70 -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/va=
r/lib/libvirt/qemu/hch_test.monitor,server,nowait -mon chardev=3Dcharmonito=
r,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dlocaltime -no-shutdown -global PI=
IX4_PM.disable_s3=3D1 -global PIIX4_PM.disable_s4=3D0 -device ich9-usb-ehci=
1,id=3Dusb,bus=3Dpci.0,addr=3D0x5.0x7 -device ich9-usb-uhci1,masterbus=3Dus=
b.0,firstport=3D0,bus=3Dpci.0,multifunction=3Don,addr=3D0x5 -device virtio-=
serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/opt/cv=
m/hch_test/hch_test.inst,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2,c=
ache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,d=
rive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/op=
t/data/hugedisk/hch_test/hch_test_share.add,if=3Dnone,id=3Ddrive-virtio-dis=
k1,format=3Dqcow2,cache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,bus=
=3Dpci.0,addr=3D0x8,drive=3Ddrive-virtio-disk1,id=3Dvirtio-disk1 -netdev ta=
p,fd=3D26,id=3Dhostnet0,vhost=3Don,vhostfd=3D27 -device virtio-net-pci,netd=
ev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:f2:05:b7,bus=3Dpci.0,addr=3D0x3 -cha=
rdev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dser=
ial0 -chardev spicevmc,id=3Dcharchannel0,name=3Dvdagent -device virtserialp=
ort,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=
=3Dcom.redhat.spice.0 -chardev socket,id=3Dcharchannel1,path=3D/var/lib/lib=
virt/qemu/hch_test.agent,server,nowait -device virtserialport,bus=3Dvirtio-=
serial0.0,nr=3D2,chardev=3Dcharchannel1,id=3Dchannel1,name=3Dorg.qemu.guest=
_agent.0 -device usb-tablet,id=3Dinput0 -spice port=3D5903,addr=3D0.0.0.0,d=
isable-ticketing,seamless-migration=3Don -device qxl-vga,id=3Dvideo0,ram_si=
ze=3D67108864,vram_size=3D67108864,bus=3Dpci.0,addr=3D0x2 -device intel-hda=
,id=3Dsound0,bus=3Dpci.0,addr=3D0x4 -device hda-duplex,id=3Dsound0-codec0,b=
us=3Dsound0.0,cad=3D0 -readconfig /etc/qemu/ich9-ehci-uhci.cfg -chardev spi=
cevmc,name=3Dusbredir,id=3Dusbredirchardev1 -device usb-redir,chardev=3Dusb=
redirchardev1,id=3Dusbredirdev1,bus=3Dehci.0 -chardev spicevmc,name=3Dusbre=
dir,id=3Dusbredirchardev2 -device usb-redir,chardev=3Dusbredirchardev2,id=
=3Dusbredirdev2,bus=3Dehci.0 -chardev spicevmc,name=3Dusbredir,id=3Dusbredi=
rchardev3 -device usb-redir,chardev=3Dusbredirchardev3,id=3Dusbredirdev3,bu=
s=3Dehci.0

  i use spice to connect to vm and utilize usb redirection. i plug a
  u-disk into a remote computer and start copy a big file (3G+) to
  u-disk and qemu was crashed in the middle of the transmission.

  i check the qemu log and found this log: "qemu-system-x86_64:
  hw/usb/core.c:438: usb_packet_complete_one: Assertion `p->stream ||
  ((&ep->queue)->tqh_first) =3D=3D p' failed". this crash can be reproduced
  every time.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1307281/+subscriptions
