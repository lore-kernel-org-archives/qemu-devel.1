Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4X-0001vA-ET
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4U-0006kw-UH
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:00 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:40657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4S-0006Pn-2n
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: by mail-wm0-x230.google.com with SMTP id y9-v6so3497954wma.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:09 +0200
Message-Id: <1534870966-9287-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/74] rcu_queue: remove barrier from
 QLIST_EMPTY_RCU
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

It's unnecessary because the pointer isn't dereferenced.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-3-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/rcu_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
index dd7b3be..6881ea5 100644
--- a/include/qemu/rcu_queue.h
+++ b/include/qemu/rcu_queue.h
@@ -36,7 +36,7 @@ extern "C" {
 /*
  * List access methods.
  */
-#define QLIST_EMPTY_RCU(head) (atomic_rcu_read(&(head)->lh_first) == NULL)
+#define QLIST_EMPTY_RCU(head) (atomic_read(&(head)->lh_first) == NULL)
 #define QLIST_FIRST_RCU(head) (atomic_rcu_read(&(head)->lh_first))
 #define QLIST_NEXT_RCU(elm, field) (atomic_rcu_read(&(elm)->field.le_next))
 
-- 
1.8.3.1
