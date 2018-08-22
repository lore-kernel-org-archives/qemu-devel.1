Received: from eggs.gnu.org ([2001:4830:134:3::10]:55663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fsLGN-0002P5-6a
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 01:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fsLGJ-0006Qs-3J
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 01:00:59 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:37222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fsLGD-0006H0-JX
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 01:00:52 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 22 Aug 2018 21:14:54 +0800
Message-Id: <1534943694-42729-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] pci-bridge/dec: remove unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/pci-bridge/dec.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 84492d5..ab39185 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -31,16 +31,6 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 
-/* debug DEC */
-//#define DEBUG_DEC
-
-#ifdef DEBUG_DEC
-#define DEC_DPRINTF(fmt, ...)                               \
-    do { printf("DEC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DEC_DPRINTF(fmt, ...)
-#endif
-
 #define DEC_21154(obj) OBJECT_CHECK(DECState, (obj), TYPE_DEC_21154)
 
 typedef struct DECState {
-- 
1.8.3.1
