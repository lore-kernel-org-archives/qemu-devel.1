Received: from eggs.gnu.org ([2001:4830:134:3::10]:57023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG5-0002mO-OY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG4-0002lc-Ot
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKG4-0002ku-KX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:16 -0400
Date: Thu, 3 May 2018 22:51:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-37-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 36/67] migration: add include directory headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This way they are easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/migration.h    | 1 +
 include/migration/postcopy-ram.h | 1 +
 include/migration/qemu-file.h    | 1 +
 3 files changed, 3 insertions(+)
 create mode 100644 include/migration/migration.h
 create mode 100644 include/migration/postcopy-ram.h
 create mode 100644 include/migration/qemu-file.h

diff --git a/include/migration/migration.h b/include/migration/migration.h
new file mode 100644
index 0000000..516b7f6
--- /dev/null
+++ b/include/migration/migration.h
@@ -0,0 +1 @@
+#include_next "../migration/migration.h"
diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
new file mode 100644
index 0000000..2ea8237
--- /dev/null
+++ b/include/migration/postcopy-ram.h
@@ -0,0 +1 @@
+#include_next "../migration/postcopy-ram.h"
diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.h
new file mode 100644
index 0000000..8ea3af1
--- /dev/null
+++ b/include/migration/qemu-file.h
@@ -0,0 +1 @@
+#include_next "../migration/qemu-file.h"
-- 
MST
