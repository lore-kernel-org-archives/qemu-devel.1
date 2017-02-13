Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdNFz-000845-Gi
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cdNFw-0005SA-DC
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:29:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:53886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cdNFw-0005S4-7W
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 15:29:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cdNFt-0001wG-O0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:29:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AD89B2E80C4
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 20:29:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Feb 2017 20:19:29 -0000
From: Thomas Huth <966316@bugs.launchpad.net>
Reply-To: Bug 966316 <966316@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120327152951.2136.20096.malonedeb@gac.canonical.com>
Message-Id: <20170213201929.6009.95625.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 966316] Re: Can't load Android VBOX image or even
 linux test image as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... Can you still reproduce this problem with
the latest version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/966316

Title:
  Can't load Android VBOX image or even linux test image as well

Status in QEMU:
  Incomplete

Bug description:
  Can't load Android X86 ICS 4.0 VBOX image.
  It worked with previous version before adding /qemu/hw/pc_sysfw.c file ( =
tested with version 1.0 ). =


  x86_64-softmmu# ./qemu-system-x86_64 ~/kvm-test-image/x86-linux-0.2.img
  qemu: PC system firmware (pflash) must be a multiple of 0x1000

  In QEMU website (http://wiki.qemu.org/Testing), there is a test image for=
 linux
  but, new version can't load the image as well because of upper error.
  linux-0.2.img.bz2 (8 MB) 	Small Linux disk image containing a 2.6.20 Linu=
x kernel, X11 and various utilities to test QEMU

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/966316/+subscriptions
