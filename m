Received: from eggs.gnu.org ([2001:4830:134:3::10]:52670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNI4t-0008Vm-AD
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fNI4q-0006ky-5A
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:20:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:35992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fNI4p-0006he-S5
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:20:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fNI4o-0001a2-PL
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 13:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B41C92E80CB
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 13:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 May 2018 13:14:16 -0000
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Reply-To: Bug 1773753 <1773753@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152749874146.3829.13327505377905335957.malonedeb@chaenomeles.canonical.com>
Message-Id: <152751325654.24551.12483174297444800514.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1773753] Re: virsh managed save fails with qemu
 version v2.12.0-813-g5a5c383b13-dirty on powerpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

followed by further attempts saves the domains as reported but issue
still same.

#virsh managedsave avocado-vt-vm1

Domain avocado-vt-vm1 state saved by libvirt
# virsh start avocado-vt-vm1 ----hung


# virsh list --all
 Id    Name                           State
----------------------------------------------------
 98    avocado-vt-vm1                 paused

I tried restarting libvirt, after which guest goes to shutoff state,
with reason as crash in the qemu log


# service libvirtd restart
Redirecting to /bin/systemctl restart libvirtd.service

# virsh list --all
 Id    Name                           State
----------------------------------------------------
 -     avocado-vt-vm1                 shut off


2018-05-28 12:59:46.748+0000: starting up libvirt version: 4.4.0, package: =
1.fc28 (Unknown, 2018-05-28-03:15:39, 9.40.192.86), qemu version: 2.12.50v2=
.12.0-813-g5a5c383b13-dirty, kernel: 4.17.0-rc5-00069-g3acf4e395260, hostna=
me: 9.40.192.86
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_AU=
DIO_DRV=3Dnone /usr/share/avocado-plugins-vt/bin/qemu -name guest=3Davocado=
-vt-vm1,debug-threads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,f=
ile=3D/var/lib/libvirt/qemu/domain-97-avocado-vt-vm1/master-key.aes -machin=
e pseries-2.13,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 1024 -realtim=
e mlock=3Doff -smp 2,maxcpus=3D4,sockets=3D4,cores=3D1,threads=3D1 -uuid ba=
3012d5-3244-47d9-bedc-0b60821f7cd1 -display none -no-user-config -nodefault=
s -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-97-a=
vocado-vt-vm1/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmo=
nitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -kernel=
 /home/kvmci/linux/vmlinux -append 'root=3D/dev/sda2 rw console=3Dtty0 cons=
ole=3DttyS0,115200 init=3D/sbin/init initcall_debug' -device qemu-xhci,id=
=3Dusb,bus=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.=
0,addr=3D0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=
=3D0x5 -drive file=3D/var/lib/avocado/data/avocado-vt/images/jeos-27-ppc64l=
e.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device scsi-hd,bus=
=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Ds=
csi0-0-0-0,bootindex=3D1 -netdev tap,fd=3D30,id=3Dhostnet0,vhost=3Don,vhost=
fd=3D32 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:3=
d:3e:3f,bus=3Dpci.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device spapr-=
vty,chardev=3Dcharserial0,id=3Dserial0,reg=3D0x30000000 -chardev socket,id=
=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/avocado-vt-vm1-guest.agent,ser=
ver,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dc=
harchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -device virtio-ball=
oon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -sandbox off -msg timestamp=3D=
on
2018-05-28T12:59:46.826738Z qemu: -chardev pty,id=3Dcharserial0: char devic=
e redirected to /dev/pts/3 (label charserial0)
2018-05-28 13:00:52.948+0000: shutting down, reason=3Dsaved

2018-05-28T13:00:52.950802Z qemu: terminating on signal 15 from pid 41456 (=
/usr/sbin/libvirtd)
2018-05-28 13:01:00.467+0000: starting up libvirt version: 4.4.0, package: =
1.fc28 (Unknown, 2018-05-28-03:15:39, 9.40.192.86), qemu version: 2.12.50v2=
.12.0-813-g5a5c383b13-dirty, kernel: 4.17.0-rc5-00069-g3acf4e395260, hostna=
me: 9.40.192.86
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_AU=
DIO_DRV=3Dnone /usr/share/avocado-plugins-vt/bin/qemu -name guest=3Davocado=
-vt-vm1,debug-threads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,f=
ile=3D/var/lib/libvirt/qemu/domain-98-avocado-vt-vm1/master-key.aes -machin=
e pseries-2.13,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 1024 -realtim=
e mlock=3Doff -smp 2,maxcpus=3D4,sockets=3D4,cores=3D1,threads=3D1 -uuid ba=
3012d5-3244-47d9-bedc-0b60821f7cd1 -display none -no-user-config -nodefault=
s -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-98-a=
vocado-vt-vm1/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmo=
nitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -kernel=
 /home/kvmci/linux/vmlinux -append 'root=3D/dev/sda2 rw console=3Dtty0 cons=
ole=3DttyS0,115200 init=3D/sbin/init initcall_debug' -device qemu-xhci,id=
=3Dusb,bus=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.=
0,addr=3D0x2 -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=
=3D0x5 -drive file=3D/var/lib/avocado/data/avocado-vt/images/jeos-27-ppc64l=
e.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device scsi-hd,bus=
=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Ds=
csi0-0-0-0,bootindex=3D1 -netdev tap,fd=3D31,id=3Dhostnet0,vhost=3Don,vhost=
fd=3D33 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:3=
d:3e:3f,bus=3Dpci.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device spapr-=
vty,chardev=3Dcharserial0,id=3Dserial0,reg=3D0x30000000 -chardev socket,id=
=3Dcharchannel0,path=3D/var/lib/libvirt/qemu/avocado-vt-vm1-guest.agent,ser=
ver,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dc=
harchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 -incoming defer -de=
vice virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -sandbox off -=
msg timestamp=3Don
2018-05-28T13:01:00.546872Z qemu: -chardev pty,id=3Dcharserial0: char devic=
e redirected to /dev/pts/3 (label charserial0)
2018-05-28 13:02:56.434+0000: shutting down, reason=3Dcrashed      <=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1773753

Title:
  virsh managed save fails with qemu version
  v2.12.0-813-g5a5c383b13-dirty on powerpc

Status in QEMU:
  New

Bug description:
  Host Env:
  IBM Power8 with Fedora28 base with compiled upstream kernel, qemu, libvir=
t.

  Host Kernel: 4.17.0-rc5-00069-g3acf4e395260

  qemu-kvm(5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b):
  v2.12.0-813-g5a5c383b13-dirty

  libvirt(4804a4db33a37f828d033733bc47f6eff5d262c3):

  Guest Kernel: 4.17.0-rc7

  Steps to recreate:
  Define a guest attached with above setup and start.
  # virsh start avocado-vt-vm1

  guest console;...
  # uname -r
  4.17.0-rc7
  [root@atest-guest ~]# lscpu
  Architecture:        ppc64le
  Byte Order:          Little Endian
  CPU(s):              3
  On-line CPU(s) list: 0-2
  Thread(s) per core:  1
  Core(s) per socket:  1
  Socket(s):           3
  NUMA node(s):        1
  Model:               2.1 (pvr 004b 0201)
  Model name:          POWER8 (architected), altivec supported
  Hypervisor vendor:   KVM
  Virtualization type: para
  L1d cache:           64K
  L1i cache:           32K
  NUMA node0 CPU(s):   0-2

  =

  # virsh managedsave avocado-vt-vm1 =


  Domain avocado-vt-vm1 state saved by libvirt

  # virsh list
   Id    Name                           State
  ----------------------------------------------------

  # virsh start avocado-vt-vm1 ----Hangs forever and vm state goes to
  paused.

  =

  # virsh list
   Id    Name                           State
  ----------------------------------------------------
   87    avocado-vt-vm1                 paused

  =

  P:S:- with same above setup, just changing the qemu-kvm comes bydefault w=
ith F28 works fine.

  /usr/bin/qemu-kvm --version
  QEMU emulator version 2.11.1(qemu-2.11.1-2.fc28)

  Summary: with above other setup.
  machine type pseries-2.12 and qemu-2.11.1-2.fc28 -Works fine.

  machine type pseries-2.12/pseries-2.13 and qemu
  5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b - Does not work.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1773753/+subscriptions
