Received: from eggs.gnu.org ([2001:4830:134:3::10]:56111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCw-0007xU-Px
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCv-00024P-KY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:46 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCv-0001nP-AK
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:45 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:34 -0500
Message-Id: <20181213050453.9677-55-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 54/73] moxie: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Anthony Green <green@moxielogic.com>

Cc: Anthony Green <green@moxielogic.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/moxie/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 8d67eb6727..bad92cfc61 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -33,7 +33,7 @@ static void moxie_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool moxie_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void moxie_cpu_reset(CPUState *s)
-- 
2.17.1
