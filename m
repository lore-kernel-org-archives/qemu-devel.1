Received: from eggs.gnu.org ([2001:4830:134:3::10]:55913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxw-0000ax-5t
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxv-0003HY-EF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:50 +0200
Message-Id: <20171006155422.10135-23-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/54] hw/block/onenand: Remove dead code block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

The condition of the for-loop makes sure that b is always smaller
than s->blocks, so the "if (b >= s->blocks)" statement is completely
superfluous here.

Buglink: https://bugs.launchpad.net/qemu/+bug/1715007
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/onenand.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index 30e40f3914..de65c9ebb9 100644
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
2.13.6
