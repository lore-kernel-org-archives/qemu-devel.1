Received: from eggs.gnu.org ([2001:4830:134:3::10]:57637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stweil@ub-blade-01.bib.uni-mannheim.de>)
	id 1fdi6e-0004RJ-DS
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stweil@ub-blade-01.bib.uni-mannheim.de>)
	id 1fdi6b-0002su-90
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:22:28 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Thu, 12 Jul 2018 21:44:54 +0200
Message-Id: <20180712194454.26765-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH] accel: Fix typo and grammar in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>

The typo was found by codespell.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 49d77fad44..1571987113 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1795,7 +1795,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->jmp_dest[0] = (uintptr_t)NULL;
     tb->jmp_dest[1] = (uintptr_t)NULL;
 
-    /* init original jump addresses wich has been set during tcg_gen_code() */
+    /* init original jump addresses which have been set during tcg_gen_code() */
     if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
         tb_reset_jump(tb, 0);
     }
-- 
2.11.0
