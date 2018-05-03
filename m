Received: from eggs.gnu.org ([2001:4830:134:3::10]:56819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFw-0002b6-4K
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFv-0002b0-BT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFv-0002aV-5L
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:07 -0400
Date: Thu, 3 May 2018 22:51:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-29-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 28/67] 9pfs: add include directory headers
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

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/9pfs/9p-proxy.h  | 1 +
 include/hw/9pfs/virtio-9p.h | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 include/hw/9pfs/9p-proxy.h
 create mode 100644 include/hw/9pfs/virtio-9p.h

diff --git a/include/hw/9pfs/9p-proxy.h b/include/hw/9pfs/9p-proxy.h
new file mode 100644
index 0000000..03d2df7
--- /dev/null
+++ b/include/hw/9pfs/9p-proxy.h
@@ -0,0 +1 @@
+#include_next "../hw/9pfs/9p-proxy.h"
diff --git a/include/hw/9pfs/virtio-9p.h b/include/hw/9pfs/virtio-9p.h
new file mode 100644
index 0000000..b6a1a5f
--- /dev/null
+++ b/include/hw/9pfs/virtio-9p.h
@@ -0,0 +1 @@
+#include_next "../hw/9pfs/virtio-9p.h"
-- 
MST
