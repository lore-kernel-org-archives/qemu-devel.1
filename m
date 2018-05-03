Received: from eggs.gnu.org ([2001:4830:134:3::10]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG5-0002ls-5m
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG3-0002iy-E0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:17 -0400
Date: Thu, 3 May 2018 22:51:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-35-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 34/67] hw/ppc: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/ppc/e500-ccsr.h | 1 +
 include/hw/ppc/mac.h       | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 include/hw/ppc/e500-ccsr.h
 create mode 100644 include/hw/ppc/mac.h

diff --git a/include/hw/ppc/e500-ccsr.h b/include/hw/ppc/e500-ccsr.h
new file mode 100644
index 0000000..08e4ba2
--- /dev/null
+++ b/include/hw/ppc/e500-ccsr.h
@@ -0,0 +1 @@
+#include_next "../hw/ppc/e500-ccsr.h"
diff --git a/include/hw/ppc/mac.h b/include/hw/ppc/mac.h
new file mode 100644
index 0000000..e0f0b67
--- /dev/null
+++ b/include/hw/ppc/mac.h
@@ -0,0 +1 @@
+#include_next "../hw/ppc/mac.h"
-- 
MST
