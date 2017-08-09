Received: from eggs.gnu.org ([2001:4830:134:3::10]:43801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfKuY-0004M8-KH
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfKuV-0006td-I6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:56:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:46524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dfKuV-0006sY-C5
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 02:56:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dfKuT-0001QT-09
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 06:56:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E05602E80CC
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 06:56:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Aug 2017 06:36:47 -0000
From: Thomas Huth <1357175@bugs.launchpad.net>
Reply-To: Bug 1357175 <1357175@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140815031311.28738.47111.malonedeb@chaenomeles.canonical.com>
Message-Id: <150226060801.8764.18190083222129742511.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1357175] Re: qemu fails to build on powerpc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OK, thanks for checking!

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1357175

Title:
  qemu fails to build on powerpc64

Status in QEMU:
  Fix Released

Bug description:
  Qemu fails to build on powerpc64, ELFv1 ABI, since the introduction of
  the ELFv2 ABI support.  On FreeBSD/powerpc64 I see the following error
  building HEAD from today (8/14/2014):

  In file included from /home/chmeee/qemu-git/tcg/tcg.c:264:
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c:1737:3: error: #error "Unhandl=
ed abi"
  In file included from /home/chmeee/qemu-git/tcg/tcg.c:264:
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c: In function 'tcg_target_qemu_=
prologue':
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c:1766: error: 'LINK_AREA_SIZE' =
undeclared (first use in this function)
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c:1766: error: (Each undeclared =
identifier is reported only once
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c:1766: error: for each function=
 it appears in.)
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c:1778: error: 'LR_OFFSET' undec=
lared (first use in this function)
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c: At top level:
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c:2579: error: 'LINK_AREA_SIZE' =
undeclared here (not in a function)
  /home/chmeee/qemu-git/tcg/ppc/tcg-target.c:2605: error: 'LR_OFFSET' undec=
lared here (not in a function)
  gmake[1]: *** [tcg/tcg.o] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1357175/+subscriptions
