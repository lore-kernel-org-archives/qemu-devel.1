Received: from eggs.gnu.org ([2001:4830:134:3::10]:48878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCr-0001lC-7V
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCn-0006AN-SD
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCn-00067g-GV
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8eG077484
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:32 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0yvga-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:32 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:31 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:40 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-66-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 65/79] 9pfs: local: remove: use correct path
 component
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bruce Rogers <brogers@suse.com>, Greg Kurz <groug@kaod.org>

From: Bruce Rogers <brogers@suse.com>

Commit a0e640a8 introduced a path processing error.
Pass fstatat the dirpath based path component instead
of the entire path.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit 790db7efdbe1536acf1c4f4f95a0316dbda59433)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 7a0c383..b13ff21 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1009,7 +1009,7 @@ static int local_remove(FsContext *ctx, const char *path)
         goto out;
     }
 
-    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
+    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
         goto err_out;
     }
 
-- 
2.7.4
