Received: from eggs.gnu.org ([2001:4830:134:3::10]:36041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOW-0004TQ-3s
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOS-0007bB-1i
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOR-0006zA-NA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOE-0007ME-2V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:55:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:38 +0000
Message-Id: <20181213145445.17935-31-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/37] target/arm: Add SCR_EL3 bits up to ARMv8.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Post v8.4 bits taken from SysReg_v85_xml-00bet8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181203203839.757-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 79d58978f7c..20d97b66def 100644
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
2.19.2
