Received: from eggs.gnu.org ([2001:4830:134:3::10]:44691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsrc-0004b3-8E
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsrX-0007SO-9v
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:58504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsrX-0007PV-3p
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:29:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsrU-0006T0-6O
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:29:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 746292E8198
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:29:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:16:29 -0000
From: Thomas Huth <1350435@bugs.launchpad.net>
Reply-To: Bug 1350435 <1350435@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140730162025.27276.9650.malonedeb@soybean.canonical.com>
Message-Id: <151335459095.10149.15908861134447867374.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1350435] Re: tcg.c:1693: tcg fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1350435

Title:
  tcg.c:1693: tcg fatal error

Status in launchpad-buildd:
  Won't Fix
Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  this started happening after the launchpad buildd trusty deploy
  https://code.launchpad.net/~costamagnagianfranco/+archive/ubuntu/firefox/=
+build/6224439

  =

  debconf-updatepo
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)
  /build/buildd/qemu-2.0.0+dfsg/tcg/tcg.c:1693: tcg fatal error
  /build/buildd/qemu-2.0.0+dfsg/tcg/tcg.c:1693: tcg fatal error

  this seems to be the patch needed
  https://patches.linaro.org/32473/

To manage notifications about this bug go to:
https://bugs.launchpad.net/launchpad-buildd/+bug/1350435/+subscriptions
