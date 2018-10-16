Received: from eggs.gnu.org ([2001:4830:134:3::10]:42923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC8-0000eU-0K
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC6-0007tW-W4
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC6-0007PR-MK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC1-0003mw-6v
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:10 +0100
Message-Id: <20181016152325.31367-5-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/19] target/arm: Align cortex-r5 id_isar0
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

The missing nibble made it more difficult to read.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181008212205.17752-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b5e61cc1775..7ea7e4c1316 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1397,7 +1397,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->id_mmfr1 = 0x00000000;
     cpu->id_mmfr2 = 0x01200000;
     cpu->id_mmfr3 = 0x0211;
-    cpu->id_isar0 = 0x2101111;
+    cpu->id_isar0 = 0x02101111;
     cpu->id_isar1 = 0x13112111;
     cpu->id_isar2 = 0x21232141;
     cpu->id_isar3 = 0x01112131;
-- 
2.19.0
