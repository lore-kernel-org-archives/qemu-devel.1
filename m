Received: from eggs.gnu.org ([2001:4830:134:3::10]:33464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRb3-0004t2-4r
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQRb1-0001rh-Lh
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:37262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQRb1-0001r9-Fm
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:30:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQRb0-0007x1-JZ
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 04:30:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8BD1C2E80C4
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 04:30:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jan 2017 04:17:30 -0000
From: Launchpad Bug Tracker <680758@bugs.launchpad.net>
Reply-To: Bug 680758 <680758@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101124034709.25625.14961.malonedeb@gandwana.canonical.com>
Message-Id: <20170109041730.18789.14727.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 680758] Re: balloon only resizes by 2M
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
https://bugs.launchpad.net/bugs/680758

Title:
  balloon only resizes by 2M

Status in QEMU:
  Expired

Bug description:
  when in monitor and running balloon 512 from a 1024M VM, the vm
  dropped the size to 1020 (this value changes), then every subsequent
  request to balloon 512 will drop it by another 2M.  The system was
  running at above 60% RAM free when these requests were made.  also
  requesting to up the ram results in no change above 1024 (I'm guessing
  this is intentional, but was unable to find any documentation)

  Versions:

  qemu-kvm 0.13.0
  qemu-kvm.git b377474e589e5a1fe2abc7b13fafa8bad802637a

  Qemu Command Line:

  ./x86_64-softmmu/qemu-system-x86_64 -drive
  file=3D/var/machines/seven.base,if=3Dvirtio -net
  nic,model=3Dvirtio,macaddr=3D02:00:00:00:00:01 -net tap,script=3D/etc/qemu
  /qemu-ifup,downscript=3D/etc/qemu/qemu-ifdown -vga std -usb -usbdevice
  tablet -rtc base=3Dlocaltime,clock=3Dhost -watchdog i6300esb -balloon
  virtio -m 1024 -no-quit -smp 2 -monitor stdio

  Monitor Session:

  QEMU 0.13.50 monitor - type 'help' for more information
  (qemu) info balloon
  balloon: actual=3D1024
  (qemu) balloon 1536
  (qemu) info balloon
  balloon: actual=3D1024
  (qemu) balloon 512
  (qemu) info balloon
  balloon: actual=3D1020
  (qemu) info balloon
  balloon: actual=3D1020
  (qemu) balloon 512
  (qemu) info balloon
  balloon: actual=3D1018

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/680758/+subscriptions
