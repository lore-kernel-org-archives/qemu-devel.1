Received: from eggs.gnu.org ([209.51.188.92]:60111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmZAN-00058U-Fq
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gmZAM-0006r2-8o
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:11:11 -0500
Received: from indium.canonical.com ([91.189.90.7]:39602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gmZAM-0006m3-3N
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:11:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gmZAK-00050w-8Q
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 07:11:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3C9592E80C7
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 07:11:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Jan 2019 06:57:40 -0000
From: Thomas Huth <1392468@bugs.launchpad.net>
Reply-To: Bug 1392468 <1392468@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141113201019.18949.57499.malonedeb@gac.canonical.com>
Message-Id: <154831306082.29374.822591317537161579.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1392468] Re: qemu uses a bitmap icon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Finally fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da442fe2f2b2f20e7be0

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1392468

Title:
  qemu uses a bitmap icon

Status in QEMU:
  Fix Committed

Bug description:
  qemu currently uses the icon in pc-bios/qemu-icon.bmp, which,
  obviously, is a bitmap file. It is loaded such that white pixels will
  be transparent. This can cause nasty artifacts in the display.

  Unless there is a specific reason to use bitmaps, I'd suggest moving
  to, e.g., a PNG file with a proper alpha channel.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1392468/+subscriptions
