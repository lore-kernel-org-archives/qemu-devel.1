Received: from eggs.gnu.org ([2001:4830:134:3::10]:57487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2L-0005mJ-OM
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2H-0002rD-66
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:33 -0500
Received: from bran.ispras.ru ([83.149.199.196]:54420 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2G-0002r0-UT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:29 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  9 Nov 2017 17:41:53 +0300
Message-Id: <20171109144155.17076-2-batuzovk@ispras.ru>
In-Reply-To: <20171109144155.17076-1-batuzovk@ispras.ru>
References: <20171109144155.17076-1-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH RFC 1/3] tcg: support MOV_VEC and MOVI_VEC
 opcodes in register allocator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kirill Batuzov <batuzovk@ispras.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/tcg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index a7854a59a1..6db7dd526a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3327,10 +3327,12 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         switch (opc) {
         case INDEX_op_mov_i32:
         case INDEX_op_mov_i64:
+        case INDEX_op_mov_vec:
             tcg_reg_alloc_mov(s, op);
             break;
         case INDEX_op_movi_i32:
         case INDEX_op_movi_i64:
+        case INDEX_op_movi_vec:
             tcg_reg_alloc_movi(s, op);
             break;
         case INDEX_op_insn_start:
-- 
2.11.0
