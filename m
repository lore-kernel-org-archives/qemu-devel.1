Received: from eggs.gnu.org ([2001:4830:134:3::10]:44607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbL-0006Kl-Ma
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbK-0007py-Td
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:15 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:51598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gbK-0007pi-Nc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:14 -0400
Received: by mail-pf0-x241.google.com with SMTP id n14so13059363pfh.8
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:21:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:20:04 -0700
Message-Id: <20171020232023.15010-34-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 33/52] target/sparc: check CF_PARALLEL
 instead of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f2b5cdbf34..9dc41869a4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2437,7 +2437,7 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
     default:
         /* ??? In theory, this should be raise DAE_invalid_asi.
            But the SS-20 roms do ldstuba [%l0] #ASI_M_CTL, %o1.  */
-        if (parallel_cpus) {
+        if (tb_cflags(dc->tb) & CF_PARALLEL) {
             gen_helper_exit_atomic(cpu_env);
         } else {
             TCGv_i32 r_asi = tcg_const_i32(da.asi);
-- 
2.13.6
