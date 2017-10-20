Received: from eggs.gnu.org ([2001:4830:134:3::10]:38893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e5av5-0003RF-8e
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e5av1-0004Zr-Vl
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:17:15 -0400
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:45601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e5av1-0004Y5-PC
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 13:17:11 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 024BF1470F9
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 19:17:08 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 20 Oct 2017 19:17:06 +0200
Message-ID: <150851982652.6179.3835155122843915432.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: drop one user of struct V9fsFidState
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
 hw/9pfs/9p.h |    8 ++++----
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
