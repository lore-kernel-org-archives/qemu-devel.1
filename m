Received: from eggs.gnu.org ([2001:4830:134:3::10]:56122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFmyc-0002zW-RC
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFmyX-0002xw-KN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:11:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFmyX-0002wH-Dp
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:10:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFmyU-0005Ji-Q6
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 20:10:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BDD172E80C0
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 20:10:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Nov 2017 19:59:40 -0000
From: Googulator <1732981@bugs.launchpad.net>
Reply-To: Bug 1732981 <1732981@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151094878036.7381.9952784988294541160.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1732981] [NEW] usb-net on aarch64 has wrong class
 IDs, isn't recognized by Windows
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

If I run qemu-system-aarch64 with "-device usb-net,...", the resulting
USB device will be seen in the guest as class 0x2, subclass 0x2,
protocol 0xFF, instead of the expected class 0xe0, subclass 0x1,
protocol 0x3. This prevents Windows' in-box class driver from binding to
the device. On x86 and x64 Windows, this is not an issue, as another
driver will bind to the device, but in Windows for ARM64, that driver is
unavailable, so the USB device is incorrectly recognized as a serial
port.

Installing a modified version of the inbox driver in "Disable Driver
Signature Enforcement" mode solves the issue, but it's not a very clean
solution.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1732981

Title:
  usb-net on aarch64 has wrong class IDs, isn't recognized by Windows

Status in QEMU:
  New

Bug description:
  If I run qemu-system-aarch64 with "-device usb-net,...", the resulting
  USB device will be seen in the guest as class 0x2, subclass 0x2,
  protocol 0xFF, instead of the expected class 0xe0, subclass 0x1,
  protocol 0x3. This prevents Windows' in-box class driver from binding
  to the device. On x86 and x64 Windows, this is not an issue, as
  another driver will bind to the device, but in Windows for ARM64, that
  driver is unavailable, so the USB device is incorrectly recognized as
  a serial port.

  Installing a modified version of the inbox driver in "Disable Driver
  Signature Enforcement" mode solves the issue, but it's not a very
  clean solution.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1732981/+subscriptions
