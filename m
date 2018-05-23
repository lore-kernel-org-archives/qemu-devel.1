Received: from eggs.gnu.org ([2001:4830:134:3::10]:39541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLSgQ-0007JX-45
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fLSgM-0008SB-VG
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:15:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:39744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fLSgM-0008Ro-Od
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:15:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fLSgL-00039s-L8
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 12:15:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 870562E8F3A
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 12:15:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 May 2018 11:58:45 -0000
From: Askar Safin <safinaskar@mail.ru>
Reply-To: Bug 1425597 <1425597@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150225170051.24385.73738.malonedeb@wampee.canonical.com>
Message-Id: <152707672571.15942.11447307121906676548.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1425597] Re: moving window + changing screen
 resolution = bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The bug is not present in Qemu 2.12 (version reported by dpkg: qemu-
system-x86 1:2.12+dfsg-1+b1). There is similar minor bug instead. The
new bug doesn't harm me and I am not even sure is this a bug.

So, this is info about new minor bug.

Host is Debian Sid installed today (23 May MSK) with mentioned Qemu
2.12. I run Qemu in X using:

# qemu-system-x86_64 -m 1024 -daemonize -snapshot -drive
file=3D/dev/sda,format=3Draw,cache=3Dnone -kernel /boot/vmlinuz* -initrd
/boot/initrd* -append root=3D/dev/sda

Then I started to move Qemu window using mouse. I kept Qemu window
catched by my mouse while guest OS boot. At some moment guest OS (Linux)
switched from text mode to framebuffer. Internal screen resolution
changed, but Qemu window didn't change its size (I kept moving Qemu
window all this time), but likely window content didn't scale (this is
as opposed to 3d30395f [3d30395f7fb3315e4ecf0de4e48790e1326bbd47]
behavior, 3d30395f scaled window content). So text in window remain
concrete (not fluid, as opposed to 3d30395f). Then I tried to resize
Qemu window and window size imidiately became normal, i. e. it started
to fit content.

All this is acceptable for me. I. e. I see this is nothing wrong when
Qemu cannot change its window size when I move Qemu window

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1425597

Title:
  moving window + changing screen resolution =3D bug

Status in QEMU:
  Incomplete

Bug description:
  Steps to reproduce:
  1. Run qemu (sdl)
  2. Start moving the window
  3. At that moment the virtualized OS should change its screen resolution =
(for example, when switching from initial qemu screen to grub)

  What I see:
  Window size doesn't change, but internal screen resolution changes, so, i=
mage scale stops to be 1:1, now I see virtualized OS in wrong scale.

  What I expected to see:
  Window size changes so, that it keeps synchronized with internal resoluti=
on (as usual)

  This bug preserves at lastest git version at the moment, i. e.
  3d30395f7fb3315e4ecf0de4e48790e1326bbd47

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1425597/+subscriptions
