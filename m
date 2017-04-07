Received: from eggs.gnu.org ([2001:4830:134:3::10]:47735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUQQ-0007T8-KL
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwUQM-00034M-MH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:59:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:42046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwUQM-00033G-G7
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:59:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwUQL-0002IL-9n
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 13:59:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3BC112E80C3
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 13:59:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 13:46:44 -0000
From: Thomas Huth <1031955@bugs.launchpad.net>
Reply-To: Bug 1031955 <1031955@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120801215949.18709.64548.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170407134644.1773.94871.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1031955] Re: qemu-system-arm -M lm3s811evb fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU (version 2.9)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1031955

Title:
  qemu-system-arm -M lm3s811evb fails

Status in QEMU:
  Incomplete

Bug description:
  I am trying out examples from StellarisWare.

  When I try the uart_echo example, that initially tries to talk to the =

  display, I get this:

      $ .../qemu-1.1.1/bin/qemu-system-arm -M lm3s811evb -kernel uart_echo/=
gcc/uart_echo.bin      =

      qemu: hardware error: strllaris_i2c_read: Bad offset 0xfc0
      =

      CPU #0:
      R00=3D00000001 R01=3D005b8d80 R02=3D00061a80 R03=3D007a11ff
      R04=3D40020000 R05=3D005b8d80 R06=3D00000002 R07=3D00000000
      R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
      R12=3D00000000 R13=3D200000d4 R14=3D00000995 R15=3D000009cc
      PSR=3D20000173 --C- T svc32
      Aborted

  The example is located in boards/ek-lm3s811/uart_echo in the =

  StellarisWare distribution.

  With the latest from git:

      $ .../qemu-git/qemu/bin/qemu-system-arm -M lm3s811evb -kernel uart_ec=
ho/gcc/uart_echo.bin
      qemu-system-arm: hw/qdev.c:310: qdev_get_gpio_in: Assertion `n >=3D 0=
 && n < dev->num_gpio_in' failed.

  This however seems to be reported already (Bug #1028260).

  Both versions compiled from sources:

      ./configure --target-list=3Darm-linux-user,arm-softmmu,armeb-linux-
  user  --enable-sdl --prefix=3D/path/to/...

  Running Ubunti 10.04 with Linux 2.6.32-40-generic-pae.

  /Lars

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1031955/+subscriptions
