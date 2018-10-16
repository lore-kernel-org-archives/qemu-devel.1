Received: from eggs.gnu.org ([2001:4830:134:3::10]:42952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC8-0000fK-N3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC7-0007un-NF
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC7-0007ll-EH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC0-0003mi-9E
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:09 +0100
Message-Id: <20181016152325.31367-4-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/19] target/arm: Define fields of ISAR
 registers
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181008212205.17752-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 54362ddce81..f00c0444c48 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1443,6 +1443,94 @@ FIELD(V7M_CSSELR, LEVEL, 1, 3)
  */
 FIELD(V7M_CSSELR, INDEX, 0, 4)
 
+/*
+ * System register ID fields.
+ */
+FIELD(ID_ISAR0, SWAP, 0, 4)
+FIELD(ID_ISAR0, BITCOUNT, 4, 4)
+FIELD(ID_ISAR0, BITFIELD, 8, 4)
+FIELD(ID_ISAR0, CMPBRANCH, 12, 4)
+FIELD(ID_ISAR0, COPROC, 16, 4)
+FIELD(ID_ISAR0, DEBUG, 20, 4)
+FIELD(ID_ISAR0, DIVIDE, 24, 4)
+
+FIELD(ID_ISAR1, ENDIAN, 0, 4)
+FIELD(ID_ISAR1, EXCEPT, 4, 4)
+FIELD(ID_ISAR1, EXCEPT_AR, 8, 4)
+FIELD(ID_ISAR1, EXTEND, 12, 4)
+FIELD(ID_ISAR1, IFTHEN, 16, 4)
+FIELD(ID_ISAR1, IMMEDIATE, 20, 4)
+FIELD(ID_ISAR1, INTERWORK, 24, 4)
+FIELD(ID_ISAR1, JAZELLE, 28, 4)
+
+FIELD(ID_ISAR2, LOADSTORE, 0, 4)
+FIELD(ID_ISAR2, MEMHINT, 4, 4)
+FIELD(ID_ISAR2, MULTIACCESSINT, 8, 4)
+FIELD(ID_ISAR2, MULT, 12, 4)
+FIELD(ID_ISAR2, MULTS, 16, 4)
+FIELD(ID_ISAR2, MULTU, 20, 4)
+FIELD(ID_ISAR2, PSR_AR, 24, 4)
+FIELD(ID_ISAR2, REVERSAL, 28, 4)
+
+FIELD(ID_ISAR3, SATURATE, 0, 4)
+FIELD(ID_ISAR3, SIMD, 4, 4)
+FIELD(ID_ISAR3, SVC, 8, 4)
+FIELD(ID_ISAR3, SYNCHPRIM, 12, 4)
+FIELD(ID_ISAR3, TABBRANCH, 16, 4)
+FIELD(ID_ISAR3, T32COPY, 20, 4)
+FIELD(ID_ISAR3, TRUENOP, 24, 4)
+FIELD(ID_ISAR3, T32EE, 28, 4)
+
+FIELD(ID_ISAR4, UNPRIV, 0, 4)
+FIELD(ID_ISAR4, WITHSHIFTS, 4, 4)
+FIELD(ID_ISAR4, WRITEBACK, 8, 4)
+FIELD(ID_ISAR4, SMC, 12, 4)
+FIELD(ID_ISAR4, BARRIER, 16, 4)
+FIELD(ID_ISAR4, SYNCHPRIM_FRAC, 20, 4)
+FIELD(ID_ISAR4, PSR_M, 24, 4)
+FIELD(ID_ISAR4, SWP_FRAC, 28, 4)
+
+FIELD(ID_ISAR5, SEVL, 0, 4)
+FIELD(ID_ISAR5, AES, 4, 4)
+FIELD(ID_ISAR5, SHA1, 8, 4)
+FIELD(ID_ISAR5, SHA2, 12, 4)
+FIELD(ID_ISAR5, CRC32, 16, 4)
+FIELD(ID_ISAR5, RDM, 24, 4)
+FIELD(ID_ISAR5, VCMA, 28, 4)
+
+FIELD(ID_ISAR6, JSCVT, 0, 4)
+FIELD(ID_ISAR6, DP, 4, 4)
+FIELD(ID_ISAR6, FHM, 8, 4)
+FIELD(ID_ISAR6, SB, 12, 4)
+FIELD(ID_ISAR6, SPECRES, 16, 4)
+
+FIELD(ID_AA64ISAR0, AES, 4, 4)
+FIELD(ID_AA64ISAR0, SHA1, 8, 4)
+FIELD(ID_AA64ISAR0, SHA2, 12, 4)
+FIELD(ID_AA64ISAR0, CRC32, 16, 4)
+FIELD(ID_AA64ISAR0, ATOMIC, 20, 4)
+FIELD(ID_AA64ISAR0, RDM, 28, 4)
+FIELD(ID_AA64ISAR0, SHA3, 32, 4)
+FIELD(ID_AA64ISAR0, SM3, 36, 4)
+FIELD(ID_AA64ISAR0, SM4, 40, 4)
+FIELD(ID_AA64ISAR0, DP, 44, 4)
+FIELD(ID_AA64ISAR0, FHM, 48, 4)
+FIELD(ID_AA64ISAR0, TS, 52, 4)
+FIELD(ID_AA64ISAR0, TLB, 56, 4)
+FIELD(ID_AA64ISAR0, RNDR, 60, 4)
+
+FIELD(ID_AA64ISAR1, DPB, 0, 4)
+FIELD(ID_AA64ISAR1, APA, 4, 4)
+FIELD(ID_AA64ISAR1, API, 8, 4)
+FIELD(ID_AA64ISAR1, JSCVT, 12, 4)
+FIELD(ID_AA64ISAR1, FCMA, 16, 4)
+FIELD(ID_AA64ISAR1, LRCPC, 20, 4)
+FIELD(ID_AA64ISAR1, GPA, 24, 4)
+FIELD(ID_AA64ISAR1, GPI, 28, 4)
+FIELD(ID_AA64ISAR1, FRINTTS, 32, 4)
+FIELD(ID_AA64ISAR1, SB, 36, 4)
+FIELD(ID_AA64ISAR1, SPECRES, 40, 4)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
-- 
2.19.0
