Received: from eggs.gnu.org ([2001:4830:134:3::10]:57169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmS-0002N6-85
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1frJmP-0000da-NB
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 05:13:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 19 Aug 2018 05:13:25 -0400
Message-Id: <20180819091335.22863-2-cota@braap.org>
In-Reply-To: <20180819091335.22863-1-cota@braap.org>
References: <20180819091335.22863-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 01/11] rcu_queue: use atomic_set in
 QLIST_REMOVE_RCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org

To avoid undefined behaviour.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/rcu_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index 01be77407b..dd7b3be043 100644
--- a/include/qemu/rcu_queue.h
+++ b/include/qemu/rcu_queue.h
@@ -112,7 +112,7 @@ extern "C" {
        (elm)->field.le_next->field.le_prev =        \
         (elm)->field.le_prev;                       \
     }                                               \
-    *(elm)->field.le_prev =  (elm)->field.le_next;  \
+    atomic_set((elm)->field.le_prev, (elm)->field.le_next); \
 } while (/*CONSTCOND*/0)
 
 /* List traversal must occur within an RCU critical section.  */
-- 
2.17.1
