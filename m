Received: from eggs.gnu.org ([2001:4830:134:3::10]:59475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqbMR-0006zS-38
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqbML-0002tv-F8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:15:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:51312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eqbML-0002qQ-5N
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:15:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eqbMJ-0005OG-9G
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:15:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1ED892E80E0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:15:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Feb 2018 09:06:14 -0000
From: Andrew Cloke <andrew.cloke@canonical.com>
Reply-To: Bug 1752026 <1752026@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151972202137.6440.8981390592966927838.malonedeb@soybean.canonical.com>
Message-Id: <151972237493.742.155565648152765892.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1752026] Re: Ubuntu18.04:POWER9:DD2.2 - Unable to
 start a KVM guest with default machine type(pseries-bionic) complaining
 "KVM implementation does not support Transactional Memory,
 try cap-htm=off" (kvm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: qemu
   Importance: Undecided
       Status: New

** No longer affects: qemu

** Also affects: ubuntu-power-systems
   Importance: Undecided
       Status: New

** Changed in: ubuntu-power-systems
   Importance: Undecided =3D> Critical

** Changed in: ubuntu-power-systems
     Assignee: (unassigned) =3D> Canonical Kernel Team (canonical-kernel-te=
am)

** Tags added: triage-g

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1752026

Title:
  Ubuntu18.04:POWER9:DD2.2 - Unable to start a KVM guest with default
  machine type(pseries-bionic) complaining "KVM implementation does not
  support Transactional Memory, try cap-htm=3Doff" (kvm)

Status in The Ubuntu-power-systems project:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  =3D=3D Comment: #0 - Satheesh Rajendran <satheera@in.ibm.com> - 2018-02-2=
3 08:31:06 =3D=3D
  ---Problem Description---
  libvirt unable to start a KVM guest complaining about cap-htm machine pro=
perty to be off

  Host Env:
  # lscpu
  Architecture:        ppc64le
  Byte Order:          Little Endian
  CPU(s):              160
  On-line CPU(s) list: 0-159
  Thread(s) per core:  4
  Core(s) per socket:  20
  Socket(s):           2
  NUMA node(s):        2
  Model:               2.2 (pvr 004e 1202)
  Model name:          POWER9 (raw), altivec supported
  CPU max MHz:         3800.0000
  CPU min MHz:         2166.0000
  L1d cache:           32K
  L1i cache:           32K
  L2 cache:            512K
  L3 cache:            10240K
  NUMA node0 CPU(s):   0-79
  NUMA node8 CPU(s):   80-159

  ii  qemu-kvm                                      1:2.11+dfsg-1ubuntu2
  ppc64el      QEMU Full virtualization on x86 hardware

  ii  libvirt-bin                                   4.0.0-1ubuntu3
  ppc64el      programs for the libvirt library

  # lsmcode
  Version of System Firmware : =

   Product Name          : OpenPOWER Firmware
   Product Version       : open-power-SUPERMICRO-P9DSU-V1.03-20180205-imp
   Product Extra         : 	occ-577915f
   Product Extra         : 	skiboot-v5.9-240-g081882690163-pcbedce4
   Product Extra         : 	petitboot-v1.6.6-p019c87e
   Product Extra         : 	sbe-095e608
   Product Extra         : 	machine-xml-fb5f933
   Product Extra         : 	hostboot-9bfb201
   Product Extra         : 	linux-4.14.13-openpower1-p78d7eee

  =

   =

  Contact Information =3D satheera@in.ibm.com =

   =

  ---uname output---
  4.15.0-10-generic
   =

  Machine Type =3D power9 boston 2.2 (pvr 004e 1202) =

   =

  ---Debugger---
  A debugger is not configured
   =

  ---Steps to Reproduce---
   1. Boot a guest from libvirt with default pseries machine type or pserie=
s-bionic

  /usr/bin/virt-install --connect=3Dqemu:///system --hvm --accelerate --nam=
e 'virt-tests-vm1' --machine pseries --memory=3D32768 --vcpu=3D32,sockets=
=3D1,cores=3D32,threads=3D1 --import --nographics --serial pty --memballoon=
 model=3Dvirtio --controller type=3Dscsi,model=3Dvirtio-scsi --disk path=3D=
/var/lib/libvirt/images/workspace/runAvocadoFVTTest/avocado-fvt-wrapper/dat=
a/avocado-vt/images/ubuntu-18.04-ppc64le.qcow2,bus=3Dscsi,size=3D10,format=
=3Dqcow2 --network=3Dbridge=3Dvirbr0,model=3Dvirtio,mac=3D52:54:00:77:78:79=
 --noautoconsole
  WARNING  No operating system detected, VM performance may suffer. Specify=
 an OS with --os-variant for optimal results.

  Starting install...
  ERROR    internal error: process exited while connecting to monitor: ,id=
=3Dscsi0-0-0-0,bootindex=3D1 -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,v=
hostfd=3D26 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:=
00:77:78:79,bus=3Dpci.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device sp=
apr-vty,chardev=3Dcharserial0,id=3Dserial0,reg=3D0x30000000 -device virtio-=
balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don
  2018-02-23T14:21:11.081809Z qemu-system-ppc64: KVM implementation does no=
t support Transactional Memory, try cap-htm=3Doff
  Domain installation does not appear to have been successful.
  If it was, you can restart your domain by running:
    virsh --connect qemu:///system start virt-tests-vm1
  otherwise, please restart your installation.

  2. Fails to boot..

  Note: if we specify machine type as pseries=3D2.12 it boots fine like
  below

  /usr/bin/virt-install --connect=3Dqemu:///system --hvm --accelerate --nam=
e 'virt-tests-vm1' --machine pseries-2.12 --memory=3D32768 --vcpu=3D32,sock=
ets=3D1,cores=3D32,threads=3D1 --import --nographics --serial pty --memball=
oon model=3Dvirtio --controller type=3Dscsi,model=3Dvirtio-scsi --disk path=
=3D/var/lib/libvirt/images/workspace/runAvocadoFVTTest/avocado-fvt-wrapper/=
data/avocado-vt/images/ubuntu-18.04-ppc64le.qcow2,bus=3Dscsi,size=3D10,form=
at=3Dqcow2 --network=3Dbridge=3Dvirbr0,model=3Dvirtio,mac=3D52:54:00:77:78:=
79 --noautoconsole
  WARNING  No operating system detected, VM performance may suffer. Specify=
 an OS with --os-variant for optimal results.

  qemu-cmd line:

  libvirt+   4283      1 99 09:26 ?        00:00:38 qemu-system-ppc64
  -enable-kvm -name guest=3Dvirt-tests-vm1,debug-threads=3Don -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-4
  -virt-tests-vm1/master-key.aes -machine pseries-2.12,accel=3Dkvm,usb=3Doff
  ,dump-guest-core=3Doff -m 32768 -realtime mlock=3Doff -smp
  32,sockets=3D1,cores=3D32,threads=3D1 -uuid
  108ac2b5-e8b2-4399-a925-a707e8020871 -display none -no-user-config
  -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-4-virt-tests-
  vm1/monitor.sock,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shu=
tdown
  -boot strict=3Don -device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x3 -devi=
ce
  virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x2 -drive
  file=3D/var/lib/libvirt/images/workspace/runAvocadoFVTTest/avocado-fvt-
  wrapper/data/avocado-
  vt/images/ubuntu-18.04-ppc64le.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-
  scsi0-0-0-0 -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-
  id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1 -=
netdev
  tap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhostfd=3D26 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:77:78:79,bus=3Dpci.0,addr=
=3D0x1
  -chardev pty,id=3Dcharserial0 -device spapr-
  vty,chardev=3Dcharserial0,id=3Dserial0,reg=3D0x30000000 -device virtio-
  balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don

   =

  Userspace tool common name: ii  libvirt-bin                              =
     4.0.0-1ubuntu3                       ppc64el      programs for the lib=
virt library =

   =

  The userspace tool has the following bit modes: both =


  Userspace rpm: ii  libvirt-bin
  4.0.0-1ubuntu3                       ppc64el      programs for the
  libvirt library

  Userspace tool obtained from project website:  na =

   =

  *Additional Instructions for satheera@in.ibm.com: =

  -Post a private note with access information to the machine that the bug =
is occuring on.
  -Attach ltrace and strace of userspace application.

  =3D=3D Comment: #1 - Satheesh Rajendran <satheera@in.ibm.com> - 2018-02-2=
3 08:35:17 =3D=3D
  vm qemu log for failed and passed cases:

  Failed:(pseries-bionic)
  2018-02-23 14:21:10.806+0000: starting up libvirt version: 4.0.0, package=
: 1ubuntu3 (Christian Ehrhardt <christian.ehrhardt@canonical.com> Mon, 19 F=
eb 2018 14:18:44 +0100), qemu version: 2.11.1(Debian 1:2.11+dfsg-1ubuntu2),=
 hostname: ltc-boston8.aus.stglabs.ibm.com
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/kvm -name guest=3Dvirt-tests-vm1,debug=
-threads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/li=
b/libvirt/qemu/domain-3-virt-tests-vm1/master-key.aes -machine pseries-bion=
ic,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 32768 -realtime mlock=3Do=
ff -smp 32,sockets=3D1,cores=3D32,threads=3D1 -uuid 36c37d3b-fb24-4350-94f9=
-3271b257f75c -display none -no-user-config -nodefaults -chardev socket,id=
=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-3-virt-tests-vm1/monitor=
.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol =
-rtc base=3Dutc -no-shutdown -boot strict=3Don -device qemu-xhci,id=3Dusb,b=
us=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=
=3D0x2 -drive file=3D/var/lib/libvirt/images/workspace/runAvocadoFVTTest/av=
ocado-fvt-wrapper/data/avocado-vt/images/ubuntu-18.04-ppc64le.qcow2,format=
=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device scsi-hd,bus=3Dscsi0.0,cha=
nnel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,boo=
tindex=3D1 -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhostfd=3D26 -devic=
e virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:77:78:79,bus=3D=
pci.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device spapr-vty,chardev=3D=
charserial0,id=3Dserial0,reg=3D0x30000000 -device virtio-balloon-pci,id=3Db=
alloon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don
  2018-02-23T14:21:10.909242Z qemu-system-ppc64: -chardev pty,id=3Dcharseri=
al0: char device redirected to /dev/pts/1 (label charserial0)
  2018-02-23T14:21:11.081809Z qemu-system-ppc64: KVM implementation does no=
t support Transactional Memory, try cap-htm=3Doff
  2018-02-23 14:21:18.857+0000: shutting down, reason=3Dfailed

  =

  Passed:(pseries-2.12)
  2018-02-23 14:26:07.047+0000: starting up libvirt version: 4.0.0, package=
: 1ubuntu3 (Christian Ehrhardt <christian.ehrhardt@canonical.com> Mon, 19 F=
eb 2018 14:18:44 +0100), qemu version: 2.11.1(Debian 1:2.11+dfsg-1ubuntu2),=
 hostname: ltc-boston8.aus.stglabs.ibm.com
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/kvm -name guest=3Dvirt-tests-vm1,debug=
-threads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/li=
b/libvirt/qemu/domain-4-virt-tests-vm1/master-key.aes -machine pseries-2.12=
,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 32768 -realtime mlock=3Doff=
 -smp 32,sockets=3D1,cores=3D32,threads=3D1 -uuid 108ac2b5-e8b2-4399-a925-a=
707e8020871 -display none -no-user-config -nodefaults -chardev socket,id=3D=
charmonitor,path=3D/var/lib/libvirt/qemu/domain-4-virt-tests-vm1/monitor.so=
ck,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rt=
c base=3Dutc -no-shutdown -boot strict=3Don -device qemu-xhci,id=3Dusb,bus=
=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0=
x2 -drive file=3D/var/lib/libvirt/images/workspace/runAvocadoFVTTest/avocad=
o-fvt-wrapper/data/avocado-vt/images/ubuntu-18.04-ppc64le.qcow2,format=3Dqc=
ow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device scsi-hd,bus=3Dscsi0.0,channel=
=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootind=
ex=3D1 -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhostfd=3D26 -device vi=
rtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:77:78:79,bus=3Dpci.=
0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device spapr-vty,chardev=3Dchar=
serial0,id=3Dserial0,reg=3D0x30000000 -device virtio-balloon-pci,id=3Dballo=
on0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don
  2018-02-23T14:26:07.116991Z qemu-system-ppc64: -chardev pty,id=3Dcharseri=
al0: char device redirected to /dev/pts/1 (label charserial0)

  Regards,
  -Satheesh

  =3D=3D Comment: #8 - VIPIN K. PARASHAR <viparash@in.ibm.com> - 2018-02-25=
 23:38:29 =3D=3D
  Starting install...
  ERROR    internal error: process exited while connecting to monitor: ,id=
=3Dscsi0-0-0-0,bootindex=3D1 -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,v=
hostfd=3D26 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:=
00:77:78:79,bus=3Dpci.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device sp=
apr-vty,chardev=3Dcharserial0,id=3Dserial0,reg=3D0x30000000 -device virtio-=
balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don
  2018-02-23T14:21:11.081809Z qemu-system-ppc64: KVM implementation does no=
t support Transactional Memory, try cap-htm=3Doff
  Domain installation does not appear to have been successful.
  If it was, you can restart your domain by running:
    virsh --connect qemu:///system start virt-tests-vm1
  otherwise, please restart your installation.

  As per above message, qemu is reporting TM to be not supported by KVM on =
this hardware
  and thus recommending to turn off cap-htm.

  =3D=3D Comment: #12 - Suraj Jitindar Singh <surajjs@au1.ibm.com> - 2018-0=
2-26 23:35:02 =3D=3D
  I don't know what a pseries-bionic is, there is no reference to it upstre=
am.

  What you are seeing is expected behaviour as far as I can tell. POWER9
  currently does not support HTM for a guest and thus it must not be
  turned on, otherwise qemu will fail to start.

  HTM can be disabled from the qemu command line by setting cap-htm=3Doff,
  as stated in the the error message. The pseries-2.12 machine type has
  htm disabled by default and thus with that machine type there is no
  requirement to set cap-htm=3Doff on the command line to get qemu to
  start.

  So depending on what machine pseries-bionic is based on it will be
  required to disable htm on the command line (with cap-htm=3Doff) if it
  is not disabled by default for the machine.

  =3D=3D Comment: #13 - Satheesh Rajendran <satheera@in.ibm.com> - 2018-02-=
27 00:05:12 =3D=3D
  Had a chat with Suraj and here is the summary

  1. Currently Power9 DD2.2(host kernel) does not support HTM, so guest sho=
uld be booted with cap-htm=3Doff, looks like host kernel patch rework in pr=
ogress--> Initial patch, https://www.spinics.net/lists/kvm-ppc/msg13378.html
  2. Libvirt does not know about this cap-htm yet and currently it does not=
 set any default values?
  3. pseries-2.12 does have cap-htm=3Doff by default but not the older mach=
ine types, so we see the guest is booting from libvirt with pseries-2.12
  4. Once 1 is fixed, we can boot cap-htm=3Don, I guess by that time pserie=
s-2.12 to be changed to cap-htm=3Don bydefault.

  ---> 3. Immediate fix can be Canonical defaults their machine type(pserie=
s-bioic) to pseries-2.12...
  ---> Future 1 and 4 to be addressed, not sure about 2?

  Needs a mirror to Canonical to address this.

  Regards,
  -Satheesh

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu-power-systems/+bug/1752026/+subscriptions
