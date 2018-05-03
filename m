Received: from eggs.gnu.org ([2001:4830:134:3::10]:57465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGM-00032T-OG
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGL-000364-OD
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGL-000357-CN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:33 -0400
Date: Thu, 3 May 2018 22:51:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-52-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 51/67] hyperv: add include directory header
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

This way it is easier to find using standard rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/target/i386/hyperv.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 include/target/i386/hyperv.h

diff --git a/include/target/i386/hyperv.h b/include/target/i386/hyperv.h
new file mode 100644
index 0000000..79a989a
--- /dev/null
+++ b/include/target/i386/hyperv.h
@@ -0,0 +1 @@
+#include_next "../target/i386/hyperv.h"
-- 
MST
