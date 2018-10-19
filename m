Received: from eggs.gnu.org ([2001:4830:134:3::10]:48682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY82-0003PH-De
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY81-0004x2-FX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY81-0002Jh-6X
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:00:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY65-0006kk-1B
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:13 +0100
Message-Id: <20181019165735.22511-24-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/45] target/arm: Don't call
 tcg_clear_temp_count
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

This is done generically in translator_loop.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181011205206.3552-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 1 -
 target/arm/translate.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 371909620bb..c3a0e5accd8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13899,7 +13899,6 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
 
 static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
-    tcg_clear_temp_count();
 }
 
 static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1bf339a98b6..7d7a48e5b93 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12701,7 +12701,6 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
         tcg_gen_movi_i32(tmp, 0);
         store_cpu_field(tmp, condexec_bits);
     }
-    tcg_clear_temp_count();
 }
 
 static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.19.1
