Received: from eggs.gnu.org ([2001:4830:134:3::10]:60004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNw1-00062x-H3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNvy-00078c-8E
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cWNvx-000789-Ua
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:22 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PDhhat041546
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:48:20 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286dq49ubs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:48:20 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 25 Jan 2017 13:48:17 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed, 25 Jan 2017 14:47:58 +0100
In-Reply-To: <1485352082-16830-1-git-send-email-groug@kaod.org>
References: <1485352082-16830-1-git-send-email-groug@kaod.org>
Message-Id: <1485352082-16830-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/5] 9pfs: add missing coroutine_fn annotations
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
 hw/9pfs/9p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index fa58877570f6..58310ca8d5a5 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1571,7 +1571,7 @@ out_nofid:
     v9fs_string_free(&name);
 }
 
-static void v9fs_fsync(void *opaque)
+static void coroutine_fn v9fs_fsync(void *opaque)
 {
     int err;
     int32_t fid;
@@ -2337,7 +2337,7 @@ out_nofid:
     v9fs_string_free(&symname);
 }
 
-static void v9fs_flush(void *opaque)
+static void coroutine_fn v9fs_flush(void *opaque)
 {
     ssize_t err;
     int16_t tag;
-- 
2.7.4
