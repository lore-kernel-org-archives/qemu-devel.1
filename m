Received: from eggs.gnu.org ([2001:4830:134:3::10]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPP-0001H1-Rx
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPO-0001Cp-Go
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPO-0000zJ-4X
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:48 -0400
Message-Id: <20180910185859.27917-2-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/12] qht: remove unused map param from
 qht_remove__locked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 util/qht.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/util/qht.c b/util/qht.c
index 1e3a072e25..28d9273371 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -692,8 +692,7 @@ static inline void qht_bucket_remove_entry(struct qht_bucket *orig, int pos)
 
 /* call with b->lock held */
 static inline
-bool qht_remove__locked(struct qht_map *map, struct qht_bucket *head,
-                        const void *p, uint32_t hash)
+bool qht_remove__locked(struct qht_bucket *head, const void *p, uint32_t hash)
 {
     struct qht_bucket *b = head;
     int i;
@@ -728,7 +727,7 @@ bool qht_remove(struct qht *ht, const void *p, uint32_t hash)
     qht_debug_assert(p);
 
     b = qht_bucket_lock__no_stale(ht, hash, &map);
-    ret = qht_remove__locked(map, b, p, hash);
+    ret = qht_remove__locked(b, p, hash);
     qht_bucket_debug__locked(b);
     qemu_spin_unlock(&b->lock);
     return ret;
-- 
2.17.1
