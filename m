Received: from eggs.gnu.org ([2001:4830:134:3::10]:42890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC6-0000dj-MC
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC5-0007qC-Rg
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC5-0007PR-I2
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC2-0003nA-9a
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:11 +0100
Message-Id: <20181016152325.31367-6-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/19] target/arm: Fix cortex-a7 id_isar0
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

The incorrect value advertised only thumb2 div without arm div.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181008212205.17752-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7ea7e4c1316..cd48ad42d87 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1587,7 +1587,10 @@ static void cortex_a7_initfn(Object *obj)
     cpu->id_mmfr1 = 0x40000000;
     cpu->id_mmfr2 = 0x01240000;
     cpu->id_mmfr3 = 0x02102211;
-    cpu->id_isar0 = 0x01101110;
+    /* a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
+     * table 4-41 gives 0x02101110, which includes the arm div insns.
+     */
+    cpu->id_isar0 = 0x02101110;
     cpu->id_isar1 = 0x13112111;
     cpu->id_isar2 = 0x21232041;
     cpu->id_isar3 = 0x11112131;
-- 
2.19.0
