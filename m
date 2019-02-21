Received: from eggs.gnu.org ([209.51.188.92]:52144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXq-0008TL-5s
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXo-0007S0-SQ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXn-0007PC-1t
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:03 -0500
Received: by mail-wm1-x32e.google.com with SMTP id n19so10575305wmi.1
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:58:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:32 +0000
Message-Id: <20190221185739.25362-15-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/21] hw/arm/armsse: Document SRAM_ADDR_WIDTH
 property in header comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit 4b635cf7a95e501211 we added a QOM property to the ARMSSE
object, but forgot to add it to the documentation comment in the
header. Correct the omission.

Fixes: 4b635cf7a95e501211 ("hw/arm/armsse: Make SRAM bank size configurable")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
