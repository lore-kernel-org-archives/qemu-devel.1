Received: from eggs.gnu.org ([2001:4830:134:3::10]:59950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMdW-0007V1-Ft
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHMdW-0007Lc-06
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:02 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:43553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHMdV-0007LU-Rc
	for qemu-devel@nongnu.org; Sat, 12 May 2018 01:00:01 -0400
Received: by mail-pf0-x243.google.com with SMTP id j20-v6so3605225pff.10
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 22:00:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 21:59:44 -0700
Message-Id: <20180512045950.12386-6-richard.henderson@linaro.org>
In-Reply-To: <20180512045950.12386-1-richard.henderson@linaro.org>
References: <20180512045950.12386-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/9] target/m68k: Remove DISAS_JUMP_NEXT as
 unused
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6ab24fac0b..c795d8e64f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -199,7 +199,6 @@ static void do_writebacks(DisasContext *s)
 /* is_jmp field values */
 #define DISAS_JUMP      DISAS_TARGET_0 /* only pc was modified dynamically */
 #define DISAS_UPDATE    DISAS_TARGET_1 /* cpu state was modified dynamically */
-#define DISAS_JUMP_NEXT DISAS_TARGET_3
 
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
-- 
2.17.0
