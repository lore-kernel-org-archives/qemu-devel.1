Received: from eggs.gnu.org ([2001:4830:134:3::10]:52249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dvHe8-00012T-8h
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dvHe5-0001Is-5h
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:41:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:53632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dvHe4-0001Ig-Vq
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:41:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dvHe2-00029D-VL
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 06:41:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D5A3E2E8490
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 06:41:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Sep 2017 06:34:22 -0000
From: ChristianEhrhardt <1718719@bugs.launchpad.net>
Reply-To: Bug 1718719 <1718719@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150601012428.28823.10384460665730601462.malonedeb@gac.canonical.com>
Message-Id: <150606206243.30646.1570377130776394901.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1718719] Re: qemu can't capture keys properly
 under wayland
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Mathieu,
thanks for the report but since we are up-to-date with qemu and I can't fin=
d an obvious breakage we might have introduced for this, this should go to =
qmeu-upstream in this case.

Furthermore are these actually two issues?:
#1 - wayland crashes under spice
     more of a wayland bug then I'd expect, but upstream qemu
     might have heard of it and have good pointers
#2 - new qemu does not recognize keys correctly with the default (SDL I'd t=
hink) frontend?
     That is worth to report upstream qemu for sure.

I added an upstream qemu (and a wayland) task and you can help them to
recreate in case they have questions on how exactly to do so.

** Also affects: qemu
   Importance: Undecided
       Status: New

** Also affects: wayland (Ubuntu)
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1718719

Title:
  qemu can't capture keys properly under wayland

Status in QEMU:
  New
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
