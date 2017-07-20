Received: from eggs.gnu.org ([2001:4830:134:3::10]:49931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYB4z-0002h4-R8
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYB4s-0006SB-H6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:01:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:52038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYB4s-0006R9-8m
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:01:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYB4q-0004um-SX
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 13:01:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0AD9E2E80CD
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 13:01:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2017 12:52:25 -0000
From: Thomas Huth <1703795@bugs.launchpad.net>
Reply-To: Bug 1703795 <1703795@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149985188503.15456.11517595781983565935.malonedeb@wampee.canonical.com>
Message-Id: <150055514546.6612.14464181789377878813.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1703795] Re: Unable to release mouse in SDL2 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Which version of SDL2 are you using? Could you please try to reproduce
it with the latest version to see whether the problem has been fixed
there?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1703795

Title:
  Unable to release mouse in SDL2 mode

Status in QEMU:
  New

Bug description:
  Starting with commit 8f4ea9cd0b770dbe496d9d24f0ef8813fdbfe0d0 "sdl:
  prefer sdl2 over sdl1", I can no longer release mouse pointer grab
  unless I use --with-sdlabi=3D1.2 configure option.

  This easily reproduces in e.g. guest Kubuntu, when I let it start Xorg
  and then click into the QEMU window. After this the mouse is trapped
  and no matter how I combine Ctrl+Alt and motion of the cursor, the
  pointer never goes out from the window. When at the border, QEMU
  window switches from "Press Ctrl+Alt to exit grab" to "QEMU", i.e. it
  thinks that it has released the grab. But it hasn't really, so I have
  to go to VT1 and do "pkill qemu" from there to get my pointer back.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1703795/+subscriptions
