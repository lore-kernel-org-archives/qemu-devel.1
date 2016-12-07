Received: from eggs.gnu.org ([2001:4830:134:3::10]:45176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEY1i-0001L7-AA
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEY1d-0007zS-AQ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:56:34 -0500
Received: from indium.canonical.com ([91.189.90.7]:51347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEY1d-0007zK-4e
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:56:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEY1Z-0002lS-16
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 08:56:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7CAE82E822C
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 08:56:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Dec 2016 08:41:34 -0000
From: Thomas Huth <1631625@bugs.launchpad.net>
Reply-To: Bug 1631625 <1631625@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161008161931.5791.70475.malonedeb@chaenomeles.canonical.com>
Message-Id: <20161207084134.12055.51215.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1631625] Re: target-mips/dsp_helper.c: two
 possible bad shifts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been committed:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De6e2784cacd4cfec149

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1631625

Title:
  target-mips/dsp_helper.c: two possible bad shifts

Status in QEMU:
  Fix Committed

Bug description:
  target-mips/dsp_helper.c:3480:1: error: V629 Consider inspecting the
  '0x01 << (size + 1)' expression. Bit shifting of the 32-bit value with
  a subsequent expansion to the 64-bit type.

  Source code is

          temp =3D temp & ((0x01 << (size + 1)) - 1);

  If size >=3D 32, then better code might be

          temp =3D temp & ((0x01UL << (size + 1)) - 1);

  target-mips/dsp_helper.c:3509:1: error: V629 Consider inspecting the
  '0x01 << (size + 1)' expression. Bit shifting of the 32-bit value with
  a subsequent expansion to the 64-bit type.

  Duplicate

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1631625/+subscriptions
