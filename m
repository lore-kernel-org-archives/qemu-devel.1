Received: from eggs.gnu.org ([209.51.188.92]:33152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKEJ-0005c6-EH
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKEI-0007i1-PZ
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKEI-0007he-K8
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id x10so6835054wrs.8
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:14:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 10:14:45 +0000
Message-Id: <20190206101446.6898-2-richard.henderson@linaro.org>
In-Reply-To: <20190206101446.6898-1-richard.henderson@linaro.org>
References: <20190206101446.6898-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH RISU 1/2] aarch64: Fill in fp regs for
 test_aarch64.s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 test_aarch64.s | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/test_aarch64.s b/test_aarch64.s
index d5a8495..f75d588 100644
--- a/test_aarch64.s
+++ b/test_aarch64.s
@@ -43,6 +43,40 @@ mov w28, 28
 mov w29, 29
 mov w30, 30
 
+/* Initialise the fp regs */
+movi d0, #0
+fmov d1, #1.0
+fmov d2, #2.0
+fmov d3, #3.0
+fmov d4, #4.0
+fmov d5, #5.0
+fmov d6, #6.0
+fmov d7, #7.0
+fmov d8, #8.0
+fmov d9, #9.0
+fmov d10, #10.0
+fmov d11, #11.0
+fmov d12, #12.0
+fmov d13, #13.0
+fmov d14, #14.0
+fmov d15, #15.0
+fmov d16, #16.0
+fmov d17, #17.0
+fmov d18, #18.0
+fmov d19, #19.0
+fmov d20, #20.0
+fmov d21, #21.0
+fmov d22, #22.0
+fmov d23, #23.0
+fmov d24, #24.0
+fmov d25, #25.0
+fmov d26, #26.0
+fmov d27, #27.0
+fmov d28, #28.0
+fmov d29, #29.0
+fmov d30, #30.0
+fmov d31, #31.0
+
 /* do compare.
  * The manual says instr with bits (28,27) == 0 0 are UNALLOCATED
  */
-- 
2.17.2
