Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df9z9-0000UZ-VJ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df9z5-0006Ka-1B
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:16:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:33883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1df9z4-0006Jr-RB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:16:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1df9z2-0001IG-7a
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 19:16:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 47BF12E81C7
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 19:16:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 19:04:59 -0000
From: Justin Hibbits <chmeeedalf+lp@gmail.com>
Reply-To: Bug 1357175 <1357175@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140815031311.28738.47111.malonedeb@chaenomeles.canonical.com>
Message-Id: <150221909962.17173.7289337918868161397.malone@gac.canonical.com>
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

It looks like this has been fixed in the intervening 3 years.  I just
tried building head on FreeBSD/powerpc64, and was successful.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1357175

Title:
  qemu fails to build on powerpc64

Status in QEMU:
  Incomplete

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
