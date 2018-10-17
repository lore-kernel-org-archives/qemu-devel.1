Received: from eggs.gnu.org ([2001:4830:134:3::10]:44837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2z-00021c-3z
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2u-0006wZ-9T
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39661 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2t-0006gi-QG
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:28 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:54 +0200
Message-Id: <1539779635-15445-27-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 26/27] target/mips: Fix misplaced 'break' in
 handling of NM_SHRA_R_PH
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

From: Stefan Markovic <smarkovic@wavecomp.com>

Fix misplaced 'break' in handling of NM_SHRA_R_PH. Found by
Coverity (CID 1395627).

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 7f97f08..a63509a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -19969,8 +19969,8 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SHRA_PH */
             gen_helper_shra_ph(v1_t, t0, v1_t);
-            break;
             gen_store_gpr(v1_t, rt);
+            break;
         case 1:
             /* SHRA_R_PH */
             gen_helper_shra_r_ph(v1_t, t0, v1_t);
-- 
2.7.4
