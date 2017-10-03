Received: from eggs.gnu.org ([2001:4830:134:3::10]:59200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzJxH-0001Zk-En
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzJxG-0002ya-Ll
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:57:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  3 Oct 2017 11:57:24 +0200
Message-Id: <1507024644-14853-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/block/onenand: Remove dead code block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The condition of the for-loop makes sure that b is always smaller
than s->blocks, so the "if (b >= s->blocks)" statement is completely
superfluous here.

Buglink: https://bugs.launchpad.net/qemu/+bug/1715007
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/onenand.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 30e40f3..de65c9e 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -520,10 +520,6 @@ static void onenand_command(OneNANDState *s)
         s->intstatus |= ONEN_INT;
 
         for (b = 0; b < s->blocks; b ++) {
-            if (b >= s->blocks) {
-                s->status |= ONEN_ERR_CMD;
-                break;
-            }
             if (s->blockwp[b] == ONEN_LOCK_LOCKTIGHTEN)
                 break;
 
-- 
1.8.3.1
