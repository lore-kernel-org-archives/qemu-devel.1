Received: from eggs.gnu.org ([2001:4830:134:3::10]:57661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqh-0000td-Kw
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g6rqc-0005O2-L1
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:31 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:40787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g6rqc-00058e-EO
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 02:38:26 -0400
Received: from player699.ha.ovh.net (unknown [10.109.159.20])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 716ED1B47A1
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 08:38:13 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  1 Oct 2018 08:37:52 +0200
Message-Id: <20181001063803.22330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/11] net: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Hello,

Here is my take to the SysBus init to realize method conversion. I
picked the /net directory and did them all. Also added a couple of
reset methods in separate patches.

make check tested

Thanks,

C.

Changes since v1:

 - dropped changes in lan9118_init() and smc91c111_init()
 - fix alignment in milkymist_minimac2_realize()
 - improved etraxfs reset method
=20

C=C3=A9dric Le Goater (11):
  net: etraxfs_eth: convert SysBus init method to a realize method
  net: etraxfs_eth: add a reset method
  net: lan9118: convert SysBus init method to a realize method
  net: lance: convert SysBus init method to a realize method
  net: milkymist_minimac2: convert SysBus init method to a realize
    method
  net: mipsnet: convert SysBus init method to a realize method
  net: opencores_eth: convert SysBus init method to a realize method
  net: smc91c111: convert SysBus init method to a realize method
  net: stellaris_enet: convert SysBus init method to a realize method
  net: stellaris_enet: add a reset method
  net: xgmac: convert SysBus init method to a realize method

 hw/net/etraxfs_eth.c        | 44 ++++++++++++++++++++++++++-----------
 hw/net/lan9118.c            |  9 +++-----
 hw/net/lance.c              |  8 +++----
 hw/net/milkymist-minimac2.c |  9 +++-----
 hw/net/mipsnet.c            |  9 +++-----
 hw/net/opencores_eth.c      |  8 +++----
 hw/net/smc91c111.c          |  8 +++----
 hw/net/stellaris_enet.c     | 15 ++++++-------
 hw/net/xgmac.c              |  9 +++-----
 9 files changed, 59 insertions(+), 60 deletions(-)

--=20
2.17.1
