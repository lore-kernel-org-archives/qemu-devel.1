Received: from eggs.gnu.org ([2001:4830:134:3::10]:42778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK4b4-00047i-5z
	for qemu-devel@nongnu.org; Sat, 19 May 2018 12:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fK4b1-0008NQ-7z
	for qemu-devel@nongnu.org; Sat, 19 May 2018 12:20:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:49518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fK4b1-0008N5-1T
	for qemu-devel@nongnu.org; Sat, 19 May 2018 12:20:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fK4b0-0008B0-5d
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 16:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 291BE2E8056
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 16:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 May 2018 16:15:03 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1772165 <1772165@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152673688616.9061.7617411809661975686.malonedeb@chaenomeles.canonical.com>
Message-Id: <152674650393.2555.13104117505563992961.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1772165] Re: qemu-system-arm: -device usb-host,
 bus=001, vendorid=0x04f2, productid=0x0111: Bus '001' not found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks. The USB controller for the raspi2/raspi3 boards is not currently
modelled, so it's expected that USB devices won't work.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772165

Title:
  qemu-system-arm: -device usb-
  host,bus=3D001,vendorid=3D0x04f2,productid=3D0x0111: Bus '001' not found

Status in QEMU:
  New

Bug description:
  Using Qemu 2.12.0 on ArchLinux.

  Trying to emulate arm device with `qemu-system-arm` and attach usb
  device for unput using

  ` -usb -device usb-host,bus=3D001,vendorid=3D0x1d6b,productid=3D0x0002 `

  # lsusb returns

  Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
  Bus 001 Device 014: ID 13d3:3487 IMC Networks =

  Bus 001 Device 004: ID 0457:11af Silicon Integrated Systems Corp. =

  Bus 001 Device 003: ID 0bda:57e6 Realtek Semiconductor Corp. =

  Bus 001 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card=
 Reader Controller
  Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

  # qemu returns
  qemu-system-arm: -device usb-host,bus=3D001,vendorid=3D0x1d6b,productid=
=3D0x0002: Bus '001' not found

  =

  Tried with connecting external usb keyboard but that didn't seem to work =
either.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772165/+subscriptions
