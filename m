Received: from eggs.gnu.org ([2001:4830:134:3::10]:43723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddPGd-0001r9-Rr
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 19:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddPGa-0000KI-JW
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 19:10:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:49879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ddPGa-0000Gn-DE
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 19:10:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ddPGZ-0005pJ-DW
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:10:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5D2472E80C7
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 23:10:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2017 23:00:46 -0000
From: Divine E <1708551@bugs.launchpad.net>
Reply-To: Bug 1708551 <1708551@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150180124657.25828.11815849760914128130.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1708551] [NEW] macOS Guest Reading USB 3.0 Bus as
 USB 2.0
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

Description:
I'm having trouble with USB Passthrough. Running `system_profiler SPUSBData=
Type` on macOS guest confirms that the system "sees" my device, and that qe=
mu is passing *something* through. However, the system sees my connection a=
s USB 2.0, even though i'm passing through XHCI controllers (nec-usb-xhci/q=
emu-xhci). I suspect this is the reason why my guest is unable to recognize=
 my iPhone in XCode & iTunes.

Parameters:
QEMU release version: 2.10.0-rc0
Bios: [patched version of OVMF](https://github.com/gsomlo/edk2/tree/macboot=
)]
Command Line: https://pastebin.com/pBSYbrW1
Host: Arch Linux
Guest: macOS v10.12.6
Guest System Info: https://pastebin.com/U1Tihxei

Notes:
1. Observed sometime after late-May-early-June of this year.

2. Due to [a defect in qemu v2.8 which affected GTK
users](https://bugs.launchpad.net/qemu/+bug/1578192), and [a recent
change to macOS' booting process conflicting with qemu
v2.9](https://lists.nongnu.org/archive/html/qemu-
devel/2017-03/msg06366.html), i'm forced to use qemu v2.10.0-rc0 (as
-rc1 fails to load OVMF right now).

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: regression usb

** Tags added: regression

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708551

Title:
  macOS Guest Reading USB 3.0 Bus as USB 2.0

Status in QEMU:
  New

Bug description:
  Description:
  I'm having trouble with USB Passthrough. Running `system_profiler SPUSBDa=
taType` on macOS guest confirms that the system "sees" my device, and that =
qemu is passing *something* through. However, the system sees my connection=
 as USB 2.0, even though i'm passing through XHCI controllers (nec-usb-xhci=
/qemu-xhci). I suspect this is the reason why my guest is unable to recogni=
ze my iPhone in XCode & iTunes.

  Parameters:
  QEMU release version: 2.10.0-rc0
  Bios: [patched version of OVMF](https://github.com/gsomlo/edk2/tree/macbo=
ot)]
  Command Line: https://pastebin.com/pBSYbrW1
  Host: Arch Linux
  Guest: macOS v10.12.6
  Guest System Info: https://pastebin.com/U1Tihxei

  Notes:
  1. Observed sometime after late-May-early-June of this year.

  2. Due to [a defect in qemu v2.8 which affected GTK
  users](https://bugs.launchpad.net/qemu/+bug/1578192), and [a recent
  change to macOS' booting process conflicting with qemu
  v2.9](https://lists.nongnu.org/archive/html/qemu-
  devel/2017-03/msg06366.html), i'm forced to use qemu v2.10.0-rc0 (as
  -rc1 fails to load OVMF right now).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708551/+subscriptions
