Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqY-0002XL-JC
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqW-0004c4-T5
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:34 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:57221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqW-0004bg-Nn
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:32 -0400
Received: by mail-pf0-x235.google.com with SMTP id b85so4313257pfj.13
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:59 -0700
Message-Id: <20171010005600.28735-23-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/23] tcg: define TCG_HIGHWATER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Will come in handy very soon.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ee60798438..4492e1eb3f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -116,6 +116,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 static bool tcg_out_ldst_finalize(TCGContext *s);
 #endif
 
+#define TCG_HIGHWATER 1024
+
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -430,7 +432,7 @@ void tcg_prologue_init(TCGContext *s)
     /* Compute a high-water mark, at which we voluntarily flush the buffer
        and start over.  The size here is arbitrary, significantly larger
        than we expect the code generation for any one opcode to require.  */
-    s->code_gen_highwater = s->code_gen_buffer + (total_size - 1024);
+    s->code_gen_highwater = s->code_gen_buffer + (total_size - TCG_HIGHWATER);
 
     tcg_register_jit(s->code_gen_buffer, total_size);
 
-- 
2.13.6
