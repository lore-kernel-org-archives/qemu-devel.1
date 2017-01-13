Received: from eggs.gnu.org ([2001:4830:134:3::10]:42076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86v-0001iv-Ie
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86u-0005Ap-EK
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:05 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:36568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS86u-0005AZ-9o
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:04 -0500
Received: by mail-yb0-x243.google.com with SMTP id l23so2166289ybj.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 12:06:04 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 13 Jan 2017 12:05:53 -0800
Message-Id: <20170113200556.2574-2-rth@twiddle.net>
In-Reply-To: <20170113200556.2574-1-rth@twiddle.net>
References: <20170113200556.2574-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 1/4] tcg/s390: Fix merge error with facilities
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

The variable was renamed s390_facilities.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 0682d01..a679280 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1096,7 +1096,7 @@ static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
             /* If we only got here because of load-and-test,
                and we couldn't use that, then we need to load
                the constant into a register.  */
-            if (!(facilities & FACILITY_EXT_IMM)) {
+            if (!(s390_facilities & FACILITY_EXT_IMM)) {
                 c2 = TCG_TMP0;
                 tcg_out_movi(s, type, c2, 0);
                 goto do_reg;
-- 
2.9.3
