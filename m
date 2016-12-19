Received: from eggs.gnu.org ([2001:4830:134:3::10]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2x6-0003Mc-W2
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cJ2x2-0004Vw-2I
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:46:25 -0500
Received: from indium.canonical.com ([91.189.90.7]:51515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cJ2x1-0004VN-SQ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 13:46:19 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cJ2x0-0002s0-2I
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:46:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B0B202E80C3
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 18:46:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2016 18:27:59 -0000
From: Thomas Huth <697510@bugs.launchpad.net>
Reply-To: Bug 697510 <697510@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110105050549.989.70900.malonedeb@wampee.canonical.com>
Message-Id: <20161219182759.17704.30162.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 697510] Re: Machine shut off after tons of
 lsi_scsi: error: MSG IN data too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... do you still have this problem with the
latest version of QEMU, or could we close this bug nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/697510

Title:
  Machine shut off after tons of lsi_scsi: error: MSG IN data too long

Status in QEMU:
  Incomplete

Bug description:
  The problem mostly happens during our backup, syslog does not have any
  problematic messages.

  Host is Ubuntu 10.10 x86 64 bits
  Guest is Windows 2003 Server 32 bits
  Using Virtio and Red Hat driver I get a STOP screen 0x100000d1 and machin=
e either reboot, stay frozen or shut off.
  Using SCSI the machine shuts off and I get tons of message on stdout;

  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/kvm -S -M pc-0.12 -enable-kvm -m 3500 =
-smp 4,sockets=3D4,cores=3D1,threads=3D1 -name BMSRV0101 -uuid 6ccbb5fa-588=
0-a1ab-3b7a-fb7ccc7c8ccf -nodefaults -chardev socket,id=3Dmonitor,path=3D/v=
ar/lib/libvirt/qemu/BMSRV0101.monitor,server,nowait -mon chardev=3Dmonitor,=
mode=3Dreadline -rtc base=3Dlocaltime -boot c -device lsi,id=3Dscsi0,bus=3D=
pci.0,addr=3D0x4 -drive if=3Dnone,media=3Dcdrom,id=3Ddrive-ide0-1-0,readonl=
y=3Don,format=3Draw -device ide-drive,bus=3Dide.1,unit=3D0,drive=3Ddrive-id=
e0-1-0,id=3Dide0-1-0 -drive file=3D/dev/vgUbuntu/vmBMSRV0101,if=3Dnone,id=
=3Ddrive-scsi0-0-0,boot=3Don,format=3Draw -device scsi-disk,bus=3Dscsi0.0,s=
csi-id=3D0,drive=3Ddrive-scsi0-0-0,id=3Dscsi0-0-0 -device virtio-net-pci,vl=
an=3D0,id=3Dnet0,mac=3D52:54:00:5d:7b:07,bus=3Dpci.0,addr=3D0x3 -net tap,fd=
=3D63,vlan=3D0,name=3Dhostnet0 -chardev pty,id=3Dserial0 -device isa-serial=
,chardev=3Dserial0 -usb -device usb-tablet,id=3Dinput0 -vnc 127.0.0.1:0 -vg=
a cirrus -device usb-host,hostbus=3D002,hostaddr=3D005,id=3Dhostdev0 -devic=
e virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6 =

  char device redirected to /dev/pts/0
  pci_add_option_rom: failed to find romfile "pxe-virtio.bin"
  husb: open device 2.5
  husb: config #1 need -1
  husb: 1 interfaces claimed for configuration 1
  husb: grabbed usb device 2.5
  husb: config #1 need 1
  husb: 1 interfaces claimed for configuration 1

  lsi_scsi: error: Unimplemented message 0x00
  (x8)

  lsi_scsi: error: MSG IN data too long
  lsi_scsi: error: Unimplemented message 0x00
  (x760)

  lsi_scsi: error: MSG IN data too long
  lsi_scsi: error: MSG IN data too long
  kvm: /build/buildd/qemu-kvm-0.12.5+noroms/hw/lsi53c895a.c:512: lsi_do_dma=
: Assertion `s->current' failed.

  =

  I can include minidump file if needed.
  I am currently using IDE and it seems OK.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/697510/+subscriptions
