Received: from eggs.gnu.org ([2001:4830:134:3::10]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEBYG-0002qb-DC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEBYA-0003zH-Gg
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:01:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:35696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEBYA-0003yY-AH
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:01:06 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEBY6-0005DS-Ts
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 10:01:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5F9F92E80DA
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 10:01:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2017 09:47:05 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1731588 <1731588@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151036051040.28255.9617838387199487085.malonedeb@gac.canonical.com>
Message-Id: <151056642583.28615.15540993644619541986.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1731588] Re: qemu-system-arm black screen and
 keyboard not detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

"stm32-p103" is not a board model supported by upstream QEMU. Presumably
you're using a fork of QEMU -- you should ask whoever is responsible for
that fork about it.


For the second command line -- is the binary you're trying to run built for=
 the stellaris board model you're trying to run it on? If it's the same bin=
ary you tried to use with the stm32 board model then I wouldn't expect it t=
o work. You need to build a binary that targets the board model you run wit=
h.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1731588

Title:
  qemu-system-arm black screen and keyboard not detected

Status in QEMU:
  New

Bug description:
  Hi guys,

  I try to emulate FreeRTOS with this guide : http://wiki.csie.ncku.edu.tw/=
embedded/Lab32
  But, the keys on my keyboard are not taken into account. =

   - Command line : qemu_stm32/arm-softmmu/qemu-system-arm -M stm32-p103 -m=
onitor stdio -kernel build/main.bin -semihosting
  If I try to add usb flag with : qemu_stm32/arm-softmmu/qemu-system-arm -M=
 stm32-p103 -monitor stdio -kernel build/main.bin -usb -device usb-host,hos=
tbus=3D1,hostaddr=3D1 -show-curso
  I obtain this message "qemu-system-arm: -device usb-host,hostbus=3D1,host=
addr=3D1: 'usb-host' is not a valid device model name"

  My second option is try with the latest version of qemu with this
  command line : "qemu-system-arm -M lm3s6965evb -monitor stdio -kernel
  build/main.bin -semihosting" but I obtain a black screen.

  Could someone guide me on this problem ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1731588/+subscriptions
