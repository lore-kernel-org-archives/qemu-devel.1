Received: from eggs.gnu.org ([2001:4830:134:3::10]:52053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdpsv-0003xX-Cg
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 00:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdpss-0006tx-9j
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 00:40:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:53720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdpss-0006sf-1V
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 00:40:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdpsq-0001zy-Ka
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 04:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6519B2E80CB
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 04:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jul 2018 04:27:20 -0000
From: Diego Viola <diego.viola@gmail.com>
Reply-To: Bug 1781515 <1781515@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153144791597.24345.4188684272748961598.malonedeb@chaenomeles.canonical.com>
Message-Id: <153145604070.4580.16253397693096247659.malone@gac.canonical.com>
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

Hi Francisco, thanks for your quick reply.

I've tried `xrandr --output Virtual-1 --mode 1360x768' with -vga std and
I also get a corrupted image.

I'm attaching a screenshot of what the screen corruption looks like
after changing the resolution.

Thanks.

** Attachment added: "qemu.png"
   https://bugs.launchpad.net/qemu/+bug/1781515/+attachment/5163111/+files/=
qemu.png

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
