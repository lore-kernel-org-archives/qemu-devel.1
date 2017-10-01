Received: from eggs.gnu.org ([2001:4830:134:3::10]:38538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dyYP9-0007wb-0Y
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 03:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dyYP5-0000jf-L3
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 03:11:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:59920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dyYP5-0000io-Ef
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 03:11:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dyYP3-0001cf-Aw
	for <qemu-devel@nongnu.org>; Sun, 01 Oct 2017 07:11:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4BB102E8076
	for <qemu-devel@nongnu.org>; Sun,  1 Oct 2017 07:11:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Oct 2017 07:05:40 -0000
From: Timo Aaltonen <tjaalton@ubuntu.com>
Reply-To: Bug 1718719 <1718719@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150601012428.28823.10384460665730601462.malonedeb@gac.canonical.com>
Message-Id: <150684154017.27741.13427131973194039947.malone@gac.canonical.com>
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

Actually, this bug would affect current 1.19-branch too since the
patches are backported there as well. You can test
ppa:canonical-x/x-staging to verify, which has xorg-server from current
stable branch.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1718719

Title:
  qemu can't capture keys properly under wayland

Status in QEMU:
  New
Status in XServer:
  Incomplete
Status in qemu package in Ubuntu:
  New
Status in xorg-server package in Ubuntu:
  Triaged

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
