Received: from eggs.gnu.org ([2001:4830:134:3::10]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82L-0006ll-As
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82H-0003fb-F7
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:37 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:54528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dD82H-0003eh-9R
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQE0031GLCGDF70@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:28 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 23 May 2017 14:31:04 +0300
Message-id: <1495539071-12995-4-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113127eucas1p1b6cebc0fc51a056b8c1a983d375f1012@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V6 03/10] migration: fix hardcoded function
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
Cc: i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4adab36..3ed78bf 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -67,7 +67,7 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
     api_struct.api = UFFD_API;
     api_struct.features = 0;
     if (ioctl(ufd, UFFDIO_API, &api_struct)) {
-        error_report("postcopy_ram_supported_by_host: UFFDIO_API failed: %s",
+        error_report("%s: UFFDIO_API failed: %s", __func__
                      strerror(errno));
         return false;
     }
-- 
1.8.3.1
