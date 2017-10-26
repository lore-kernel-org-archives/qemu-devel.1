Received: from eggs.gnu.org ([2001:4830:134:3::10]:35421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7iJm-0006V3-7i
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7iJj-0006ww-KD
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:35:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:51634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7iJj-0006vV-4j
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:35:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7iJg-0001XD-IW
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 13:35:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 49CB82E80DA
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 13:35:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Oct 2017 13:16:44 -0000
From: Thomas Huth <1368791@bugs.launchpad.net>
Reply-To: Bug 1368791 <1368791@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140912141944.25418.71896.malonedeb@soybean.canonical.com>
Message-Id: <150902380466.17619.15924810659664670422.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1368791] Re: qemu build fails on Ubuntu 10.04 LTS
 since recent pixman changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since 10.04 is already end-of-life, I'm closing this bug now. If you
still have problems with newer versions of Ubuntu, please open a new bug
instead.

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1368791

Title:
  qemu build fails on Ubuntu 10.04 LTS since recent pixman changes

Status in QEMU:
  Won't Fix

Bug description:
  Since commit 0dfa7e30126364c434a48cb37a1a41119e536c2a, the qemu git
  mainline no longer builds on Ubuntu 10.04 LTS.  The build fails with:

    CC    ui/input.o
  ui/qemu-pixman.c: In function 'qemu_pixelformat_from_pixman':
  ui/qemu-pixman.c:42: error: 'PIXMAN_TYPE_RGBA' undeclared (first use in t=
his function)
  ui/qemu-pixman.c:42: error: (Each undeclared identifier is reported only =
once
  ui/qemu-pixman.c:42: error: for each function it appears in.)
  make: *** [ui/qemu-pixman.o] Error 1

  Andreas Gustafsson, gson@gson.org

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1368791/+subscriptions
