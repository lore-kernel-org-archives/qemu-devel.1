Received: from eggs.gnu.org ([2001:4830:134:3::10]:56068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFM-00027F-7g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFI-0001xM-Qc
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:31 -0400
Date: Thu, 3 May 2018 22:50:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-5-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 04/67] s390x: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org

we just need a struct name, let's add a forward
declaration instead of an include.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/s390x/sclp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index f9db243..6e65150 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -16,7 +16,8 @@
 
 #include "hw/sysbus.h"
 #include "hw/qdev.h"
-#include "target/s390x/cpu-qom.h"
+
+typedef struct CPUS390XState CPUS390XState;
 
 #define SCLP_CMD_CODE_MASK                      0xffff00ff
 
-- 
MST
