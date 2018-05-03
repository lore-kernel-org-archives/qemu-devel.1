Received: from eggs.gnu.org ([2001:4830:134:3::10]:56473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFi-0002Ok-7Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFd-0002HP-93
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFd-0002H9-47
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:49 -0400
Date: Thu, 3 May 2018 22:50:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-15-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 14/67] sd: fix up include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Michael Walle <michael@walle.cc>

include files shouldn't have the "include/" part,
that is implied.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/sd/milkymist-memcard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5570c1e..fe1cccc 100644
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
-- 
MST
