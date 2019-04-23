Received: from eggs.gnu.org ([209.51.188.92]:49347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2h-0003hY-Qt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2g-000736-W6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:47507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIp2e-00071C-VU
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:33 -0400
From: Nick Hudson <nick.hudson@gmx.co.uk>
Date: Tue, 23 Apr 2019 07:36:19 +0100
Message-Id: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] HPPA fixes for NetBSD/hppa emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nick Hudson <nick.hudson@gmx.co.uk>, Kamil Rytarowski <kamil@netbsd.org>, "open list:NETBSD" <qemu-devel@nongnu.org>

v3 changes:
 - Don't use C99 comments and fix a typo in the comment

v2 changes:
 - remove old debug code

*** BLURB HERE ***

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
