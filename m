Received: from eggs.gnu.org ([2001:4830:134:3::10]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFt3-000462-P4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFt3-0002wE-1I
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFt2-0002vm-TD
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:16 -0400
Date: Fri, 25 May 2018 19:48:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-19-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/20] trace: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 trace/qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace/qmp.c b/trace/qmp.c
index 756086c..ea99b00 100644
--- a/trace/qmp.c
+++ b/trace/qmp.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-trace.h"
-#include "trace/control.h"
+#include "control.h"
 
 
 static CPUState *get_cpu(bool has_vcpu, int vcpu, Error **errp)
-- 
MST
