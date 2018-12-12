Received: from eggs.gnu.org ([2001:4830:134:3::10]:48478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX05B-0003A5-1d
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX059-0005LA-J1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:41:28 -0500
Received: from indium.canonical.com ([91.189.90.7]:38970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gX059-0005KO-83
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:41:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gX058-0005Zt-9m
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:41:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 487A42E807E
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:41:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Dec 2018 08:31:39 -0000
From: Thomas Huth <1780812@bugs.launchpad.net>
Reply-To: Bug 1780812 <1780812@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153115106911.12886.11036147672468872471.malonedeb@gac.canonical.com>
Message-Id: <154460350024.28375.6058970767777904291.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1780812] Re: Full-Screen Switch Does Nothing When
 Using SDL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1780812

Title:
  Full-Screen Switch Does Nothing When Using SDL

Status in QEMU:
  Fix Released

Bug description:
  When using SDL switches, e.g.

  -sdl -full-screen -display sdl

  ... you'd expect the display to start full-screen, as per the switch
  description, but it just starts in a window. Pressing the full-screen
  key combination (Ctrl+Alt+F) enters fullscreen mode as expected.

  Tested on QEmu 2.12.0 using qemu-system-x86_64. OS is Arch Linux.
  Guest is Windows 98 in this test, but happens universally so the guest
  shouldn't be relevant in this instance.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1780812/+subscriptions
