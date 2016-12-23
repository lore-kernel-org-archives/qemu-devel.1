Received: from eggs.gnu.org ([2001:4830:134:3::10]:39061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKKmx-0001Ph-BP
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 03:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cKKms-0008Ly-DR
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 03:01:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:57877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cKKms-0008Kv-5L
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 03:01:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cKKmp-0006ZR-Rh
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 08:01:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CFD262E80CC
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 08:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Dec 2016 07:47:26 -0000
From: Thomas Huth <1652011@bugs.launchpad.net>
Reply-To: Bug 1652011 <1652011@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161222104842.1045.42075.malonedeb@soybean.canonical.com>
Message-Id: <20161223074726.2232.29444.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1652011] Re: VM shuts down due to error in qemu
 block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Please do not report distribution specific bugs (since you're using
qemu-kvm 2.0.0+dfsg-2ubuntu1.27) against the QEMU project bugtracker -
use the distribution's bugtracker instead.

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1652011

Title:
  VM shuts down due to error in qemu block.c

Status in qemu package in Ubuntu:
  New

Bug description:
  On a Trusty KVM host one of the guest VMs shut down without any user
  interaction. The system is running:

  $ cat /etc/lsb-release
  DISTRIB_ID=3DUbuntu
  DISTRIB_RELEASE=3D14.04
  DISTRIB_CODENAME=3Dtrusty
  DISTRIB_DESCRIPTION=3D"Ubuntu 14.04.5 LTS"

  $ dpkg -l libvirt0 qemu-kvm qemu-system-common qemu-system-x86
  Desired=3DUnknown/Install/Remove/Purge/Hold
  | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Tr=
ig-pend
  |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
  ||/ Name                                                         Version =
                            Architecture                        Description
  +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  ii  libvirt0                                                     1.2.2-0u=
buntu13.1.17                amd64                               library for=
 interfacing with different virtualization systems
  ii  qemu-kvm                                                     2.0.0+df=
sg-2ubuntu1.27              amd64                               QEMU Full v=
irtualization
  ii  qemu-system-common                                           2.0.0+df=
sg-2ubuntu1.27              amd64                               QEMU full s=
ystem emulation binaries (common files)
  ii  qemu-system-x86                                              2.0.0+df=
sg-2ubuntu1.27              amd64                               QEMU full s=
ystem emulation binaries (x86)

  In the VMs log in /var/lib/libvirt/qemu/hostname we see:

  2016-11-17 09:18:42.603+0000: starting up
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/kvm -name hostname,process=3Dqemu:host=
name -S -machine pc-i440fx-trusty,accel=3Dkvm,usb=3Doff -m 12697 -realtime =
mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -uuid 51766564-ed8e-41=
aa-91b5-574220af4ac3 -no-user-config -nodefaults -chardev socket,id=3Dcharm=
onitor,path=3D/var/lib/libvirt/qemu/hostname.monitor,server,nowait -mon cha=
rdev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown=
 -boot strict=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0=
x2 -drive file=3D/dev/disk1/hostname,if=3Dnone,id=3Ddrive-virtio-disk0,form=
at=3Draw -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Dd=
rive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/dev/disk2/=
hostname_mnt_data,if=3Dnone,id=3Ddrive-virtio-disk1,format=3Draw -device vi=
rtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x5,drive=3Ddrive-virtio-disk1,i=
d=3Dvirtio-disk1 -drive file=3D/dev/disk1/hostname_tmp,if=3Dnone,id=3Ddrive=
-virtio-disk2,format=3Draw -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,ad=
dr=3D0x8,drive=3Ddrive-virtio-disk2,id=3Dvirtio-disk2 -netdev tap,fd=3D24,i=
d=3Dhostnet0,vhost=3Don,vhostfd=3D30 -device virtio-net-pci,tx=3Dbh,netdev=
=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:45:e7:d9,bus=3Dpci.0,addr=3D0x6 -netde=
v tap,fd=3D31,id=3Dhostnet1,vhost=3Don,vhostfd=3D32 -device virtio-net-pci,=
tx=3Dbh,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:f6:6c:77,bus=3Dpci.0,add=
r=3D0x7 -chardev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharseri=
al0,id=3Dserial0 -device usb-tablet,id=3Dinput0 -vnc 0.0.0.0:5 -device VGA,=
id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device AC97,id=3Dsound0,bus=3Dpci.0,add=
r=3D0x3 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x9
  char device redirected to /dev/pts/6 (label charserial0)
  qemu-system-x86_64: /build/qemu-PVxDqC/qemu-2.0.0+dfsg/block.c:3491: bdrv=
_error_action: Assertion `error >=3D 0' failed.
  2016-12-22 09:49:49.392+0000: shutting down

  In /var/lib/libvirt/libvirtd.log we see:

  2016-12-22 09:49:49.298+0000: 6946: error : qemuMonitorIO:656 :
  internal error: End of file from monitor

  We investigated to see if this is a known issue and came across a bug
  report for Fedora
  (https://bugzilla.redhat.com/show_bug.cgi?id=3D1147398), but nothing
  references changes upstream that fix this.

  The guest OS is Ubuntu Precise (12.04.5) running kernel linux-
  image-3.2.0-101-virtual 3.2.0-101.141. There wasn't any significant
  load (CPU or IO) on the guest at the time that it shut down and there
  wasn't any appreciable disk IO on the KVM host either. The disks for
  the guest are on the KVM host box.

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1652011/+subscriptions
