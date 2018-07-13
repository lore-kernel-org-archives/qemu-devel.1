Received: from eggs.gnu.org ([2001:4830:134:3::10]:36387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdnr5-00032Y-BN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 22:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdnr0-0007sI-DM
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 22:30:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:43676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdnr0-0007s4-71
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 22:30:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdnqy-0006XK-Qg
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 02:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BC9842E8052
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 02:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jul 2018 02:16:57 -0000
From: Diego Viola <diego.viola@gmail.com>
Reply-To: Bug 1781515 <1781515@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153144791597.24345.4188684272748961598.malonedeb@chaenomeles.canonical.com>
Message-Id: <153144821716.23804.5319121004648467630.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1781515] Re: Resolution switch leads to the
 screen/image being corrupted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Switching the resolution with -vga std was working fine before, I'm not
sure on which version it started having this issue, but it should be on
a recent version.

I use the intel i915 drivers on the host OS.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1781515

Title:
  Resolution switch leads to the screen/image being corrupted

Status in QEMU:
  New

Bug description:
  I am currently using QEMU on a Arch Linux host, the guest OS is also
  Arch Linux.

  The QEMU version is currently 2.12.0-2 packaged by Arch Linux, the
  command line I'm using to fire an Arch VM is:

  $ qemu-system-x86_64 -enable-kvm -hda archlinux.qcow2 -m 4G -smp 4

  The problem I'm currently having is, after firing the VM and running
  startx I want to change the resolution to the native resolution, which
  is 1366x768 on my ThinkPad T450, however, after changing the
  resolution the image on the guest gets corrupted and it's impossible
  to see anything.

  At this point I can only turn off the VM. The only workaround I found
  is to start the VM with -vga virtio.

  The problem in this case occurs with -vga std which is the default
  video driver.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1781515/+subscriptions
