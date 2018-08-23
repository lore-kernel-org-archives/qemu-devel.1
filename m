Received: from eggs.gnu.org ([2001:4830:134:3::10]:46034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspmJ-00056b-1U
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspmA-0000F1-K8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41931 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fspmA-0000AL-1b
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:50 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 15:34:28 +0200
Message-Id: <1535031276-22911-39-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v4 38/46] target/mips: Fix ERET/ERETNC behavior
 related to ADEL exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

Fix ERET/ERETNC so that ADEL exception can be raised.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/op_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index b3eef9f..c148b31 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2427,10 +2427,12 @@ void helper_eretnc(CPUMIPSState *env)
 void helper_deret(CPUMIPSState *env)
 {
     debug_pre_eret(env);
-    set_pc(env, env->CP0_DEPC);
 
     env->hflags &= ~MIPS_HFLAG_DM;
     compute_hflags(env);
+
+    set_pc(env, env->CP0_DEPC);
+
     debug_post_eret(env);
 }
 #endif /* !CONFIG_USER_ONLY */
-- 
2.7.4
