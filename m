Received: from eggs.gnu.org ([2001:4830:134:3::10]:57640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGU-00039M-Ku
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGQ-0003CF-S4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGQ-0003BP-Le
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:38 -0400
Date: Thu, 3 May 2018 22:51:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-57-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 56/67] tcg: use include "tcg-gvec-desc.h.h"
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
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Some places include tcg-gvec-desc.h, others tcg/tcg-gvec-desc.h.
Let's be consistent.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 accel/tcg/tcg-runtime-gvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 90340e5..dad5821 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -21,7 +21,7 @@
 #include "qemu/host-utils.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "tcg-gvec-desc.h"
+#include "tcg/tcg-gvec-desc.h"
 
 
 /* Virtually all hosts support 16-byte vectors.  Those that don't can emulate
-- 
MST
