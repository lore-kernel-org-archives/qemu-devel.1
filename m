Received: from eggs.gnu.org ([2001:4830:134:3::10]:47654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0o1C-0003J6-TC
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 08:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e0o19-0000me-M6
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 08:15:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:42490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e0o19-0000mL-Fk
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 08:15:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e0o18-0003a5-30
	for <qemu-devel@nongnu.org>; Sat, 07 Oct 2017 12:15:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 134BF2E8053
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 12:15:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Oct 2017 12:09:25 -0000
From: Joan Moreau <jom@grosjo.net>
Reply-To: Bug 1721952 <1721952@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150737816601.1214.11131017369010701335.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721952] [NEW] Network issue above 2.5.1.1
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

Hi,
WHen running a QEMU guest (Windows7) on a linux x86-64 server, the network =
stops working after some time for any version above 2.5.1.1

In 2.5.1.1, all is fine (no issue with network)
Any version ablve (trying 2.10.1 now), the application in windows stops acc=
essing the internet after a while

THis is my starting line:
/usr/bin/qemu-system-x86_64 -machine pc-i440fx-1.7,accel=3Dkvm -usb -usbdev=
ice tablet -usbdevice keyboard -enable-kvm -cpu core2duo -smp 2 -drive file=
=3Dwinpro.qcow,index=3D0,media=3Ddisk,format=3Dqco
w2 -m 4096 -vga vmware -vnc :3 -k en-us -device e1000,netdev=3Dnic1 -netdev=
 user,id=3Dnic1,smb=3D/data/vps/files/,hostfwd=3Dtcp::10053-:10053,hostfwd=
=3Dtcp::3387-:3389 -rtc base=3Dutc,clock=3Dhost -daemon
ize

Thisis my configure line:
./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/var --en=
able-kvm --disable-gtk --disable-xen --disable-user --enable-vnc-sasl --dis=
able-libusb --disable-debug-info --disable-spi
ce --enable-lzo --enable-pie --disable-werror --enable-linux-aio --enable-v=
host-net --disable-tcmalloc --enable-vde --enable-nettle --disable-smartcar=
d --enable-curl

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721952

Title:
  Network issue above 2.5.1.1

Status in QEMU:
  New

Bug description:
  Hi,
  WHen running a QEMU guest (Windows7) on a linux x86-64 server, the networ=
k stops working after some time for any version above 2.5.1.1

  In 2.5.1.1, all is fine (no issue with network)
  Any version ablve (trying 2.10.1 now), the application in windows stops a=
ccessing the internet after a while

  THis is my starting line:
  /usr/bin/qemu-system-x86_64 -machine pc-i440fx-1.7,accel=3Dkvm -usb -usbd=
evice tablet -usbdevice keyboard -enable-kvm -cpu core2duo -smp 2 -drive fi=
le=3Dwinpro.qcow,index=3D0,media=3Ddisk,format=3Dqco
  w2 -m 4096 -vga vmware -vnc :3 -k en-us -device e1000,netdev=3Dnic1 -netd=
ev user,id=3Dnic1,smb=3D/data/vps/files/,hostfwd=3Dtcp::10053-:10053,hostfw=
d=3Dtcp::3387-:3389 -rtc base=3Dutc,clock=3Dhost -daemon
  ize

  Thisis my configure line:
  ./configure --prefix=3D/usr --sysconfdir=3D/etc --localstatedir=3D/var --=
enable-kvm --disable-gtk --disable-xen --disable-user --enable-vnc-sasl --d=
isable-libusb --disable-debug-info --disable-spi
  ce --enable-lzo --enable-pie --disable-werror --enable-linux-aio --enable=
-vhost-net --disable-tcmalloc --enable-vde --enable-nettle --disable-smartc=
ard --enable-curl

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721952/+subscriptions
