Received: from eggs.gnu.org ([209.51.188.92]:48201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZs-0005YO-6Q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZr-0006UP-8V
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEbZq-0006TC-T0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BC6A30AA3A0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:25:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 17:25:04 +0200
Message-Id: <20190411152520.10061-2-armbru@redhat.com>
In-Reply-To: <20190411152520.10061-1-armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/17] include: Include fprintf-fn.h only where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
