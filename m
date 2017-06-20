Received: from eggs.gnu.org ([2001:4830:134:3::10]:33545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eR-0003MP-Th
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eP-0001nN-G8
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:11 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:32993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6eP-0001n9-AS
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:09 -0400
Received: by mail-pf0-x241.google.com with SMTP id w12so19893430pfk.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 17:04:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 17:03:48 -0700
Message-Id: <20170620000405.3391-2-rth@twiddle.net>
In-Reply-To: <20170620000405.3391-1-rth@twiddle.net>
References: <20170620000405.3391-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 01/18] target/s390x: Map existing FAC_*
 names to S390_FEAT_* names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

The FAC_ names were placeholders prior to the introduction
of the current facility modeling.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 59 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 8c055b7..af18ffb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1178,39 +1178,10 @@ typedef enum {
     EXIT_NORETURN,
 } ExitStatus;
 
-typedef enum DisasFacility {
-    FAC_Z,                  /* zarch (default) */
-    FAC_CASS,               /* compare and swap and store */
-    FAC_CASS2,              /* compare and swap and store 2*/
-    FAC_DFP,                /* decimal floating point */
-    FAC_DFPR,               /* decimal floating point rounding */
-    FAC_DO,                 /* distinct operands */
-    FAC_EE,                 /* execute extensions */
-    FAC_EI,                 /* extended immediate */
-    FAC_FPE,                /* floating point extension */
-    FAC_FPSSH,              /* floating point support sign handling */
-    FAC_FPRGR,              /* FPR-GR transfer */
-    FAC_GIE,                /* general instructions extension */
-    FAC_HFP_MA,             /* HFP multiply-and-add/subtract */
-    FAC_HW,                 /* high-word */
-    FAC_IEEEE_SIM,          /* IEEE exception sumilation */
-    FAC_MIE,                /* miscellaneous-instruction-extensions */
-    FAC_LAT,                /* load-and-trap */
-    FAC_LOC,                /* load/store on condition */
-    FAC_LD,                 /* long displacement */
-    FAC_PC,                 /* population count */
-    FAC_SCF,                /* store clock fast */
-    FAC_SFLE,               /* store facility list extended */
-    FAC_ILA,                /* interlocked access facility 1 */
-    FAC_LPP,                /* load-program-parameter */
-    FAC_DAT_ENH,            /* DAT-enhancement */
-    FAC_E2,                 /* extended-translation facility 2 */
-} DisasFacility;
-
 struct DisasInsn {
     unsigned opc:16;
     DisasFormat fmt:8;
-    DisasFacility fac:8;
+    unsigned fac:8;
     unsigned spec:8;
 
     const char *name;
@@ -5413,6 +5384,34 @@ enum DisasInsnEnum {
 #define SPEC_prep_0 0
 #define SPEC_wout_0 0
 
+/* Give smaller names to the various facilities.  */
+#define FAC_Z           S390_FEAT_ZARCH
+#define FAC_CASS        S390_FEAT_COMPARE_AND_SWAP_AND_STORE
+#define FAC_CASS2       S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2
+#define FAC_DFP         S390_FEAT_DFP
+#define FAC_DFPR        S390_FEAT_FLOATING_POINT_SUPPPORT_ENH /* DFP-rounding */
+#define FAC_DO          S390_FEAT_STFLE_45 /* distinct-operands */
+#define FAC_EE          S390_FEAT_EXECUTE_EXT
+#define FAC_EI          S390_FEAT_EXTENDED_IMMEDIATE
+#define FAC_FPE         S390_FEAT_FLOATING_POINT_EXT
+#define FAC_FPSSH       S390_FEAT_FLOATING_POINT_SUPPPORT_ENH /* FPS-sign-handling */
+#define FAC_FPRGR       S390_FEAT_FLOATING_POINT_SUPPPORT_ENH /* FPR-GR-transfer */
+#define FAC_GIE         S390_FEAT_GENERAL_INSTRUCTIONS_EXT
+#define FAC_HFP_MA      S390_FEAT_HFP_MADDSUB
+#define FAC_HW          S390_FEAT_STFLE_45 /* high-word */
+#define FAC_IEEEE_SIM   S390_FEAT_FLOATING_POINT_SUPPPORT_ENH /* IEEE-exception-simulation */
+#define FAC_MIE         S390_FEAT_STFLE_49 /* misc-instruction-extensions */
+#define FAC_LAT         S390_FEAT_STFLE_49 /* load-and-trap */
+#define FAC_LOC         S390_FEAT_STFLE_45 /* load/store on condition 1 */
+#define FAC_LD          S390_FEAT_LONG_DISPLACEMENT
+#define FAC_PC          S390_FEAT_STFLE_45 /* population count */
+#define FAC_SCF         S390_FEAT_STORE_CLOCK_FAST
+#define FAC_SFLE        S390_FEAT_STFLE
+#define FAC_ILA         S390_FEAT_STFLE_45 /* interlocked-access-facility 1 */
+#define FAC_LPP         S390_FEAT_SET_PROGRAM_PARAMETERS /* load-program-parameter */
+#define FAC_DAT_ENH     S390_FEAT_DAT_ENH
+#define FAC_E2          S390_FEAT_EXTENDED_TRANSLATION_2
+
 static const DisasInsn insn_info[] = {
 #include "insn-data.def"
 };
-- 
2.9.4
