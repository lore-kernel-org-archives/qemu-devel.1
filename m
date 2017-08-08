Received: from eggs.gnu.org ([2001:4830:134:3::10]:58147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Ji-00065l-AZ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Jh-0002Uf-Al
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:22 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 14:33:06 -0400
Message-Id: <20170808183306.27474-10-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-1-jsnow@redhat.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] AHCI: remove DPRINTF macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1a4d4db..ce2010c 100644
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
2.9.4
