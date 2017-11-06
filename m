Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBnf3-0006TA-In
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBnez-0001tG-HR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBnez-0001sy-8K
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:06:17 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6K5W2V002243
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 15:06:12 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2ue9280m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 15:06:11 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 6 Nov 2017 20:06:09 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  6 Nov 2017 21:05:53 +0100
In-Reply-To: <20171106200554.5894-1-groug@kaod.org>
References: <20171106200554.5894-1-groug@kaod.org>
Message-Id: <20171106200554.5894-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/2] 9pfs: drop one user of struct V9fsFidState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

To comply with QEMU coding style.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index d1cfeaf10e4f..cdfc4f4ce787 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -117,7 +117,7 @@ static inline char *rpath(FsContext *ctx, const char *path)
 #define P9_IOHDRSZ 24
 
 typedef struct V9fsPDU V9fsPDU;
-struct V9fsState;
+typedef struct V9fsState V9fsState;
 
 typedef struct {
     uint32_t size_le;
@@ -137,7 +137,7 @@ struct V9fsPDU
     uint8_t id;
     uint8_t cancelled;
     CoQueue complete;
-    struct V9fsState *s;
+    V9fsState *s;
     QLIST_ENTRY(V9fsPDU) next;
     uint32_t idx;
 };
@@ -230,7 +230,7 @@ struct V9fsFidState
     V9fsFidState *rclm_lst;
 };
 
-typedef struct V9fsState
+struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
     QLIST_HEAD(, V9fsPDU) active_list;
@@ -251,7 +251,7 @@ typedef struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
-} V9fsState;
+};
 
 /* 9p2000.L open flags */
 #define P9_DOTL_RDONLY        00000000
-- 
2.13.6
