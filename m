Received: from eggs.gnu.org ([2001:4830:134:3::10]:43758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F93-0008Qd-Hr
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F91-00088R-OT
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F91-00085i-Fu
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8u-0006w2-Na
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:40:57 +0100
Message-Id: <1492706470-10921-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/24] cadence_gem: Read the correct queue
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Read the correct descriptor instead of hardcoding the first (q=0).

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 988b183dcf951856d8b3379f7e911ec95233bbf4.1491947224.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
