Received: from eggs.gnu.org ([2001:4830:134:3::10]:57237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5E-0003LD-9p
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5C-0004H8-GP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:56 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5C-0004FX-9G
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:40:54 -0400
Received: by mail-pf0-x22d.google.com with SMTP id w7-v6so8602266pfn.9
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:40:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:25 -1000
Message-Id: <20180618184046.6270-2-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/22] target/openrisc: Remove DISAS_JUMP &
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
index d69f8d0422..2d7588a3eb 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -41,9 +41,7 @@
                   ## __VA_ARGS__)
 
 /* is_jmp field values */
-#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
-#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
 
 typedef struct DisasContext {
     DisasContextBase base;
@@ -1467,8 +1465,6 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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
