Received: from eggs.gnu.org ([2001:4830:134:3::10]:57819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGZ-0003FO-Lf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGY-0003N9-UK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:47 -0400
Date: Thu, 3 May 2018 22:51:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-65-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 64/67] target/s390x: add include directory
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

This way it is easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/target/s390x/cpu_models.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 include/target/s390x/cpu_models.h

diff --git a/include/target/s390x/cpu_models.h b/include/target/s390x/cpu_models.h
new file mode 100644
index 0000000..f66ea19
--- /dev/null
+++ b/include/target/s390x/cpu_models.h
@@ -0,0 +1 @@
+#include_next "../target/s390x/cpu_models.h"
-- 
MST
