Received: from eggs.gnu.org ([2001:4830:134:3::10]:34881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSp8-0007T5-3S
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSp5-0007rp-Jp
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:25:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:46813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTSp5-0007q7-Df
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:25:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTSp4-0008AU-Lm
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:25:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8FB852E80BF
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:25:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 12:09:12 -0000
From: Thomas Huth <723460@bugs.launchpad.net>
Reply-To: Bug 723460 <723460@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110222234911.23392.3517.malonedeb@palladium.canonical.com>
Message-Id: <20170117120913.20288.48152.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 723460] Re: qemu on linux doesn't boot for winxp
 install via usb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/723460

Title:
  qemu on linux doesn't boot for winxp install via usb

Status in QEMU:
  Invalid

Bug description:
  hi guys,
  I try to install windows xp via qemu. I can only boot from usb and someho=
w it is my problem.
  I run a Winxp/xubuntu10.04 Dualboot-system with some virtual drives in wi=
ndows ( till letter f:? ).
  at qemu I created an image from 30Gigabytes and entered this command from=
 the imagefile's directory :

  "sudo qemu-system-x86_64 -localtime -usbdevice -hda /dev/sdb -m 384
  -boot d winxp.img"

  the answer is :

  "qemu-system-x86_64: -boot d: drive with bus=3D0, unit=3D0 (index=3D0)
  exists"

  I had to set the usb-stick in the fstab file with this command :

  "UUID=3DX /media/usb      vfat    rw,users,noauto,umask=3D000       0
  0"

  anybody experienced the same problem?

  I would appreciate any kind of help

  greetz

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/723460/+subscriptions
