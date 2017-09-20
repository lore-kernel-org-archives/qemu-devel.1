Received: from eggs.gnu.org ([2001:4830:134:3::10]:45283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duery-0003LJ-1k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1duert-0001J9-Jd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1duert-0001IH-5T
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:45 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Sep 2017 12:46:37 +0200
Message-Id: <20170920104639.2335-15-quintela@redhat.com>
In-Reply-To: <20170920104639.2335-1-quintela@redhat.com>
References: <20170920104639.2335-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 14/16] migration: fix hardcoded function name in
 error report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

From: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/postcopy-ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index c70305ccc7..cf62fc756f 100644
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
2.13.5
