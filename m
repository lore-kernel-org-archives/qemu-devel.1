Received: from eggs.gnu.org ([2001:4830:134:3::10]:42437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1duLhE-0001CY-RB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1duLhB-0006OK-Vt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:48:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1duLhB-0006Ma-PY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:48:25 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 19 Sep 2017 19:47:57 +0300
Message-id: <1505839684-10046-4-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164822eucas1p2e2b1f9bbf32fdb171a8db1e6d75941ef@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v10 03/10] migration: fix hardcoded function
 name in error report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4350dd0..a0e74db 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -69,7 +69,7 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
     api_struct.api = UFFD_API;
     api_struct.features = 0;
     if (ioctl(ufd, UFFDIO_API, &api_struct)) {
-        error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
+        error_report("%s: UFFDIO_API failed: %s", __func__,
                      strerror(errno));
         return false;
     }
-- 
1.9.1
