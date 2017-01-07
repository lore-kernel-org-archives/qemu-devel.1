Received: from eggs.gnu.org ([2001:4830:134:3::10]:34749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPie8-0002ME-N0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPie6-000115-8n
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:24 -0500
Received: from indium.canonical.com ([91.189.90.7]:34808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPie6-00010P-2f
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:22 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPie5-0000Xh-1W
	for <qemu-devel@nongnu.org>; Sat, 07 Jan 2017 04:30:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 093862E80C2
	for <qemu-devel@nongnu.org>; Sat,  7 Jan 2017 04:30:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Jan 2017 04:17:49 -0000
From: Launchpad Bug Tracker <607204@bugs.launchpad.net>
Reply-To: Bug 607204 <607204@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100719123800.18641.46171.malonedeb@potassium.ubuntu.com>
Message-Id: <20170107041749.790.70536.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 607204] Re: New qemu instances often cannot be
 started if host system is under load
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
https://bugs.launchpad.net/bugs/607204

Title:
  New qemu instances often cannot be started if host system is under
  load

Status in QEMU:
  Expired

Bug description:
  I've got a problem where I cannot start any new VMs with qemu-kvm if
  the host machine is under high CPU load. The problem is not 100%
  reproducible (it works sometimes), but under load conditions, it
  happens most of the time - roughly 95%.

  I'm usually using libvirt to start and stop KVM VMs. When using virsh
  to start a new VM under those conditions, the output looks like this:

  virsh # start testserver-a
  error: Failed to start domain testserver-a
  error: monitor socket did not show up.: Connection refused

  (There is a very long wait after the command has been sent until the
  error message shows up.)

  This is (an example of) the command line that libvirtd uses to start
  up qemu:

  ----- snip -----
  LC_ALL=3DC PATH=3D/sbin:/usr/sbin:/bin:/usr/bin HOME=3D/root USER=3Droot =
LOGNAME=3Droot QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-kvm -S -M pc-0.12 -enabl=
e-kvm -m 256 -smp 1,sockets=3D1,cores=3D1,threads=3D1 -name testserver-a -u=
uid 7cbb3665-4d58-86b8-ce8f-20541995a99c -nodefaults -chardev socket,id=3Dm=
onitor,path=3D/usr/local/var/lib/libvirt/qemu/testserver-a.monitor,server,n=
owait -mon chardev=3Dmonitor,mode=3Dreadline -rtc base=3Dutc -no-acpi -boot=
 c -device lsi,id=3Dscsi0,bus=3Dpci.0,addr=3D0x7 -drive file=3D/data/testse=
rver-a-system.img,if=3Dnone,id=3Ddrive-scsi0-0-1,boot=3Don -device scsi-dis=
k,bus=3Dscsi0.0,scsi-id=3D1,drive=3Ddrive-scsi0-0-1,id=3Dscsi0-0-1 -drive f=
ile=3D/data/testserver-a-data1.img,if=3Dnone,id=3Ddrive-virtio-disk1 -devic=
e virtio-blk-pci,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk1,id=3Dvir=
tio-disk1 -drive file=3D/data/testserver-a-data2.img,if=3Dnone,id=3Ddrive-v=
irtio-disk2 -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x5,drive=3Ddrive-vir=
tio-disk2,id=3Dvirtio-disk2 -drive file=3D/data/gentoo-install-amd64-minima=
l-20100408.iso,if=3Dnone,media=3Dcdrom,id=3Ddrive-ide0-0-0,readonly=3Don -d=
evice ide-drive,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0 -=
drive file=3D/data/testserver-a_configfloppy.img,if=3Dnone,id=3Ddrive-fdc0-=
0-0 -global isa-fdc.driveA=3Ddrive-fdc0-0-0 -device e1000,vlan=3D0,id=3Dnet=
0,mac=3D52:54:00:84:6d:69,bus=3Dpci.0,addr=3D0x6 -net tap,fd=3D24,vlan=3D0,=
name=3Dhostnet0 -usb -vnc 127.0.0.1:1,password -k de -vga cirrus -device vi=
rtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3
  ----- snip -----

  Copy-pasting this to a commandline on the host to start qemu manually
  leads to a non-functional qemu process that "just sits there" with
  nothing happening. The monitor socket
  /usr/local/var/lib/libvirt/qemu/testserver-a.monitor will, indeed, not
  show up.

  I've tried starting qemu with the same commandline but without the
  parameters for redirecting the monitor to a socket, without the fd
  parameter for the network interface and without the vnc parameter.
  This resulted in a black window with the title "QEMU (testserver-a)
  [Stopped]". I could not access the monitor console in graphical mode
  either. When I press Ctrl-Alt-2 in graphical mode to access the
  monitor console, qemu will sometimes (but not always) crash with a
  segfault about 2 seconds after.

  Some experimentation I've done suggests that this problem only happens
  if the high cpu load is caused by another qemu process, not if it is
  caused by something else running on the machine.

  The bug appears much less often if I leave off the -nodefaults
  parameter.

  The bug will still appear if I start qemu as qemu-system-x86_64
  instead of qemu-kvm and replace the -enable-kvm parameter with -no-
  kvm.

  The host machine I'm running this on has got 16 cores in total. It
  looks like it is sufficient for this bug to surface if at least one of
  these cores is brought to near 100% use by a qemu process.

  The version of qemu I'm using is qemu-kvm 0.12.4, built from source.
  Libvirt is version 0.8.1, built from source as well. The host OS is
  Fedora 12. The Kernel version is 2.6.32.12-115.fc12.x86_64.

  Attached is an strace of attempting to start qemu which I hope will
  help someone with a better understanding of qemu's internals see
  what's actually going on there.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/607204/+subscriptions
