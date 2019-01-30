Received: from eggs.gnu.org ([209.51.188.92]:35078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe37-0007tC-02
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe36-0000fh-8s
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:16 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe36-0000f5-3j
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:16 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:09 -0500
Message-Id: <20190130004811.27372-12-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 11/73] hppa: convert to helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
