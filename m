Received: from eggs.gnu.org ([2001:4830:134:3::10]:44182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d4qDj-0006Uo-AU
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d4qDi-0006cL-FK
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:46998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d4qDi-0006bu-AB
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 10:53:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 30 Apr 2017 16:52:53 +0200
Message-Id: <20170430145254.25616-3-aurelien@aurel32.net>
In-Reply-To: <20170430145254.25616-1-aurelien@aurel32.net>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170430145254.25616-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v5++ 2/3] target/mips: optimize cross-page
 direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3022f349cb..1a7ac07c67 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4233,7 +4233,7 @@ static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
             save_cpu_state(ctx, 0);
             gen_helper_raise_exception_debug(cpu_env);
         }
-        tcg_gen_exit_tb(0);
+        tcg_gen_lookup_and_goto_ptr(cpu_PC);
     }
 }
 
-- 
2.11.0
