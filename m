Received: from eggs.gnu.org ([209.51.188.92]:54773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0e-0005Ds-AL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0Z-0005Jm-1J
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:49 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:04 +0200
Message-Id: <20190418205135.6686-6-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 05/36] qemu-img: Use error_vreport() in
 error_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

error_exit() uses low-level error_printf() to report errors.
Modernize it to use error_vreport().

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190417190641.26814-2-armbru@redhat.com>
---
 qemu-img.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 8c7b2437f0..c376e91ca0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -85,13 +85,11 @@ static void QEMU_NORETURN GCC_FMT_ATTR(1, 2) error_exit(const char *fmt, ...)
 {
     va_list ap;
 
-    error_printf("qemu-img: ");
-
     va_start(ap, fmt);
-    error_vprintf(fmt, ap);
+    error_vreport(fmt, ap);
     va_end(ap);
 
-    error_printf("\nTry 'qemu-img --help' for more information\n");
+    error_printf("Try 'qemu-img --help' for more information\n");
     exit(EXIT_FAILURE);
 }
 
-- 
2.17.2
