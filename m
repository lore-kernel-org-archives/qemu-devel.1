Received: from eggs.gnu.org ([2001:4830:134:3::10]:47819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5oP-00024M-O5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cT5oN-0007rv-4v
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:34532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cT5oM-0007rZ-Ud
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:50:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cT5oK-0006Bu-HV
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:50:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8B03D2E80DD
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:50:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 11:40:19 -0000
From: Thomas Huth <1640525@bugs.launchpad.net>
Reply-To: Bug 1640525 <1640525@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161109161632.21072.79812.malonedeb@gac.canonical.com>
Message-Id: <20170116114019.21242.49194.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1640525] Re: -net socket,
 connect/listen does not work in 2.7.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been released with QEMU v2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1640525

Title:
  -net socket,connect/listen does not work in 2.7.0

Status in QEMU:
  Fix Released

Bug description:
  Using 2.7.0 release on Debian Sid. What I did: start one VM with:
  ----
  /home/pierre/build/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
  -smp 4 \
  -cpu Nehalem \
  -soundhw ac97 \
  -k fr \
  -localtime \
  -enable-kvm \
  -m 4099 \
  -drive file=3D/mnt/virtualMachines/qemu/lfs-7.10-porg.qcow2,cache=3Dwrite=
back \
  -cdrom /mnt/virtualMachines/qemu/grub-img.iso \
  -boot order=3Dc,once=3Dd,menu=3Don \
  -vga std \
  -serial mon:stdio \
  -net nic,vlan=3D0,model=3De1000,macaddr=3D52:54:00:12:34:58 \
  -net user,vlan=3D0,hostfwd=3Dtcp::2223-10.0.2.9:22 \
  -net nic,vlan=3D1,model=3De1000,macaddr=3D52:54:00:12:34:56 \
  -net socket,vlan=3D1,listen=3D:4321
  ----
  Start another one with:
  ----
  /home/pierre/build/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
  -smp 4 \
  -cpu Nehalem \
  -soundhw ac97 \
  -k fr \
  -localtime \
  -enable-kvm \
  -m 4099 \
  -drive file=3D/mnt/virtualMachines/qemu/lfs-7.10-october.qcow2,cache=3Dwr=
iteback \
  -cdrom /mnt/virtualMachines/qemu/grub-img.iso \
  -boot order=3Dc \
  -serial mon:stdio \
  -vga std \
  -net nic,vlan=3D0,model=3De1000,macaddr=3D52:54:00:12:34:57 \
  -net socket,vlan=3D0,connect=3Dlocalhost:4321
  ----
  The network settings of the first machine are:
  ----
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default qlen 1
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      inet 127.0.0.1/8 scope host lo
         valid_lft forever preferred_lft forever
  2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast ma=
ster br0 state UP group default qlen 1000
      link/ether 52:54:00:12:34:58 brd ff:ff:ff:ff:ff:ff
  3: enp0s4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast ma=
ster br0 state UP group default qlen 1000
      link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
  4: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP=
 group default qlen 1000
      link/ether 52:54:00:12:34:56 brd ff:ff:ff:ff:ff:ff
      inet 10.0.2.9/24 brd 10.0.2.255 scope global br0
         valid_lft forever preferred_lft forever
  ----
  The network settings on the second machine are:
  ----
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default qlen 1
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      inet 127.0.0.1/8 scope host lo
         valid_lft forever preferred_lft forever
  2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast st=
ate UP group default qlen 1000
      link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
      inet 10.0.2.10/24 brd 10.0.2.255 scope global enp0s3
         valid_lft forever preferred_lft forever
  ----
  typing "ping -c 1 10.0.2.10" on the first machine returns:
  ----
  PING 10.0.2.10 (10.0.2.10): 56 data bytes
  92 bytes from virtuallfs (10.0.2.9): Destination Host Unreachable
  --- 10.0.2.10 ping statistics ---
  1 packets transmitted, 0 packets received, 100% packet loss
  ----
  and something similar when typing "ping -c 1 10.0.2.9" on the second mach=
ine.

  This very same setting works as expected in version 2.6.0. I could bisect=
, and the offending commit is 16a3df403b1:
  ----
  commit 16a3df403b10c4ac347159e39005fd520b2648bb
  Author: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
  Date:   Fri May 13 15:35:19 2016 +0800

      net/net: Add SocketReadState for reuse codes
      =

      This function is from net/socket.c, move it to net.c and net.h.
      Add SocketReadState to make others reuse net_fill_rstate().
      suggestion from jason.
      =

      v4:
       - move 'rs->finalize =3D finalize' to rs_init()
      =

      v3:
       - remove SocketReadState init callback
       - put finalize callback to net_fill_rstate()
      =

      v2:
       - rename ReadState to SocketReadState
       - add SocketReadState init and finalize callback
      =

      v1:
       - init patch
      =

      Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
      Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
      Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
      Signed-off-by: Jason Wang <jasowang@redhat.com>
  ----

  BTW, the systems on both VM are built from
  http://www.linuxfromscratch.org. But I do not think this is important,
  since I could do the bisect. Of course, I'll be happy to try other
  VMs, if you point me to some.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1640525/+subscriptions
