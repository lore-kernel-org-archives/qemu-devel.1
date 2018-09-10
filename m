Received: from eggs.gnu.org ([2001:4830:134:3::10]:49143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPQ-0001Hu-V4
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPP-0001Di-BF
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPP-000196-02
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:55 -0400
Message-Id: <20180910185859.27917-9-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 08/12] qht: fix comment in
 qht_bucket_remove_entry
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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 util/qht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qht.c b/util/qht.c
index 50ed7a2102..3564a7e20f 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -671,7 +671,7 @@ qht_entry_move(struct qht_bucket *to, int i, struct qht_bucket *from, int j)
 }
 
 /*
- * Find the last valid entry in @head, and swap it with @orig[pos], which has
+ * Find the last valid entry in @orig, and swap it with @orig[pos], which has
  * just been invalidated.
  */
 static inline void qht_bucket_remove_entry(struct qht_bucket *orig, int pos)
-- 
2.17.1
