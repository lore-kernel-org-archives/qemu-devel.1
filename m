Received: from eggs.gnu.org ([2001:4830:134:3::10]:56089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFM-00027K-Mz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFL-00021C-Kh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFL-00020w-Fg
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:31 -0400
Date: Thu, 3 May 2018 22:50:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-7-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 06/67] trace: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory. Directory based path works more or less by accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 trace/control.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace/control.h b/trace/control.h
index 1903e22..eb65c8e 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -267,6 +267,6 @@ char *trace_opt_parse(const char *optarg);
 uint32_t trace_get_vcpu_event_count(void);
 
 
-#include "trace/control-internal.h"
+#include "control-internal.h"
 
 #endif /* TRACE__CONTROL_H */
-- 
MST
