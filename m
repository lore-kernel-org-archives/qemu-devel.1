Received: from eggs.gnu.org ([2001:4830:134:3::10]:54006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG58-0004Mb-MO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHG55-0007gv-Qw
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:50 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHG55-0007gQ-L7
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 16:27:47 -0500
Received: by mail-wm0-x244.google.com with SMTP id x63so6255336wmf.4
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 13:27:47 -0800 (PST)
Received: from cloudburst.twiddle.net
	(70.red-37-158-60.dynamicip.rima-tde.net. [37.158.60.70])
	by smtp.gmail.com with ESMTPSA id
	e124sm706517wmg.34.2017.11.21.13.27.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 Nov 2017 13:27:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 21 Nov 2017 22:25:16 +0100
Message-Id: <20171121212534.5177-9-richard.henderson@linaro.org>
In-Reply-To: <20171121212534.5177-1-richard.henderson@linaro.org>
References: <20171121212534.5177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 08/26] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 89d49cdcb2..8238edaba9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -492,7 +492,7 @@ typedef struct CPUARMState {
          * the two execution states, and means we do not need to explicitly
          * map these registers when changing states.
          */
-        float64 regs[64];
+        float64 regs[64] QEMU_ALIGNED(16);
 
         uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
-- 
2.13.6
