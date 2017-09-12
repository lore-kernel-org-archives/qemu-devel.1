Received: from eggs.gnu.org ([2001:4830:134:3::10]:57368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dri42-0004xv-KK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dri3x-0003co-MI
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:05:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:53220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dri3x-0003bj-GT
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:05:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dri3w-00072E-Gh
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:05:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 72D6E2E8486
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:05:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Sep 2017 09:45:51 -0000
From: Philosophish <philosophish@gmail.com>
Reply-To: Bug 1135567 <1135567@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130228104653.3556.64942.malonedeb@soybean.canonical.com>
Message-Id: <150520955157.32282.10731642024196215044.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1135567] Re: QXL crashes a Windows 7 guest if
 host goes into screensaver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Obviously my hardware configuration and versions etc. have changed.

Also, I have taken to not using screensavers in the virtual machines
anymore i.e. disabled.

BUT: I have set it up as similarly as possible and the crash/freeze/hang
up with current versions of the drivers seems to be gone.

So I guess the ticket can be closed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1135567

Title:
  QXL crashes a Windows 7 guest if host goes into screensaver

Status in QEMU:
  Incomplete

Bug description:
  Note: if further information is required, I'll be glad to supply it.

  I am using on the host
  - HP z800 with 72GB RAM and 2x x5680
  - Gentoo 64-bit host (3.7.9 kernel, FGLRX RADEON driver 13.1)
  - LIBVIRT 1.0.2 with QEMU(-KVM) 1.4.0

  The guest:
  - Windows 7 32-bit
  - 2GB allocated
  - 2 CPU
  - using virtio for everything (disk,net,memballoon)
  - Display =3D SPICE with spice channel
  - Video driver is qxl (ram says 64MB)
  - Spice-guest-tools 0.52 installed

  When I use QXL and  have the guest open in Virt-Manager/Virt-Viewer
  and let the host go into screensaver mode, the Win7 crashes hard.

  When I change video to VGA, it survives the screen saver,  no problem
  at all ,smooth sailing.

  regards

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1135567/+subscriptions
