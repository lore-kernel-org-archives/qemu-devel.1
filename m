Received: from eggs.gnu.org ([2001:4830:134:3::10]:57331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGJ-0002zr-FA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGH-0002zk-BP
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGH-0002yy-5m
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:29 -0400
Date: Thu, 3 May 2018 22:51:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-48-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 47/67] tcg-op: use include "tcg.h" consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Some places include tcg-op.h, others tcg/tcg-op.h.
Let's be consistent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 accel/tcg/translator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 01480b9..429b0c8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -12,7 +12,7 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "tcg.h"
-#include "tcg/tcg-op.h"
+#include "tcg-op.h"
 #include "exec/exec-all.h"
 #include "exec/gen-icount.h"
 #include "exec/log.h"
-- 
MST
