Received: from eggs.gnu.org ([2001:4830:134:3::10]:41439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f8pcB-0003sQ-OI
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f8pc6-0001TB-OZ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:07:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:60962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f8pc6-0001SO-In
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:07:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f8pc5-0002VO-25
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 16:07:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 056812E80C9
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 16:07:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Apr 2018 15:51:04 -0000
From: Thomas Huth <1386197@bugs.launchpad.net>
Reply-To: Bug 1386197 <1386197@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141027132911.2480.54218.malonedeb@gac.canonical.com>
Message-Id: <152406666445.12721.11225938858388984872.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1386197] Re: keyboard suddenly stops working in
 VM and problem persists until host reboot. All super-standard setup no
 funny stuff
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
https://bugs.launchpad.net/bugs/1386197

Title:
  keyboard suddenly stops working in VM and problem persists until host
  reboot. All super-standard setup no funny stuff

Status in QEMU:
  Incomplete

Bug description:
  QEMU emulator version 2.1.2, Copyright (c) 2003-2008 Fabrice Bellard
  Linux HOST 3.16.3-1-ck #1 SMP PREEMPT Sun Sep 21 11:27:46 CEST 2014 x86_6=
4 GNU/Linux

  qemu-system-x86_64 -daemonize -enable-kvm -cpu host -smp
  4,maxcpus=3D4,sockets=3D1,cores=3D2,threads=3D1 -m 4096 -monitor
  telnet:127.0.0.1:4446,server,nowait -vga qxl -spice
  port=3D5556,ipv4,addr=3D127.0.0.1,disable-ticketing -soundhw all -net
  tap,script=3Dno,ifname=3Dvm6,vlan=3D0,vnet_hdr=3Don -net
  nic,macaddr=3D52:54:00:2A:F1:16,vlan=3D0,model=3Dvirtio -drive
  file=3D/mnt/2/VM/vm-
  centos.qcow2,cache=3Dwriteback,index=3D0,media=3Ddisk,if=3Dvirtio,aio=3Dn=
ative
  -boot c -vnc :6

  I already had this with ubanto VM so I installed a centos one and it
  worked for a while, but then today I restart it and type HDD password
  in VNC suddenly keyboard stops working forever again. Kill qemu, stop
  qemu, start again ... same issue. Very strange. Problem in VNC,
  problem in vga std problem in spicec problem with options problem
  without options, SDL no SDL and nothing helps. dmesg only shows
  unhandled wrmsr like always .. so irrelevant.

  Must be problem with new kernel or nvidia driver mystery magic I
  suppose? But I had riced CK kernel before and no issue. Hardware
  didn't change. Nothing works, what is this? Can do sendkey 1 1 in
  console no issue. So why is all keyboard input dead in mid-operation?
  You see after host system reboot I open VM and no matter what VNC or
  spicec or SDL I input keyboard all normal then randomly this! BAM all
  keyboard input gone! So in ubuntu I still had mouse so I used onscreen
  keyboard to enable SSH and then I didn't care. But now I have
  harddrive password, what can I do? Install different QEMU but I
  suppose problem with new kernel xorg stuff rather ... Can't change
  that! Help much appreciated.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1386197/+subscriptions
