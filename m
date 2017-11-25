Received: from eggs.gnu.org ([2001:4830:134:3::10]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eIijm-0003tY-Dn
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 17:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eIijh-00031w-DR
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 17:15:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:49334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eIijh-00031d-6u
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 17:15:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eIijg-0002CG-2r
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 22:15:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 109332E8059
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 22:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Nov 2017 22:03:03 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1734474 <1734474@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151163832560.18460.16214125618253771985.malonedeb@gac.canonical.com>
Message-Id: <151164738311.14317.6634026424975800585.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1734474] Re: Maemo does not boot on emulated N800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

That's a regression, but unfortunately the n800 boards aren't really
maintained (I don't have any test images to hand, and the hardware is
long-gone these days). You could try a git bisect to see what commit
broke, if you want to investigate.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1734474

Title:
  Maemo does not boot on emulated N800

Status in QEMU:
  New

Bug description:
  I start QEMU with qemu-system-arm-m 130 -M n800 -kernel zImage.1 -mtdbloc=
k maemo.img -append "root=3D/dev/mtdblock3 rootfstype=3Djffs2"
  On QEMU 1.2.0 see "NOKIA" logo and then desktop appears, but on 1.5.0 and=
 newer (including latest versions) I see only white screen and no signs of =
life. Was this caused by regression or any syntax change?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1734474/+subscriptions
