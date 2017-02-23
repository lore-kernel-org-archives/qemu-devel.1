Received: from eggs.gnu.org ([2001:4830:134:3::10]:54970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cgkyO-00087n-Iv
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cgkyL-0000ir-CW
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:25:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:48578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cgkyL-0000ig-0I
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:25:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cgkyI-0001OC-LA
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 04:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9CB202E80C6
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 04:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Feb 2017 04:17:23 -0000
From: Launchpad Bug Tracker <1652333@bugs.launchpad.net>
Reply-To: Bug 1652333 <1652333@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161223152652.14283.5770.malonedeb@wampee.canonical.com>
Message-Id: <20170223041724.20146.1407.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1652333] Re: TCG mode fails to boot Linux kernel
 with qemu 2.6.0 and libvirt 2.0.0
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
https://bugs.launchpad.net/bugs/1652333

Title:
  TCG mode fails to boot Linux kernel with qemu 2.6.0 and libvirt 2.0.0

Status in QEMU:
  Expired

Bug description:
  Trying to boot a Cirros (minimal Linux) VM with qemu 2.6.0 and libvirt
  2.0.0 in TCG mode fails for me. The VM gets stuck in "Starting up ..."
  and never moves on. The command line used to boot the VM was:

  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
  QEMU_AUDIO_DRV=3Dnone /usr/libexec/qemu-kvm -name
  guest=3Dinstance-00000002,debug-threads=3Don -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1=
-instance-00000002
  /master-key.aes -machine pc-i440fx-rhel7.3.0,accel=3Dtcg,usb=3Doff -cpu
  SandyBridge,+osxsave,+hypervisor,+xsaveopt -m 512 -realtime mlock=3Doff
  -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid ae38b0e1-b3ae-41ec-
  8e50-c89669a2ec1c -smbios 'type=3D1,manufacturer=3DRed
  Hat,product=3DOpenStack Compute,version=3D14.0.2-7.el7ost,serial=3Dedd3a6=
7d-
  6ce5-4c36-8f20-085d1097abb7,uuid=3Dae38b0e1-b3ae-41ec-
  8e50-c89669a2ec1c,family=3DVirtual Machine' -no-user-config -nodefaults
  -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-1-instance-00=
000002/monitor.sock,server,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -n=
o-
  shutdown -boot strict=3Don -device piix3-usb-
  uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive
  file=3D/var/lib/nova/instances/ae38b0e1-b3ae-41ec-
  8e50-c89669a2ec1c/disk,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-
  disk0,cache=3Dnone -device virtio-blk-
  pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=3Dvir=
tio-
  disk0,bootindex=3D1 -netdev tap,fd=3D28,id=3Dhostnet0 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:c1:27:73,bus=3Dpci.0,addr=
=3D0x3
  -add-fd set=3D1,fd=3D31 -chardev
  file,id=3Dcharserial0,path=3D/dev/fdset/1,append=3Don -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev pty,id=3Dcharserial1
  -device isa-serial,chardev=3Dcharserial1,id=3Dserial1 -device usb-
  tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.0.0.0:0 -k en-us -device
  cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device virtio-balloon-
  pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -msg timestamp=3Don

  A qcow2 image can be downloaded from http://download.cirros-
  cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img to reproduce the issue.
  I've seen a similar failure with a CentOS 7.2 image.

  I am also attaching the libvirt log from the failed VM.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1652333/+subscriptions
