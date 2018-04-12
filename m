Received: from eggs.gnu.org ([2001:4830:134:3::10]:49022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgZ-0004AE-22
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgW-0005mc-6E
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:43 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:55003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1f6bgW-0005ls-0D
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:40 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 12 Apr 2018 14:50:37 +0200
Message-Id: <510ceca2c869bb1e8d4bdd87986f23170b779047.1523537181.git.simon@ruderich.org>
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
References: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v2 4/5] hmp: don't truncate size in
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
---
 hmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp.c b/hmp.c
index a25c7bd9a8..1e392055f7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1064,7 +1064,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
@@ -1081,7 +1081,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
 
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-- 
2.15.0
