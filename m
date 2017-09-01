Received: from eggs.gnu.org ([2001:4830:134:3::10]:51862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZcv-0000Zk-Vl
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZcv-000561-1u
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:16:01 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 Aug 2017 20:15:02 -0400
Message-Id: <20170901001502.29915-10-jsnow@redhat.com>
In-Reply-To: <20170901001502.29915-1-jsnow@redhat.com>
References: <20170901001502.29915-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 9/9] AHCI: remove DPRINTF macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, f4bug@amsat.org, John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 6c98047..14b71a3 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -34,17 +34,8 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci_internal.h"
=20
-#define DEBUG_AHCI 0
 #include "trace.h"
=20
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
--=20
2.9.5
