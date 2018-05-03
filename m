Received: from eggs.gnu.org ([2001:4830:134:3::10]:57119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG8-0002nt-CA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG7-0002q5-Nd
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKG7-0002p8-Jb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:19 -0400
Date: Thu, 3 May 2018 22:51:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-41-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 40/67] trace: add include directory headers
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
 include/trace/mem-internal.h | 1 +
 include/trace/mem.h          | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 include/trace/mem-internal.h
 create mode 100644 include/trace/mem.h

diff --git a/include/trace/mem-internal.h b/include/trace/mem-internal.h
new file mode 100644
index 0000000..eb84b2f
--- /dev/null
+++ b/include/trace/mem-internal.h
@@ -0,0 +1 @@
+#include_next "../trace/mem-internal.h"
diff --git a/include/trace/mem.h b/include/trace/mem.h
new file mode 100644
index 0000000..a907937
--- /dev/null
+++ b/include/trace/mem.h
@@ -0,0 +1 @@
+#include_next "../trace/mem.h"
-- 
MST
