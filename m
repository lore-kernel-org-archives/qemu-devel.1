Received: from eggs.gnu.org ([2001:4830:134:3::10]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006Zc-D3
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwK-0006j5-Ld
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:26 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwJ-0006es-QP
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:24 -0500
Received: by mail-wm1-x341.google.com with SMTP id y185so15834187wmd.1
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:19 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:32 +0200
Message-Id: <20181222095036.29743-28-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel]  [PATCH PULL 27/31] pvrdma: add uar_read routine
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

Define skeleton 'uar_read' routine. Avoid NULL dereference.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 64de16fb52..838ad8a949 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -448,6 +448,11 @@ static const MemoryRegionOps regs_ops = {
     },
 };
 
+static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0xffffffff;
+}
+
 static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     PVRDMADev *dev = opaque;
@@ -489,6 +494,7 @@ static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps uar_ops = {
+    .read = uar_read,
     .write = uar_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
-- 
2.17.1
