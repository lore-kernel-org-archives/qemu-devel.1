Received: from eggs.gnu.org ([2001:4830:134:3::10]:46263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2dMv-0006lW-8M
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2dMu-0008I1-HO
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:17:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 14:17:47 +0100
Message-Id: <1507814267-21400-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] include/hw/or-irq.h: Drop unused in_irqs field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Alistair Francis <alistair.francis@xilinx.com>

The struct OrIRQState has an unused member field in_irqs.
This is a legacy of earlier versions of the patch; the
code that used it was dropped from the final version of
the code that went into master, but we forgot to delete
the no-longer-used struct field. Do so now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/or-irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index d400a81..fd900fc 100644
--- a/include/hw/or-irq.h
+++ b/include/hw/or-irq.h
@@ -38,7 +38,6 @@ struct OrIRQState {
     DeviceState parent_obj;
 
     qemu_irq out_irq;
-    qemu_irq *in_irqs;
     bool levels[MAX_OR_LINES];
     uint16_t num_lines;
 };
-- 
2.7.4
