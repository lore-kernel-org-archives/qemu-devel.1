Received: from eggs.gnu.org ([2001:4830:134:3::10]:47319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cidvV-0007FP-Lq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cidvS-0005MO-5S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:18:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:42365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cidvR-0005M8-Vt
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 04:18:30 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cidvR-0007IX-5e
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:18:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 295192E80C4
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:18:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Feb 2017 09:03:57 -0000
From: Thomas Huth <1200212@bugs.launchpad.net>
Reply-To: Bug 1200212 <1200212@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130711130307.21680.39535.malonedeb@soybean.canonical.com>
Message-Id: <20170228090357.20922.1538.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1200212] Re: qemu-system-arm aborts in
 lsi_soft_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1200212

Title:
  qemu-system-arm aborts in lsi_soft_reset

Status in QEMU:
  Incomplete

Bug description:
  Qemu compiled from master branch (fetched on 11th Jul 2013, qemu-
  system-arm -version prints "QEMU emulator version 1.5.50, Copyright
  (c) 2003-2008 Fabrice Bellard") running on OSX 10.6.8 crashes during
  Debian 7.1 netboot installation with error: "Assertion failed:
  (QTAILQ_EMPTY(&s->queue)), function lsi_soft_reset, file
  hw/scsi/lsi53c895a.c, line 351."

  Steps to reproduce:

  1. Get kernel and initrd from http://ftp.debian.org/debian/dists/Debian7.=
1/main/installer-armel/20130613/images/versatile/netboot/ .
  2. Create a hard disk image with qemu-img: qemu-img create -f qcow2 debia=
n.qcow2 2G.
  3. Run arm-softmmu/qemu-system-arm -M versatilepb -kernel vmlinuz-3.2.0-4=
-versatile \
          -initrd initrd-3.2.0-4-versatile-netboot -drive file=3Ddebian.qco=
w2,index=3D0,if=3Dscsi,media=3Ddisk \
          -append "console=3DttyAMA0" -nographic -net user,hostfwd=3Dtcp:12=
7.0.0.1:22080-:80,vlan=3D0 \
          -net nic,vlan=3D0 -smp 1,cores=3D4

  The installation should proceed past partition setup and start
  downloading packages onto hard disk. After several tries I've never
  got past 31% with the package downloads before getting Abort trap with
  "Assertion failed: (QTAILQ_EMPTY(&s->queue)), function lsi_soft_reset,
  file hw/scsi/lsi53c895a.c, line 351." message.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1200212/+subscriptions
