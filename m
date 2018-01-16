Received: from eggs.gnu.org ([2001:4830:134:3::10]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNr-0008AB-Cx
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNq-0002mP-Ku
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNq-0002ll-Dz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNp-0002tN-Db
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:05 +0000
Message-Id: <1516109659-1557-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/24] target/arm: Add fp16 support to
 vfp_expand_imm
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180110063337.21538-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 80ae019..cf537e9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5006,6 +5006,11 @@ static uint64_t vfp_expand_imm(int size, uint8_t imm8)
             (extract32(imm8, 0, 6) << 3);
         imm <<= 16;
         break;
+    case MO_16:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3000 : 0x4000) |
+            (extract32(imm8, 0, 6) << 6);
+        break;
     default:
         g_assert_not_reached();
     }
-- 
2.7.4
