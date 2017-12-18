Received: from eggs.gnu.org ([2001:4830:134:3::10]:59308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQs9H-0007pF-6O
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQs9C-0007pV-AS
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:55:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:40720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQs9C-0007ox-4Y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:55:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQs9A-0002OL-FM
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:55:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 732A42E80CB
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:55:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 09:48:17 -0000
From: Thomas Huth <1731588@bugs.launchpad.net>
Reply-To: Bug 1731588 <1731588@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151036051040.28255.9617838387199487085.malonedeb@gac.canonical.com>
Message-Id: <151359049760.10605.17583182023554350852.launchpad@gac.canonical.com>
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

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1731588

Title:
  qemu-system-arm black screen and keyboard not detected

Status in QEMU:
  Incomplete

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
