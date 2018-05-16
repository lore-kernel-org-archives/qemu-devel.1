Received: from eggs.gnu.org ([2001:4830:134:3::10]:53514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wo-0002v1-Nk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fJ1Wo-0000hb-1b
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:58 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fJ1Wn-0000hI-QM
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:51:57 -0400
Received: by mail-wm0-x242.google.com with SMTP id t11-v6so3953185wmt.0
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 11:51:57 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 16 May 2018 20:51:13 +0200
Message-Id: <20180516185146.30708-6-edgar.iglesias@gmail.com>
In-Reply-To: <20180516185146.30708-1-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 05/38] target-microblaze: Correct special
 register array sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Correct special register array sizes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.h       | 4 ++--
 target/microblaze/translate.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 5be71bc320..994496515f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -242,8 +242,8 @@ struct CPUMBState {
     uint32_t bimm;
 
     uint32_t imm;
-    uint32_t regs[33];
-    uint32_t sregs[24];
+    uint32_t regs[32];
+    uint32_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
     uint32_t slr, shr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 46595e6336..9614f15d58 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -54,7 +54,7 @@
 
 static TCGv env_debug;
 static TCGv cpu_R[32];
-static TCGv cpu_SR[18];
+static TCGv cpu_SR[14];
 static TCGv env_imm;
 static TCGv env_btaken;
 static TCGv env_btarget;
@@ -106,8 +106,7 @@ static const char *regnames[] =
 static const char *special_regnames[] =
 {
     "rpc", "rmsr", "sr2", "sr3", "sr4", "sr5", "sr6", "sr7",
-    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13", "sr14", "sr15",
-    "sr16", "sr17", "sr18"
+    "sr8", "sr9", "sr10", "sr11", "sr12", "sr13"
 };
 
 static inline void t_sync_flags(DisasContext *dc)
-- 
2.14.1
