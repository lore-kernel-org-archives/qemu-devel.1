Received: from eggs.gnu.org ([2001:4830:134:3::10]:47745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WH-0005CN-Ky
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WG-0006EH-QQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dt1WG-0006DF-JZ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:40 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 15 Sep 2017 21:03:30 -0400
Message-Id: <20170916010330.10435-12-jsnow@redhat.com>
In-Reply-To: <20170916010330.10435-1-jsnow@redhat.com>
References: <20170916010330.10435-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/11] AHCI: remove DPRINTF macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170901001502.29915-10-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index dfc05be..24c65df 100644
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
