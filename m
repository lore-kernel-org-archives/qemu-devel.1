Received: from eggs.gnu.org ([2001:4830:134:3::10]:41608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvt-0006BP-9y
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvr-0006NE-DF
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvr-0006L1-5A
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:50:55 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so7506661wrx.9
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:50:52 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:13 +0200
Message-Id: <20181222095036.29743-9-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 08/31] hw/pvrdma: Make default pkey 0xFFFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Yuval Shaia <yuval.shaia@oracle.com>

Commit 6e7dba23af ("hw/pvrdma: Make default pkey 0xFFFF") exports
default pkey as external definition but omit the change from 0x7FFF to
0xFFFF.

Fixes: 6e7dba23af ("hw/pvrdma: Make default pkey 0xFFFF")

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index e3742d893a..15c3f28b86 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -52,7 +52,7 @@
 #define PVRDMA_FW_VERSION    14
 
 /* Some defaults */
-#define PVRDMA_PKEY          0x7FFF
+#define PVRDMA_PKEY          0xFFFF
 
 typedef struct DSRInfo {
     dma_addr_t dma;
-- 
2.17.1
