Received: from eggs.gnu.org ([2001:4830:134:3::10]:56375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQBv9-0006sO-KK
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQBv5-0002PQ-RS
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 08:54:59 -0500
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 23 Nov 2018 14:54:50 +0100
Message-Id: <20181123135450.24829-2-edgar.iglesias@gmail.com>
In-Reply-To: <20181123135450.24829-1-edgar.iglesias@gmail.com>
References: <20181123135450.24829-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/1] net: cadence_gem: Remove incorrect
 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Don't assert on RX descriptor settings when the receiver is
disabled. This fixes an issue with incoming packets on an
unused GEM.

Reported-by: mbilal <muhammad_bilal@mentor.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d95cc27f58..7f63411430 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -979,7 +979,6 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 
         /* Do nothing if receive is not enabled. */
         if (!gem_can_receive(nc)) {
-            assert(!first_desc);
             return -1;
         }
 
-- 
2.17.1
