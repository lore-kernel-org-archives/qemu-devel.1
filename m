Received: from eggs.gnu.org ([2001:4830:134:3::10]:42079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86v-0001j2-OV
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86u-0005B8-Is
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:05 -0500
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:33480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS86u-0005Ae-Fv
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:04 -0500
Received: by mail-yb0-x242.google.com with SMTP id 123so2170962ybe.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 12:06:04 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 13 Jan 2017 12:05:54 -0800
Message-Id: <20170113200556.2574-3-rth@twiddle.net>
In-Reply-To: <20170113200556.2574-1-rth@twiddle.net>
References: <20170113200556.2574-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/4] target/arm: Fix ubfx et al for aarch64
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

The patch in 59a71b4c5b4e suffered from a merge failure
when compared to the original patch in

  http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg00137.html

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4f09dfb..d0352e2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3217,7 +3217,7 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
     tcg_tmp = read_cpu_reg(s, rn, 1);
 
     /* Recognize simple(r) extractions.  */
-    if (si <= ri) {
+    if (si >= ri) {
         /* Wd<s-r:0> = Wn<s:r> */
         len = (si - ri) + 1;
         if (opc == 0) { /* SBFM: ASR, SBFX, SXTB, SXTH, SXTW */
-- 
2.9.3
