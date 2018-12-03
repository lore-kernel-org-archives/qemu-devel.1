Received: from eggs.gnu.org ([2001:4830:134:3::10]:33748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNt-00021a-Ib
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gTpNs-0000h0-LO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gTpNs-0000gE-DE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:39:40 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Mon,  3 Dec 2018 22:48:51 +0800
Message-Id: <1543848532-12604-4-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH for-4.0 v3 3/4] i386: import bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philip.li@intel.com, zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>

It provides setup_data struct and header fields

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

---
V3: new patch
---
 hw/i386/pc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 067d23a..8db7417 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -74,6 +74,7 @@
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include <asm/bootparam.h>
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -820,20 +821,6 @@ static long get_file_size(FILE *f)
     return size;
 }
 
-/* setup_data types */
-#define SETUP_NONE     0
-#define SETUP_E820_EXT 1
-#define SETUP_DTB      2
-#define SETUP_PCI      3
-#define SETUP_EFI      4
-
-struct setup_data {
-    uint64_t next;
-    uint32_t type;
-    uint32_t len;
-    uint8_t data[0];
-} __attribute__((packed));
-
 static void load_linux(PCMachineState *pcms,
                        FWCfgState *fw_cfg)
 {
-- 
2.7.4
