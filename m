Received: from eggs.gnu.org ([2001:4830:134:3::10]:38874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dma5S-0000PG-CZ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dma5R-00042y-Jf
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:33:22 -0400
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 29 Aug 2017 02:33:09 -0400
Message-Id: <20170829063313.10237-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH 1/5] target/arm: Remove stale comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: rth@twiddle.net, pbonzini@redhat.com

Update the comment which is not true since MTTCG.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 target/arm/translate-a64.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2200e25be0..f42b155d7d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2012,10 +2012,6 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     }
     tcg_addr = read_cpu_reg_sp(s, rn, 1);
 
-    /* Note that since TCG is single threaded load-acquire/store-release
-     * semantics require no extra if (is_lasr) { ... } handling.
-     */
-
     if (is_excl) {
         if (!is_store) {
             s->is_ldex = true;
-- 
2.13.0
