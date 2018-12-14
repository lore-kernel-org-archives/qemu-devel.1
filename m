Received: from eggs.gnu.org ([2001:4830:134:3::10]:58700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0k-0005rA-DW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0j-0006S2-Ic
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:34 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0j-0006PO-Cm
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:33 -0500
Received: by mail-oi1-x230.google.com with SMTP id x23so3480112oix.3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:56 -0600
Message-Id: <20181214031923.29527-7-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/32] tcg/arm: Remove reloc_pc24_atomic
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

It is unused since 3fb53fb4d12f2e7833bd1659e6013237b130ef20.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index e1fbf465cb..1142eb13ad 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -193,14 +193,6 @@ static inline void reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
     *code_ptr = (*code_ptr & ~0xffffff) | (offset & 0xffffff);
 }
 
-static inline void reloc_pc24_atomic(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
-{
-    ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
-    tcg_insn_unit insn = atomic_read(code_ptr);
-    tcg_debug_assert(offset == sextract32(offset, 0, 24));
-    atomic_set(code_ptr, deposit32(insn, 0, 24, offset));
-}
-
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-- 
2.17.2
