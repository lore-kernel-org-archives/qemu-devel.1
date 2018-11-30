Received: from eggs.gnu.org ([2001:4830:134:3::10]:52503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqi6-0007rW-8U
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqi5-0006TI-Gm
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:30 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSqi5-0006Nf-9g
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:29 -0500
Received: by mail-pf1-x444.google.com with SMTP id c73so3415644pfe.13
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:52:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 13:52:08 -0800
Message-Id: <20181130215221.20554-4-richard.henderson@linaro.org>
In-Reply-To: <20181130215221.20554-1-richard.henderson@linaro.org>
References: <20181130215221.20554-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 03/16] tcg/aarch64: Remove reloc_pc26_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

It is unused since b68686bd4bfeb70040b4099df993dfa0b4f37b03.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 083592a4d7..a41b633960 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -87,18 +87,6 @@ static inline void reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
     *code_ptr = deposit32(*code_ptr, 0, 26, offset);
 }
 
-static inline void reloc_pc26_atomic(tcg_insn_unit *code_ptr,
-                                     tcg_insn_unit *target)
-{
-    ptrdiff_t offset = target - code_ptr;
-    tcg_insn_unit insn;
-    tcg_debug_assert(offset == sextract64(offset, 0, 26));
-    /* read instruction, mask away previous PC_REL26 parameter contents,
-       set the proper offset, then write back the instruction. */
-    insn = atomic_read(code_ptr);
-    atomic_set(code_ptr, deposit32(insn, 0, 26, offset));
-}
-
 static inline void reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
 {
     ptrdiff_t offset = target - code_ptr;
-- 
2.17.2
