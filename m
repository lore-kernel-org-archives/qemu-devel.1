Received: from eggs.gnu.org ([2001:4830:134:3::10]:50374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIy-0004Ir-GD
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rIx-00006e-La
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:43:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:42:29 -0300
Message-Id: <20180415234307.28132-4-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 03/41] hw/block/nvme: Include the
 "qemu/cutils.h" in the source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:nvme" <qemu-block@nongnu.org>

where it is used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/nvme.h | 1 -
 hw/block/nvme.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 8f3981121d..cabcf20c32 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -1,6 +1,5 @@
 #ifndef HW_NVME_H
 #define HW_NVME_H
-#include "qemu/cutils.h"
 #include "block/nvme.h"
 
 typedef struct NvmeAsyncEvent {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 85d2406400..811084b6a7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -35,6 +35,7 @@
 #include "sysemu/block-backend.h"
 
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 #include "nvme.h"
 
-- 
2.17.0
