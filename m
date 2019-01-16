Received: from eggs.gnu.org ([209.51.188.92]:55750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gjkuU-0004f7-IX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gjkuT-0002Hc-AD
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:10 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54171 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gjkuS-0008Ez-Uz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:07:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 16 Jan 2019 14:05:47 +0100
Message-Id: <1547643949-10776-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547643949-10776-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/3] target/mips: Add preprocessor constants
 for CP0 subregisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, arikalo@wavecomp.com, aurelien@aurel32.net

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add preprocessor constants for CP0 subregisters. The names of
the subregisters were chosen to be in sync with the table of
corresponding assembler mnemonics found in the documentation
for I6500 and I6400 (release 1.0).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 48e86d1..294aef0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -267,6 +267,120 @@ typedef struct mips_def_t mips_def_t;
 #define CPO_REGISTER_31    31
 
 
+/* CP0 Register 00 */
+#define CPO_REG00__INDEX           0
+#define CPO_REG00__VPCONTROL       4
+/* CP0 Register 01 */
+/* CP0 Register 02 */
+#define CPO_REG02__ENTRYLO0        0
+/* CP0 Register 03 */
+#define CPO_REG03__ENTRYLO1        0
+#define CPO_REG03__GLOBALNUM       1
+/* CP0 Register 04 */
+#define CPO_REG04__CONTEXT         0
+#define CPO_REG04__USERLOCAL       2
+#define CPO_REG04__DBGCONTEXTID    4
+#define CPO_REG00__MMID            5
+/* CP0 Register 05 */
+#define CPO_REG05__PAGEMASK        0
+#define CPO_REG05__PAGEGRAIN       1
+/* CP0 Register 06 */
+#define CPO_REG06__WIRED           0
+/* CP0 Register 07 */
+#define CPO_REG07__HWRENA          0
+/* CP0 Register 08 */
+#define CPO_REG08__BADVADDR        0
+#define CPO_REG08__BADINSTR        1
+#define CPO_REG08__BADINSTRP       2
+/* CP0 Register 09 */
+#define CPO_REG09__COUNT           0
+#define CPO_REG09__SAARI           6
+#define CPO_REG09__SAAR            7
+/* CP0 Register 10 */
+#define CPO_REG10__ENTRYHI         0
+#define CPO_REG10__GUESTCTL1       4
+#define CPO_REG10__GUESTCTL2       5
+/* CP0 Register 11 */
+#define CPO_REG11__COMPARE         0
+#define CPO_REG11__GUESTCTL0EXT    4
+/* CP0 Register 12 */
+#define CPO_REG12__STATUS          0
+#define CPO_REG12__INTCTL          1
+#define CPO_REG12__SRSCTL          2
+#define CPO_REG12__GUESTCTL0       6
+#define CPO_REG12__GTOFFSET        7
+/* CP0 Register 13 */
+#define CPO_REG13__CAUSE           0
+/* CP0 Register 14 */
+#define CPO_REG14__EPC             0
+/* CP0 Register 15 */
+#define CPO_REG15__PRID            0
+#define CPO_REG15__EBASE           1
+#define CPO_REG15__CDMMBASE        2
+#define CPO_REG15__CMGCRBASE       3
+/* CP0 Register 16 */
+#define CPO_REG16__CONFIG          0
+#define CPO_REG16__CONFIG1         1
+#define CPO_REG16__CONFIG2         2
+#define CPO_REG16__CONFIG3         3
+#define CPO_REG16__CONFIG4         4
+#define CPO_REG16__CONFIG5         5
+#define CPO_REG00__CONFIG7         7
+/* CP0 Register 17 */
+#define CPO_REG17__LLADDR          0
+#define CPO_REG17__MAAR            1
+#define CPO_REG17__MAARI           2
+/* CP0 Register 18 */
+#define CPO_REG18__WATCHLO0        0
+#define CPO_REG18__WATCHLO1        1
+#define CPO_REG18__WATCHLO2        2
+#define CPO_REG18__WATCHLO3        3
+/* CP0 Register 19 */
+#define CPO_REG19__WATCHHI0        0
+#define CPO_REG19__WATCHHI1        1
+#define CPO_REG19__WATCHHI2        2
+#define CPO_REG19__WATCHHI3        3
+/* CP0 Register 20 */
+#define CPO_REG20__XCONTEXT        0
+/* CP0 Register 21 */
+/* CP0 Register 22 */
+/* CP0 Register 23 */
+#define CPO_REG23__DEBUG           0
+/* CP0 Register 24 */
+#define CPO_REG24__DEPC            0
+/* CP0 Register 25 */
+#define CPO_REG25__PERFCTL0        0
+#define CPO_REG25__PERFCNT0        1
+#define CPO_REG25__PERFCTL1        2
+#define CPO_REG25__PERFCNT1        3
+#define CPO_REG25__PERFCTL2        4
+#define CPO_REG25__PERFCNT2        5
+#define CPO_REG25__PERFCTL3        6
+#define CPO_REG25__PERFCNT3        7
+/* CP0 Register 26 */
+#define CPO_REG00__ERRCTL          0
+/* CP0 Register 27 */
+#define CPO_REG27__CACHERR         0
+/* CP0 Register 28 */
+#define CPO_REG28__ITAGLO          0
+#define CPO_REG28__IDATALO         1
+#define CPO_REG28__DTAGLO          2
+#define CPO_REG28__DDATALO         3
+/* CP0 Register 29 */
+#define CPO_REG29__IDATAHI         1
+#define CPO_REG29__DDATAHI         3
+/* CP0 Register 30 */
+#define CPO_REG30__ERROREPC        0
+/* CP0 Register 31 */
+#define CPO_REG31__DESAVE          0
+#define CPO_REG31__KSCRATCH1       2
+#define CPO_REG31__KSCRATCH2       3
+#define CPO_REG31__KSCRATCH3       4
+#define CPO_REG31__KSCRATCH4       5
+#define CPO_REG31__KSCRATCH5       6
+#define CPO_REG31__KSCRATCH6       7
+
+
 typedef struct TCState TCState;
 struct TCState {
     target_ulong gpr[32];
-- 
2.7.4
