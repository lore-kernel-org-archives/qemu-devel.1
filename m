Received: from eggs.gnu.org ([2001:4830:134:3::10]:44963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cVaGk-0005SG-V7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 03:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cVaGh-0001NX-SF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 03:46:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cVaGh-0001LY-J4
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 03:46:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0N8iMur023374
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 03:46:20 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 285cwwknk3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 03:46:19 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 23 Jan 2017 01:46:18 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 23 Jan 2017 09:46:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148516117357.20705.15695597290038452727.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] 9pfs: local: trivial cosmetic fix in pwritev op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |    3 +--
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
