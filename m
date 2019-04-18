Received: from eggs.gnu.org ([209.51.188.92]:54574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-00056S-JT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0T-0005EV-U4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0T-0005D5-Gs
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C310230842A9
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 92D9D60BEC
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:19 +0200
Message-Id: <20190418205135.6686-21-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 20/36] include: Include fprintf-fn.h
 only where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-2-armbru@redhat.com>
---
 include/qemu-common.h | 2 --
 include/qemu/cutils.h | 2 --
 include/sysemu/cpus.h | 1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index a102245519..f891e05e7e 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -12,8 +12,6 @@
 #ifndef QEMU_COMMON_H
 #define QEMU_COMMON_H
 
-#include "qemu/fprintf-fn.h"
-
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 /* Copyright string for -version arguments, About dialogs, etc */
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index d2dad3057c..12301340a4 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -1,8 +1,6 @@
 #ifndef QEMU_CUTILS_H
 #define QEMU_CUTILS_H
 
-#include "qemu/fprintf-fn.h"
-
 /**
  * pstrcpy:
  * @buf: buffer to copy string into
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 731756d948..eea0010b53 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_CPUS_H
 #define QEMU_CPUS_H
 
+#include "qemu/fprintf-fn.h"
 #include "qemu/timer.h"
 
 /* cpus.c */
-- 
2.17.2
