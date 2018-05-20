Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHck-0001XQ-4J
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHcg-0005Jp-PD
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:15:18 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:47 +0300
Message-Id: <1d349821551c2da4dfefe36c6ac17319f33ebbd5.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 01/22] tcg: fix s/compliment/complement/ typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/i386/translate.c | 2 +-
 target/m68k/translate.c | 2 +-
 tcg/README              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b0f69838f2..7c21814676 100644
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
index 44a0ac4e2e..8959e4d0f0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4002,7 +4002,7 @@ DISAS_INSN(bfext_reg)
     TCGv shift;
 
     /* In general, we're going to rotate the field so that it's at the
-       top of the word and then right-shift by the compliment of the
+       top of the word and then right-shift by the complement of the
        width to extend the field.  */
     if (ext & 0x20) {
         /* Variable width.  */
diff --git a/tcg/README b/tcg/README
index a5237a9edb..d22ee084b8 100644
--- a/tcg/README
+++ b/tcg/README
@@ -561,7 +561,7 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 * orc_vec   v0, v1, v2
 * not_vec   v0, v1
 
-  Similarly, logical operations with and without compliment.
+  Similarly, logical operations with and without complement.
   Note that VECE is unused.
 
 * shli_vec   v0, v1, i2
-- 
2.11.0
