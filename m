Received: from eggs.gnu.org ([2001:4830:134:3::10]:53762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fanUv-0002PE-Nl
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fanUs-00014j-JJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:31:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47821 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fanUs-000146-Bg
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:31:26 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed,  4 Jul 2018 21:30:32 +0200
Message-Id: <1530732637-28606-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 3/8] target/mips: Update some CP0 registers
 bit definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update CP0 registers Config0, Config1, and Config5 bit definitions.

Some of these bits will be utilized by upcoming nanoMIPS changes.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cfe1735..edbb66d 100644
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
@@ -468,7 +469,21 @@ struct CPUMIPSState {
 #define CP0C5_CV         29
 #define CP0C5_EVA        28
 #define CP0C5_MSAEn      27
+#define CP0C5_PMJ2       25
+#define CP0C5_PMJ1       24
+#define CP0C5_PMJ0       23
+#define CP0C5_WR2        22
+#define CP0C5_NMS        21
+#define CP0C5_ULS        20
+#define CP0C5_XPA        19
+#define CP0C5_CRCP       18
+#define CP0C5_MI         17
+#define CP0C5_GI1        16
+#define CP0C5_GI0        15
+#define CP0C5_CA2        14
 #define CP0C5_XNP        13
+#define CP0C5_DEC        11
+#define CP0C5_L2C        10
 #define CP0C5_UFE        9
 #define CP0C5_FRE        8
 #define CP0C5_VP         7
-- 
2.7.4
