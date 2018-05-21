Received: from eggs.gnu.org ([2001:4830:134:3::10]:34553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrj-0001rH-02
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrg-0005KW-Bx
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:51 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:51641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fKmrg-0005J6-5a
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:48 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Mon, 21 May 2018 17:36:43 +0200
Message-Id: <e07162bfefe8e4f376d52318c9ab53f7ad916176.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v3 4/5] hmp: don't truncate size in
 hmp_memsave/hmp_pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

The called function takes an uint64_t as size parameter and
qdict_get_int() returns an uint64_t. Don't truncate it needlessly to an
uint32_t.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index ef93f4878b..a4d28913bb 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1079,7 +1079,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
@@ -1096,7 +1096,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
 
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-- 
2.15.0
