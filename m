Received: from eggs.gnu.org ([2001:4830:134:3::10]:51877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esaHN-00071B-GG
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 15:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1esaHI-0007YY-HU
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 15:30:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:58524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1esaHI-0007YI-81
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 15:30:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1esaHH-0000v9-CY
	for <qemu-devel@nongnu.org>; Sun, 04 Mar 2018 20:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 56D582E80C7
	for <qemu-devel@nongnu.org>; Sun,  4 Mar 2018 20:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Mar 2018 20:18:03 -0000
From: Bill Paul <wpaul@windriver.com>
Reply-To: Bug 1753314 <1753314@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152019468379.20188.16040439279180777761.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1753314] [NEW] UART in sabrelite machine
 simulation doesn't work with VxWorks 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

The imx_serial.c driver currently implements only partial support for
the i.MX6 UART hardware. (I understand it's a work in progress and
that's fine.) dIn particular, it does not implement support for the
Transmit Complete Interrupt Enable bit in the UCR4 register. The VxWorks
7 i.MX6 serial driver depends on the behavior of this bit in actual
hardware in order to send characters through the UART correctly. The
result is that with the current machine model, VxWorks will boot and run
in QEMU but it's unable to print any characters to the console serial
port.

I have produced a small patch for the imx_serial.c module to make it
nominally functional with VxWorks 7. It works well enough to allow the
boot banner to appear and for the user to interact with the target
shell.

I'm not submitting this as a patch to the development list as I'm not
fully certain it complies with the hardware spec and doesn't break any
other functionality. I would prefer if the maintainer (or someone)
reviewed it for any issues/refinements first.

I'm attaching the patch to this bug report. A copy can also be obtained
from:

http://people.freebsd.org/~wpaul/qemu/imx_serial.zip

This patch was generated against QEMU 2.11.0 but also works with QEMU
2.11.1.

My host environment is FreeBSD/amd64 11.1-RELEASE with QEMU
2.11.0/2.11.11 built from source.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: arm sabrelite uart

** Patch added: "Patch for imx_serial.c/h to make it work with VxWorks"
   https://bugs.launchpad.net/bugs/1753314/+attachment/5069246/+files/imx_s=
erial.zip

** Summary changed:

- UART in sabrelite machine simulation doesn't work wth VxWorks
+ UART in sabrelite machine simulation doesn't work with VxWorks 7

** Description changed:

  The imx_serial.c driver currently implements only partial support for
- the i.MX6 UART hardware. In particular, it does not implement support
- for the Transmit Complete Interrupt Enable bit in the UCR4 register. The
- VxWorks 7 i.MX6 serial driver depends on the behavior of this bit in
- actual hardware in order to send characters through the UART correctly.
- The result is that with the current machine model, VxWorks will boot and
- run in QEMU but it's unable to print any characters to the console
- serial port.
+ the i.MX6 UART hardware. (I understand it's a work in progress and
+ that's fine.) In particular, it does not implement support for the
+ Transmit Complete Interrupt Enable bit in the UCR4 register. The VxWorks
+ 7 i.MX6 serial driver depends on the behavior of this bit in actual
+ hardware in order to send characters through the UART correctly. The
+ result is that with the current machine model, VxWorks will boot and run
+ in QEMU but it's unable to print any characters to the console serial
+ port.
  =

  I have produced a small patch for the imx_serial.c module to make it
  nominally functional with VxWorks 7. It works well enough to allow the
  boot banner to appear and for the user to interact with the target
  shell.
  =

  I'm not submitting this as a patch to the development list as I'm not
  fully certain it complies with the hardware spec and doesn't break any
  other functionality. I would prefer if the maintainer (or someone)
  reviewed it for any issues/refinements first.
  =

  I'm attaching the patch to this bug report. A copy can also be obtained
  from:
  =

  http://people.freebsd.org/~wpaul/qemu/imx_serial.zip
  =

  This patch was generated against QEMU 2.11.0 but also works with QEMU
  2.11.1.

** Description changed:

  The imx_serial.c driver currently implements only partial support for
  the i.MX6 UART hardware. (I understand it's a work in progress and
- that's fine.) In particular, it does not implement support for the
+ that's fine.) dIn particular, it does not implement support for the
  Transmit Complete Interrupt Enable bit in the UCR4 register. The VxWorks
  7 i.MX6 serial driver depends on the behavior of this bit in actual
  hardware in order to send characters through the UART correctly. The
  result is that with the current machine model, VxWorks will boot and run
  in QEMU but it's unable to print any characters to the console serial
  port.
  =

  I have produced a small patch for the imx_serial.c module to make it
  nominally functional with VxWorks 7. It works well enough to allow the
  boot banner to appear and for the user to interact with the target
  shell.
  =

  I'm not submitting this as a patch to the development list as I'm not
  fully certain it complies with the hardware spec and doesn't break any
  other functionality. I would prefer if the maintainer (or someone)
  reviewed it for any issues/refinements first.
  =

  I'm attaching the patch to this bug report. A copy can also be obtained
  from:
  =

  http://people.freebsd.org/~wpaul/qemu/imx_serial.zip
  =

  This patch was generated against QEMU 2.11.0 but also works with QEMU
  2.11.1.
+ =

+ My host environment is FreeBSD/amd64 11.1-RELEASE with QEMU
+ 2.11.0/2.11.11 built from source.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753314

Title:
  UART in sabrelite machine simulation doesn't work with VxWorks 7

Status in QEMU:
  New

Bug description:
  The imx_serial.c driver currently implements only partial support for
  the i.MX6 UART hardware. (I understand it's a work in progress and
  that's fine.) dIn particular, it does not implement support for the
  Transmit Complete Interrupt Enable bit in the UCR4 register. The
  VxWorks 7 i.MX6 serial driver depends on the behavior of this bit in
  actual hardware in order to send characters through the UART
  correctly. The result is that with the current machine model, VxWorks
  will boot and run in QEMU but it's unable to print any characters to
  the console serial port.

  I have produced a small patch for the imx_serial.c module to make it
  nominally functional with VxWorks 7. It works well enough to allow the
  boot banner to appear and for the user to interact with the target
  shell.

  I'm not submitting this as a patch to the development list as I'm not
  fully certain it complies with the hardware spec and doesn't break any
  other functionality. I would prefer if the maintainer (or someone)
  reviewed it for any issues/refinements first.

  I'm attaching the patch to this bug report. A copy can also be
  obtained from:

  http://people.freebsd.org/~wpaul/qemu/imx_serial.zip

  This patch was generated against QEMU 2.11.0 but also works with QEMU
  2.11.1.

  My host environment is FreeBSD/amd64 11.1-RELEASE with QEMU
  2.11.0/2.11.11 built from source.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1753314/+subscriptions
