Received: from eggs.gnu.org ([2001:4830:134:3::10]:52537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFa-0004sp-2Z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFZ-00028x-16
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 20:39:08 -0300
Message-Id: <20170508233918.9043-2-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-1-f4bug@amsat.org>
References: <20170508233918.9043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/11] hw/net: removed obsolete comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/pcnet-pci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0acf8a4879..bdb533436e 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -38,14 +38,6 @@
 
 #include "pcnet.h"
 
-//#define PCNET_DEBUG
-//#define PCNET_DEBUG_IO
-//#define PCNET_DEBUG_BCR
-//#define PCNET_DEBUG_CSR
-//#define PCNET_DEBUG_RMD
-//#define PCNET_DEBUG_TMD
-//#define PCNET_DEBUG_MATCH
-
 #define TYPE_PCI_PCNET "pcnet"
 
 #define PCI_PCNET(obj) \
@@ -239,8 +231,6 @@ static const VMStateDescription vmstate_pci_pcnet = {
     }
 };
 
-/* PCI interface */
-
 static const MemoryRegionOps pcnet_mmio_ops = {
     .old_mmio = {
         .read = { pcnet_mmio_readb, pcnet_mmio_readw, pcnet_mmio_readl },
-- 
2.11.0
