Received: from eggs.gnu.org ([2001:4830:134:3::10]:56781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFv-0002a5-2e
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFu-0002ZM-4n
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42004 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFt-0002Yd-WE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:06 -0400
Date: Thu, 3 May 2018 22:51:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-27-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 26/67] cpu: replace command line flags with
 preprocessor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

Each target is currently built with a different set of include
directories, this is what makes it possible to pull in a separate copy
of cpu.h depending on the target.

Replace with per-target ifdefs which are easier to understand.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/cpu.h | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 include/cpu.h

diff --git a/include/cpu.h b/include/cpu.h
new file mode 100644
index 0000000..b18f163
--- /dev/null
+++ b/include/cpu.h
@@ -0,0 +1,2 @@
+#include "target-dir.h"
+#include TARGET_DIR(cpu.h)
-- 
MST
