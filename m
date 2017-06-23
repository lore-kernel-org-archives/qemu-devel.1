Received: from eggs.gnu.org ([2001:4830:134:3::10]:60241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMM-0001f1-Jc
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMI-0007sP-Pa
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:02 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMI-0007s8-Lf
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:58 -0400
Received: by mail-qt0-x244.google.com with SMTP id c20so6462813qte.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:22:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:35 -0700
Message-Id: <20170623162241.8964-10-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 09/15] target/s390x: Implement processor-assist
 insn
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

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def | 3 +++
 target/s390x/translate.c   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 8e3f7db..5ba7822 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -699,6 +699,9 @@
     /* Implemented as nops of course.  */
     C(0xe336, PFD,     RXY_b, GIE, 0, 0, 0, 0, 0, 0)
     C(0xc602, PFDRL,   RIL_c, GIE, 0, 0, 0, 0, 0, 0)
+/* PERFORM PROCESSOR ASSIST */
+    /* Implemented as nop of course.  */
+    C(0xb2e8, PPA,     RRF_c, PPA, 0, 0, 0, 0, 0, 0)
 
 /* POPULATION COUNT */
     C(0xb9e1, POPCNT,  RRE,   PC,  0, r2_o, r1, 0, popcnt, nz64)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 06d5600..72af76d 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5444,6 +5444,7 @@ enum DisasInsnEnum {
 #define FAC_DAT_ENH     S390_FEAT_DAT_ENH
 #define FAC_E2          S390_FEAT_EXTENDED_TRANSLATION_2
 #define FAC_EH          S390_FEAT_STFLE_49 /* execution-hint */
+#define FAC_PPA         S390_FEAT_STFLE_49 /* processor-assist */
 #define FAC_LZRB        S390_FEAT_STFLE_53 /* load-and-zero-rightmost-byte */
 
 static const DisasInsn insn_info[] = {
-- 
2.9.4
