Received: from eggs.gnu.org ([2001:4830:134:3::10]:58225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4U-000559-38
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyj-00086Y-1Z
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cyi-00085a-J5
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id c10-v6so8386823pgq.4
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:21:57 -0700
Message-Id: <20181008212205.17752-3-richard.henderson@linaro.org>
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 02/10] target/arm: Define fields of ISAR
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
Cc: peter.maydell@linaro.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 54362ddce8..f00c0444c4 100644
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
2.17.1
