Received: from eggs.gnu.org ([2001:4830:134:3::10]:56843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFw-0002bn-PF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFv-0002bW-Tm
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFv-0002b5-Mt
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:07 -0400
Date: Thu, 3 May 2018 22:51:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-30-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 29/67] fsdev: add include directory headers
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
 include/fsdev/9p-iov-marshal.h | 1 +
 include/fsdev/file-op-9p.h     | 1 +
 include/fsdev/qemu-fsdev.h     | 1 +
 3 files changed, 3 insertions(+)
 create mode 100644 include/fsdev/9p-iov-marshal.h
 create mode 100644 include/fsdev/file-op-9p.h
 create mode 100644 include/fsdev/qemu-fsdev.h

diff --git a/include/fsdev/9p-iov-marshal.h b/include/fsdev/9p-iov-marshal.h
new file mode 100644
index 0000000..8e608e9
--- /dev/null
+++ b/include/fsdev/9p-iov-marshal.h
@@ -0,0 +1 @@
+#include_next "../fsdev/9p-iov-marshal.h"
diff --git a/include/fsdev/file-op-9p.h b/include/fsdev/file-op-9p.h
new file mode 100644
index 0000000..782a83d
--- /dev/null
+++ b/include/fsdev/file-op-9p.h
@@ -0,0 +1 @@
+#include_next "../fsdev/file-op-9p.h"
diff --git a/include/fsdev/qemu-fsdev.h b/include/fsdev/qemu-fsdev.h
new file mode 100644
index 0000000..b7b8b87
--- /dev/null
+++ b/include/fsdev/qemu-fsdev.h
@@ -0,0 +1 @@
+#include_next "../fsdev/qemu-fsdev.h"
-- 
MST
