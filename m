Received: from eggs.gnu.org ([2001:4830:134:3::10]:43380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dVE8p-0007zu-S9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dVE8k-00028T-VY
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:41:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:56100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dVE8k-00027U-PX
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:41:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dVE8j-0004Ng-GM
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:41:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 732E12E8197
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:41:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jul 2017 09:31:24 -0000
From: Ruslan <b7.10110111@gmail.com>
Reply-To: Bug 1703795 <1703795@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149985188503.15456.11517595781983565935.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1703795] [NEW] Unable to release mouse in SDL2
 mode
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

Starting with commit 8f4ea9cd0b770dbe496d9d24f0ef8813fdbfe0d0 "sdl:
prefer sdl2 over sdl1", I can no longer release mouse pointer grab
unless I use --with-sdlabi=3D1.2 configure option.

This easily reproduces in e.g. guest Kubuntu, when I let it start Xorg
and then click into the QEMU window. After this the mouse is trapped and
no matter how I combine Ctrl+Alt and motion of the cursor, the pointer
never goes out from the window. When at the border, QEMU window switches
from "Press Ctrl+Alt to exit grab" to "QEMU", i.e. it thinks that it has
released the grab. But it hasn't really, so I have to go to VT1 and do
"pkill qemu" from there to get my pointer back.

** Affects: qemu
     Importance: Undecided
         Status: New

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
