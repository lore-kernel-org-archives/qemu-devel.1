Received: from eggs.gnu.org ([2001:4830:134:3::10]:59410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9Xwe-0000in-JI
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e9Xwb-00077F-45
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:12 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:51001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e9Xwa-00075q-OL
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:55:09 -0400
Received: by mail-wm0-x22e.google.com with SMTP id s66so23012656wmf.5
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:55:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 31 Oct 2017 14:54:44 +0000
Message-Id: <20171031145444.13766-8-alex.bennee@linaro.org>
In-Reply-To: <20171031145444.13766-1-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 7/7] aarch64.risu: clean-up and annotate
 with groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Clean-up the risu definitions by:
  - removing out-dated section numbers
  - fixing section titles to match ASL encoding groups
  - add @Section markers

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 aarch64.risu | 200 +++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 141 insertions(+), 59 deletions(-)

diff --git a/aarch64.risu b/aarch64.risu
index 9667ef7..838bded 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -40,6 +40,8 @@
 #  0  Q  0  0  1  1  0  0  0  0  0  0  0  0  0  0  x  x  1  x size   Rn   Rt
 #                            [L]                  [  opcode  ]
 
+@Store
+
 ST1m_1 A64_V 0 Q:1 001100000 00000 0111 size:2 rn:5 rt:5 \
 !constraints { $rn != 31; } \
 !memory { align(1 << $size); reg($rn); }
@@ -348,11 +350,12 @@ ST4_Dp A64_V 0 Q:1 001101101 rm:5 101 0 01 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rm; } \
 !memory { align(8); reg($rn); }
 
-
+@
 # C6.3.152 LD1 (multiple structures) - no offset
 # 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9  5 4  0
 #  0  Q  0  0  1  1  0  0  0  1  0  0  0  0  0  0  x  x  1  x  size  Rn   Rt
 #                            [L]                  [  opcode  ]
+@Load
 
 LD1m_1 A64_V 0 Q:1 001100010 00000 0111 size:2 rn:5 rt:5 \
 !constraints { $rn != 31; } \
@@ -727,6 +730,8 @@ LD4R_p A64_V 0 Q:1 001101111 rm:5 111 0 size:2 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rm; } \
 !memory { align(1 << $size); reg($rn); }
 
+@
+
 # C3.3.5 Load register (PC-relative literal)
 # 31 30 29 28 27 26 25 24 23       5 4    0
 #  opc   0  1  1  V  0  0    imm19     Rt
@@ -788,6 +793,8 @@ LD4R_p A64_V 0 Q:1 001101111 rm:5 111 0 size:2 rn:5 rt:5 \
 # find out how to relax some of these constraints to really check
 # the whole range of possibilities.
 
+@Store
+
 STXRB A64 00 001000 000 rs:5 0 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rs != $rt && $rs != $rn && $rn != $rt; } \
 !memory { align(1); reg($rn); }
@@ -812,6 +819,8 @@ STLRH A64 01 001000 100 11111 1 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(2); reg($rn); }
 
+@Load
+
 LDXRB A64 00 001000 010 11111 0 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(1); reg($rn); }
@@ -836,6 +845,8 @@ LDARH A64 01 001000 110 11111 1 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(2); reg($rn); }
 
+@Store
+
 STXRW A64 10 001000 000 rs:5 0 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rs != $rt && $rs != $rn && $rn != $rt; } \
 !memory { align(4); reg($rn); }
@@ -848,6 +859,8 @@ STLRW A64 10 001000 100 11111 1 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(4); reg($rn); }
 
+@Load
+
 LDXRW A64 10 001000 010 11111 0 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(4); reg($rn); }
@@ -860,6 +873,8 @@ LDARW A64 10 001000 110 11111 1 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(4); reg($rn); }
 
+@Store
+
 STXR A64 11 001000 000 rs:5 0 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rs != $rt && $rs != $rn && $rn != $rt; } \
 !memory { align(8); reg($rn); }
@@ -872,6 +887,8 @@ STLR A64 11 001000 100 11111 1 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(8); reg($rn); }
 
+@Load
+
 LDXR A64 11 001000 010 11111 0 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(8); reg($rn); }
@@ -884,6 +901,8 @@ LDAR A64 11 001000 110 11111 1 11111 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt; } \
 !memory { align(8); reg($rn); }
 
+@
+
 #  Now with P (pair load/stores):
 #  10   0  0 1  0  STXP        32-bit
 #  10   0  0 1  1  STLXP       32-bit
@@ -897,6 +916,8 @@ LDAR A64 11 001000 110 11111 1 11111 rn:5 rt:5 \
 #  11   0  1 1  0  LDXP        64-bit
 #  11   0  1 1  1  LDAXP       64-bit
 
+@Store
+
 STXPW A64 10 001000 001 rs:5 0 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rs != $rt && $rs != $rtt && $rs != $rn && $rn != $rt && $rn != $rtt; } \
 !memory { align(8); reg($rn); }
@@ -905,6 +926,8 @@ STLXPW A64 10 001000 001 rs:5 1 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rs != $rt && $rs != $rtt && $rs != $rn && $rn != $rt && $rn != $rtt; } \
 !memory { align(8); reg($rn); }
 
+@Load
+
 LDXPW A64 10 001000 011 11111 0 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rt != $rtt && $rn != $rt && $rn != $rtt; } \
 !memory { align(8); reg($rn); }
@@ -913,6 +936,8 @@ LDAXPW A64 10 001000 011 11111 1 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rt != $rtt && $rn != $rt && $rn != $rtt; } \
 !memory { align(8); reg($rn); }
 
+@Store
+
 STXP A64 11 001000 001 rs:5 0 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rs != $rt && $rs != $rtt && $rs != $rn && $rn != $rt && $rn != $rtt; } \
 !memory { align(16); reg($rn); }
@@ -921,6 +946,8 @@ STLXP A64 11 001000 001 rs:5 1 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rs != $rt && $rs != $rtt && $rs != $rn && $rn != $rt && $rn != $rtt; } \
 !memory { align(16); reg($rn); }
 
+@Load
+
 LDXP A64 11 001000 011 11111 0 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rt != $rtt && $rn != $rt && $rn != $rtt; } \
 !memory { align(16); reg($rn); }
@@ -929,6 +956,8 @@ LDAXP A64 11 001000 011 11111 1 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rt != $rtt && $rn != $rt && $rn != $rtt; } \
 !memory { align(16); reg($rn); }
 
+@
+
 # C3.3.7 Load/store no-allocate pair (offset)
 # 31 30 29 28 27 26 25 24 23 22 21      15 14     10 9    5 4    0
 #  opc   1  0  1  V  0  0  0  L    simm7      Rt2      Rn     Rt
@@ -939,22 +968,28 @@ LDAXP A64 11 001000 011 11111 1 rtt:5 rn:5 rt:5 \
 #   10            0           0    STNP 64-bit
 #   10            0           1    LDNP 64-bit
 
+@Store
+
 STNPW A64 00 101 0 000 0 imm:7 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt && $rn != $rtt; } \
 !memory { align(8); reg_plus_imm($rn, sextract($imm, 7) * 4); }
 
-LDNPW A64 00 101 0 000 1 imm:7 rtt:5 rn:5 rt:5 \
-!constraints { $rn != 31 && $rt != $rtt && $rn != $rt && $rn != $rtt; } \
-!memory { align(8); reg_plus_imm($rn, sextract($imm, 7) * 4); }
-
 STNP A64 10 101 0 000 0 imm:7 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rn != $rt && $rn != $rtt; } \
 !memory { align(16); reg_plus_imm($rn, sextract($imm, 7) * 8); }
 
+@Load
+
+LDNPW A64 00 101 0 000 1 imm:7 rtt:5 rn:5 rt:5 \
+!constraints { $rn != 31 && $rt != $rtt && $rn != $rt && $rn != $rtt; } \
+!memory { align(8); reg_plus_imm($rn, sextract($imm, 7) * 4); }
+
 LDNP A64 10 101 0 000 1 imm:7 rtt:5 rn:5 rt:5 \
 !constraints { $rn != 31 && $rt != $rtt && $rn != $rt && $rn != $rtt; } \
 !memory { align(16); reg_plus_imm($rn, sextract($imm, 7) * 8); }
 
+@
+
 # SIMD variants
 #  opc            V           L
 #   00            1           0    SIMD STNP  32-bit
@@ -1516,8 +1551,21 @@ LDPQ A64_V 10 10110 idx:2 1 imm:7 rtt:5 rn:5 rt:5 \
 !memory { align(32); reg_plus_imm($rn, $idx == 1 ? 0 : sextract($imm, 7) * 16); }
 
 
-# - - - 1 0 0 - - - - - - - - - - - - - - - - Data processing - immediate
-# C3.4.1 Add/subtract (immediate)
+# Data processing - immediate
+#
+# 31  29| 28 27 26 | 25 24 23 | 22                              0
+# - - - |  1  0  0 |    op0   |
+# Where op0:
+#  00x - PC-rel. addressing
+#  01x - Add/subtract (immediate)
+#  100 - Logical (immediate)
+#  101 - Move wide (immediate)
+#  110 - Bitfield
+#  111 - Extract
+
+@DataProcessingImmediate
+
+# - Arithmetic (immediate)
 # 31 30 29 | 28 27 26 25 24 |23 22| 21       10 | 9    5 | 4    0
 # sf op  S |  1  0  0  0  1 | shft|    imm12    |   Rn   |   Rd
 
@@ -1533,7 +1581,7 @@ SUBi A64 sf:1 10 10001 0 shft:1 imm:12 rn:5 rd:5 \
 SUBSi A64 sf:1 11 10001 0 shft:1 imm:12 rn:5 rd:5 \
 !constraints { $rn != 31 && $rd != 31; }
 
-# C3.4.2 Bitfield
+# - Bitfield move
 # 31 | 30 29 | 28 27 26 25 24 23| 22 | 21      16 15      10 9    5 4    0
 # sf |  opc  |  1  0  0  1  1  0|  N |    immr       imms      Rn     Rd
 #
@@ -1577,7 +1625,7 @@ UBFM_RES2 A64 0 10 100110 sn:1 1 immr:5 imms:6 rn:5 rd:5
 # ReservedValue: break the ($imms <= 0x1f) constraint
 UBFM_RES3 A64 0 10 100110 sn:1 immr:6 1 imms:5 rn:5 rd:5
 
-# C3.4.3 Extract
+#  - Bitfield insert and extract
 # 31 |30 29| 28 27 26 25 24 23| 22 | 21 | 20    16 15      10 9    5 4    0
 # sf |op21 |  1  0  0  1  1  1|  N | o0 |    Rm       imms      Rn     Rd
 
@@ -1585,7 +1633,7 @@ EXTRW A64 0 00 100111 0 0 rm:5 0 imms:5 rn:5 rd:5
 
 EXTR A64 1 00 100111 1 0 rm:5 imms:6 rn:5 rd:5
 
-# C3.4.4 Logical (immediate)
+# - Logical (immediate)
 # 31 |30 29| 28 27 26 25 24 23| 22 | 21      16 15      10 9    5 4    0
 # sf |opc  |  1  0  0  1  0  0|  N |    immr       imms      Rn     Rd
 
@@ -1661,7 +1709,7 @@ ANDSi_RES6 A64 0 11 100100 0 immr:6 101111 rn:5 rd:5
 ANDSi_RES7 A64 0 11 100100 0 immr:6 011111 rn:5 rd:5
 ANDSi_RES8 A64 sf:1 11 100100 sn:1 immr:6 111111 rn:5 rd:5
 
-# C3.4.5 Move wide (immediate)
+# - Move wide (immediate)
 # 31 |30 29| 28 27 26 25 24 23 | 22 21 | 20       5 4    0
 # sf |opc  |  1  0  0  1  0  1 |  hw   |    imm16     Rd
 # hw is shift/16 (bigger values invalid for 32 bit)
@@ -1672,11 +1720,18 @@ MOVZ A64 sf:1 10 100101 hw:2 imm:16 rd:5
 
 MOVK A64 sf:1 11 100101 hw:2 imm:16 rd:5
 
-# C3.4.6 PC-rel. addressing NIY
+# PC-rel. addressing NIY
+
+@
+# End of Data Processing Immediate
 
-# - - - - 1 0 1 - - - - - - - - - - - - - - - Data processing - register
+# Data processing - Register
+#
+# 31  30 29  28 | 27 26 25 | 24   21 | 20      12 | 11  | 10          0
+#  - op0  - op1 |  1  0  1 |   op2   |            | op3 |
+@DataProcessingRegister
 
-# C3.5.1 Add/subtract (extended register)
+# - Add/subtract (extended register)
 # 31 30 29 28 27 26 25 24 |23 22| 21 | 20    16 15    13 12  10 9    5 4    0
 # sf op  S  0  1  0  1  1 | opt |  1 |    Rm     option   imm3    Rn     Rd
 #
@@ -1707,7 +1762,7 @@ SUBSx A64 sf:1 11 01011 00 1 rm:5 option:3 imm:3 rn:5 rd:5 \
 SUBSx_RES A64 sf:1 11 01011 00 1 rm:5 option:3 imm:3 rn:5 rd:5 \
 !constraints { $imm > 4; }
 
-# C3.5.2 Add/subtract (shifted register)
+# - Add/subtract (shifted register)
 # 31 30 29 28 27 26 25 24 |23 22| 21 | 20    16 15      10 9    5 4    0
 # sf op  S  0  1  0  1  1 |shift|  0 |    Rm       imm6      Rn     Rd
 
@@ -1739,7 +1794,7 @@ SUBS_RES1 A64 sf:1 11 01011 11 0 rm:5 imm:6 rn:5 rd:5
 # ReservedValue: break the ($imm <= 0x1f) constraint
 SUBS_RES2 A64 0 11 01011 shft:2 0 rm:5 1 imm:5 rn:5 rd:5
 
-# C3.5.3 Add/subtract (with carry)
+# - Add/subtract (with carry)
 # 31 30 29 28 27 26 25 24 23 22 21 |20    16 15         10 9    5 4    0
 # sf op  S  1  1  0  1  0  0  0  0 |   Rm       opcode2      Rn     Rd
 
@@ -1749,7 +1804,7 @@ ADCS A64 sf:1 01 11010000 rm:5 000000 rn:5 rd:5
 SBC A64 sf:1 10 11010000 rm:5 000000 rn:5 rd:5
 SBCS A64 sf:1 11 11010000 rm:5 000000 rn:5 rd:5
 
-# C3.5.4 Conditional compare (immediate)
+# - Conditional compare (immediate)
 
 # 31 30 29 28 27 26 25 24 23 22 21 20      16 15      12 11 10 9    5 4 3      0
 # sf op  1  1  1  0  1  0  0  1  0    imm5       cond     1  0   Rn   0   nzcv
@@ -1762,7 +1817,7 @@ SBCS A64 sf:1 11 11010000 rm:5 000000 rn:5 rd:5
 CCMNi A64 sf:1 0 111010010 imm:5 cond:4 10 rn:5 0 nzcv:4
 CCMPi A64 sf:1 1 111010010 imm:5 cond:4 10 rn:5 0 nzcv:4
 
-# C3.5.5 Conditional compare (register)
+# - Conditional compare (register)
 # 31 30 29 28 27 26 25 24 23 22 21 20       16 15      12 11 10 9    5 4 3        0
 # sf op  1  1  1  0  1  0  0  1  0      Rm        cond     0  0   Rn   0    nzcv
 #  0  0     CCMN (register) 32-bit
@@ -1773,7 +1828,7 @@ CCMPi A64 sf:1 1 111010010 imm:5 cond:4 10 rn:5 0 nzcv:4
 CCMN A64 sf:1 0 111010010 rm:5 cond:4 00 rn:5 0 nzcv:4
 CCMP A64 sf:1 1 111010010 rm:5 cond:4 00 rn:5 0 nzcv:4
 
-# C3.5.6 Conditional select
+# - Conditional select
 # 31 30 29 28 27 26 25 24 23 22 21 |20    16 15      12 11 10 9    5 4    0
 # sf op  S  1  1  0  1  0  1  0  0 |   Rm       cond     op2    Rn     Rd
 
@@ -1782,7 +1837,7 @@ CSINC A64 sf:1 00 11010100 rm:5 cond:4 01 rn:5 rd:5
 CSINV A64 sf:1 10 11010100 rm:5 cond:4 00 rn:5 rd:5
 CSNEG A64 sf:1 10 11010100 rm:5 cond:4 01 rn:5 rd:5
 
-# C3.5.7 Data-processing (1 source)
+# - Data-processing (1 source)
 # 31 30 29 28 27 26 25 24 23 22 21 |20         16 15        10 9    5 4    0
 # sf  1  S  1  1  0  1  0  1  1  0 |   opcode2       opcode      Rn     Rd
 
@@ -1793,7 +1848,7 @@ CLZ A64 sf:1 10 11010110 00000 000100 rn:5 rd:5
 CLS A64 sf:1 10 11010110 00000 000101 rn:5 rd:5
 REV A64 1 10 11010110 00000 000011 rn:5 rd:5
 
-# C3.5.8 Data-processing (2 source)
+# - Data-processing (2 source)
 # 31 30 29 28 27 26 25 24 23 22 21 |20    16 15        10 9    5 4    0
 # sf  0  S  1  1  0  1  0  1  1  0 |   Rm       opcode      Rn     Rd
 
@@ -1808,7 +1863,7 @@ RORV A64 sf:1 00 11010110 rm:5 001011 rn:5 rd:5
 CRC32 A64 sf 00 11010110 rm:5 010 0 sz:2 rn:5 rd:5
 CRC32C A64 sf 00 11010110 rm:5 010 1 sz:2 rn:5 rd:5
 
-# C3.5.9 Data-processing (3 source)
+# - Data-processing (3 source)
 # 31 |30 29| 28 27 26 25 24 |23    21|20    16 15 14    10 9    5 4    0
 # sf | op54|  1  1  0  1  1 |  op31  |   Rm    o0    Ra      Rn     Rd
 
@@ -1846,7 +1901,7 @@ UMNEGL A64 1 00 11011 101 rm:5 1 11111 rn:5 rd:5
 
 UMULH A64 1 00 11011 110 rm:5 0 ra:5 rn:5 rd:5
 
-# C3.5.10 Logical (shifted register)
+# - Logical (shifted register)
 # 31|30 29| 28 27 26 25 24 |23 22| 21| 20    16 15      10 9    5 4    0
 # sf| opc |  0  1  0  1  0 |shift|  N|    Rm       imm6      Rn     Rd
 
@@ -1895,9 +1950,17 @@ BICS A64 sf:1 11 01010 shft:2 1 rm:5 imm:6 rn:5 rd:5 \
 # ReservedValue: break the ($imm <= 0x1f) constraint
 BICS_RES A64 0 11 01010 shft:2 1 rm:5 1 imm:5 rn:5 rd:5
 
-# C3.6 Data processing - SIMD and floating point
+@
+# End of Data Processing - Register
+
+# Data processing - SIMD and floating point
+# Data processing - Scalar Floating-Point and Advanced SIMD
+#
+# 31   28 | 27 26 25 | 24 23 | 22   19 | 18   10 | 9         0
+#   op0   |  1  1  1 |  op1  |   op2   |   op3   |
+@DataProcessingScalarFP,DataProcessingAdvSIMD
 
-# C3.6.1 AdvSIMD EXT
+# - Advanced SIMD Extract
 # 31 30 29 28 27 26 25 24 23 22 21 20  16|15|14    11|10|9  5 4  0
 #  0  Q  1  0  1  1  1  0  0  0  0   Rm  | 0|  imm4  | 0| Rn   Rd
 
@@ -1912,14 +1975,14 @@ EXT A64_V      0 Q:1 101110000 rm:5 0  imm:4 0 rn:5 rd:5 \
 !constraints { $Q == 0 || !($imm & 0x08); }
 EXT_RES A64_V  0 0   101110000 rm:5 01 imm:3 0 rn:5 rd:5
 
-# C3.6.2 AdvSIMD TBL/TBX
+# - Advanced SIMD table lookup
 # 31 30 29 28 27 26 25 24 23 22 21 20  16 15 14 13 12 11 10 9  5 4  0
 #  0  Q  0  0  1  1  1  0  0  0  0   Rm    0  len  op  0  0  Rn   Rd
 
 TBL A64_V 0 Q:1 001110000 rm:5 0 len:2 0 00 rn:5 rd:5
 TBX A64_V 0 Q:1 001110000 rm:5 0 len:2 1 00 rn:5 rd:5
 
-# C3.6.3 AdvSIMD ZIP/UZP/TRN
+# - Advanced SIMD permute
 # 31 30 29 28 27 26 25 24 23 22 21 20  16 15 14   12 11 10 9  5 4  0
 #  0  Q  0  0  1  1  1  0  size  0   Rm    0 opcode   1  0  Rn   Rd
 
@@ -1953,7 +2016,7 @@ ZIP2 A64_V 0 Q:1 001110 size:2 0 rm:5 0 111 10 rn:5 rd:5 \
 # ReservedValue: break the !($size == 3 && $Q == 0) constraint
 ZIP2_RES A64_V 0 0 001110 11 0 rm:5 0 111 10 rn:5 rd:5
 
-# C4-286 AdvSIMD across vector lanes
+# - Advanced SIMD across lanes
 # 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16  12 11 10 9  5 4  0
 #  0  Q  U  0  1  1  1  0  size  1  1  0  0  0 opcode  1  0  Rn   Rd
 
@@ -1997,9 +2060,10 @@ UMINV        A64_V 0 Q:1 1 01110 s:2 11000 11010 10 rn:5 rd:5 \
 # ReservedValue: break the constraint (s==2) => (Q=1)
 UMINV_RES    A64_V 0   0 1 01110  10 11000 11010 10 rn:5 rd:5
 
-# C3.6.5 AdvSIMD copy
+# - Advanced SIMD copy
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15 14    11 10 9  5 4  0
 #  0  Q op  0  1  1  1  0  0  0  0   imm5    0   imm4    1  Rn   Rd
+@DataProcessingAdvSIMD,AdvSIMDCopy
 
 DUPe A64_V 0 Q:1 0 01110000 imm:5 0 0000 1 rn:5 rd:5 \
 !constraints { ($imm & 0x07) || (($imm & 0x0f) && $Q == 1); }
@@ -2040,50 +2104,52 @@ INSe A64_V 0 1 1 01110000 imm:5 0 immm:4 1 rn:5 rd:5 \
 # ReservedValue: break the constraint ($imm & 0x0f)
 INSe_RES A64_V 0 1 1 01110000 imm:1 0000 0 immm:4 1 rn:5 rd:5
 
-# C3.6.6 AdvSIMD modified immediate
+@DataProcessingScalarFP,DataProcessingAdvSIMD
+
+# - Advanced SIMD modified immediate
 # 31 30 29 28 27 26 25 24 23 22 21 20 19 18   16 15   12 11 10  9   5 4  0
 #  0  Q op  0  1  1  1  1  0  0  0  0  0 [ abc ] [cmode] o2  1 [defgh] Rd
 #                                                       [ 0]
-# C6.3.179 MOVI move immediate (vector)
+# MOVI move immediate (vector)
 MOVI A64_V 0 Q:1 op:1 0111100000 abc:3 cm:4 01 defgh:5 rd:5 \
 !constraints { \
 ($op == 0 && $cm != 1 && $cm != 3 && $cm != 5 && $cm != 7 && $cm != 9 && $cm != 11 && $cm != 15) \
 || ($op == 1 && $cm == 14); \
 }
 
-# C6.3.183 MVNI move inverted immediate (vector)
+# MVNI move inverted immediate (vector)
 MVNI A64_V 0 Q:1 1 0111100000 abc:3 cm:4 01 defgh:5 rd:5 \
 !constraints { \
 ($cm == 2 || $cm == 4 || $cm == 6 || $cm == 8 || $cm == 10 || $cm == 12 || $cm == 13); \
 }
 
-#C6.3.187 ORR (vector, immediate)
+# ORR (vector, immediate)
 ORRiv A64_V 0 Q:1 0 0111100000 abc:3 cmode:3 1 01 defgh:5 rd:5 \
 !constraints { $cmode <= 5; }
 
-# C6.3.112 FMOV (vector, immediate)
+# FMOV (vector, immediate)
 FMOViv A64_V 0 Q:1 op:1 0111100000 abc:3 1111 01 defgh:5 rd:5 \
 !constraints { $op == 0 || $Q == 1; }
 
 # UnallocatedEncoding() op==1 with Q==0
 FMOViv_RES A64_V 0 0 1 0111100000 abc:3 1111 01 defgh:5 rd:5
 
-# C6.3.12
+# BIC (vector, immediate)
 # 31  30   29                    19  18 16   15   12 11 10 9     5   4  0
 #  0 [ Q ]  1 0 1 1 1 1 1 0 0 0 0 0 [ abc ] [ cmode ] 0 1 [ defgh ] [ Rd ]
 BICiv A64_V 0 Q:1 1 0111100000 abc:3 cm:4 01 defgh:5 rd:5 \
 !constraints { $cm <= 11 && ($cm & 0x1) == 1; }
 
-# C3.6.7 AdvSIMD scalar copy
+# Advanced SIMD scalar copy
 # Includes just one instruction (DUP element); this pattern includes
 # all the reserved stuff for bad imm4 and op values
 DUPes A64_V 0 1 op 1111 0000 imm5:5 0 imm4:4 1 rn:5 rd:5
 
-# C3.6.8 AdvSIMD scalar pairwise
+# Advanced SIMD scalar pairwise
 # Includes all ops and reserved patterns
 SCALARPAIR A64_V 0 1 U 11110 size:2 11000 opcode:5 10 rn:5 rd:5
 
-# C3.6.9 scalar shift immediate
+# Advanced SIMD scalar shift by immediate
 #
 # 31 30 29 28 27 26 25 24 23 22    19 18    16 15      11 10 9      5 4      0
 #  0  1 U   1  1  1  1  1  0 [ immh ] [ immb ] [ opcode ]  1 [  Rn  ] [  Rd  ]
@@ -2117,16 +2183,18 @@ SQSHLU_SSI A64_V 0 1 1 111110 immh:4 immb:3 01100 1 rn:5 rd:5 !constraints { $im
 SQSHRUN_SSI A64_V 0 1 1 111110 immh:4 immb:3 10000 1 rn:5 rd:5 !constraints { $immh != 0; }
 SQRSHRUN_SSI A64_V 0 1 1 111110 immh:4 immb:3 10001 1 rn:5 rd:5 !constraints { $immh != 0; }
 
-# C3.6.10 AdvSIMD scalar three different
+# Advanced SIMD scalar three different
 # Complete coverage.
 SQDMLAL_S3D A64_V 0 1 U 11110 size:2 1 rm:5 1001 00 rn:5 rd:5
 SQDMLSL_S3D A64_V 0 1 U 11110 size:2 1 rm:5 1011 00 rn:5 rd:5
 SQDMULL_S3D A64_V 0 1 U 11110 size:2 1 rm:5 1101 00 rn:5 rd:5
 
-# C3.6.11 AdvSIMD scalar three same
+# Advanced SIMD scalar three same
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15      11 10  9    5   4    0
 #  0  1 U   1  1  1  1  0  size  1 [  Rm  ] [ opcode ]  1 [  Rn  ] [  Rd  ]
 #
+@DataProcessingAdvSIMD,AdvSIMDScalar3Same
+
 SQADD    A64_V   01 0 11110 size:2 1 rm:5 00001 1 rn:5 rd:5
 SQSUB    A64_V   01 0 11110 size:2 1 rm:5 00101 1 rn:5 rd:5
 CMGT     A64_V   01 0 11110 size:2 1 rm:5 00110 1 rn:5 rd:5
@@ -2164,11 +2232,14 @@ FCMGT    A64_V   01 1 11110 1 size:1 1 rm:5 11100 1 rn:5 rd:5
 FACGT    A64_V   01 1 11110 1 size:1 1 rm:5 11101 1 rn:5 rd:5 \
 !constraints { $size != 11; }
 
+@DataProcessingAdvSIMD
 
-# C3.6.12 AdvSIMD scalar two-reg misc
+# Advanced SIMD scalar two-register miscellaneous
 # 31 30 29 28 27 26 25 24 23 22 21 20      16     12 11 10 9     5  4    0
 #  0  1 U   1  1  1  1  0  size  1 0 0 0 0 [ opcode ] 1 0 [  Rn  ] [  Rd  ]
 # U size opcode
+@DataProcessingAdvSIMD,AdvSIMDScalar2RegMisc
+
 ABSs  A64_V             01 0 11110   size:2 10000 01011 10 rn:5 rd:5
 CMEQzs  A64_V           01 0 11110   size:2 10000 01001 10 rn:5 rd:5
 CMGTzs  A64_V           01 0 11110   size:2 10000 01000 10 rn:5 rd:5
@@ -2204,7 +2275,10 @@ SUQADDs  A64_V          01 0 11110   size:2 10000 00011 10 rn:5 rd:5
 UCVTFvis  A64_V         01 1 11110 0 size:1 10000 11101 10 rn:5 rd:5
 UQXTN_UQXTN2s  A64_V    01 1 11110   size:2 10000 10100 10 rn:5 rd:5
 USQADDs  A64_V          01 1 11110   size:2 10000 00011 10 rn:5 rd:5
-# C3.6.13 AdvSIMD scalar x indexed element
+
+@DataProcessingAdvSIMD
+
+# Advanced SIMD scalar x indexed element
 # Complete coverage.
 
 # Long ops
@@ -2219,7 +2293,7 @@ FMLA_SIDX A64_V 0 1 U 11111 sz:2 l m rm:4 0001 h 0 rn:5 rd:5
 FMLS_SIDX A64_V 0 1 U 11111 sz:2 l m rm:4 0101 h 0 rn:5 rd:5
 FMUL_FMULX_SIDX A64_V 0 1 U 11111 sz:2 l m rm:4 1001 h 0 rn:5 rd:5
 
-# C3.6.14 AdvSIMD shift by immediate
+# Advanced SIMD shift by immediate
 # 31 30 29 28 27 26 25 24 23 22    19 18    16 15      11 10 9      5 4      0
 #  0  Q U   0  1  1  1  1  0 [ immh ] [ immb ] [ opcode ]  1 [  Rn  ] [  Rd  ]
 
@@ -2286,7 +2360,7 @@ SQSHLU_SI A64_V 0 Q 1 011110 immh:4 immb:3 01100 1 rn:5 rd:5 !constraints { $imm
 FCVTZS_SI A64_V 0 Q 0 011110 immh:4 immb:3 11111 1 rn:5 rd:5 !constraints { $immh != 0; }
 FCVTZU_SI A64_V 0 Q 1 011110 immh:4 immb:3 11111 1 rn:5 rd:5 !constraints { $immh != 0; } 
 
-# C3.6.15 AdvSIMD three different
+# Advanced SIMD three different
 # the '2' variants are included in the main patterns here
 SADDL A64_V   0 Q 0 0 1 1 1 0 size:2 1 rm:5 0000 00 rn:5 rd:5
 SADDW A64_V   0 Q 0 0 1 1 1 0 size:2 1 rm:5 0001 00 rn:5 rd:5
@@ -2324,7 +2398,7 @@ SQDMULL_RES A64_V 0 Q 1 0 1 1 1 0 size:2 1 rm:5 1101 00 rn:5 rd:5
 # opcode 1111 unallocated
 SIMD_3D_RES A64_V 0 Q U 0 1 1 1 0 size:2 1 rm:5 1111 00 rn:5 rd:5
 
-# C3.6.16 AdvSIMD three same
+# Advanced SIMD three same
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15      11 10  9    5   4    0
 #  0  Q  U  0  1  1  1  0  size  1 [  Rm  ] [ opcode ]  1 [  Rn  ] [  Rd  ]
 SHADD   A64_V  0 Q:1 0 01110  size:2 1 rm:5 00000 1 rn:5 rd:5
@@ -2405,7 +2479,7 @@ FMINPv   A64_V  0 Q:1 1 01110  size:2 1 rm:5 11110 1 rn:5 rd:5 # size: 1x
 BIT     A64_V  0 Q:1 1 01110  size:2 1 rm:5 00011 1 rn:5 rd:5 # size: 10
 BIF     A64_V  0 Q:1 1 01110  size:2 1 rm:5 00011 1 rn:5 rd:5 # size: 11
 
-# C3.6.17 AdvSIMD two-reg misc
+# Advanced SIMD two-register miscellaneous
 # 31 30 29 28 27 26 25 24 23    22 21 20 19 18 17 16      12 11 10 9    5 4    0
 #  0  Q  U  0  1  1  1  0 [ size ]  1  0  0  0  0 [ opcode ] 1   0 [ Rn ] [ Rd ]
 #
@@ -2508,7 +2582,7 @@ FRSQRTE  A64_V  0 Q:1 1 01110 size:2 10000 11101 10 rn:5 rd:5 \
 FSQRTv   A64_V  0 Q:1 1 01110 size:2 10000 11111 10 rn:5 rd:5 \
 !constraints { $size > 1; }
 
-# C3.6.18 AdvSIMD vector x indexed element
+# Advanced SIMD vector x indexed element
 # Complete coverage. Note we tend to leave in U bit etc which
 # may actually be unallocated encodings.
 
@@ -2530,13 +2604,15 @@ FMLA_IDX A64_V 0 Q U 01111 sz:2 l m rm:4 0001 h 0 rn:5 rd:5
 FMLS_IDX A64_V 0 Q U 01111 sz:2 l m rm:4 0101 h 0 rn:5 rd:5
 FMUL_FMULX_IDX A64_V 0 Q U 01111 sz:2 l m rm:4 1001 h 0 rn:5 rd:5
 
-# C3.6.19 Cryptographic AES
+# Cryptographic AES
+@Cryptographic,CryptographicAES
 AESE   A64_V 0100 1110 sz:2 10100 00100 10 rn:5 rd:5
 AESD   A64_V 0100 1110 sz:2 10100 00101 10 rn:5 rd:5
 AESMC  A64_V 0100 1110 sz:2 10100 00110 10 rn:5 rd:5
 AESIMC A64_V 0100 1110 sz:2 10100 00111 10 rn:5 rd:5
 
-# C3.6.20 Cryptographic three-register SHA
+# Cryptographic three-register SHA
+@Cryptographic,CryptographicSHA
 SHA1C     A64_V 0101 1110 sz:2 0 rm:5 0 000 00 rn:5 rd:5
 SHA1P     A64_V 0101 1110 sz:2 0 rm:5 0 001 00 rn:5 rd:5
 SHA1M     A64_V 0101 1110 sz:2 0 rm:5 0 010 00 rn:5 rd:5
@@ -2545,14 +2621,15 @@ SHA256H   A64_V 0101 1110 sz:2 0 rm:5 0 100 00 rn:5 rd:5
 SHA256H2  A64_V 0101 1110 sz:2 0 rm:5 0 101 00 rn:5 rd:5
 SHA256SU1 A64_V 0101 1110 sz:2 0 rm:5 0 110 00 rn:5 rd:5
 
-# C3.6.21 Cryptographic two-register SHA
+# Cryptographic two-register SHA
 SHA1H     A64_V 0101 1110 sz:2 10100 00000 10 rn:5 rd:5
 SHA1SU1   A64_V 0101 1110 sz:2 10100 00001 10 rn:5 rd:5
 SHA256SU0 A64_V 0101 1110 sz:2 10100 00010 10 rn:5 rd:5
 
-# C3.6.22 Floating-point compare
+# Floating-point compare
 # 31 30 29 28 27 26 25 24 23 22 21 20  16 15 14 13 12 11 10 9    5 4       0
 #  M  0  S  1  1  1  1  0  type  1   Rm    op    1  0  0  0   Rn    opcode2
+@DataProcessingScalarFP
 
 FCMPS A64_V 000 11110 00 1 rm:5 00 1000 rn:5 00 000
 FCMPZS A64_V 000 11110 00 1 rm:5 00 1000 rn:5 01 000
@@ -2573,7 +2650,7 @@ FCMP_RES3 A64_V 000 11110 0 type:1 1 rm:5 op:2 1000 rn:5 opc:2 000 \
 FCMP_RES4 A64_V 000 11110 0 type:1 1 rm:5 00 1000 rn:5 opc:2 op2r:3 \
 !constraints { $op2r != 0; }
 
-# C3.6.23 Floating-point conditional compare
+# Floating-point conditional compare
 # 31 30 29 28 27 26 25 24 23 22 21 20  16 15   12 11 10 9  5  4  3    0
 #  M  0  S  1  1  1  1  0  type  1   Rm    cond    0  1  Rn  op   nzcv
 
@@ -2587,7 +2664,7 @@ FCCMP_RES1 A64_V mos:3 11110 0 type:1 1 rm:5 cond:4 01 rn:5 op:1 nzcv:4 \
 !constraints { $mos != 0 && !($mos & 2); }
 FCCMP_RES2 A64_V 000 11110 1 type:1 1 rm:5 cond:4 01 rn:5 op:1 nzcv:4
 
-# C3.6.24 Floating-point conditional select
+# Floating-point conditional select
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15    12 11 10 9    5 4    0
 #  M  0  S  1  1  1  1  0  type  1    Rm      cond    1  1   Rn     Rd
 
@@ -2598,7 +2675,7 @@ FCSEL_RES1 A64_V mos:3 11110 0 type:1 1 rm:5 cond:4 11 rn:5 rd:5 \
 !constraints { $mos != 0 && !($mos & 2); }
 FCSEL_RES2 A64_V 000 11110 1 type:1 1 rm:5 cond:4 11 rn:5 rd:5
 
-# C3.6.25 Floating-point data-processing (1 source)
+# Floating-point data-processing (1 source)
 # 31 30 29 28 27 26 25 24 |23 22| 21 20        15 14 13 12 11 10 9  5 4  0
 #  M  0  S  1  1  1  1  0 |type |  1    opcode     1  0  0  0  0  Rn   Rd
 
@@ -2645,7 +2722,7 @@ FRINT_RES1 A64_V 00011110 1 type:1 1 001 mode:3 10000 rn:5 rd:5
 # UnallocatedEncoding: rounding mode == 5
 FRINT_RES2 A64_V 00011110 type:2 1 001 101 10000 rn:5 rd:5
 
-# C3.6.26 Floating-point data-processing (2 source)
+# Floating-point data-processing (2 source)
 # 31 30 29 28 27 26 25 24 23 22 21 20    16 15      12 11 10 9  5 4  0
 #  M  0  S  1  1  1  1  0  type  1    Rm      opcode    1  0  Rn   Rd
 
@@ -2703,7 +2780,7 @@ FNMUL A64_V 00011110 type:2 1 rm:5 1000 10 rn:5 rd:5 \
 # UnallocatedEncoding: type >= 2
 FNMUL_RES A64_V 00011110 1 type:1 1 rm:5 1000 10 rn:5 rd:5
 
-# C3.6.27 Floating-point data-processing (3 source)
+# Floating-point data-processing (3 source)
 # 31 30 29 28 27 26 25 24 23 22 21 20  16 15 14  10 9  5 4  0
 #  M  0  S  1  1  1  1  1 type  o1   Rm   o0   Ra    Rn   Rd
 
@@ -2727,7 +2804,7 @@ FNMSUB A64_V 00011111 type:2 1 rm:5 1 ra:5 rn:5 rd:5 \
 # UnallocatedEncoding: type >= 2
 FNMSUB_RES A64_V 00011111 1 type:1 1 rm:5 1 ra:5 rn:5 rd:5
 
-# C3.6.28 Floating-point immediate
+# Floating-point immediate
 # 31 30 29 28 27 26 25 24 23 22 21 20    13 12 11 10 9    5 4    0
 #  M  0  S  1  1  1  1  0 type   1   imm8    1  0  0  imm5    Rd
 
@@ -2736,7 +2813,7 @@ FMOVi A64_V 00011110 type:2 1 imm:8 100 00000 rd:5 \
 # UnallocatedEncoding: type >= 2
 FMOVi_RES A64_V 00011110 1 type:1 1 imm:8 100 00000 rd:5
 
-# C3.6.29 Floating-point<->fixed-point conversions
+# Conversion between floating-point and fixed-point
 # 31 30 29 28 27 26 25 24 23 22 21 20 19  18  16  15     10 9  5 4  0
 # sf  0  S  1  1  1  1  0 type   0 rmode  opcode    scale    Rn   Rd
 
@@ -2772,7 +2849,7 @@ FCVTZUsf_RES1 A64_V sf:1 0011110 1 type:1 0 11 001 scale:6 rn:5 rd:5
 # UnallocatedEncoding: sf == 0 && $scale < 0x20
 FCVTZUsf_RES2 A64_V 0 0011110 1 type:1 0 11 001 0 scale:5 rn:5 rd:5
 
-# C3.6.30 Floating-point<->integer conversions
+# Conversion between floating-point and integer
 # 31 30 29 28 27 26 25 24 23 22 21 20 19 18    16 15 14 13 12 11 10  9  5  4  0
 # sf  0  S  1  1  1  1  0  type  1 rmode  opcode   0  0  0  0  0  0   Rn    Rd
 
@@ -2855,3 +2932,8 @@ FCVTZUsi A64_V sf:1 0011110 type:2 1 11 001 000000 rn:5 rd:5 \
 !constraints { $type < 2; }
 # UnallocatedEncoding: type >= 2
 FCVTZUsi_RES A64_V sf:1 0011110 1 type:1 1 11 001 000000 rn:5 rd:5
+
+@
+# End of:
+# Data processing - SIMD and floating point
+# Data processing - Scalar Floating-Point and Advanced SIMD
-- 
2.14.2
