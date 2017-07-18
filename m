Received: from eggs.gnu.org ([2001:4830:134:3::10]:60200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsS-0001eW-1O
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsR-0000kR-5O
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:46 -0300
Message-Id: <20170718061005.29518-11-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/29] net/rocker: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/rocker/rocker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 4f0f6d71e5..55228f2f52 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1419,7 +1419,7 @@ static int pci_rocker_init(PCIDevice *dev)
             desc_ring_set_consume(ring, cmd_consume, ROCKER_MSIX_VEC_CMD);
         } else if (i == ROCKER_RING_EVENT) {
             desc_ring_set_consume(ring, NULL, ROCKER_MSIX_VEC_EVENT);
-        } else if (i % 2 == 0) {
+        } else if (QEMU_IS_ALIGNED(i, 2)) {
             desc_ring_set_consume(ring, tx_consume,
                                   ROCKER_MSIX_VEC_TX((i - 2) / 2));
         } else if (i % 2 == 1) {
-- 
2.13.2
