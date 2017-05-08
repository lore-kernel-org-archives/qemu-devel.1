Received: from eggs.gnu.org ([2001:4830:134:3::10]:52623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFg-0004wZ-DT
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7sFf-0002HM-HG
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:39:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 20:39:11 -0300
Message-Id: <20170508233918.9043-5-f4bug@amsat.org>
In-Reply-To: <20170508233918.9043-1-f4bug@amsat.org>
References: <20170508233918.9043-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/11] ide/ahci: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

qemu/include/hw/ide/ahci.h:260:16: error: field ‘sglist’ has incomplete type
     QEMUSGList sglist;
                ^~~~~~
/qemu/include/hw/ide/ahci.h:272:5: error: unknown type name ‘IDEDMA’
     IDEDMA dma;
     ^~~~~~
qemu/include/hw/ide/ahci.h:273:5: error: unknown type name ‘IDEBus’
     IDEBus port;
     ^~~~~~
qemu/include/hw/ide/ahci.h:305:15: error: field ‘parent_obj’ has incomplete type
     PCIDevice parent_obj;
               ^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/ide/ahci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 0ca7c65820..293f9ebcd0 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -25,6 +25,8 @@
 #define HW_IDE_AHCI_H
 
 #include "hw/sysbus.h"
+#include "hw/ide/internal.h"
+#include "sysemu/dma.h"
 
 #define AHCI_MEM_BAR_SIZE         0x1000
 #define AHCI_MAX_PORTS            32
-- 
2.11.0
