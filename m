Received: from eggs.gnu.org ([2001:4830:134:3::10]:52931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdw0-0005MY-RC
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduN-0006u1-H4
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduN-0006sm-7t
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduL-0007QI-OB
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:19:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:13 +0100
Message-Id: <20180814181815.23348-44-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/45] target/arm: Fix typo in do_sat_addsub_64
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

Used the wrong temporary in the computation of subtractive overflow.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180801123111.3595-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 374051cd20a..9dd4c38bab7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1625,7 +1625,7 @@ static void do_sat_addsub_64(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
             /* Detect signed overflow for subtraction.  */
             tcg_gen_xor_i64(t0, reg, val);
             tcg_gen_sub_i64(t1, reg, val);
-            tcg_gen_xor_i64(reg, reg, t0);
+            tcg_gen_xor_i64(reg, reg, t1);
             tcg_gen_and_i64(t0, t0, reg);
 
             /* Bound the result.  */
-- 
2.18.0
