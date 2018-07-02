Received: from eggs.gnu.org ([2001:4830:134:3::10]:48583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tb-0003uS-Bl
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Ta-0007mq-JD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:51 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0Ta-0007mD-Dm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:50 -0400
Received: by mail-pf0-x243.google.com with SMTP id b17-v6so7660480pfi.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:10:50 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:02 +0900
Message-Id: <20180702151023.24532-5-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 04/25] target/openrisc: Remove DISAS_JUMP &
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
