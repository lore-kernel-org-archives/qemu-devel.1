Received: from eggs.gnu.org ([2001:4830:134:3::10]:37371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKuK5-0003I8-Ky
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 18:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dKuK2-0007W9-Gc
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 18:30:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:33540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dKuK2-0007Vi-BL
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 18:30:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dKuJz-0005Om-7p
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:29:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3189D2E81C5
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 22:29:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2017 22:17:05 -0000
From: PeteVine <davine@poczta.onet.pl>
Reply-To: Bug 893208 <893208@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111121171820.16487.92704.malonedeb@chaenomeles.canonical.com>
Message-Id: <149739222577.8544.17606102740238494602.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 893208] Re: qemu on ARM hosts can't boot i386
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Indeed, I had no problem booting the images this time around:

https://asciinema.org/a/d2m42g5c0n3z2pnbskhirdv5j

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/893208

Title:
  qemu on ARM hosts can't boot i386 image

Status in QEMU:
  Fix Committed
Status in Linaro QEMU:
  New

Bug description:
  If you apply some workarounds for bug 870990, bug 883133 and bug
  883136 QEMU still cannot boot the i386
  debian_squeeze_i386_standard.qcow2 image from
  http://people.debian.org/~aurel32/qemu/i386/ -- grub starts to boot
  but something causes the system to reset just before display of the
  blue-background grub menu, so we go round in a loop forever. This
  image boots OK on i386 hosted qemu so this indicates some kind of ARM-
  host specific bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/893208/+subscriptions
