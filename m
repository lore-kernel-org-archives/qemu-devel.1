Received: from eggs.gnu.org ([2001:4830:134:3::10]:35910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYcu-000379-2A
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cvYcq-0003R4-TM
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:16:44 -0400
Received: from mail-sn1nam01on0088.outbound.protection.outlook.com
	([104.47.32.88]:56128
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cvYcq-0003Ps-LC
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:16:40 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 4 Apr 2017 16:40:04 -0700
Message-ID: <a0d9c14a38201af8f4838e2c84cadec573d56e13.1491349058.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491349058.git.alistair.francis@xilinx.com>
References: <cover.1491349058.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/5] cadence_gem: Read the correct queue
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Read the correct descriptor instead of hardcoding the first (q=0).

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/net/cadence_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d4de8ad..17c229d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -790,8 +790,8 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
 {
     DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
     /* read current descriptor */
-    cpu_physical_memory_read(s->rx_desc_addr[0],
-                             (uint8_t *)s->rx_desc[0], sizeof(s->rx_desc[0]));
+    cpu_physical_memory_read(s->rx_desc_addr[q],
+                             (uint8_t *)s->rx_desc[q], sizeof(s->rx_desc[q]));
 
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
-- 
2.9.3
