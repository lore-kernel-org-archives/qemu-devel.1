Received: from eggs.gnu.org ([2001:4830:134:3::10]:38783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtW-0002MT-5w
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtU-0007M4-68
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtU-0007Lg-20
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:12 -0400
Date: Fri, 1 Jun 2018 19:27:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-18-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/31] e1000e: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/net/e1000e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 16a9417a85..cda8d48333 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -41,7 +41,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
=20
-#include "hw/net/e1000_regs.h"
+#include "e1000_regs.h"
=20
 #include "e1000x_common.h"
 #include "e1000e_core.h"
--=20
MST
