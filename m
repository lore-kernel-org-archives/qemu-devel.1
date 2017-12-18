Received: from eggs.gnu.org ([2001:4830:134:3::10]:51407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQqKz-0005EL-Ee
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQqKw-0008Lx-Cq
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:59:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:43004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQqKw-0008Le-6a
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:59:46 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQqKt-0002ZE-Li
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 07:59:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2B6142E818B
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 07:59:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 07:50:16 -0000
From: ChristianEhrhardt <1350435@bugs.launchpad.net>
Reply-To: Bug 1350435 <1350435@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140730162025.27276.9650.malonedeb@soybean.canonical.com>
Message-Id: <151358341795.24699.16758832648445111099.launchpad@wampee.canonical.com>
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

** Tags added: qemu-18.04

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
