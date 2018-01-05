Received: from eggs.gnu.org ([2001:4830:134:3::10]:47389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXXYN-0001rF-Cd
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXXYK-0007c8-38
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:21:19 -0500
Received: from indium.canonical.com ([91.189.90.7]:39288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eXXYJ-0007au-Dr
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 14:21:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eXXYH-0004Wt-GU
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:21:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 799E52E807D
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 19:21:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jan 2018 19:13:30 -0000
From: David Moreau Simard <dms@redhat.com>
Reply-To: Bug 1731957 <1731957@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151058776720.8536.5546556835888911638.malonedeb@wampee.canonical.com>
Message-Id: <151517961035.3599.11428520408897099966.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1731957] Re: qemu-kvm exits with console
 permission problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These might be helpful or related:
- https://bugzilla.redhat.com/show_bug.cgi?id=3D1499800
- https://bugzilla.redhat.com/show_bug.cgi?id=3D1501957

** Bug watch added: Red Hat Bugzilla #1499800
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1499800

** Bug watch added: Red Hat Bugzilla #1501957
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1501957

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1731957

Title:
  qemu-kvm exits with console permission problems

Status in QEMU:
  New

Bug description:
  # rpm -qa | grep qemu
  qemu-img-ev-2.9.0-16.el7_4.8.1.x86_64
  qemu-kvm-ev-2.9.0-16.el7_4.8.1.x86_64
  ipxe-roms-qemu-20170123-1.git4e85b27.el7_4.1.noarch
  libvirt-daemon-driver-qemu-3.2.0-14.el7_4.3.x86_64
  qemu-kvm-common-ev-2.9.0-16.el7_4.8.1.x86_64

  qemu.conf:
  stdio_handler =3D "file"

  libvirtd runs as root with '/usr/sbin/libvirtd --listen'

  we run openstack, it creates an instance like this:

  2017-11-13 15:17:14.143+0000: starting up libvirt version: 3.2.0, package=
: 14.el7_4.3 (Unknown, 2017-09-05-02:55:29, x86-ol7-builder
  -02.us.oracle.com), qemu version: 2.9.0(qemu-kvm-ev-2.9.0-16.el7_4.8.1), =
hostname: compute6
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin HOME=3D/root QEMU_AUDIO_DRV=3Dnone /usr/libexec/qemu-kvm -name guest=
=3Dinstance-00000016,debug-threads=3Don -S -object secret,id=3DmasterKey0,f=
ormat=3Draw,file=3D/var/lib/libvirt/qemu/domain-1-instance-00000016/master-=
key.aes -machine pc-i440fx-rhel7.4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=
=3Doff -cpu Haswell-noTSX,vme=3Don,ss=3Don,f16c=3Don,rdrand=3Don,hypervisor=
=3Don,arat=3Don,tsc_adjust=3Don,xsaveopt=3Don,abm=3Don,invpcid=3Doff -m 64 =
-realtime mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid 48ea95=
7f-6fbc-4b43-83c8-8c5e83a2ffdf -smbios 'type=3D1,manufacturer=3DOpenStack F=
oundation,product=3DOpenStack Nova,version=3D13.0.0,serial=3Dde115ee2-a86f-=
432d-96fe-bec91b0a5748,uuid=3D48ea957f-6fbc-4b43-83c8-8c5e83a2ffdf,family=
=3DVirtual Machine' -no-user-config -nodefaults -chardev socket,id=3Dcharmo=
nitor,path=3D/var/lib/libvirt/qemu/domain-1-instance-00000016/monitor.sock,=
server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc b=
ase=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpet=
 -no-shutdown -boot
   strict=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -=
drive file=3D/var/lib/nova/instances/48ea957f-6fbc-4b43-83c8-8c5e83a2ffdf/d=
isk,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone -device v=
irtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,=
id=3Dvirtio-disk0,bootindex=3D1 -netdev tap,fd=3D26,id=3Dhostnet0,vhost=3Do=
n,vhostfd=3D27 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:=
16:3e:bf:f5:40,bus=3Dpci.0,addr=3D0x3 -chardev pty,id=3Dcharserial0,logfile=
=3D/var/lib/nova/instances/48ea957f-6fbc-4b43-83c8-8c5e83
  a2ffdf/console.log,logappend=3Doff -device isa-serial,chardev=3Dcharseria=
l0,id=3Dserial0 -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.=
0.0.0:1 -k en-us -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -dev=
ice virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -msg =

  timestamp=3Don

  With older qemu like 2.5 or 2.6 console log belongs to qemu:qemu and the =
process starts successfully.
  With 2.9 it fails and console.log is left root:root :

  2017-11-13 15:17:14.173+0000: 26010: debug : qemuProcessHook:2738 : Hook =
complete ret=3D0
  2017-11-13 15:17:14.173+0000: 26010: debug : virExec:699 : Done hook 0
  2017-11-13 15:17:14.173+0000: 26010: debug : virExec:736 : Setting child =
uid:gid to 42427:42427 with caps 0
  2017-11-13 15:17:14.173+0000: 26010: debug : virCommandHandshakeChild:435=
 : Notifying parent for handshake start on 29
  2017-11-13 15:17:14.173+0000: 26010: debug : virCommandHandshakeChild:443=
 : Waiting on parent for handshake complete on 30
  2017-11-13 15:17:14.192+0000: 26010: debug : virFileClose:110 : Closed fd=
 29
  2017-11-13 15:17:14.192+0000: 26010: debug : virFileClose:110 : Closed fd=
 30
  2017-11-13 15:17:14.192+0000: 26010: debug : virCommandHandshakeChild:463=
 : Handshake with parent is done
  2017-11-13T15:17:14.232713Z qemu-kvm: -chardev pty,id=3Dcharserial0,logfi=
le=3D/var/lib/nova/instances/48ea957f-6fbc-4b43-83c8-8c5e83a2ffdf/console.l=
og,logappend=3Doff: Unable to open logfile /var/lib/nova/instances/48ea957f=
-6fbc-4b43-83c8-8c5e83a2ffdf/console.log: Permission denied
  2017-11-13 15:17:14.321+0000: shutting down, reason=3Dfailed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1731957/+subscriptions
