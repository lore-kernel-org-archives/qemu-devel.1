Received: from eggs.gnu.org ([2001:4830:134:3::10]:57662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQP-0008PR-3v
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQN-0004Md-3J
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:33 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMwQM-0004MO-U0
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:31 -0400
Received: by mail-pl0-x242.google.com with SMTP id n10-v6so5737103plp.0
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 07:13:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 27 May 2018 09:13:05 -0500
Message-Id: <20180527141324.11937-2-richard.henderson@linaro.org>
In-Reply-To: <20180527141324.11937-1-richard.henderson@linaro.org>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/20] target/openrisc: Remove DISAS_JUMP &
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
Cc: Stafford Horne <shorne@gmail.com>

These values are unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index e7c96ca990..f4f2f37e28 100644
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
2.17.0
