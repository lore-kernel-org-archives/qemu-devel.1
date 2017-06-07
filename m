Received: from eggs.gnu.org ([2001:4830:134:3::10]:58058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIXYu-0001Az-9L
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIXYq-0000FQ-CW
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:47:36 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55809)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIXYq-0000Ec-6k
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:47:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR600A4C8J4VT30@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:47:28 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 07 Jun 2017 12:46:30 +0300
Message-id: <1496828798-27548-4-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094727eucas1p2d1063171fa2850fc1d590b286cd5d880@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v8 03/11] migration: fix hardcoded function
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
index 10d39a0..8838901 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -71,7 +71,7 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
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
