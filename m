Received: from eggs.gnu.org ([2001:4830:134:3::10]:41853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwO-0006a0-3F
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006lQ-8i
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwN-0006hx-1t
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:27 -0500
Received: by mail-wm1-x342.google.com with SMTP id y185so15834305wmd.1
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:23 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:35 +0200
Message-Id: <20181222095036.29743-31-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 30/31] rdma: remove unused
 VENDOR_ERR_NO_SGE macro
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

From: Prasad J Pandit <pjp@fedoraproject.org>

With commit 4481985c (rdma: check num_sge does not exceed MAX_SGE)
macro VENDOR_ERR_NO_SGE is no longer in use - delete it.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index bd4710d16f..c28bfbd44d 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -37,12 +37,11 @@
 #define VENDOR_ERR_TOO_MANY_SGES    0x202
 #define VENDOR_ERR_NOMEM            0x203
 #define VENDOR_ERR_QP0              0x204
-#define VENDOR_ERR_NO_SGE           0x205
+#define VENDOR_ERR_INV_NUM_SGE      0x205
 #define VENDOR_ERR_MAD_SEND         0x206
 #define VENDOR_ERR_INVLKEY          0x207
 #define VENDOR_ERR_MR_SMALL         0x208
 #define VENDOR_ERR_INV_MAD_BUFF     0x209
-#define VENDOR_ERR_INV_NUM_SGE      0x210
 
 #define THR_NAME_LEN 16
 #define THR_POLL_TO  5000
-- 
2.17.1
