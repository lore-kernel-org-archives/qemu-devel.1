Received: from eggs.gnu.org ([209.51.188.92]:51221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnw-0001HG-GP
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnv-0002dK-Eu
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDnv-0002bl-8x
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B99F3082E5A
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EFCCC1001DF5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:38:33 +0200
Message-Id: <20190418203840.10528-3-armbru@redhat.com>
In-Reply-To: <20190418203840.10528-1-armbru@redhat.com>
References: <20190418203840.10528-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 2/9] Use #include "..." for our own
 headers, <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Also delete a few redundant #include.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190315145123.28030-2-armbru@redhat.com>
---
 contrib/rdmacm-mux/main.c       | 18 +++++++++---------
 contrib/rdmacm-mux/rdmacm-mux.h |  6 +++---
 hw/rdma/rdma_utils.h            |  1 -
 target/i386/whp-dispatch.h      |  2 +-
 target/i386/whpx-all.c          |  1 -
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 21cc804367..30c7052651 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -14,16 +14,16 @@
  */
 
 #include "qemu/osdep.h"
-#include "sys/poll.h"
-#include "sys/ioctl.h"
-#include "pthread.h"
-#include "syslog.h"
+#include <sys/poll.h>
+#include <sys/ioctl.h>
+#include <pthread.h>
+#include <syslog.h>
 
-#include "infiniband/verbs.h"
-#include "infiniband/umad.h"
-#include "infiniband/umad_types.h"
-#include "infiniband/umad_sa.h"
-#include "infiniband/umad_cm.h"
+#include <infiniband/verbs.h>
+#include <infiniband/umad.h>
+#include <infiniband/umad_types.h>
+#include <infiniband/umad_sa.h>
+#include <infiniband/umad_cm.h>
 
 #include "rdmacm-mux.h"
 
diff --git a/contrib/rdmacm-mux/rdmacm-mux.h b/contrib/rdmacm-mux/rdmacm-mux.h
index 942a802c47..07a4722913 100644
--- a/contrib/rdmacm-mux/rdmacm-mux.h
+++ b/contrib/rdmacm-mux/rdmacm-mux.h
@@ -17,9 +17,9 @@
 #define RDMACM_MUX_H
 
 #include "linux/if.h"
-#include "infiniband/verbs.h"
-#include "infiniband/umad.h"
-#include "rdma/rdma_user_cm.h"
+#include <infiniband/verbs.h>
+#include <infiniband/umad.h>
+#include <rdma/rdma_user_cm.h>
 
 typedef enum RdmaCmMuxMsgType {
     RDMACM_MUX_MSG_TYPE_REQ   = 0,
diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
index 2d42249691..e7babe96cb 100644
--- a/hw/rdma/rdma_utils.h
+++ b/hw/rdma/rdma_utils.h
@@ -20,7 +20,6 @@
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
-#include "stdio.h"
 
 #define rdma_error_report(fmt, ...) \
     error_report("%s: " fmt, "rdma", ## __VA_ARGS__)
diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index 4ae3cc8fa5..a23fb33a29 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -1,4 +1,4 @@
-#include "windows.h"
+#include <windows.h>
 
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 57e53e1f1f..31d47320e4 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -13,7 +13,6 @@
 #include "exec/address-spaces.h"
 #include "exec/ioport.h"
 #include "qemu-common.h"
-#include "strings.h"
 #include "sysemu/accel.h"
 #include "sysemu/whpx.h"
 #include "sysemu/sysemu.h"
-- 
2.17.2
