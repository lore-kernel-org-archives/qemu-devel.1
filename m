Received: from eggs.gnu.org ([2001:4830:134:3::10]:55261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey87-0001Mj-Mr
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey84-000798-Lf
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fey84-00078d-Bp
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:08 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 16 Jul 2018 10:40:34 +0300
Message-Id: <20180716074038.3364-10-yuval.shaia@oracle.com>
In-Reply-To: <20180716074038.3364-1-yuval.shaia@oracle.com>
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 09/13] hw/pvrdma: Cosmetic change - indent right
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 1b1330e113..3d448bffc4 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -430,7 +430,7 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
             reset_device(dev);
             break;
         }
-    break;
+        break;
     case PVRDMA_REG_IMR:
         pr_dbg("Interrupt mask=0x%" PRIx64 "\n", val);
         dev->interrupt_mask = val;
@@ -439,7 +439,7 @@ static void regs_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         if (val == 0) {
             execute_command(dev);
         }
-    break;
+        break;
     default:
         break;
     }
-- 
2.17.1
