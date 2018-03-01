Received: from eggs.gnu.org ([2001:4830:134:3::10]:33699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJs-0003gT-UZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJs-00085t-6C
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJr-00082m-Vx
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJq-0000ai-Qh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:14 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:36 +0000
Message-Id: <20180301112403.12487-16-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/42] arm/translate-a64: handle_3same_64
 comment fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

We do implement all the opcodes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-8-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ebaf4571ac..5dd54b7ac4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7278,8 +7278,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     /* Handle 64x64->64 opcodes which are shared between the scalar
      * and vector 3-same groups. We cover every opcode where size == 3
      * is valid in either the three-reg-same (integer, not pairwise)
-     * or scalar-three-reg-same groups. (Some opcodes are not yet
-     * implemented.)
+     * or scalar-three-reg-same groups.
      */
     TCGCond cond;
 
-- 
2.16.2
