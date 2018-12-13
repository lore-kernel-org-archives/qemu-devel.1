Received: from eggs.gnu.org ([2001:4830:134:3::10]:36279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOu-0004py-LG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOs-0008D7-KF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSOr-000747-Sr
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:55:42 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSOD-0007M0-B1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:55:01 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:37 +0000
Message-Id: <20181213145445.17935-30-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/37] target/arm: Add HCR_EL2 bits up to ARMv8.5
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

Post v8.3 bits taken from SysReg_v85_xml-00bet8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181203203839.757-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 656a96a8f8f..79d58978f7c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1249,7 +1249,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_TIDCP     (1ULL << 20)
 #define HCR_TACR      (1ULL << 21)
 #define HCR_TSW       (1ULL << 22)
-#define HCR_TPC       (1ULL << 23)
+#define HCR_TPCP      (1ULL << 23)
 #define HCR_TPU       (1ULL << 24)
 #define HCR_TTLB      (1ULL << 25)
 #define HCR_TVM       (1ULL << 26)
@@ -1261,6 +1261,26 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_CD        (1ULL << 32)
 #define HCR_ID        (1ULL << 33)
 #define HCR_E2H       (1ULL << 34)
+#define HCR_TLOR      (1ULL << 35)
+#define HCR_TERR      (1ULL << 36)
+#define HCR_TEA       (1ULL << 37)
+#define HCR_MIOCNCE   (1ULL << 38)
+#define HCR_APK       (1ULL << 40)
+#define HCR_API       (1ULL << 41)
+#define HCR_NV        (1ULL << 42)
+#define HCR_NV1       (1ULL << 43)
+#define HCR_AT        (1ULL << 44)
+#define HCR_NV2       (1ULL << 45)
+#define HCR_FWB       (1ULL << 46)
+#define HCR_FIEN      (1ULL << 47)
+#define HCR_TID4      (1ULL << 49)
+#define HCR_TICAB     (1ULL << 50)
+#define HCR_TOCU      (1ULL << 52)
+#define HCR_TTLBIS    (1ULL << 54)
+#define HCR_TTLBOS    (1ULL << 55)
+#define HCR_ATA       (1ULL << 56)
+#define HCR_DCT       (1ULL << 57)
+
 /*
  * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
  * HCR_MASK and then clear it again if the feature bit is not set in
-- 
2.19.2
