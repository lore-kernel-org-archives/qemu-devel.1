Received: from eggs.gnu.org ([2001:4830:134:3::10]:56409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7iH-0007MX-Tg
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC7iD-0007xb-DE
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:31:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC7iD-0007x8-6s
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:30:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC7iC-0008Io-3C
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 17:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 04B3A2E80D2
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 17:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:16:36 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1151450 <1151450@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130307063955.30520.24052.malonedeb@chaenomeles.canonical.com>
Message-Id: <151007499612.4565.16900035436727060853.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1151450] Re: wrong description in qemu manual
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This typo was fixed in commit db2d5eba652ec back in 2013, but we forgot
to close the bug. Oops, and belated thanks for the report!


** Changed in: qemu
       Status: New =3D> Fix Committed

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1151450

Title:
  wrong description in qemu manual

Status in QEMU:
  Fix Released

Bug description:
  =

  Description:
  man qemu, there is a line:
  qemu-system-x86_84 --drive file=3Dgluster://192.0.2.1/testvol/a.img
  seems should be:
  qemu-system-x86_64 --drive file=3Dgluster://192.0.2.1/testvol/a.img

  Additional info:
  * operating system
  arch linux x86_64
  * package version(s)
  1.4.0
  * config and/or log files etc.

  =

  Steps to reproduce:
  man qemu

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1151450/+subscriptions
