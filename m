Received: from eggs.gnu.org ([2001:4830:134:3::10]:57468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGM-00032Y-R4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGM-00036l-4U
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGM-00035z-0a
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:34 -0400
Date: Thu, 3 May 2018 22:51:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-53-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 52/67] target/arm: add include directory headers
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
 include/arm-powerctl.h    | 1 +
 include/target/arm/cpu.h  | 1 +
 include/target/arm/idau.h | 1 +
 3 files changed, 3 insertions(+)
 create mode 100644 include/arm-powerctl.h
 create mode 100644 include/target/arm/cpu.h
 create mode 100644 include/target/arm/idau.h

diff --git a/include/arm-powerctl.h b/include/arm-powerctl.h
new file mode 100644
index 0000000..77af740
--- /dev/null
+++ b/include/arm-powerctl.h
@@ -0,0 +1 @@
+#include_next "../target/arm/arm-powerctl.h"
diff --git a/include/target/arm/cpu.h b/include/target/arm/cpu.h
new file mode 100644
index 0000000..97b4615
--- /dev/null
+++ b/include/target/arm/cpu.h
@@ -0,0 +1 @@
+#include_next "../target/arm/cpu.h"
diff --git a/include/target/arm/idau.h b/include/target/arm/idau.h
new file mode 100644
index 0000000..06bce14
--- /dev/null
+++ b/include/target/arm/idau.h
@@ -0,0 +1 @@
+#include_next "../target/arm/idau.h"
-- 
MST
