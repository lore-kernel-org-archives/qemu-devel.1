Received: from eggs.gnu.org ([2001:4830:134:3::10]:33321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0001nF-6J
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4S-0006fg-0g
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4K-0006Oi-Db
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:53 -0400
Received: by mail-wm0-x243.google.com with SMTP id y9-v6so3497868wma.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:08 +0200
Message-Id: <1534870966-9287-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 36/74] rcu_queue: use atomic_set in
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
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

To avoid undefined behaviour.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-2-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/rcu_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index 01be774..dd7b3be 100644
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
1.8.3.1
