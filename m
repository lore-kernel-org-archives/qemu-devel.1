Received: from eggs.gnu.org ([2001:4830:134:3::10]:32768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDTcg-0002pr-Hc
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gDTcb-00004z-5R
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:11:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:52178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gDTca-0008Tz-Uu
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:11:17 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gDTcZ-00038F-9c
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 12:11:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 93D922E80D5
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 12:11:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Oct 2018 11:59:26 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1797262 <1797262@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153921596093.13046.16485884973780639345.malonedeb@wampee.canonical.com>
Message-Id: <153995036671.15384.18371512606809407583.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1797262] Re: qemu arm no longer able to boot RPI
 Kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Isn't this likely due to the newer kernel accessing hardware we are not
emulating properly?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1797262

Title:
  qemu arm no longer able to boot RPI Kernels

Status in QEMU:
  New

Bug description:
  Since RPi Kernel 1.20170427, qemu is no longer able to emulate the
  Rasberry Pi, as the linux kernel is complaining about timing issues.

  Old kernel output - https://pastebin.com/wvkneNNF
  New kernel output - https://pastebin.com/QTwgCkV2

  Note that the actual error is caused by the kernel being unable to get
  the timing source for the mmc (Line 160), which causes an unable-to-
  mount-root panic.  There are other issues with the serial port
  returning an invalid speed, which displays a divide-by-zero error,
  which is PROBABLY a symptom of the same root cause.

  This is simple to replicate - The last working kernel is available
  here:

  https://github.com/raspberrypi/firmware/tree/1.20170405/boot

  Download kernel7 and the dtb, and try to boot with (for example)

  qemu-system-aarch64 -M raspi2 -kernel kernel7.img -dtb
  bcm2709-rpi-2-b.dtb -serial stdio -sd noobs.img -append
  "root=3D/dev/mmcblk0p2 init=3D/bin/bash"

  This works, and boots successfully.

  However, if you replace the kernel7.img and dtb with ones taken from
  https://github.com/raspberrypi/firmware/tree/1.20170427/boot it will
  NOT boot because of various clock timing issues (as in the second
  paste)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1797262/+subscriptions
