Received: from eggs.gnu.org ([2001:4830:134:3::10]:39610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabm-0003q4-O1
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabh-0002ou-50
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabg-0002o7-Tu
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabg-0001Ox-0z
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:12 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:06:56 +0100
Message-Id: <20180515140707.15957-6-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/16] target/arm: Early exit after
 unallocated_encoding in disas_fp_int_conv
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

No sense in emitting code after the exception.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5b8cf75e9f..11d8c07943 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5780,7 +5780,7 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
         default:
             /* all other sf/type/rmode combinations are invalid */
             unallocated_encoding(s);
-            break;
+            return;
         }
 
         if (!fp_access_check(s)) {
-- 
2.17.0
