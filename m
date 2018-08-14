Received: from eggs.gnu.org ([2001:4830:134:3::10]:52950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdw3-0005Oq-Bo
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduP-0006us-Qx
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduP-0006uC-I2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduO-0007R8-FG
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:19:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:15 +0100
Message-Id: <20180814181815.23348-46-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 45/45] target/arm: Fix typo in helper_sve_movz_d
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

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180801123111.3595-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 87594a8adb4..c3cbec9cf5f 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1042,7 +1042,7 @@ void HELPER(sve_movz_d)(void *vd, void *vn, void *vg, uint32_t desc)
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
     for (i = 0; i < opr_sz; i += 1) {
-        d[i] = n[1] & -(uint64_t)(pg[H1(i)] & 1);
+        d[i] = n[i] & -(uint64_t)(pg[H1(i)] & 1);
     }
 }
 
-- 
2.18.0
