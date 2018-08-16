Received: from eggs.gnu.org ([2001:4830:134:3::10]:58926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQR-0000BF-Sp
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQR-0001sd-5p
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:55 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQQ-0001pa-UV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:55 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQF-0008R4-4e
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:09 +0100
Message-Id: <20180816133438.17061-2-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/30] target/arm: Fix typo in
 helper_sve_ld1hss_r
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

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/sve_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index c3cbec9cf5f..e03f954a264 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4045,7 +4045,7 @@ DO_LD1(sve_ld1bdu_r, cpu_ldub_data_ra, uint64_t, uint8_t, )
 DO_LD1(sve_ld1bds_r, cpu_ldsb_data_ra, uint64_t, int8_t, )
 
 DO_LD1(sve_ld1hsu_r, cpu_lduw_data_ra, uint32_t, uint16_t, H1_4)
-DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int8_t, H1_4)
+DO_LD1(sve_ld1hss_r, cpu_ldsw_data_ra, uint32_t, int16_t, H1_4)
 DO_LD1(sve_ld1hdu_r, cpu_lduw_data_ra, uint64_t, uint16_t, )
 DO_LD1(sve_ld1hds_r, cpu_ldsw_data_ra, uint64_t, int16_t, )
 
-- 
2.18.0
