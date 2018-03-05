Received: from eggs.gnu.org ([2001:4830:134:3::10]:34233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1esyMR-0001vt-0X
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1esyMN-0002Ns-MZ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:13:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  5 Mar 2018 17:13:30 -0500
Message-Id: <1520288010-9187-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] tcg: fix s/compliment/complement/ typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 2 +-
 target/m68k/translate.c | 2 +-
 tcg/README              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0135415..2e923c0 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -113,7 +113,7 @@ typedef struct DisasContext {
     int rex_x, rex_b;
 #endif
     int vex_l;  /* vex vector length */
-    int vex_v;  /* vex vvvv register, without 1's compliment.  */
+    int vex_v;  /* vex vvvv register, without 1's complement.  */
     int ss32;   /* 32 bit stack segment */
     CCOp cc_op;  /* current CC operation */
     bool cc_op_dirty;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dbb24f8..8f0b7c9 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3974,7 +3974,7 @@ DISAS_INSN(bfext_reg)
     TCGv shift;
 
     /* In general, we're going to rotate the field so that it's at the
-       top of the word and then right-shift by the compliment of the
+       top of the word and then right-shift by the complement of the
        width to extend the field.  */
     if (ext & 0x20) {
         /* Variable width.  */
diff --git a/tcg/README b/tcg/README
index bb2ea51..8a8d7e2 100644
--- a/tcg/README
+++ b/tcg/README
@@ -553,7 +553,7 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 * orc_vec   v0, v1, v2
 * not_vec   v0, v1
 
-  Similarly, logical operations with and without compliment.
+  Similarly, logical operations with and without complement.
   Note that VECE is unused.
 
 * shli_vec   v0, v1, i2
-- 
2.7.4
