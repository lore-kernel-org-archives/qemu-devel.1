Received: from eggs.gnu.org ([2001:4830:134:3::10]:59922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6wcw-0006Sa-P6
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6wcr-000449-HY
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:44:38 -0400
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:53143)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6wcr-00043A-A9
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 07:44:33 -0400
Received: from player791.ha.ovh.net (unknown [10.109.146.143])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 22DF2186275
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 13:44:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 13:44:19 +0200
Message-Id: <20181001114421.1377-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] ppc: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here are a couple of patches converting the SysBus init method to a
realize method. make check tested only.

Thanks,

C.


C=C3=A9dric Le Goater (2):
  ppc440_pcix: convert SysBus init method to a realize method
  ppc4xx_pci: convert SysBus init method to a realize method

 hw/ppc/ppc440_pcix.c | 14 ++++++--------
 hw/ppc/ppc4xx_pci.c  | 14 ++++++--------
 2 files changed, 12 insertions(+), 16 deletions(-)

--=20
2.17.1
