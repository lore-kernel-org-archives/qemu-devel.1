Received: from eggs.gnu.org ([2001:4830:134:3::10]:56137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCx-0007xz-Ad
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCw-00026U-1F
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:47 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCv-0001o4-OA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:45 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:38 -0500
Message-Id: <20181213050453.9677-59-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 58/73] microblaze: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/microblaze/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9b546a2c18..206fdd8651 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -84,7 +84,7 @@ static void mb_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool mb_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.17.1
