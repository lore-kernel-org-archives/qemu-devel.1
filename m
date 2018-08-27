Received: from eggs.gnu.org ([2001:4830:134:3::10]:44074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fuIeo-0001eI-Hf
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fuISn-0000F1-Ru
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:25:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:41286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fuISn-0000Dl-IT
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:25:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fuISl-0006QE-4N
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 14:25:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AF1EF2E80CE
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 14:25:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Aug 2018 14:18:23 -0000
From: Thomas Huth <1780812@bugs.launchpad.net>
Reply-To: Bug 1780812 <1780812@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153115106911.12886.11036147672468872471.malonedeb@gac.canonical.com>
Message-Id: <153537950388.6556.7464573606452918007.malone@gac.canonical.com>
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

Fix has been merged:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D6fb34ffcaae0823

** Changed in: qemu
       Status: New =3D> Fix Committed

** Changed in: qemu
     Assignee: (unassigned) =3D> Thomas Huth (th-huth)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1780812

Title:
  Full-Screen Switch Does Nothing When Using SDL

Status in QEMU:
  Fix Committed

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
