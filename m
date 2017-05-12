Received: from eggs.gnu.org ([2001:4830:134:3::10]:57683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afi-0005O4-UF
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d9Afd-000729-Sf
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:20657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d9Afd-00070o-NZ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 09:31:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPU00GMPDKPLB10@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 12 May 2017 14:31:46 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 12 May 2017 16:31:20 +0300
Message-id: <1494595886-30912-4-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133145eucas1p2cad4c4efe46e6f1b757d97dd9d301dbe@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH V5 3/9] migration: fix hardcoded function name
 in error report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, peterx@redhat.com

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4c859b4..0f75700 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -68,7 +68,7 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
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
