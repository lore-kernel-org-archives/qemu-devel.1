Received: from eggs.gnu.org ([2001:4830:134:3::10]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Og-0007wF-0v
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Of-0002JW-9P
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Of-00029H-3T
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OU-0003TG-7M
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:58 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:42 +0100
Message-Id: <1500295494-8991-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/18] target/arm/translate.h: expand comment on
 DISAS_EXIT
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

We already have an exit condition, DISAS_UPDATE which will exit the
run-loop. Expand on the difference with DISAS_EXIT in the comments.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 20170713141928.25419-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 15d383d..12fd79b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -140,7 +140,10 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  */
 #define DISAS_BX_EXCRET 11
 /* For instructions which want an immediate exit to the main loop,
- * as opposed to attempting to use lookup_and_goto_ptr.
+ * as opposed to attempting to use lookup_and_goto_ptr. Unlike
+ * DISAS_UPDATE this doesn't write the PC on exiting the translation
+ * loop so you need to ensure something (gen_a64_set_pc_im or runtime
+ * helper) has done so before we reach return from cpu_tb_exec.
  */
 #define DISAS_EXIT 12
 
-- 
2.7.4
