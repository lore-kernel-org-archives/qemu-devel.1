Received: from eggs.gnu.org ([209.51.188.92]:49935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeO-00034b-FP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGUe-000728-Je
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:58 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGUe-0006ZF-Ao
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:56 -0500
Received: by mail-wm1-x32c.google.com with SMTP id x10so5926232wmg.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:51:01 +0000
Message-Id: <20190214125107.22178-9-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/14] hw/arm/armsse: Document SRAM_ADDR_WIDTH
 property in header comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

In commit 4b635cf7a95e501211 we added a QOM property to the ARMSSE
object, but forgot to add it to the documentation comment in the
header. Correct the omission.

Fixes: 4b635cf7a95e501211 ("hw/arm/armsse: Make SRAM bank size configurable")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index f800bafb14a..444605b44dc 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -46,6 +46,8 @@
  *    being the same for both, to avoid having to have separate Property
  *    lists for different variants. This restriction can be relaxed later
  *    if necessary.)
+ *  + QOM property "SRAM_ADDR_WIDTH" sets the number of bits used for the
+ *    address of each SRAM bank (and thus the total amount of internal SRAM)
  *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts for CPU 0,
  *    which are wired to its NVIC lines 32 .. n+32
  *  + Named GPIO inputs "EXP_CPU1_IRQ" 0..n are the expansion interrupts for
-- 
2.20.1
