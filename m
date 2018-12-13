Received: from eggs.gnu.org ([2001:4830:134:3::10]:55891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCr-0007rf-Ur
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXJCp-0001uz-5i
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:41 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXJCo-0001bB-CN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:06:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Dec 2018 00:04:27 -0500
Message-Id: <20181213050453.9677-48-cota@braap.org>
In-Reply-To: <20181213050453.9677-1-cota@braap.org>
References: <20181213050453.9677-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 47/73] hppa: convert to cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..1ab4e62850 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -60,7 +60,7 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 
 static bool hppa_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
-- 
2.17.1
