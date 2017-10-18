Received: from eggs.gnu.org ([2001:4830:134:3::10]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPX-0000Sq-EX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPU-0003pd-Jd
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:01:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 18 Oct 2017 18:01:43 -0400
Message-Id: <1508364103-16131-5-git-send-email-cota@braap.org>
In-Reply-To: <1508364103-16131-1-git-send-email-cota@braap.org>
References: <1508364103-16131-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 4/4] qht: fix kernel-doc markup in qht.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

While at it, s/stuct/struct/.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 56c2c77..531aa95 100644
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
2.7.4
