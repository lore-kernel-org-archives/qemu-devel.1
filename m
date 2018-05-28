Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRY5-0006ib-6v
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRY4-0000Q6-De
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:27:33 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:26:59 -0300
Message-Id: <20180528232719.4721-2-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/21] vfio: Include "exec/address-spaces.h"
 directly in the source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/vfio/vfio-common.h | 1 -
 hw/vfio/ccw.c                 | 1 +
 hw/vfio/platform.c            | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d9360148e6..8264a65fa5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -22,7 +22,6 @@
 #define HW_VFIO_VFIO_COMMON_H
 
 #include "qemu-common.h"
-#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "qemu/queue.h"
 #include "qemu/notify.h"
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e67392c5f9..76e4e8c652 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -22,6 +22,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/ccw-device.h"
+#include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 
 #define TYPE_VFIO_CCW "vfio-ccw"
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5c921c27ba..57c4a0ee2b 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -24,6 +24,7 @@
 #include "qemu/range.h"
 #include "sysemu/sysemu.h"
 #include "exec/memory.h"
+#include "exec/address-spaces.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
 #include "trace.h"
-- 
2.17.0
