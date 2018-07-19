Received: from eggs.gnu.org ([2001:4830:134:3::10]:46970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8T0-0002xJ-MN
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Qz-0002oq-P5
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:55:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54356 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Qy-0002nr-UY
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:53:29 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:51:59 +0200
Message-Id: <1532004727-13778-4-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 03/11] target/mips: Update some CP0
 registers bit definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update CP0 registers Config0, Config1, Config2, Config3,
Config4, and Config5 bit definitions.

Some of these bits will be utilized by upcoming nanoMIPS changes.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/mips/cpu.h | 157 ++++++++++++++++++++++++++++++------------------=
------
 1 file changed, 88 insertions(+), 69 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cfe1735..77c638c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -388,26 +388,27 @@ struct CPUMIPSState {
     target_ulong CP0_CMGCRBase;
     int32_t CP0_Config0;
 #define CP0C0_M    31
-#define CP0C0_K23  28
-#define CP0C0_KU   25
+#define CP0C0_K23  28    /* 30..28 */
+#define CP0C0_KU   25    /* 27..25 */
 #define CP0C0_MDU  20
 #define CP0C0_MM   18
 #define CP0C0_BM   16
+#define CP0C0_Impl 16    /* 24..16 */
 #define CP0C0_BE   15
-#define CP0C0_AT   13
-#define CP0C0_AR   10
-#define CP0C0_MT   7
+#define CP0C0_AT   13    /* 14..13 */
+#define CP0C0_AR   10    /* 12..10 */
+#define CP0C0_MT   7     /*  9..7  */
 #define CP0C0_VI   3
-#define CP0C0_K0   0
+#define CP0C0_K0   0     /*  2..0  */
     int32_t CP0_Config1;
 #define CP0C1_M    31
-#define CP0C1_MMU  25
-#define CP0C1_IS   22
-#define CP0C1_IL   19
-#define CP0C1_IA   16
-#define CP0C1_DS   13
-#define CP0C1_DL   10
-#define CP0C1_DA   7
+#define CP0C1_MMU  25    /* 30..25 */
+#define CP0C1_IS   22    /* 24..22 */
+#define CP0C1_IL   19    /* 21..19 */
+#define CP0C1_IA   16    /* 18..16 */
+#define CP0C1_DS   13    /* 15..13 */
+#define CP0C1_DL   10    /* 12..10 */
+#define CP0C1_DA   7     /*  9..7  */
 #define CP0C1_C2   6
 #define CP0C1_MD   5
 #define CP0C1_PC   4
@@ -417,67 +418,85 @@ struct CPUMIPSState {
 #define CP0C1_FP   0
     int32_t CP0_Config2;
 #define CP0C2_M    31
-#define CP0C2_TU   28
-#define CP0C2_TS   24
-#define CP0C2_TL   20
-#define CP0C2_TA   16
-#define CP0C2_SU   12
-#define CP0C2_SS   8
-#define CP0C2_SL   4
-#define CP0C2_SA   0
+#define CP0C2_TU   28    /* 30..28 */
+#define CP0C2_TS   24    /* 27..24 */
+#define CP0C2_TL   20    /* 23..20 */
+#define CP0C2_TA   16    /* 19..16 */
+#define CP0C2_SU   12    /* 15..12 */
+#define CP0C2_SS   8     /* 11..8  */
+#define CP0C2_SL   4     /*  7..4  */
+#define CP0C2_SA   0     /*  3..0  */
     int32_t CP0_Config3;
-#define CP0C3_M    31
-#define CP0C3_BPG  30
-#define CP0C3_CMGCR 29
-#define CP0C3_MSAP  28
-#define CP0C3_BP 27
-#define CP0C3_BI 26
-#define CP0C3_SC 25
-#define CP0C3_IPLW 21
-#define CP0C3_MMAR 18
-#define CP0C3_MCU  17
-#define CP0C3_ISA_ON_EXC 16
-#define CP0C3_ISA  14
-#define CP0C3_ULRI 13
-#define CP0C3_RXI  12
-#define CP0C3_DSP2P 11
-#define CP0C3_DSPP 10
-#define CP0C3_LPA  7
-#define CP0C3_VEIC 6
-#define CP0C3_VInt 5
-#define CP0C3_SP   4
-#define CP0C3_CDMM 3
-#define CP0C3_MT   2
-#define CP0C3_SM   1
-#define CP0C3_TL   0
+#define CP0C3_M            31
+#define CP0C3_BPG          30
+#define CP0C3_CMGCR        29
+#define CP0C3_MSAP         28
+#define CP0C3_BP           27
+#define CP0C3_BI           26
+#define CP0C3_SC           25
+#define CP0C3_PW           24
+#define CP0C3_VZ           23
+#define CP0C3_IPLV         21    /* 22..21 */
+#define CP0C3_MMAR         18    /* 20..18 */
+#define CP0C3_MCU          17
+#define CP0C3_ISA_ON_EXC   16
+#define CP0C3_ISA          14    /* 15..14 */
+#define CP0C3_ULRI         13
+#define CP0C3_RXI          12
+#define CP0C3_DSP2P        11
+#define CP0C3_DSPP         10
+#define CP0C3_CTXTC        9
+#define CP0C3_ITL          8
+#define CP0C3_LPA          7
+#define CP0C3_VEIC         6
+#define CP0C3_VInt         5
+#define CP0C3_SP           4
+#define CP0C3_CDMM         3
+#define CP0C3_MT           2
+#define CP0C3_SM           1
+#define CP0C3_TL           0
     int32_t CP0_Config4;
     int32_t CP0_Config4_rw_bitmask;
-#define CP0C4_M    31
-#define CP0C4_IE   29
-#define CP0C4_AE   28
-#define CP0C4_KScrExist 16
-#define CP0C4_MMUExtDef 14
-#define CP0C4_FTLBPageSize 8
-#define CP0C4_FTLBWays 4
-#define CP0C4_FTLBSets 0
-#define CP0C4_MMUSizeExt 0
+#define CP0C4_M            31
+#define CP0C4_IE           29    /* 30..29 */
+#define CP0C4_AE           28
+#define CP0C4_VTLBSizeExt  24    /* 27..24 */
+#define CP0C4_KScrExist    16
+#define CP0C4_MMUExtDef    14
+#define CP0C4_FTLBPageSize 8     /* 12..8  */
+/* bit layout if MMUExtDef=3D1 */
+#define CP0C4_MMUSizeExt   0     /*  7..0  */
+/* bit layout if MMUExtDef=3D2 */
+#define CP0C4_FTLBWays     4     /*  7..4  */
+#define CP0C4_FTLBSets     0     /*  3..0  */
     int32_t CP0_Config5;
     int32_t CP0_Config5_rw_bitmask;
-#define CP0C5_M          31
-#define CP0C5_K          30
-#define CP0C5_CV         29
-#define CP0C5_EVA        28
-#define CP0C5_MSAEn      27
-#define CP0C5_XNP        13
-#define CP0C5_UFE        9
-#define CP0C5_FRE        8
-#define CP0C5_VP         7
-#define CP0C5_SBRI       6
-#define CP0C5_MVH        5
-#define CP0C5_LLB        4
-#define CP0C5_MRP        3
-#define CP0C5_UFR        2
-#define CP0C5_NFExists   0
+#define CP0C5_M            31
+#define CP0C5_K            30
+#define CP0C5_CV           29
+#define CP0C5_EVA          28
+#define CP0C5_MSAEn        27
+#define CP0C5_PMJ          23    /* 25..23 */
+#define CP0C5_WR2          22
+#define CP0C5_NMS          21
+#define CP0C5_ULS          20
+#define CP0C5_XPA          19
+#define CP0C5_CRCP         18
+#define CP0C5_MI           17
+#define CP0C5_GI           15    /* 16..15 */
+#define CP0C5_CA2          14
+#define CP0C5_XNP          13
+#define CP0C5_DEC          11
+#define CP0C5_L2C          10
+#define CP0C5_UFE          9
+#define CP0C5_FRE          8
+#define CP0C5_VP           7
+#define CP0C5_SBRI         6
+#define CP0C5_MVH          5
+#define CP0C5_LLB          4
+#define CP0C5_MRP          3
+#define CP0C5_UFR          2
+#define CP0C5_NFExists     0
     int32_t CP0_Config6;
     int32_t CP0_Config7;
     uint64_t CP0_MAAR[MIPS_MAAR_MAX];
--=20
2.7.4
