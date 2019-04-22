Received: from eggs.gnu.org ([209.51.188.92]:54301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIYJz-0004m0-Ld
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIY9R-0005Ji-Ss
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:38087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIY9R-00059c-KE
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:25 -0400
From: Nick Hudson <nick.hudson@gmx.co.uk>
Date: Mon, 22 Apr 2019 13:34:09 +0100
Message-Id: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] HPPA fixes for NetBSD/hppa emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nick Hudson <skrll@netbsd.org>, Kamil Rytarowski <kamil@netbsd.org>, "open list:NETBSD" <qemu-devel@nongnu.org>

From: Nick Hudson <skrll@netbsd.org>

Here are the required changes to allow qemu to emulate NetBSD/hppa.

v2 changes:
 - remove old debug code

Nick Hudson (2):
  Implement the pcxl and pcxl2 Fast TLB Insert instructions as used by
    NetBSD (and OpenBSD)
  Always return EXCP_DMAR for protection id trap as EXCP_DMP is
    considered legacy.

 target/hppa/insns.decode |  3 +++
 target/hppa/mem_helper.c |  3 +--
 target/hppa/translate.c  | 52 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

=2D-
2.17.1
