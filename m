Received: from eggs.gnu.org ([2001:4830:134:3::10]:45623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpjjn-0001Xz-Eg
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 18:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpjjj-00017B-Iu
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 18:55:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:48809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cpjjj-00016l-Cz
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 18:55:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cpjjg-0008KI-Bb
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 22:55:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 569E72E806C
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 22:55:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Mar 2017 22:47:21 -0000
From: Mario <1674114@bugs.launchpad.net>
Reply-To: Bug 1674114 <1674114@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170319155854.19555.99549.malonedeb@soybean.canonical.com>
Message-Id: <20170319224721.22178.31733.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1674114] Re: Bad sectors when using MS-DOS 6.22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is working now without the parameters "-machine isapc" and "-cpu
486".

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1674114

Title:
  Bad sectors when using MS-DOS 6.22

Status in QEMU:
  New

Bug description:
  When I try to install DOS 6.22 in QEMU, I get many disk errors when
  the virtual disk is beeing partionized and formatted. When I later do
  a SCANDISK, I can see many bad sectors and file errors.

  I have tested this with the following disk formats: qcow2, vmdk, raw.

  I tested this on Windows 7 with the following command line and QEMU versi=
on:
  qemu-system-i386 -name "Windows 3.11 WfW" -machine isapc -cpu 486 -boot o=
rder=3Dadc -m 32 -soundhw sb16 -hda disk1.qcow2 -vga cirrus

  qemu-system-i386 --version
  QEMU emulator version 2.8.50 (v2.8.0-12557-g0bd1f6b1b2-dirty)
  Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers

  I then did a test with the linux version of qemu, which gave me the same =
results.
  Command line: qemu-system-i386 -name "Windows 3.11 WfW" -machine isapc -c=
pu 486 -boot order=3Dadc -m 32 -soundhw sb16 -hda disk1.qcow2 -vga cirrus -=
monitor stdout
  Version: qemu-system-i386 --version
  QEMU emulator version 2.1.2 (Debian 1:2.1+dfsg-12+deb8u6), Copyright (c) =
2003-2008 Fabrice Bellard

  I also checked the disk image with qemu-img, with no results:

  No errors were found on the image.
  7986/8000 =3D 99.83% allocated, 0.20% fragmented, 0.00% compressed cluste=
rs
  Image end offset: 523698176

  Because I got the error with two different versions of QEMU, I think
  this is a general problem and not related to a specific distribution.

  I have attached a zip file with screenshots of SCANDISK, which shows
  the disk errors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1674114/+subscriptions
