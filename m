Received: from eggs.gnu.org ([2001:4830:134:3::10]:49354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C57-0000q3-IX
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C54-0001wr-2p
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:36 +0300
Message-Id: <69fa4f9568b18b9b1726a3e51a0bc48478798ad4.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
References: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 09/14] include/hw/or-irq.h: Drop unused in_irqs
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

The struct OrIRQState has an unused member field in_irqs.
This is a legacy of earlier versions of the patch; the
code that used it was dropped from the final version of
the code that went into master, but we forgot to delete
the no-longer-used struct field. Do so now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/or-irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index d400a8120b..fd900fcf19 100644
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
2.11.0
