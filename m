Received: from eggs.gnu.org ([2001:4830:134:3::10]:41922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fFKWd-0004q1-F1
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fFKWY-0008Mx-S8
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:20:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  6 May 2018 15:20:03 +0100
Message-Id: <20180506142005.19580-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
References: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/4] macio: add trace-events to timer device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/macio.c      | 3 +++
 hw/misc/macio/trace-events | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 79621eb879..f9a40eea81 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -32,6 +32,7 @@
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/intc/heathrow_pic.h"
+#include "trace.h"
 
 /* Note: this code is strongly inspirated from the corresponding code
  * in PearPC */
@@ -246,6 +247,7 @@ static void macio_oldworld_init(Object *obj)
 static void timer_write(void *opaque, hwaddr addr, uint64_t value,
                        unsigned size)
 {
+    trace_macio_timer_write(addr, size, value);
 }
 
 static uint64_t timer_read(void *opaque, hwaddr addr, unsigned size)
@@ -266,6 +268,7 @@ static uint64_t timer_read(void *opaque, hwaddr addr, unsigned size)
         break;
     }
 
+    trace_macio_timer_read(addr, size, value);
     return value;
 }
 
diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
index 24c0a36824..d499d78c99 100644
--- a/hw/misc/macio/trace-events
+++ b/hw/misc/macio/trace-events
@@ -9,3 +9,7 @@ cuda_packet_receive(int len) "length %d"
 cuda_packet_receive_data(int i, const uint8_t data) "[%d] 0x%02x"
 cuda_packet_send(int len) "length %d"
 cuda_packet_send_data(int i, const uint8_t data) "[%d] 0x%02x"
+
+# hw/misc/macio/macio.c
+macio_timer_write(uint64_t addr, unsigned len, uint64_t val) "write addr 0x%"PRIx64 " len %d val 0x%"PRIx64
+macio_timer_read(uint64_t addr, unsigned len, uint32_t val) "read addr 0x%"PRIx64 " len %d val 0x%"PRIx32
-- 
2.11.0
