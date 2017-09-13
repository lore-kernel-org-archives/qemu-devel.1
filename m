Received: from eggs.gnu.org ([2001:4830:134:3::10]:46728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2XW-0000Zl-Fb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2XT-00064r-H7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:43876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds2XT-00063c-Bf
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds2XR-00048k-GN
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:56:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BDDB32E84A3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:56:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:43:58 -0000
From: Thomas Huth <839790@bugs.launchpad.net>
Reply-To: Bug 839790 <839790@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110902181253.1208.72905.malonedeb@wampee.canonical.com>
Message-Id: <150528863897.29215.14714501127935004053.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 839790] Re: -usbdevice tablet broken on win XP
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

According to the Fedora bug, this has been fixed. And since there wasn't
any reply to the question in my last comment, I assume nobody
experiences this issue anymore. So closing this ticket now...

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/839790

Title:
  -usbdevice tablet broken on win XP client

Status in QEMU:
  Fix Released

Bug description:
  I'm using the qemu-kvm package from arch (not the qemu package), and
  on prior versions of qemu-kvm I was able to use -usbdevide tablet
  without problems.  The absolute mouse position is great...  With
  current version of qemu-kvm, when I use -usbdevice tablet, I got no
  mouse at all.  As my client is windows XP, it's not good to try do
  anything without mouse, :-)

  I searched in current bugs, and didn't find any bug which subject
  included "tablet", so I'm submitting this bug...

  Current qemu-kvm package in arch I'm using is:

  % pacman -Ss qemu-kvm
  extra/qemu-kvm 0.15.0-2 [installed]
      Latest KVM QEMU is a generic and open source processor emulator which=
 achieves a good emulation speed by using dynamic translation.

  Please notice I do not get any error, just the mouse broken...

  thanks,

  Javier.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/839790/+subscriptions
