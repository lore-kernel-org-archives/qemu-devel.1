Received: from eggs.gnu.org ([2001:4830:134:3::10]:43947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYj-00007p-9c
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1frjYf-0000fx-Ng
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1frjYf-0000fh-H2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:45:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id o37-v6so4009432wrf.6
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 05:45:21 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun, 19 Aug 2018 23:22:54 +0300
Message-Id: <20180819202300.10590-10-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 09/15] hw/pvrdma: Cosmetic change - indent
 right
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, thuth@redhat.com, marcel.apfelbaum@gmail.com

From: Yuval Shaia <yuval.shaia@oracle.com>

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20180805153518.2983-10-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
