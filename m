Received: from eggs.gnu.org ([2001:4830:134:3::10]:54909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrS-0002Mb-Mj
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrR-0008Cj-Jx
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:44:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:26 -0300
Message-Id: <20180625124238.25339-35-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 34/46] hw/net: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, "open list:Allwinner-a10" <qemu-arm@nongnu.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
---
 hw/net/ne2000.h                 | 5 +++--
 include/hw/net/allwinner_emac.h | 5 +++--
 hw/net/e1000e.c                 | 7 ++++---
 hw/net/e1000x_common.c          | 3 ++-
 hw/net/eepro100.c               | 3 +--
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/net/ne2000.h b/hw/net/ne2000.h
index adb8021bd1..2cd193e4c6 100644
--- a/hw/net/ne2000.h
+++ b/hw/net/ne2000.h
@@ -1,11 +1,12 @@
 #ifndef HW_NE2000_H
 #define HW_NE2000_H
 
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "net/net.h"
 
-#define NE2000_PMEM_SIZE    (32*1024)
-#define NE2000_PMEM_START   (16*1024)
+#define NE2000_PMEM_SIZE    (32 * KiB)
+#define NE2000_PMEM_START   (16 * KiB)
 #define NE2000_PMEM_END     (NE2000_PMEM_SIZE+NE2000_PMEM_START)
 #define NE2000_MEM_SIZE     NE2000_PMEM_END
 
diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner_emac.h
index 4cc8aab7ec..905a43deb4 100644
--- a/include/hw/net/allwinner_emac.h
+++ b/include/hw/net/allwinner_emac.h
@@ -23,6 +23,7 @@
 #ifndef ALLWINNER_EMAC_H
 #define ALLWINNER_EMAC_H
 
+#include "qemu/units.h"
 #include "net/net.h"
 #include "qemu/fifo8.h"
 #include "hw/net/mii.h"
@@ -125,8 +126,8 @@
 #define EMAC_INT_RX         (1 << 8)
 
 /* Due to lack of specifications, size of fifos is chosen arbitrarily */
-#define TX_FIFO_SIZE        (4 * 1024)
-#define RX_FIFO_SIZE        (32 * 1024)
+#define TX_FIFO_SIZE        (4 * KiB)
+#define RX_FIFO_SIZE        (32 * KiB)
 
 #define NUM_TX_FIFOS        2
 #define RX_HDR_SIZE         8
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index cda8d48333..510ddb3897 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -34,6 +34,7 @@
 */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "net/net.h"
 #include "net/tap.h"
 #include "qemu/range.h"
@@ -81,10 +82,10 @@ typedef struct E1000EState {
 #define E1000E_IO_IDX       2
 #define E1000E_MSIX_IDX     3
 
-#define E1000E_MMIO_SIZE    (128 * 1024)
-#define E1000E_FLASH_SIZE   (128 * 1024)
+#define E1000E_MMIO_SIZE    (128 * KiB)
+#define E1000E_FLASH_SIZE   (128 * KiB)
 #define E1000E_IO_SIZE      (32)
-#define E1000E_MSIX_SIZE    (16 * 1024)
+#define E1000E_MSIX_SIZE    (16 * KiB)
 
 #define E1000E_MSIX_TABLE   (0x0000)
 #define E1000E_MSIX_PBA     (0x2000)
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index eb0e097137..09047806f2 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -23,6 +23,7 @@
 */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
@@ -111,7 +112,7 @@ bool e1000x_is_oversized(uint32_t *mac, size_t size)
     static const int maximum_ethernet_vlan_size = 1522;
     /* this is the size past which hardware will
        drop packets when setting LPE=1 */
-    static const int maximum_ethernet_lpe_size = 16384;
+    static const int maximum_ethernet_lpe_size = 16 * KiB;
 
     if ((size > maximum_ethernet_lpe_size ||
         (size > maximum_ethernet_vlan_size
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index a07a63247e..e761daf551 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -41,6 +41,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "net/net.h"
@@ -60,8 +61,6 @@
  * changed to pad short packets itself. */
 #define CONFIG_PAD_RECEIVED_FRAMES
 
-#define KiB 1024
-
 /* Debug EEPRO100 card. */
 #if 0
 # define DEBUG_EEPRO100
-- 
2.18.0
