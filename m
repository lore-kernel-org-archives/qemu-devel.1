Received: from eggs.gnu.org ([2001:4830:134:3::10]:46021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvbfV-0005S2-KW
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 01:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvbSC-0008A4-GI
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 00:54:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:54574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvbSC-00089C-7c
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 00:54:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvbSB-0004E6-CZ
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 04:54:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 548892E80CC
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 04:54:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Aug 2018 04:41:41 -0000
From: Thomas Huth <1495380@bugs.launchpad.net>
Reply-To: Bug 1495380 <1495380@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150914061958.23529.20211.malonedeb@chaenomeles.canonical.com>
Message-Id: <153569050132.20411.1552415018902830709.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1495380] Re: Invalid parameter 'queues'.
 multi-queue vhost-user backends does not work.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1495380

Title:
  Invalid parameter 'queues'. multi-queue vhost-user backends does not
  work.

Status in QEMU:
  Incomplete

Bug description:
  The command line which I use:
  /usr/bin/qemu-system-x86_64 -name instance-00000006 -S -machine pc-i440fx=
-2.4,accel=3Dkvm,usb=3Doff -cpu Haswell-noTSX,+abm,+pdpe1gb,+rdrand,+f16c,+=
osxsave,+pdcm,+xtpr,+tm2,+est,+smx,+vmx,+ds_cpl,+monitor,+dtes64,+pbe,+tm,+=
ht,+ss,+acpi,+ds,+vme -m 1024 -realtime mlock=3Doff -smp 1,sockets=3D1,core=
s=3D1,threads=3D1 -object memory-backend-file,id=3Dram-node0,prealloc=3Dyes=
,mem-path=3D/hugepages/libvirt/qemu,share=3Dyes,size=3D1073741824 -numa nod=
e,nodeid=3D0,cpus=3D0,memdev=3Dram-node0 -uuid 54d61ffc-c8cf-4227-9610-96bc=
f1590984 -smbios type=3D1,manufacturer=3DOpenStack,product=3DOpenStack,vers=
ion=3D2014.1.3,serial=3D44454c4c-3300-1043-804c-b5c04f463532,uuid=3D54d61ff=
c-c8cf-4227-9610-96bcf1590984 -no-user-config -nodefaults -mon chardev=3Dch=
armonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -glob=
al kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=3D=
on -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=
=3D/var/lib/nova/instances/54d61ffc-c8cf-4227-9610-96bcf1590984/disk,if=3Dn=
one,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnone -device virtio-blk-=
pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=3Dvirti=
o-disk0,bootindex=3D1 -chardev socket,id=3Dcharnet0,path=3D/var/run/vrouter=
/uvh_vif_tap35abd3c0-4f -netdev type=3Dvhost-user,id=3Dhostnet0,chardev=3Dc=
harnet0,queues=3D5 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mq=3D=
on,mac=3D02:35:ab:d3:c0:4f,bus=3Dpci.0,mq=3Don,addr=3D0x3 -chardev file,id=
=3Dcharserial0,path=3D/var/lib/nova/instances/54d61ffc-c8cf-4227-9610-96bcf=
1590984/console.log -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -=
chardev pty,id=3Dcharserial1 -device isa-serial,chardev=3Dcharserial1,id=3D=
serial1 -device usb-tablet,id=3Dinput0 -vnc 10.10.6.14:0 -k en-us -device c=
irrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device virtio-balloon-pci,id=
=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -msg timestamp=3Don

  The error information :
  2015-09-14T06:16:05.914264Z qemu-system-x86_64: -netdev type=3Dvhost-user=
,id=3Dhostnet0,chardev=3Dcharnet0,queues=3D5: Invalid parameter 'queues'

  qemu version:
  root@ubuntu:~# qemu-system-x86_64 --version
  QEMU emulator version 2.4.0, Copyright (c) 2003-2008 Fabrice Bellard
  root@ubuntu:~# =


  ubuntu version:
  root@ubuntu:~# lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 14.04.1 LTS
  Release:        14.04
  Codename:       trusty
  root@ubuntu:~# =


  kernel version:
  root@ubuntu:~# uname -a
  Linux ubuntu 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15 03:51:08 UTC 201=
4 x86_64 x86_64 x86_64 GNU/Linux
  root@ubuntu:~#

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1495380/+subscriptions
