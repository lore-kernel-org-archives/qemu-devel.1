Received: from eggs.gnu.org ([2001:4830:134:3::10]:53985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dy0gx-0002qZ-57
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dy0gt-0002o8-VQ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:11:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:58632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dy0gt-0002nl-PD
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:11:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dy0gr-0002Am-00
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 19:11:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F1FFF2E808B
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 19:11:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Sep 2017 18:59:51 -0000
From: =?utf-8?q?Jonas_=C3=85dahl?= <1718719@bugs.launchpad.net>
Reply-To: Bug 1718719 <1718719@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150601012428.28823.10384460665730601462.malonedeb@gac.canonical.com>
Message-Id: <150671159126.17620.11200240855267458327.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1718719] Re: qemu can't capture keys properly
 under wayland
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Upstream bug is probably
https://bugs.freedesktop.org/show_bug.cgi?id=3D102475 ?

** Bug watch added: freedesktop.org Bugzilla #102475
   https://bugs.freedesktop.org/show_bug.cgi?id=3D102475

** Also affects: xserver via
   https://bugs.freedesktop.org/show_bug.cgi?id=3D102475
   Importance: Unknown
       Status: Unknown

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1718719

Title:
  qemu can't capture keys properly under wayland

Status in QEMU:
  New
Status in XServer:
  Unknown
Status in qemu package in Ubuntu:
  New
Status in wayland package in Ubuntu:
  New

Bug description:
  This appears to be different than the previous similar bugs; patches
  do look to be applied to use libinput in the wayland case. Still:

  unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org

  I am using qemu-system-x86                       1:2.10+dfsg-0ubuntu1
  on artful.

  Many key inputs work correctly, but at boot the system will not
  properly catch the arrow keys, the above error shows up immediately
  after hitting Esc (for instance) to get to the boot menu. Booting from
  CD onto a daily Ubuntu desktop image, I can't navigate the splash
  menu.

  The same works correctly through virt-manager (which uses spice
  AFAICT, but wayland tends to crash when running virt-manager), and
  things work if I switch my session to Xorg rather than wayland.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1718719/+subscriptions
