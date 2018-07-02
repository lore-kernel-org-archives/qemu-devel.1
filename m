Received: from eggs.gnu.org ([2001:4830:134:3::10]:47235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLV-0002Cl-P1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLU-0007vg-5k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:25 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzLT-0007uj-W1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:24 -0400
Received: by mail-pl0-x241.google.com with SMTP id z9-v6so8007624plo.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:58:23 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:57:45 +0900
Message-Id: <20180702135806.7087-5-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/25] target/openrisc: Remove DISAS_JUMP &
 DISAS_TB_JUMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

These values are unused.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index fbdc2058dc..f5af515979 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -37,9 +37,7 @@
 #include "exec/log.h"
 
 /* is_jmp field values */
-#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
-#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
 typedef struct DisasContext {
     DisasContextBase base;
@@ -1353,8 +1351,6 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             gen_goto_tb(dc, 0, dc->base.pc_next);
             break;
         case DISAS_NORETURN:
-        case DISAS_JUMP:
-        case DISAS_TB_JUMP:
             break;
         case DISAS_UPDATE:
             /* indicate that the hash table must be used
-- 
2.17.0
