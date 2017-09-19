Received: from eggs.gnu.org ([2001:4830:134:3::10]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOz4-0004u8-Rm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOz4-0004Gw-05
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOz3-0004G0-Qh
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:40 -0300
Message-Id: <20170919201850.14772-3-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] osdep: Define QEMU_MADV_REMOVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Define QEMU_MADV_REMOVE, so we can use it with qemu_madvise().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170824192315.5897-3-ehabkost@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Zack Cornelius <zack.cornelius@kove.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qemu/osdep.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 6855b94bbf..e9fa21788b 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -257,6 +257,11 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #else
 #define QEMU_MADV_NOHUGEPAGE QEMU_MADV_INVALID
 #endif
+#ifdef MADV_REMOVE
+#define QEMU_MADV_REMOVE MADV_REMOVE
+#else
+#define QEMU_MADV_REMOVE QEMU_MADV_INVALID
+#endif
 
 #elif defined(CONFIG_POSIX_MADVISE)
 
@@ -269,6 +274,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define QEMU_MADV_DONTDUMP QEMU_MADV_INVALID
 #define QEMU_MADV_HUGEPAGE  QEMU_MADV_INVALID
 #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
+#define QEMU_MADV_REMOVE QEMU_MADV_INVALID
 
 #else /* no-op */
 
@@ -281,6 +287,7 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #define QEMU_MADV_DONTDUMP QEMU_MADV_INVALID
 #define QEMU_MADV_HUGEPAGE  QEMU_MADV_INVALID
 #define QEMU_MADV_NOHUGEPAGE  QEMU_MADV_INVALID
+#define QEMU_MADV_REMOVE QEMU_MADV_INVALID
 
 #endif
 
-- 
2.13.5
