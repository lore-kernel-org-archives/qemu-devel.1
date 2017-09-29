Received: from eggs.gnu.org ([2001:4830:134:3::10]:33021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxzHy-0002MH-Ux
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dxzHu-0007Fc-UL
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:41:26 -0400
Received: from indium.canonical.com ([91.189.90.7]:43826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dxzHu-0007EE-Ne
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:41:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1dxzHq-0002Ng-NK
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 17:41:18 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 70F612E80E8
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 17:41:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Sep 2017 17:27:50 -0000
From: Joshua Powers <josh.powers@canonical.com>
Reply-To: Bug 1718719 <1718719@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150601012428.28823.10384460665730601462.malonedeb@gac.canonical.com>
Message-Id: <150670607102.16564.9559662566795283410.malone@wampee.canonical.com>
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

Hi! I am running Artful on my X1 Carbon Gen3.

I downloaded the Ubuntu Server Artful final beta and attempt to do an
install with the following qemu cli:

$ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 -boot d -hda
vdisk.img -cdrom artful-server-amd64.iso -monitor stdio

Trying to use the arrow key at the first menu does not work and errors
with the unknown keycodes error. However, if I issue the `sendkey down`
command from the qemu CLI it works as expected.

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
