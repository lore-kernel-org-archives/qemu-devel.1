Received: from eggs.gnu.org ([2001:4830:134:3::10]:43259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb5IT-0000qG-1H
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cb5IP-0000lC-Ug
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:55:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:52054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cb5IP-0000ks-Oj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:54:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cb5IN-0004lV-JP
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 12:54:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7C41E2E80CE
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 12:54:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Feb 2017 12:42:30 -0000
From: Thomas Huth <709584@bugs.launchpad.net>
Reply-To: Bug 709584 <709584@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110129011958.31878.27278.malonedeb@wampee.canonical.com>
Message-Id: <20170207124230.29623.17633.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 709584] Re: Fullscreen mode splits screen over
 monitor boundaries on dual-monitor system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

QEMU 0.12 is completely outdated nowadays ... can you still reproduce
this issue with the latest version of QEMU (currently v2.8)? If yes,
which graphical backend are you using? SDL1? SDL2? GTK?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/709584

Title:
  Fullscreen mode splits screen over monitor boundaries on dual-monitor
  system

Status in QEMU:
  Incomplete

Bug description:
  I originally reported this for the Android SDK emulator, which is
  built on QEMU: http://code.google.com/p/android/issues/detail?id=3D14336

  Can confirm that this bug is present in stock QEMU shipped with Ubuntu 10=
.10:
  QEMU PC emulator version 0.12.5 (qemu-kvm-0.12.5), Copyright (c) 2003-200=
8 Fabrice Bellard

  Steps to reproduce:
  - get a Linux machine with multiple-monitor setup (tested using NVidia pr=
oprietary driver on Ubuntu 10.10 x86_64, with two monitors side-by-side in =
'TwinView' configuration)
  - launch qemu
  - hit ctrl+alt+f to go into fullscreen mode

  Expected behavior:
  - emulator should take over one screen (either the first screen, largest =
screen, or screen the emulator is presently on)
  - emulator's display should center or scale to fit within available area =
of the taken-over screen

  Actual behavior:
  - emulator takes over both screens
  - emulator's display is split over the boundary between the two screens

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/709584/+subscriptions
