Received: from eggs.gnu.org ([2001:4830:134:3::10]:60801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1eahp3-0004fb-HC
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 07:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1eahoy-00057g-Mq
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 07:55:37 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:41132 helo=zju.edu.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzc@zju.edu.cn>) id 1eahox-00051l-S4
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 07:55:32 -0500
From: linzhecheng <linzc@zju.edu.cn>
Date: Sun, 14 Jan 2018 20:55:19 +0800
Message-Id: <1515934519-16158-1-git-send-email-linzc@zju.edu.cn>
Subject: [Qemu-devel] [PATCH] memory: set ioeventfd_update_pending after
 address_space_update_ioeventfds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: linzhecheng <linzc@zju.edu.cn>

We should set ioeventfd_update_pending same as memory_region_update_pending.

Signed-off-by: linzhecheng <linzc@zju.edu.cn>
---
 memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/memory.c b/memory.c
index 4b41fb8..0cf39d0 100644
--- a/memory.c
+++ b/memory.c
@@ -1091,6 +1091,7 @@ void memory_region_transaction_commit(void)
                 address_space_update_ioeventfds(as);
             }
             memory_region_update_pending = false;
+            ioeventfd_update_pending = false;
             MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
         } else if (ioeventfd_update_pending) {
             QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
-- 
1.8.3.1
