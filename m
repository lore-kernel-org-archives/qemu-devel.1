Received: from eggs.gnu.org ([2001:4830:134:3::10]:42230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1kB-0000Jy-Tk
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds1k8-0000mO-Nb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:05:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:34727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds1k8-0000lI-EQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:05:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds1k6-0002wj-Tb
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:05:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BF9E92E8492
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:05:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 06:52:27 -0000
From: Thomas Huth <1135567@bugs.launchpad.net>
Reply-To: Bug 1135567 <1135567@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130228104653.3556.64942.malonedeb@soybean.canonical.com>
Message-Id: <150528554782.5566.7353163024471116557.malone@wampee.canonical.com>
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

Thanks for checking! ... so I'm closing this ticket now.

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1135567

Title:
  QXL crashes a Windows 7 guest if host goes into screensaver

Status in QEMU:
  Fix Released

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
