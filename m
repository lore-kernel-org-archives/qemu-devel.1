Received: from eggs.gnu.org ([2001:4830:134:3::10]:37123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdfc4-0004EO-TX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdfc0-0005nl-Nl
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:05:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:38892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdfc0-0005nJ-G5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:05:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdfbx-0002Wh-WD
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 16:05:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E005C2E80D9
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 16:05:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Feb 2017 15:45:48 -0000
From: Rafael David Tinoco <rafael.tinoco@canonical.com>
Reply-To: Bug 1455475 <1455475@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150515121048.26278.39911.malonedeb@gac.canonical.com>
Message-Id: <20170214154548.29722.5351.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1455475] Re: Block Commit: [100 %]error: failed
 to pivot job for disk vda
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

*** This bug is a duplicate of bug 1317491 ***
    https://bugs.launchpad.net/bugs/1317491

Upstream "fixed" the issue - by finishing "block-commit" - in v1.3. That
is why I'm marking this bug as a duplicate of the Ubuntu bug. I'll
provide more comments in that bug.

** This bug has been marked a duplicate of bug 1317491
   virsh blockcommit hangs at 100%

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1455475

Title:
  Block Commit: [100 %]error: failed to pivot job for disk vda

Status in QEMU:
  New
Status in Ubuntu:
  Confirmed

Bug description:
  Hi,

  i=C2=B4ve a Problem with committing a snapshot. The problem was discussed
  on the libvirt mailing list earlier this year.

  https://www.redhat.com/archives/libvirt-
  users/2015-January/msg00029.html

  =

  Iam running gentoo and:

  Compiled against library: libvirt 1.2.14
  Using library: libvirt 1.2.14
  Using API: QEMU 1.2.14
  Running hypervisor: QEMU 2.3.0

  I=C2=B4am running a Windows Server 2012 R2 VM with the latest quest driver
  (0.1.96) and  QEMU quest Agent 0.12.1 installed.

  The domain is started with following command line:

  /usr/bin/qemu-system-x86_64 -name $DOMAIN -S -machine pc-i440fx-1.6,accel=
=3Dkvm,usb=3Doff -m 8192 -realtime mlock=3Doff -smp 8,sockets=3D8,cores=3D1=
,threads=3D1 -uuid c96ef576-dbfc-49aa-9dd0-068886c4ef0e -no-user-config -no=
defaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/$DOM=
AIN.monitor,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dco=
ntrol -rtc base=3Dlocaltime -no-shutdown -boot strict=3Don -device piix3-us=
b-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device virtio-serial-pci,id=3Dv=
irtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive file=3D/var/lib/libvirt/images/=
$DOMAIN.qcow2,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2 -device virt=
io-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-virtio-disk0,id=
=3Dvirtio-disk0,bootindex=3D1 -netdev tap,fd=3D25,id=3Dhostnet0,vhost=3Don,=
vhostfd=3D26 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54=
:00:07:b4:0a,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0 -device i=
sa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev socket,id=3Dcharchann=
el0,path=3D/var/lib/libvirt/qemu/f16x86_64.agent,server,nowait -device virt=
serialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchanne=
l0,name=3Dorg.qemu.guest_agent.0 -device usb-tablet,id=3Dinput0 -vnc 127.0.=
0.1:6 -k de -device VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x5 -=
device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timesta=
mp=3Don
  char device redirected to /dev/pts/2 (label charserial0)

  =

  I=C2=B4ve created the snapshot with:

  virsh # snapshot-create-as --domain $DOMAIN snap1 --diskspec vda,file=3D/=
var/lib/libvirt/images/snap1.qcow2 --quiesce --disk-only --atomic --no-meta=
data
  Domain snapshot snap1 created

  If i try to commit the snapshot i get this error:

  virsh # blockcommit $DOMAIN vda --active --verbose --pivot
  error: internal error: unable to execute QEMU command 'block-commit': Dev=
ice 'drive-virtio-disk0' is busy: block device is in use by block job: comm=
it

  =

  virsh # blockjob $DOMAIN /var/lib/libvirt/images/snap1.qcow2
  Block Commit: [100 %]

  virsh # $DOMAIN var/lib/libvirt/images/snap1.qcow2 --abort

  virsh # blockjob $DOMAIN /var/lib/libvirt/images/snap1.qcow2
  No current block job for /var/lib/libvirt/images/snap1.qcow2

  =

  I=C2=B4ve test this with qemu 2.1 and the problem does`nt exist.

  /usr/bin/qemu-system-x86_64 -name $DOMAIN -S -machine pc-
  i440fx-1.6,accel=3Dkvm,usb=3Doff -m 8192 -realtime mlock=3Doff -smp
  8,sockets=3D8,cores=3D1,threads=3D1 -uuid 30c49f37-6e62-49f6-a9df-
  ad2fef1fa312 -no-user-config -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/$DOMAIN.monitor,serv=
er,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dlocalt=
ime
  -no-shutdown -boot strict=3Don -device piix3-usb-
  uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device virtio-serial-pci,id
  =3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x6 -drive
  file=3D/var/lib/libvirt/images/$DOMAIN.qcow2,if=3Dnone,id=3Ddrive-virtio-
  disk0,format=3Dqcow2 -device virtio-blk-
  pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-virtio-disk0,id=3Dvir=
tio-
  disk0,bootindex=3D1 -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  socket,id=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/f16x86_64.agent,ser=
ver,nowait
  -device virtserialport,bus=3Dvirtio-
  serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.gue=
st_agent.0
  -device usb-tablet,id=3Dinput0 -vnc 127.0.0.1:0 -k de -device
  VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x5 -device virtio-ball=
oon-
  pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don


  Compiled against library: libvirt 1.2.11
  Using library: libvirt 1.2.11
  Using API: QEMU 1.2.11
  Running hypervisor: QEMU 2.1.2

  =

  virsh # snapshot-create-as --domain windows.trohde-snapshot-test windows.=
trohde-snapshot-test_snap1 --diskspec vda,file=3D/var/lib/libvirt/images/wi=
ndows.trohde-snapshot-test_snap1.qcow2 --quiesce --disk-only --atomic --no-=
metadata
  Domain snapshot windows.trohde-snapshot-test_snap1 created

  virsh # blockcommit $DOMAIN vda --active --verbose --pivot
  Block Commit: [100 %]
  Successfully pivoted

  Cheers

  Tim

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1455475/+subscriptions
