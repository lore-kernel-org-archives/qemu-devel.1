Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLUx-0002JE-ET
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJLUu-0000yK-PK
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:06:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Jun 2017 12:06:00 -0300
Message-Id: <20170609150600.4654-3-f4bug@amsat.org>
In-Reply-To: <20170609150600.4654-1-f4bug@amsat.org>
References: <20170609150600.4654-1-f4bug@amsat.org>
In-Reply-To: <80969f61-38d4-20ac-d850-5e90c8852b40@redhat.com>
References: <80969f61-38d4-20ac-d850-5e90c8852b40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/2] ide/ahci: add missing includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-block@nongnu.org

  CC      arm-softmmu/hw/arm/highbank.o
In file included from qemu/hw/arm/highbank.c:34:0:
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
qemu/rules.mak:69: recipe for target 'hw/arm/highbank.o' failed
make[1]: *** [hw/arm/highbank.o] Error 1
make: *** [subdir-arm-softmmu] Error 2

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
