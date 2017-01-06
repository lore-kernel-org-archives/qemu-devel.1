Received: from eggs.gnu.org ([2001:4830:134:3::10]:54987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPINU-0007Cz-Gs
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 19:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cPINR-0000s6-EF
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 19:27:28 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Fri,  6 Jan 2017 08:26:24 +0800
Message-Id: <20170106002628.10343-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH v2 0/4] QOM'ify work for ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, peter.maydell@linaro.org, qemu-ppc@nongnu.org

This is some QOM'ify work relate with ppc.
See each commit message for details.

changes in v2:
  remove empty function 'spapr_vio_bridge_init'

xiaoqiang zhao (4):
  hw/gpio: QOM'ify mpc8xxx.c
  hw/ppc: QOM'ify e500.c
  hw/ppc: QOM'ify ppce500_spin.c
  hw/ppc: QOM'ify spapr_vio.c

 hw/gpio/mpc8xxx.c     | 20 +++++++++++---------
 hw/ppc/e500.c         | 17 ++++-------------
 hw/ppc/ppce500_spin.c | 18 ++++++++----------
 hw/ppc/spapr_vio.c    | 10 ----------
 4 files changed, 23 insertions(+), 42 deletions(-)

-- 
2.11.0
