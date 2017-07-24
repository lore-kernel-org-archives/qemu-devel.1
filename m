Received: from eggs.gnu.org ([2001:4830:134:3::10]:55479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoI-0007B0-Me
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoH-0001ck-VC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dZgoH-0001cR-Om
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoF-00008p-Pl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:06:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 18:06:15 +0100
Message-Id: <1500915978-29213-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
References: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/4] target/arm: fix TCG temp leak in aarch64
 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Emilio G. Cota" <cota@braap.org>

Fix a TCG temporary leak in the new aarch64 rev16 handling.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 883e9df..58ed4c6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4051,6 +4051,7 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
     tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
     tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
 
+    tcg_temp_free_i64(mask);
     tcg_temp_free_i64(tcg_tmp);
 }
 
-- 
2.7.4
