Received: from eggs.gnu.org ([2001:4830:134:3::10]:53065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97O-0001uz-Ha
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb97L-00074W-E6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:22 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:53444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb97L-00072q-89
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:04:19 -0500
Received: from player687.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E0BDCA2659
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:04:15 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 15 Jan 2018 19:04:00 +0100
Message-Id: <20180115180406.28489-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] ppc/pnv: misc fixes and cleanups for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here are some preliminary and straight forward fixes before adding
POWER9 support to the PowerNV machine.

The full tree can be found here :

  https://github.com/legoater/qemu powernv-2.12

Thanks,

C.=20

C=C3=A9dric Le Goater (6):
  ppc/pnv: use POWER9 DD2 processor
  ppc/pnv: change core mask for POWER9
  ppc/pnv: introduce pnv*_is_power9() helpers
  ppc/pnv: fix XSCOM core addressing on POWER9
  ppc/pnv: change initrd address
  target/ppc: add support for POWER9 HILE

 hw/ppc/pnv.c               | 23 ++++++++++++-----------
 hw/ppc/pnv_core.c          |  2 +-
 hw/ppc/pnv_xscom.c         |  8 +++-----
 include/hw/ppc/pnv.h       | 11 ++++++++++-
 include/hw/ppc/pnv_xscom.h | 13 +++++++++++--
 target/ppc/cpu.h           |  1 +
 target/ppc/excp_helper.c   |  2 +-
 tests/pnv-xscom-test.c     | 31 +++++++++++++++++++------------
 8 files changed, 58 insertions(+), 33 deletions(-)

--=20
2.13.6
