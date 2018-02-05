Received: from eggs.gnu.org ([2001:4830:134:3::10]:44464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS4-0004FY-6U
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS3-0004tG-06
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:16 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:21 +0100
Message-Id: <1517858941-5538-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/47] memory: set ioeventfd_update_pending
 after address_space_update_ioeventfds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: linzhecheng <linzc@zju.edu.cn>, qemu-stable@nongnu.org

From: linzhecheng <linzc@zju.edu.cn>

We should set ioeventfd_update_pending same as memory_region_update_pending.

Signed-off-by: linzhecheng <linzc@zju.edu.cn>
Message-Id: <1515934519-16158-1-git-send-email-linzc@zju.edu.cn>
Cc: qemu-stable@nongnu.org
Fixes: ade9c1aac5292ff698fa550adebe794c37d86cc9
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/memory.c b/memory.c
index 449a142..9e83496 100644
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
