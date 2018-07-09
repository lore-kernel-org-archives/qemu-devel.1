Received: from eggs.gnu.org ([2001:4830:134:3::10]:60719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcbP1-0000ox-OG
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcbOy-0004Z5-Nj
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:00:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:37450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fcbOy-0004Xt-HO
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 15:00:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fcbOx-0002ac-6q
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 19:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 10BE62E819C
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 19:00:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jul 2018 18:48:16 -0000
From: Thomas Huth <1780812@bugs.launchpad.net>
Reply-To: Bug 1780812 <1780812@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153115106911.12886.11036147672468872471.malonedeb@gac.canonical.com>
Message-Id: <153116209699.12523.12884364152047958854.malone@gac.canonical.com>
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

Suggested a patch here:
http://marc.info/?i=3D1531161850-6860-1-git-send-email-thuth@redhat.com

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1780812

Title:
  Full-Screen Switch Does Nothing When Using SDL

Status in QEMU:
  New

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
