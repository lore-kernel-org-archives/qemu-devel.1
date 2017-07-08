Received: from eggs.gnu.org ([2001:4830:134:3::10]:50152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dThXo-00047F-Sk
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dThXi-00034d-Gl
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:40:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:41871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dThXi-00031j-Aa
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:40:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dThXf-0001aY-W7
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 04:40:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F1BD62E8197
	for <qemu-devel@nongnu.org>; Sat,  8 Jul 2017 04:40:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Jul 2017 04:21:35 -0000
From: Launchpad Bug Tracker <899664@bugs.launchpad.net>
Reply-To: Bug 899664 <899664@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111203174530.13621.15995.malonedeb@soybean.canonical.com>
Message-Id: <149948769579.21585.17756793021267139091.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 899664] Re: Bad internet performance for Host to
 Guest or Guest to Host
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
https://bugs.launchpad.net/bugs/899664

Title:
  Bad internet performance for Host to Guest or Guest to Host

Status in QEMU:
  Expired

Bug description:
  Hi, =

  Internet performance for Host to Quest is low. =

  The speed Guest to same Guest is  11.3 Gbits/sec
  The speed Host to same Host is  similar (9.8-11 Gbits/sec)

  But the speed from Guest to Host is slow and around 1Gbit/sec. =

  In the reality traffic never leave a Host. I expected that in this case s=
peed should be close to Host to Host. =

  It is important for virtual infrastructure when you have several Guests o=
n a same Host. Guest to Guest on a same host has speed  around 1 Gbits/sec =
too. =


  Below you can find testes and additional information:

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  biouml@biouml-db:~$ iperf -c 192.168.2.31 -t 30 #Guest to Guest =

  ------------------------------------------------------------
  Client connecting to 192.168.2.31, TCP port 5001
  TCP window size: 49.7 KByte (default)
  ------------------------------------------------------------
  [  3] local 192.168.2.31 port 52170 connected with 192.168.2.31 port 5001
  [ ID] Interval       Transfer     Bandwidth
  [  3]  0.0-30.0 sec  39.6 GBytes  11.3 Gbits/sec
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  biouml@biouml-db:~$ iperf -c 192.168.2.11 -t 30 # Guest to Host
  ------------------------------------------------------------
  Client connecting to 192.168.2.11, TCP port 5001
  TCP window size: 43.4 KByte (default)
  ------------------------------------------------------------
  [  3] local 192.168.2.31 port 47148 connected with 192.168.2.11 port 5001
  [ ID] Interval       Transfer     Bandwidth
  [  3]  0.0-30.0 sec  3.69 GBytes  1.06 Gbits/sec
  biouml@biouml-db:~$ =

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  root@s2-8core:~# iperf -c 192.168.2.30 -t 30 #host to guest
  ------------------------------------------------------------
  Client connecting to 192.168.2.30, TCP port 5001
  TCP window size: 16.0 KByte (default)
  ------------------------------------------------------------
  [  3] local 192.168.2.11 port 57403 connected with 192.168.2.30 port 5001
  [ ID] Interval       Transfer     Bandwidth
  [  3]  0.0-30.0 sec  5.47 GBytes  1.57 Gbits/sec

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  root@s2-8core:~# iperf -c 192.168.2.11 -t 30 #host to host
  ------------------------------------------------------------
  Client connecting to 192.168.2.11, TCP port 5001
  TCP window size: 49.7 KByte (default)
  ------------------------------------------------------------
  [  3] local 192.168.2.11 port 38313 connected with 192.168.2.11 port 5001
  [ ID] Interval       Transfer     Bandwidth
  [  3]  0.0-30.0 sec  34.5 GBytes  9.87 Gbits/sec
  root@s2-8core:~# =

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  I am using virtio drivers and virtual machine was started with
  following parameters:

  /usr/bin/kvm -S -M pc-1.0 -enable-kvm -m 4096 -smp 4,sockets=3D4,cores=3D=
1,threads=3D1 -name one-25 -uuid d1e125ee-d692-4598-3a75-441cd79a513a -node=
fconfig -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvir=
t/qemu/one-25.monitor,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor=
,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -drive file=3D/var/lib/one/Ope=
nNebula/var//25/images/disk.0,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dra=
w,cache=3Dnone -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-=
virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/var/lib/one/Ope=
nNebula/var//25/images/disk.1,if=3Dnone,id=3Ddrive-virtio-disk3,format=3Dra=
w -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x5,drive=3Ddrive-virtio-disk3,=
id=3Dvirtio-disk3 -netdev tap,fd=3D19,id=3Dhostnet0 -device virtio-net-pci,=
netdev=3Dhostnet0,id=3Dnet0,mac=3D02:00:c0:a8:02:02,bus=3Dpci.0,addr=3D0x3 =
-usb -device usb-mouse,id=3Dinput0 -vnc 0.0.0.0:98 -vga cirrus -device virt=
io-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
  Qemu version:
  root@s2-8core:~# /usr/bin/kvm --version
  QEMU emulator version 0.15.92, Copyright (c) 2003-2008 Fabrice Bellard

  root@s2-8core:~# ls -la /usr/bin/kvm
  lrwxrwxrwx 1 root root 27 2011-11-07 17:34 /usr/bin/kvm -> /usr/bin/qemu-=
system-x86_64

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Bridge configuration:

  root@s2-8core:~# cat /etc/network/interfaces =

  auto lo
  iface lo inet loopback

  auto eth0
  iface eth0 inet manual

  auto eth1 =

  iface eth1 inet manual

  auto br0
  iface br0 inet static
          address 192.168.2.11
          network 192.168.2.0
          netmask 255.255.255.0
          broadcast 192.168.2.255
          gateway 192.168.2.1
          bridge_ports eth0
          bridge_stp on
          bridge_fd 0
          bridge_maxwait 0
  root@s2-8core:~# =


  root@s2-8core:~# brctl show
  bridge name	bridge id		STP enabled	interfaces
  br0		8000.001e8cec6113	yes		eth0
  							vnet0
  virbr0		8000.000000000000	yes		=


  root@s2-8core:~# brctl --version
  bridge-utils, 1.5
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  root@s2-8core:~# uname -a
  Linux s2-8core 3.0.0-13-server #22-Ubuntu SMP Wed Nov 2 15:09:08 UTC 2011=
 x86_64 x86_64 x86_64 GNU/Linux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/899664/+subscriptions
