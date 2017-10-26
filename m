Received: from eggs.gnu.org ([2001:4830:134:3::10]:56072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7l3w-0002AL-NG
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7l3s-0003I6-HF
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:31:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:44548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7l3s-0003Hn-Ay
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:31:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7l3q-0000y2-NU
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:31:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AAD5F2E80CC
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:31:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 16:11:05 -0000
From: OIiver <1368178@bugs.launchpad.net>
Reply-To: Bug 1368178 <1368178@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140911114353.25076.30246.malonedeb@soybean.canonical.com>
Message-Id: <150903426523.4453.5351702824693208039.malone@gac.canonical.com>
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

I am still using Kubuntu 16.04.3 LTS and that is shipped with QEMU 2.5.0

# qemu-system-i386 --version
QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16)

I am not planning to go into the hassle to install QEMU latest on
16.04.3 LTS.

Could you delay the closing of the ticket until Kubuntu 18.04 LTS is releas=
ed?
Then i could test it with the QEMU version that will be shipped with Kubunt=
u 18.04 LTS.

As an alternative, i could also do the test with QEMU 2.5 instead.

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
