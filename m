Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5S-0002yq-Ko
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgux-0007xL-Af
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgux-0007gK-4C
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:45:48 -0400
Message-Id: <20181025144644.15464-15-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 15/71] tcg-runtime: convert to cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/tcg-runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 4aa038465f..70e3c9de71 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -172,5 +172,5 @@ void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
 {
     CPUState *cpu = ENV_GET_CPU(env);
 
-    cpu->halted = val;
+    cpu_halted_set(cpu, val);
 }
-- 
2.17.1
