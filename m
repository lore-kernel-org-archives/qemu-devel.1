Received: from eggs.gnu.org ([2001:4830:134:3::10]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcl-0007fr-CI
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWck-00052b-NA
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fcWck-00051K-9w
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:54:42 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fcWcj-0000iu-4l
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:54:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jul 2018 14:54:30 +0100
Message-Id: <20180709135435.836-7-peter.maydell@linaro.org>
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/11] target/arm: Suppress Coverity warning for
 PRF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

These instructions must perform the sve_access_check, but
since they are implemented as NOPs there is no generated
code to elide when the access check fails.

Fixes: Coverity issues 1393780 & 1393779.
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c080345b9c7..d41f1155f91 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5164,7 +5164,7 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a, uint32_t insn)
 static bool trans_PRF(DisasContext *s, arg_PRF *a, uint32_t insn)
 {
     /* Prefetch is a nop within QEMU.  */
-    sve_access_check(s);
+    (void)sve_access_check(s);
     return true;
 }
 
@@ -5174,7 +5174,7 @@ static bool trans_PRF_rr(DisasContext *s, arg_PRF_rr *a, uint32_t insn)
         return false;
     }
     /* Prefetch is a nop within QEMU.  */
-    sve_access_check(s);
+    (void)sve_access_check(s);
     return true;
 }
 
-- 
2.17.1
