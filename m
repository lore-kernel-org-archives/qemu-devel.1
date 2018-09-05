Received: from eggs.gnu.org ([2001:4830:134:3::10]:49816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fxWvu-0005NS-1E
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fxWvq-0001aD-Pd
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:29:17 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fxWvq-0001ZP-JX
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:29:14 -0400
Received: by mail-pf1-x444.google.com with SMTP id d4-v6so3423688pfn.0
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 05:29:14 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed,  5 Sep 2018 05:29:08 -0700
Message-Id: <1536150548-2797-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] cpu.h: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Found by reading the code.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 include/qom/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index dc130cd307..5bb94a9f86 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -852,7 +852,7 @@ extern CPUInterruptHandler cpu_interrupt_handler;
 /**
  * cpu_interrupt:
  * @cpu: The CPU to set an interrupt on.
- * @mask: The interupts to set.
+ * @mask: The interrupts to set.
  *
  * Invokes the interrupt handler.
  */
-- 
2.11.0
