Received: from eggs.gnu.org ([2001:4830:134:3::10]:38638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtI-00029U-4l
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtH-0007Ce-9O
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtH-0007CD-4F
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:59 -0400
Date: Fri, 1 Jun 2018 19:26:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-13-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/31] migration: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

In the vmstate.h file, we just need a struct name. Use a forward
declaration instead of an include, then adjust the one affected .c file
to include the file that is no longer implicit from the header.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/migration/vmstate.h | 2 +-
 migration/savevm.c          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index df463fd33d..5877caed90 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -27,7 +27,7 @@
 #ifndef QEMU_VMSTATE_H
 #define QEMU_VMSTATE_H
 
-#include "migration/qjson.h"
+typedef struct QJSON QJSON;
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
diff --git a/migration/savevm.c b/migration/savevm.c
index 4251125831..da724c52f2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -55,6 +55,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
 #include "sysemu/replay.h"
+#include "qjson.h"
 
 #ifndef ETH_P_RARP
 #define ETH_P_RARP 0x8035
-- 
MST
