Received: from eggs.gnu.org ([2001:4830:134:3::10]:49788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcYas-0003eW-0O
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fcYam-0004sY-4z
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:00:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:36988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fcYal-0004qw-VC
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:00:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fcYak-00056x-4I
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 16:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 182572E802D
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 16:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jul 2018 15:50:19 -0000
From: Benjamin Hodgetts <ben@xnode.org>
Reply-To: Bug 1780815 <1780815@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153115141921.29497.8768235999219760846.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1780815] [NEW] SDL Doesn't Rescale Image on
 Resolution Change
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

Whilst in fullscreen mode, if the guest changes resolution for whatever
reason, the screen doesn't update the scaling so you end up looking at
only part of the screen, e.g. if the guest changes from 640x480 to
1024x768, the image will still be fullscreen, but what you're actually
looking at will be the top-left most 640x480 segment of the screen
stretched out.

Manually going out of fullscreen mode and then back in fixes the
scaling, but you have to do that every time the guest changes
resolution.

QEmu 2.12.0 using qemu-system-x86_64 with Arch Linux host.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: sdl

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1780815

Title:
  SDL Doesn't Rescale Image on Resolution Change

Status in QEMU:
  New

Bug description:
  Whilst in fullscreen mode, if the guest changes resolution for
  whatever reason, the screen doesn't update the scaling so you end up
  looking at only part of the screen, e.g. if the guest changes from
  640x480 to 1024x768, the image will still be fullscreen, but what
  you're actually looking at will be the top-left most 640x480 segment
  of the screen stretched out.

  Manually going out of fullscreen mode and then back in fixes the
  scaling, but you have to do that every time the guest changes
  resolution.

  QEmu 2.12.0 using qemu-system-x86_64 with Arch Linux host.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1780815/+subscriptions
