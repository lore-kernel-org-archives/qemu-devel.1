Received: from eggs.gnu.org ([2001:4830:134:3::10]:49151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYC-0001WV-Pf
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYB-0000a9-RX
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 Nov 2017 21:26:21 +0100
Message-Id: <20171103202624.5956-2-laurent@vivier.eu>
In-Reply-To: <20171103202624.5956-1-laurent@vivier.eu>
References: <20171103202624.5956-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/4] arm: fix float64 helper definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>

neon_ceq_f64(), neon_cge_f64() and neon_cgt_f64()
take float64 as parameter, fix the definition in
helper-a64.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/arm/helper-a64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 85d86741db..b5e9ba03c0 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -26,9 +26,9 @@ DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, ptr)
 DEF_HELPER_FLAGS_5(simd_tbl, TCG_CALL_NO_RWG_SE, i64, env, i64, i64, i32, i32)
 DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
 DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
-DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
-DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
-DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, i64, i64, ptr)
+DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, f64, f64, ptr)
+DEF_HELPER_FLAGS_3(neon_cge_f64, TCG_CALL_NO_RWG, i64, f64, f64, ptr)
+DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, f64, f64, ptr)
 DEF_HELPER_FLAGS_3(recpsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
 DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, ptr)
 DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, ptr)
-- 
2.13.6
