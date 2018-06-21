Received: from eggs.gnu.org ([2001:4830:134:3::10]:50370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39G-0004tF-Q5
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39F-0002BN-R7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:54 -0300
Message-Id: <20180621171257.14897-9-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/11] hw/net/ne2000: Convert printf() calls to
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/ne2000.c     | 8 ++------
 hw/net/trace-events | 2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 26b234b7eb..07d79e317f 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -277,9 +277,7 @@ static void ne2000_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     int offset, page, index;
 
     addr &= 0xf;
-#ifdef DEBUG_NE2000
-    printf("NE2000: write addr=0x%x val=0x%02x\n", addr, val);
-#endif
+    trace_ne2000_ioport_write(addr, val);
     if (addr == E8390_CMD) {
         /* control register */
         s->cmd = val;
@@ -442,9 +440,7 @@ static uint32_t ne2000_ioport_read(void *opaque, uint32_t addr)
             break;
         }
     }
-#ifdef DEBUG_NE2000
-    printf("NE2000: read addr=0x%x val=%02x\n", addr, ret);
-#endif
+    trace_ne2000_ioport_read(addr, ret);
     return ret;
 }
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 95a1de01e9..f57010df37 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -26,6 +26,8 @@ mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (0x%02x)"
 # hw/net/ne2000.c
 ne2000_read(uint64_t addr, uint64_t val) "read addr=0x%" PRIx64 " val=0x%" PRIx64
 ne2000_write(uint64_t addr, uint64_t val) "write addr=0x%" PRIx64 " val=0x%" PRIx64
+ne2000_ioport_read(uint64_t addr, uint64_t val) "io read addr=0x%02" PRIx64 " val=0x%02" PRIx64
+ne2000_ioport_write(uint64_t addr, uint64_t val) "io write addr=0x%02" PRIx64 " val=0x%02" PRIx64
 
 # hw/net/opencores_eth.c
 open_eth_mii_write(unsigned idx, uint16_t v) "MII[0x%02x] <- 0x%04x"
-- 
2.18.0.rc2
