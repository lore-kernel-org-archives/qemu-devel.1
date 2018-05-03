Received: from eggs.gnu.org ([2001:4830:134:3::10]:57348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGJ-00030D-N9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKGF-0002xR-Fz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKGF-0002x1-Ag
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:27 -0400
Date: Thu, 3 May 2018 22:51:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-45-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 44/67] tcg-ldst.inc.c: replace command line
 flags with preprocessor
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

Each target is currently built with a different set of include
directories, this is what makes it possible to pull in a separate copy
of tcg-ldst.inc.c depending on the target.

Replace with per-target ifdefs which are easier to understand.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/tcg-ldst.inc.c | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 include/tcg-ldst.inc.c

diff --git a/include/tcg-ldst.inc.c b/include/tcg-ldst.inc.c
new file mode 100644
index 0000000..fa0f3bf
--- /dev/null
+++ b/include/tcg-ldst.inc.c
@@ -0,0 +1 @@
+#include_next "../tcg/tcg-ldst.inc.c"
-- 
MST
