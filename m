Received: from eggs.gnu.org ([2001:4830:134:3::10]:60658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNz0-0008T6-JJ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNyx-00080N-Bu
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:51:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cWNyx-00080F-2x
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:51:27 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PDpJPI002464
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:51:26 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286ua05356-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:51:23 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 25 Jan 2017 13:48:26 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed, 25 Jan 2017 14:48:01 +0100
In-Reply-To: <1485352082-16830-1-git-send-email-groug@kaod.org>
References: <1485352082-16830-1-git-send-email-groug@kaod.org>
Message-Id: <1485352082-16830-5-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 4/5] 9pfs: local: trivial cosmetic fix in
 pwritev op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 845675e7a1bb..7de07e1ba67f 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -436,8 +436,7 @@ static ssize_t local_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
                              const struct iovec *iov,
                              int iovcnt, off_t offset)
 {
-    ssize_t ret
-;
+    ssize_t ret;
 #ifdef CONFIG_PREADV
     ret = pwritev(fs->fd, iov, iovcnt, offset);
 #else
-- 
2.7.4
