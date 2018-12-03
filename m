Received: from eggs.gnu.org ([2001:4830:134:3::10]:42284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzS-0005zO-B8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTuzQ-0005e2-Pj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:50 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:36564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTuzQ-0005cS-KL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:38:48 -0500
Received: by mail-ot1-x331.google.com with SMTP id k98so12988541otk.3
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 12:38:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 14:38:32 -0600
Message-Id: <20181203203839.757-4-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-1-richard.henderson@linaro.org>
References: <20181203203839.757-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/10] target/arm: Add SCR_EL3 bits up to
 ARMv8.5
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

Post v8.4 bits taken from SysReg_v85_xml-00bet8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 79d58978f7..20d97b66de 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1302,6 +1302,16 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_ST                (1U << 11)
 #define SCR_TWI               (1U << 12)
 #define SCR_TWE               (1U << 13)
+#define SCR_TLOR              (1U << 14)
+#define SCR_TERR              (1U << 15)
+#define SCR_APK               (1U << 16)
+#define SCR_API               (1U << 17)
+#define SCR_EEL2              (1U << 18)
+#define SCR_EASE              (1U << 19)
+#define SCR_NMEA              (1U << 20)
+#define SCR_FIEN              (1U << 21)
+#define SCR_ENSCXT            (1U << 25)
+#define SCR_ATA               (1U << 26)
 #define SCR_AARCH32_MASK      (0x3fff & ~(SCR_RW | SCR_ST))
 #define SCR_AARCH64_MASK      (0x3fff & ~SCR_NET)
 
-- 
2.17.2
