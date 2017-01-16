Received: from eggs.gnu.org ([2001:4830:134:3::10]:33046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTDDp-0004uo-Ow
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTDDl-00064U-Hs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:45:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:52880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTDDl-00064N-47
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:45:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTDDk-0000Gc-2m
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 19:45:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 053912E80C7
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 19:45:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Jan 2017 19:36:26 -0000
From: Joan Moreau <jom@grosjo.net>
Reply-To: Bug 1656927 <1656927@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170116193627.27340.49782.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1656927] [NEW] Network (TCP) access regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Starting a VM with

/usr/bin/qemu-system-x86_64 -machine pc-i440fx-1.7,accel=3Dkvm -usb -usbdev=
ice tablet -usbdevice keyboard -enable-kvm -cpu core2duo -smp 2 -drive file=
=3Dwinp
ro.qcow,index=3D0,media=3Ddisk,format=3Dqcow2 -m 4096 -vga vmware -vnc :3 -=
k en-us -device rtl8139,netdev=3Dnic1 -netdev user,id=3Dnic1,smb=3D/data/vp=
s/files/,hostfw
d=3Dtcp::10053-:10053,hostfwd=3Dtcp::3387-:3389 -rtc base=3Dutc,clock=3Dhos=
t -daemonize

in 2.5.1, all works fine

in any version after 2.5.1.1, the network terminate TCP connections
after a certain period .

To reproduce, starts an app that use always connected TCP sockets (I am
using Metatrader 4), let it run a an hour, the app does not realize the
TCP is out of order but the TCP connection is closed by QEMU

in 2.5.1.x, Metatrader works perfectly

Thank you for your help

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1656927

Title:
  Network (TCP) access regression

Status in QEMU:
  New

Bug description:
  Starting a VM with

  /usr/bin/qemu-system-x86_64 -machine pc-i440fx-1.7,accel=3Dkvm -usb -usbd=
evice tablet -usbdevice keyboard -enable-kvm -cpu core2duo -smp 2 -drive fi=
le=3Dwinp
  ro.qcow,index=3D0,media=3Ddisk,format=3Dqcow2 -m 4096 -vga vmware -vnc :3=
 -k en-us -device rtl8139,netdev=3Dnic1 -netdev user,id=3Dnic1,smb=3D/data/=
vps/files/,hostfw
  d=3Dtcp::10053-:10053,hostfwd=3Dtcp::3387-:3389 -rtc base=3Dutc,clock=3Dh=
ost -daemonize

  in 2.5.1, all works fine

  in any version after 2.5.1.1, the network terminate TCP connections
  after a certain period .

  To reproduce, starts an app that use always connected TCP sockets (I
  am using Metatrader 4), let it run a an hour, the app does not realize
  the TCP is out of order but the TCP connection is closed by QEMU

  in 2.5.1.x, Metatrader works perfectly

  Thank you for your help

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1656927/+subscriptions
