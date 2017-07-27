Received: from eggs.gnu.org ([2001:4830:134:3::10]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlX-0005aM-7A
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlU-00080N-M1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:15 -0300
Message-Id: <20170727024224.22900-11-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 10/20] m68k/translate: fix
 incorrect copy/paste
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

db3d7945ae extended gen_cc_cond() for cond [6, 7, 9, 10] but misswrote [4, 5]

target/m68k/translate.c:1323:70: warning: identical expressions on both sides of logical operator
        if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
            op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
            ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~ ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ada2a91b64..be24355080 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1321,7 +1321,7 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
     case 5: /* CS (C) */
         /* Some cases fold C into X.  */
         if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
-            op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
+            op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL) {
             tcond = TCG_COND_NE;
             c->v1 = QREG_CC_X;
             goto done;
-- 
2.13.3
