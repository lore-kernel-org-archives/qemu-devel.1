Received: from eggs.gnu.org ([2001:4830:134:3::10]:39856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDg-0004tp-GB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDf-0007e1-KO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:40 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:40667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDf-0007dp-E6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:39 -0400
Received: by mail-pf0-x230.google.com with SMTP id z24-v6so1887375pfe.7
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:11 -0700
Message-Id: <20180628030330.15615-5-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/23] target/openrisc: Remove DISAS_JUMP &
 DISAS_TB_JUMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

These values are unused.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.1
