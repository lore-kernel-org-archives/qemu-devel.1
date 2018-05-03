Received: from eggs.gnu.org ([2001:4830:134:3::10]:57143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG8-0002nw-TB
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG8-0002qo-9P
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKG8-0002qK-4R
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:20 -0400
Date: Thu, 3 May 2018 22:51:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-42-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 41/67] tcg-pool.inc.c: replace command line
 flags with preprocessor
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
 include/tcg-pool.inc.c | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 include/tcg-pool.inc.c

diff --git a/include/tcg-pool.inc.c b/include/tcg-pool.inc.c
new file mode 100644
index 0000000..d04a981
--- /dev/null
+++ b/include/tcg-pool.inc.c
@@ -0,0 +1 @@
+#include_next "../tcg/tcg-pool.inc.c"
-- 
MST
