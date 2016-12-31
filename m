Received: from eggs.gnu.org ([2001:4830:134:3::10]:54851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8KJ-0001dT-Gs
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8KI-0000ON-LM
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:15 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:27 +0800
Message-Id: <20161231011831.4097-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 0/4] QOM'ify work for ppc
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

xiaoqiang zhao (4):
  hw/gpio: QOM'ify mpc8xxx.c
  hw/ppc: QOM'ify e500.c
  hw/ppc: QOM'ify ppce500_spin.c
  hw/ppc: QOM'ify spapr_vio.c

 hw/gpio/mpc8xxx.c     | 20 +++++++++++---------
 hw/ppc/e500.c         | 17 ++++-------------
 hw/ppc/ppce500_spin.c | 18 ++++++++----------
 hw/ppc/spapr_vio.c    |  2 --
 4 files changed, 23 insertions(+), 34 deletions(-)

-- 
2.11.0
