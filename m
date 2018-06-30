Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZ3Lm-0002F3-Rq
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 20:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZ3Lk-0007AA-TI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 20:02:50 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:32984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZ3Lk-00078k-Np
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 20:02:48 -0400
Received: by mail-pl0-x244.google.com with SMTP id 6-v6so5176599plb.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 17:02:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Jun 2018 17:02:41 -0700
Message-Id: <20180630000242.29594-2-richard.henderson@linaro.org>
In-Reply-To: <20180630000242.29594-1-richard.henderson@linaro.org>
References: <20180630000242.29594-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Always return ARMASIdx_NS when
 num_ases == 1
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
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e310ffc29d..c26cc43ea8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2915,7 +2915,7 @@ enum {
 /* Return the address space index to use for a memory access */
 static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
-    return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
+    return cs->num_ases > 1 && attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
 }
 
 /* Return the AddressSpace to use for a memory access
-- 
2.17.1
