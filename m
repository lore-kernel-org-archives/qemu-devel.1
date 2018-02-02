Received: from eggs.gnu.org ([2001:4830:134:3::10]:51744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ehh7X-0005n6-Rv
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ehh7T-00059V-VA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:35:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:56212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ehh7T-00057U-Ll
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:35:31 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ehh7R-0008Bg-UC
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 19:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E388C2E804C
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 19:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Feb 2018 19:28:41 -0000
From: Ruslan <b7.10110111@gmail.com>
Reply-To: Bug 1703795 <1703795@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149985188503.15456.11517595781983565935.malonedeb@wampee.canonical.com>
Message-Id: <151759972158.29200.275303343104790361.malone@chaenomeles.canonical.com>
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

I can confirm that the patch from comment #9 appears to fix the original
problem.

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
