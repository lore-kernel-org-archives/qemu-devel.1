Received: from eggs.gnu.org ([2001:4830:134:3::10]:58274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsY-0003h1-CO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsX-0002g0-MK
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFsX-0002fi-I2
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:45 -0400
Date: Fri, 25 May 2018 19:47:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-5-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/20] migration: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

we just need a struct name, let's add a forward
declaration instead of an include.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/vmstate.h | 2 +-
 migration/savevm.c          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index df463fd..5877cae 100644
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
index 4251125..da724c5 100644
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
