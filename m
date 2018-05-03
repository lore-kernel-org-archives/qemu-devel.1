Received: from eggs.gnu.org ([2001:4830:134:3::10]:57834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGa-0003Fp-5L
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGZ-0003O3-HI
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGZ-0003NQ-B5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:47 -0400
Date: Thu, 3 May 2018 22:51:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-66-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 65/67] tcg: use include "translate-all.h"
 consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Max Filippov <jcmvbkbc@gmail.com>

Some places include translate-all.h, others accel/tcg/translate-all.h.
Let's be consistent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/xtensa/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index e3bcbe1..ede60ea 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -38,7 +38,7 @@
 
 #ifdef CONFIG_USER_ONLY
 /* tb_invalidate_phys_range */
-#include "accel/tcg/translate-all.h"
+#include "translate-all.h"
 #endif
 
 #ifndef CONFIG_USER_ONLY
-- 
MST
