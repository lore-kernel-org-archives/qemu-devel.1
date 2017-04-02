Received: from eggs.gnu.org ([2001:4830:134:3::10]:59314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cuXGL-0002s6-Nf
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 00:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cuXGK-00025V-Oj
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 00:37:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cuXGK-00024m-IZ
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 00:37:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cuXGI-0000ys-MF
	for <qemu-devel@nongnu.org>; Sun, 02 Apr 2017 04:37:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A67172E8371
	for <qemu-devel@nongnu.org>; Sun,  2 Apr 2017 04:36:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Apr 2017 04:17:24 -0000
From: Launchpad Bug Tracker <1026176@bugs.launchpad.net>
Reply-To: Bug 1026176 <1026176@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120718144939.31209.59720.malonedeb@gac.canonical.com>
Message-Id: <20170402041724.11031.20470.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1026176] Re: unable to boot squashfs through mtd
 device
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
https://bugs.launchpad.net/bugs/1026176

Title:
  unable to boot squashfs through mtd device

Status in QEMU:
  Expired

Bug description:
  Hi,

  I have built latest qemu archive qemu-1.1.1 to be sure of up to date sour=
ce code.
  I have then built buildroot squashfs image, which can be used correctly w=
ith cmdline like:

  qemu-system-i386 -m 64 -k fr -boot c -kernel images/bzImage -drive
  if=3Dide,file=3Dimages/rootfs.squashfs  -append "root=3D/dev/sda"

  Then I wanted to modify cmdline to use real MTD device, like:

  qemu-system-i386 -m 64 -k fr -boot c -kernel images/bzImage -drive
  if=3Dmtd,file=3Dimages/rootfs.squashfs  -append "root=3D/dev/mtdblock0".

  But nothing was good under kernel.
  Even if mtd0 is reported through qemu interface (Ctrl Alt+2), no device c=
an be found under kernel even if all drivers are built to use it.

  Is this feature okay on qemu-1.1.1 ??
  did I do mistake in my cmdline??

  thank you for your help.
  regards,

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1026176/+subscriptions
