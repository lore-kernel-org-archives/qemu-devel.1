Received: from eggs.gnu.org ([2001:4830:134:3::10]:33041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gamCm-0000qP-5c
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 13:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gamCi-000562-Kh
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 13:40:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:45078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gamCi-00054S-As
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 13:40:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gamCg-0001BA-Uu
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 18:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB29C2E80CD
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 18:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Dec 2018 18:33:30 -0000
From: Neil Darlow <1793275@bugs.launchpad.net>
Reply-To: Bug 1793275 <1793275@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153734706849.11874.4653304097344263662.malonedeb@gac.canonical.com>
Message-Id: <154550361046.24863.10282987990156013652.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1793275] Re: Hosts fail to start after update to
 QEMU 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This bug is not present in QEMU-3.1.0.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1793275

Title:
  Hosts fail to start after update to QEMU 3.0

Status in QEMU:
  New

Bug description:
  Host OS: Archlinux
  Host Architecture: AMD64
  Guest OS: FreeBSD-11.2 (x2) and Archlinux (x1)
  Guest Architecture: AMD64

  I have been using QEMU 2.x without issue for a number of years but
  since updating to QEMU 3.0 my guests do not complete startup.

  FreeBSD 11.2 guest failure symptom:
  The two FreeBSD-11.2 guests output repeated messages of "unexpected cache=
 type 4". This appears to be an internal error message and I've not found a=
ny instances of it through Google search.

  Archlinux guest failure symptom:
  The single Archlinux guest gets no further than the message "uncompressin=
g initial ramdisk".

  The guests are started by a qemu-kvm invokation. No virtual machine
  managers are used. The command lines used (from ps awx) to launch the
  VMs are:

  [neil@optimus ~]$ ps awx |grep qemu
   1492 ?        Sl     3:19 /usr/bin/qemu-system-x86_64 -daemonize -pidfil=
e /run/qemu_vps1.pid -enable-kvm -cpu host -smp 2 -k en-gb -boot order=3Dc =
-drive file=3D/dev/system/vps1,cache=3Dnone,format=3Draw,if=3Dvirtio,index=
=3D0,media=3Ddisk -m 1024 -name FreeBSD_1 -net nic,macaddr=3D52:54:AD:86:64=
:00,model=3Dvirtio -net vde,sock=3D/run/vde_switch-tap0.sock -monitor telne=
t:127.0.0.2:23,server,nowait -vnc 192.168.0.1:0
   1510 ?        Sl     0:54 /usr/bin/qemu-system-x86_64 -daemonize -pidfil=
e /run/qemu_vps2.pid -enable-kvm -cpu host -smp 2 -k en-gb -boot order=3Dc =
-drive file=3D/dev/system/vps2,cache=3Dnone,format=3Draw,if=3Dvirtio,index=
=3D0,media=3Ddisk -m 1024 -name Archlinux -net nic,macaddr=3D52:54:AD:86:64=
:01,model=3Dvirtio -net vde,sock=3D/run/vde_switch-tap0.sock -monitor telne=
t:127.0.0.3:23,server,nowait -vnc 192.168.0.1:1
   1529 ?        Sl     3:07 /usr/bin/qemu-system-x86_64 -daemonize -pidfil=
e /run/qemu_vps3.pid -enable-kvm -cpu host -smp 2 -k en-gb -boot order=3Dc =
-drive file=3D/dev/system/vps3,cache=3Dnone,format=3Draw,if=3Dvirtio,index=
=3D0,media=3Ddisk -m 1024 -name FreeBSD_2 -net nic,macaddr=3D52:54:AD:86:64=
:02,model=3Dvirtio -net vde,sock=3D/run/vde_switch-tap0.sock -monitor telne=
t:127.0.0.4:23,server,nowait -vnc 192.168.0.1:2

  The VMs were installed to LVM volumes on the host machine (hence the
  /dev/system/vpsN device names). Networking is over a Linux tap
  interface connected to a VDE2 virtual network switch.

  Currently working version of QEMU: qemu-headless 2.12.1-1
  Failing version of QEMU: qemu-headless-3.0.0-1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1793275/+subscriptions
