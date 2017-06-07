Received: from eggs.gnu.org ([2001:4830:134:3::10]:54573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVh-00047t-H1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVe-0000sl-Dy
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:09 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:52390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIVVe-0000rq-6y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR600IE02G49H80@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:36:04 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 07 Jun 2017 10:35:23 +0300
Message-id: <1496820931-27416-4-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
References: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607073602eucas1p2ab6458769c054d79742b299a1df30cea@eucas1p2.samsung.com>
Subject: [Qemu-devel] [[PATCH V7] 03/11] migration: fix hardcoded function
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, dgilbert@redhat.com, i.maximets@samsung.com, peterx@redhat.com

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 10d39a0..9963ce4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -71,7 +71,7 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
     api_struct.api = UFFD_API;
     api_struct.features = 0;
     if (ioctl(ufd, UFFDIO_API, &api_struct)) {
-        error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
+        error_report("%s: UFFDIO_API failed: %s", __func__
                      strerror(errno));
         return false;
     }
-- 
1.9.1
