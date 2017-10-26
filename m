Received: from eggs.gnu.org ([2001:4830:134:3::10]:56076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7l3w-0002AO-OI
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7l3s-0003IF-Kd
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:31:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:44574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7l3s-0003Hs-E2
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:31:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7l3r-0000xi-0K
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:31:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 008232E80CC
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:31:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 16:13:37 -0000
From: OIiver <1368178@bugs.launchpad.net>
Reply-To: Bug 1368178 <1368178@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140911114353.25076.30246.malonedeb@soybean.canonical.com>
Message-Id: <150903441794.4275.2452872769753096735.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1368178] Re: Windows ME falsely detects qemu's
 videocards as Number Nine Imagine 128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Addition to my last comment.

Ubuntu 17.10 is now shipped with QEMU 2.10. Thus we can expect that
18.04 LTS will be shipped with QEMU 2.10 or later, too.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1368178

Title:
  Windows ME falsely detects qemu's videocards as Number Nine Imagine
  128

Status in QEMU:
  Incomplete

Bug description:
  A fresh installation of  Windows Millennium Edition (Windows ME,
  WinME) as guest OS on qemu interprets qemu's videocards as Number Nine
  Imagine  128 with the consequence, that

  1. It is impossible to change color depth.
  2. WinME uses the i128.drv Driver that is shipped with WinMe.
  3. Forcing WinME to use other drivers has no effect.

  =

  It also doesn't matter what option for -vga was given to QEMU at command =
line.
  cirrus, std,   vmware,  qxl etc. all have no effect, the videocard detect=
ed by Windows Me stays at Number Nine Imagine 128.

  Even selecting another driver in WinME and forcing WinME to use
  drivers such as the Cirrus Logic 5446 PCI driver has no effect.

  I also want to mention, that the BIOS isn't detected by WinME properly.
  The device manager of WinME shows errors with the Plug & Play BIOS driver=
 BIOS.vxd.

  =

  That is the QEMU Version:

  # qemu-system-i386 --version                                             =
                                                                           =
                                                  =

  QEMU emulator version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.3), Copyright (c)=
 2003-2008 Fabrice Bellard                  =


  And this was the complete command line, that was given: =

  # sudo /usr/bin/qemu-system-i386 -hda WinME_QEMU.img -cdrom drivers.iso -=
boot c -no-acpi -no-hpet -soundhw sb16 -net nic -cpu pentium3 -m 256 -vga c=
irrus

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1368178/+subscriptions
