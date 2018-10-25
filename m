Received: from eggs.gnu.org ([2001:4830:134:3::10]:60776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5U-0004Uf-Re
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgus-0007ta-S2
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgus-0007gJ-JN
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:43 -0400
Message-Id: <20181025144644.15464-10-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 10/71] hppa: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/hppa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ce05d5619d..df9179e70f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2845,8 +2845,7 @@ static DisasJumpType trans_pause(DisasContext *ctx, uint32_t insn,
 
     /* Tell the qemu main loop to halt until this cpu has work.  */
     tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, cpu_env, -offsetof(HPPACPU, env) +
-                                 offsetof(CPUState, halted));
+    gen_helper_cpu_halted_set(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
     gen_excp_1(EXCP_HALTED);
 
-- 
2.17.1
