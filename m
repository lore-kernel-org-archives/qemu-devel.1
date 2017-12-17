Received: from eggs.gnu.org ([2001:4830:134:3::10]:39463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgTy-0002qN-BB
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgTu-0002UM-61
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:28:26 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:10 +0300
Message-Id: <b07ad2347243a5bcfc01da8d6b8e63372d904cc2.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 05/61] qht: fix kernel-doc markup in qht.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: "Emilio G. Cota" <cota@braap.org>

While at it, s/stuct/struct/.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/qemu/qht.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 56c2c7784c..531aa95325 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -166,7 +166,7 @@ void qht_iter(struct qht *ht, qht_iter_func_t func, void *userp);
 /**
  * qht_statistics_init - Gather statistics from a QHT
  * @ht: QHT to gather statistics from
- * @stats: pointer to a struct qht_stats to be filled in
+ * @stats: pointer to a &struct qht_stats to be filled in
  *
  * Does NOT need to be called under an RCU read-critical section,
  * since it does not dereference any pointers stored in the hash table.
@@ -177,8 +177,8 @@ void qht_iter(struct qht *ht, qht_iter_func_t func, void *userp);
 void qht_statistics_init(struct qht *ht, struct qht_stats *stats);
 
 /**
- * qht_statistics_destroy - Destroy a struct qht_stats
- * @stats: stuct qht_stats to be destroyed
+ * qht_statistics_destroy - Destroy a &struct qht_stats
+ * @stats: &struct qht_stats to be destroyed
  *
  * See also: qht_statistics_init().
  */
-- 
2.11.0
