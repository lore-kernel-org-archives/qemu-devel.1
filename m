Received: from eggs.gnu.org ([2001:4830:134:3::10]:59169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQm-0000rI-Rs
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQk-00029U-Pc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQi-00027R-Vx
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQh-0000BG-AF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:35 +0100
Message-Id: <20180816133438.17061-28-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 27/30] target/arm: Use FZ not FZ16 for SVE FCVT
 single-half and double-half
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

We were using the wrong flush-to-zero bit for the non-half input.

Fixes: 46d33d1e3c9
Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d27bc8c946b..667879564f8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4093,7 +4093,7 @@ static bool do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
 
 static bool trans_FCVT_sh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_sh);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_sh);
 }
 
 static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
@@ -4103,7 +4103,7 @@ static bool trans_FCVT_hs(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 
 static bool trans_FCVT_dh(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 {
-    return do_zpz_ptr(s, a->rd, a->rn, a->pg, true, gen_helper_sve_fcvt_dh);
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve_fcvt_dh);
 }
 
 static bool trans_FCVT_hd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
-- 
2.18.0
