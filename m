Received: from eggs.gnu.org ([2001:4830:134:3::10]:55684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dvHxV-0008Mj-Fr
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dvHxQ-0006Jy-M2
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:01:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:36202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dvHxQ-0006Iy-Fs
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:01:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dvHxN-00035B-Vb
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:01:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED8A42E8499
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:01:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Sep 2017 06:54:14 -0000
From: ChristianEhrhardt <1718719@bugs.launchpad.net>
Reply-To: Bug 1718719 <1718719@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150601012428.28823.10384460665730601462.malonedeb@gac.canonical.com>
Message-Id: <150606325476.29033.6893934439290641519.malone@gac.canonical.com>
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

I wanted to write steps to reproduce, which should be as simple as:
$ wget http://cdimage.ubuntu.com/daily-live/current/artful-desktop-amd64.iso
$ qemu-system-x86_64 -m 512 -boot d -cdrom artful-desktop-amd64.iso

But that works for me as seen in the attached video.
@Mathieu - can you elaborate how to trigger the missing key issue?

** Attachment added: "Screencast 2017-09-22 08:52:05.mp4"
   https://bugs.launchpad.net/ubuntu/+source/wayland/+bug/1718719/+attachme=
nt/4954840/+files/Screencast%202017-09-22%2008%3A52%3A05.mp4

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
