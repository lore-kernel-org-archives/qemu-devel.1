Received: from eggs.gnu.org ([2001:4830:134:3::10]:50220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmnSO-0003mN-8O
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmnSN-0001zZ-Dl
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:49:56 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Aug 2017 16:49:34 -0400
Message-Id: <20170829204934.9039-10-jsnow@redhat.com>
In-Reply-To: <20170829204934.9039-1-jsnow@redhat.com>
References: <20170829204934.9039-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 9/9] AHCI: remove DPRINTF macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 2e75f9b..57bb59d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -34,17 +34,8 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci_internal.h"
 
-#define DEBUG_AHCI 0
 #include "trace.h"
 
-#define DPRINTF(port, fmt, ...) \
-do { \
-    if (DEBUG_AHCI) { \
-        fprintf(stderr, "ahci: %s: [%d] ", __func__, port); \
-        fprintf(stderr, fmt, ## __VA_ARGS__); \
-    } \
-} while (0)
-
 static void check_cmd(AHCIState *s, int port);
 static int handle_cmd(AHCIState *s, int port, uint8_t slot);
 static void ahci_reset_port(AHCIState *s, int port);
-- 
2.9.5
