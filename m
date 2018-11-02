Received: from eggs.gnu.org ([2001:4830:134:3::10]:56698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIN5b-0000pm-Gx
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIN5a-00054P-L3
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:13:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Nov 2018 01:12:59 +0100
Message-Id: <20181102001303.32640-4-f4bug@amsat.org>
In-Reply-To: <20181102001303.32640-1-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.2 v2 3/7] hw/arm/bcm2835: Use 0x prefix
 for hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/bcm2835_aux.c      | 2 +-
 hw/intc/bcm2836_control.c  | 4 ++--
 hw/misc/bcm2835_property.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 0364596c55..9632e8972c 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -159,7 +159,7 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
     case AUX_ENABLES:
         if (value != 1) {
             qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable SPI "
-                          "or disable UART\n", __func__);
+                          "or disable UART: 0x%lx\n", __func__, value);
         }
         break;
 
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index cfa5bc7365..96cc53f8a7 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -204,8 +204,8 @@ static void bcm2836_control_write(void *opaque, hwaddr offset,
     } else if (offset >= REG_MBOX0_RDCLR && offset < REG_LIMIT) {
         s->mailboxes[(offset - REG_MBOX0_RDCLR) >> 2] &= ~val;
     } else {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
-                      __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx" 0x%lx\n",
+                      __func__, offset, val);
         return;
     }
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 5d332324bd..c715cbaef6 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -277,7 +277,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
-                          "bcm2835_property: unhandled tag %08x\n", tag);
+                          "bcm2835_property: unhandled tag 0x%08x\n", tag);
             break;
         }
 
-- 
2.17.2
