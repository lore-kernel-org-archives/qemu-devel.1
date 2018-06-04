Received: from eggs.gnu.org ([2001:4830:134:3::10]:48422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPqGs-0004oR-Le
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPqGm-0005JP-Li
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:46772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fPqGm-0005Iy-9A
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:15:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fPqGl-0002QO-A1
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 14:15:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 47B642E8030
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 14:15:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Jun 2018 14:07:23 -0000
From: Alex <1775011@bugs.launchpad.net>
Reply-To: Bug 1775011 <1775011@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152812124309.24357.17398369138889360746.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1775011] [NEW] -display gtk,
 gl=on crashes on Wayland
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

steps to reproduce:

1. run a Wayland compositor (I use sway, probably the same bug exists for o=
ther compositors)
2. execute qemu -display gtk,gl=3Don

expected results:

a GTK window is created that shows SeaBIOS failing to boot

actual results:

segmentation fault  qemu-system-x86_64 -display gtk,gl=3Don

additional information:

qemu version 2.12.0 from Arch Linux

looks like qemu is trying to take the Wayland display from GTK and
initialize EGL but telling EGL it's a X11 display, which is not correct.
setting GDK_BACKEND=3Dx11 works around the issue.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1775011

Title:
  -display gtk,gl=3Don crashes on Wayland

Status in QEMU:
  New

Bug description:
  steps to reproduce:

  1. run a Wayland compositor (I use sway, probably the same bug exists for=
 other compositors)
  2. execute qemu -display gtk,gl=3Don

  expected results:

  a GTK window is created that shows SeaBIOS failing to boot

  actual results:

  segmentation fault  qemu-system-x86_64 -display gtk,gl=3Don

  additional information:

  qemu version 2.12.0 from Arch Linux

  looks like qemu is trying to take the Wayland display from GTK and
  initialize EGL but telling EGL it's a X11 display, which is not
  correct. setting GDK_BACKEND=3Dx11 works around the issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1775011/+subscriptions
