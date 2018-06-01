Received: from eggs.gnu.org ([2001:4830:134:3::10]:38859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtZ-0002Pf-5D
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtY-0007Py-DK
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtY-0007PT-9L
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:16 -0400
Date: Fri, 1 Jun 2018 19:27:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-22-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/31] sd: fix up include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Walle <michael@walle.cc>

include files shouldn't have the "include/" part, that is implied.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5570c1e9a0..fe1cccca76 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -27,7 +27,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-#include "include/qapi/error.h"
+#include "qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/sd/sd.h"
--=20
MST
