Received: from eggs.gnu.org ([2001:4830:134:3::10]:57082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG7-0002no-5Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKG6-0002o7-FK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKG6-0002ng-Az
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:18 -0400
Date: Thu, 3 May 2018 22:51:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-39-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 38/67] helper: replace command line flags with
 preprocessor
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

Each target is currently built with a different set of include
directories, this is what makes it possible to pull in a separate copy
of helper.h depending on the target.

Replace with per-target ifdefs which are easier to understand.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/helper.h | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 include/exec/helper.h

diff --git a/include/exec/helper.h b/include/exec/helper.h
new file mode 100644
index 0000000..55a48a0
--- /dev/null
+++ b/include/exec/helper.h
@@ -0,0 +1,2 @@
+#include "target-dir.h"
+#include TARGET_DIR(helper.h)
-- 
MST
