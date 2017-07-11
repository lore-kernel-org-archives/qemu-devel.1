Received: from eggs.gnu.org ([2001:4830:134:3::10]:33930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1QD-0000Mv-0q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dV1Q9-0001Eg-SE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:06:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:51066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dV1Q9-0001EI-M9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:06:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dV1Q5-0000NR-Iq
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:06:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D0EBD2E81D0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 20:06:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Jul 2017 19:55:36 -0000
From: Thomas Huth <1089281@bugs.launchpad.net>
Reply-To: Bug 1089281 <1089281@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121212101906.19778.769.malonedeb@wampee.canonical.com>
Message-Id: <149980293611.24753.7001951446426680492.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1089281] Re: kvm crash when writing on disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing according to comment #2 and #3

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1089281

Title:
  kvm crash when writing on disk

Status in QEMU:
  Won't Fix

Bug description:
  When running the following command:

  /usr/bin/kvm -S -M pc-1.0 -cpu qemu32 -enable-kvm -m 1024 -smp
  1,sockets=3D1,cores=3D1,threads=3D1 -name winxp -uuid f86ef88f-b90e-699a-
  74b8-9675063fc26e -nodefconfig -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/winxp.monitor,server=
,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -n=
o-
  shutdown -device lsi,id=3Dscsi0,bus=3Dpci.0,addr=3D0x4 -drive
  file=3D/home/master/xpnew.iso,if=3Dnone,media=3Dcdrom,id=3Ddrive-
  ide0-0-0,readonly=3Don,format=3Draw -device ide-
  drive,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,bootindex=
=3D1
  -drive file=3D/var/lib/zentyal/machines/winxp/winxp.img,if=3Dnone,id
  =3Ddrive-scsi0-0-0,format=3Dqcow2 -device scsi-disk,bus=3Dscsi0.0,scsi-
  id=3D0,drive=3Ddrive-scsi0-0-0,id=3Dscsi0-0-0 -netdev tap,fd=3D18,id=3Dho=
stnet0
  -device
  rtl8139,netdev=3Dhostnet0,id=3Dnet0,mac=3Db3:b8:a9:49:a2:f8,bus=3Dpci.0,a=
ddr=3D0x3
  -usb -device usb-mouse,id=3Dinput0 -vnc 0.0.0.0:0,password -k de -vga
  cirrus -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5

  =

  running a windows installation (for instance, it has crashed with other O=
S), when the guest OS installer has reached 60% of the copying files proces=
s, the following errors can be found, and KVM gets Force Closed (i am recol=
lecting errors from different times I have tried to references to memory po=
sitions may vary)

  syslog:

  Nov 26 19:46:59 mikeboxx kernel: [2254718.689953] kvm6983 general
  protection ip:7fc451d4be08 sp:7fc44991ab80 error:0 in
  libc-2.15.so[7fc451ccd000+1b5000]

  /var/log/libvirt/libvirtd.log:

  2012-11-21 10:01:26.464+0000: 16050: error : qemuMonitorIO:603 :
  internal error End of file from monitor

  /var/log/libvirt/qemu/winxp-ajur.log

  **enclosed as it has a long size due to the core dump

  =

  The linux kernel running is this one:

  3.2.0-32-generic #51-Ubuntu SMP Wed Sep 26 21:33:09 UTC 2012 x86_64
  x86_64 x86_64 GNU/Linux

  Libvirtd versions are these:
  root@mikeboxx:/home/ebox-remote-support# dpkg -l | grep libvirt
  ii  libvirt-bin                          0.9.8-2ubuntu17.4               =
           programs for the libvirt library
  ii  libvirt0                             0.9.8-2ubuntu17.4               =
           library for interfacing with different virtualization systems

  and KVM - QEMU versions are these ones:
  root@mikeboxx:/home/ebox-remote-support# dpkg -l | grep qemu
  ii  qemu-common                          1.0+noroms-0ubuntu14.3          =
           qemu common functionality (bios, documentation, etc)
  ii  qemu-kvm                             1.0+noroms-0ubuntu14.3          =
           Full virtualization on i386 and amd64 hardware
  ii  qemu-utils                           1.0+noroms-0ubuntu14.3          =
           qemu utilities


  I have checked bug  #1022901 in
  https://bugs.launchpad.net/ubuntu/+source/qemu-kvm/+bug/1022901  due
  to the similarity of the error "internal error End of file from
  monitor", but the sintoms are not the same as long as the partition
  where the img file resides has plenty of space and so does the img
  itself:

  root@mikeboxx:/home/ebox-remote-support# df -h
  Filesystem      Size  Used Avail Use% Mounted on
  /dev/sda1       226G  3.4G  211G   2% /

  root@mikeboxx:/home/ebox-remote-support# qemu-img info /var/lib/zentyal/m=
achines/winxp/winxp.img =

  image: /var/lib/zentyal/machines/winxp/winxp.img
  file format: qcow2
  virtual size: 11G (11559501824 bytes)
  disk size: 384M
  cluster_size: 65536

  =

  Can you help us to solve this? Case you needed any information else, plea=
se do not hesitate to ask for it

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1089281/+subscriptions
