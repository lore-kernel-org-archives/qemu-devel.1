Received: from eggs.gnu.org ([2001:4830:134:3::10]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWK-00036t-Vn
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWH-0003Lm-NS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 14:13:16 -0300
Message-Id: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 0/7] Generalize MDIO framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi,

I have a follow up series using multiples PHY on the MDIO bus based on this
series.

Regards,

Phil.

Grant's previous work:
http://lists.nongnu.org/archive/html/qemu-devel/2013-02/msg00257.html

"There is more work to be done, particularly in moving to the common GPIO api,
 but that work can be done as a follow on patch series."

Grant Likely (7):
  hw/mdio: Generalize etraxfs MDIO bitbanging emulation
  hw/mdio: Add PHY register definition
  hw/mdio: Generalize phy initialization routine
  hw/mdio: Mask out read-only bits.
  hw/mdio: Refactor bitbanging state machine
  hw/mdio: Add VMState support
  hw/mdio: Use bitbang core for smc91c111 network device

 include/hw/net/mdio.h   | 124 +++++++++++++++++++++
 hw/net/etraxfs_eth.c    | 291 +-----------------------------------------------
 hw/net/mdio.c           | 280 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/net/smc91c111.c      |  27 ++++-
 hw/net/xilinx_axienet.c | 189 +------------------------------
 hw/net/Makefile.objs    |   2 +
 6 files changed, 438 insertions(+), 475 deletions(-)
 create mode 100644 include/hw/net/mdio.h
 create mode 100644 hw/net/mdio.c

-- 
2.14.1
