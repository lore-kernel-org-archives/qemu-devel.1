Received: from eggs.gnu.org ([2001:4830:134:3::10]:57061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG6-0002n9-GC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG5-0002mv-K7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55698 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKG5-0002lx-Az
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:17 -0400
Date: Thu, 3 May 2018 22:51:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-38-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 37/67] tcg: add include directory headers
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
 include/tcg-mo.h            | 1 +
 include/tcg-op-gvec.h       | 1 +
 include/tcg-op.h            | 1 +
 include/tcg-runtime.h       | 1 +
 include/tcg.h               | 1 +
 include/tcg/tcg-gvec-desc.h | 1 +
 6 files changed, 6 insertions(+)
 create mode 100644 include/tcg-mo.h
 create mode 100644 include/tcg-op-gvec.h
 create mode 100644 include/tcg-op.h
 create mode 100644 include/tcg-runtime.h
 create mode 100644 include/tcg.h
 create mode 100644 include/tcg/tcg-gvec-desc.h

diff --git a/include/tcg-mo.h b/include/tcg-mo.h
new file mode 100644
index 0000000..ba16778
--- /dev/null
+++ b/include/tcg-mo.h
@@ -0,0 +1 @@
+#include_next "../tcg/tcg-mo.h"
diff --git a/include/tcg-op-gvec.h b/include/tcg-op-gvec.h
new file mode 100644
index 0000000..0c00fbc
--- /dev/null
+++ b/include/tcg-op-gvec.h
@@ -0,0 +1 @@
+#include_next "../tcg/tcg-op-gvec.h"
diff --git a/include/tcg-op.h b/include/tcg-op.h
new file mode 100644
index 0000000..3e08978
--- /dev/null
+++ b/include/tcg-op.h
@@ -0,0 +1 @@
+#include_next "../tcg/tcg-op.h"
diff --git a/include/tcg-runtime.h b/include/tcg-runtime.h
new file mode 100644
index 0000000..b6be561
--- /dev/null
+++ b/include/tcg-runtime.h
@@ -0,0 +1 @@
+#include_next "../accel/tcg/tcg-runtime.h"
diff --git a/include/tcg.h b/include/tcg.h
new file mode 100644
index 0000000..052e05d
--- /dev/null
+++ b/include/tcg.h
@@ -0,0 +1 @@
+#include_next "../tcg/tcg.h"
diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
new file mode 100644
index 0000000..71d8e27
--- /dev/null
+++ b/include/tcg/tcg-gvec-desc.h
@@ -0,0 +1 @@
+#include_next "../tcg/tcg-gvec-desc.h"
-- 
MST
