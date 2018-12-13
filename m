Received: from eggs.gnu.org ([2001:4830:134:3::10]:55451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCe-0007fF-Vx
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCd-0001bM-Ny
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:28 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCd-0000yW-6O
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:02 -0500
Message-Id: <20181213050453.9677-23-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 22/73] m68k: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/m68k/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8d09ed91c4..61ba1a6dec 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -237,7 +237,7 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
                 do_m68k_semihosting(env, env->dregs[0]);
                 return;
             }
-            cs->halted = 1;
+            cpu_halted_set(cs, 1);
             cs->exception_index = EXCP_HLT;
             cpu_loop_exit(cs);
             return;
-- 
2.17.1
