Received: from eggs.gnu.org ([2001:4830:134:3::10]:34747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPie8-0002MB-MC
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cPie7-000126-BW
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:24 -0500
Received: from indium.canonical.com ([91.189.90.7]:34833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cPie7-00011G-6P
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 23:30:23 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cPie6-0000SP-6J
	for <qemu-devel@nongnu.org>; Sat, 07 Jan 2017 04:30:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 10C3F2E80CA
	for <qemu-devel@nongnu.org>; Sat,  7 Jan 2017 04:30:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Jan 2017 04:17:48 -0000
From: Launchpad Bug Tracker <521202@bugs.launchpad.net>
Reply-To: Bug 521202 <521202@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100212225021.24686.96808.malonedeb@palladium.canonical.com>
Message-Id: <20170107041748.790.32782.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 521202] Re: Windows XP x64 / 2008 Server x64
 broken on 32-bit hosts with QEMU > 0.9.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/521202

Title:
  Windows XP x64 / 2008 Server x64 broken on 32-bit hosts with QEMU >
  0.9.0

Status in QEMU:
  Expired

Bug description:
  QEMU >0.9.0 fails to install/run 64-bit Windows XP guests on 32-bit
  hosts. This is mentioned here: http://qemu-
  forum.ipi.fi/viewtopic.php?f=3D5&t=3D4625 . As explained there, 0.9.0
  manages to install and run XP64 fine, if somewhat slowly. The host is
  an actual 32-bit CPU (Athlon XP), although I've tested it and
  confirmed the bug to occur on a Core2 Duo CPU running in 32-bit mode
  with KVM disabled. It's impossible to test with KVM enabled, as this
  causes Windows to detect a 32-bit CPU and refuse to run.

  When installing, the installer hangs at the "Setup is starting
  Windows" step. An attempt at running a converted VBox image reveals
  the problem lies somewhere in the ACPI -- in safe mode, the boot
  sequence gets to loading ACPI tables, then hangs indefinitely.
  Interestingly enough, the emulator itself runs fine, you can interact
  with the monitor etc., but the virtual CPU appears to stop; there's a
  marked point in "log cpu" output after which nothing comes. Disabling
  ACPI predictably does nothing to help, as in this case Windows refuses
  to run.

  I've tested with several versions, and 0.9.1 is the first one to
  break. The bug is still present in 0.11 and 0.12 as packaged by
  Ubuntu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/521202/+subscriptions
