Received: from eggs.gnu.org ([2001:4830:134:3::10]:59493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g0ZML-000068-Kz
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g0ZMB-0000N0-6x
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:41:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g0ZM7-0007yM-Bk
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:40:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Sep 2018 17:39:08 -0400
Message-Id: <20180913213910.28189-2-cota@braap.org>
In-Reply-To: <20180913213910.28189-1-cota@braap.org>
References: <20180913213910.28189-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 1/3] softfloat: remove float64_trunc_to_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

It has not had users since f83311e476 ("target-m68k: use floatx80
internally", 2017-06-21).

Note that no other bit-width has floatX_trunc_to_int.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/softfloat.h | 1 -
 fpu/softfloat.c         | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cc1b58b029..8fd9f9bbae 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -535,7 +535,6 @@ float128 float64_to_float128(float64, float_status *status);
 | Software IEC/IEEE double-precision operations.
 *----------------------------------------------------------------------------*/
 float64 float64_round_to_int(float64, float_status *status);
-float64 float64_trunc_to_int(float64, float_status *status);
 float64 float64_add(float64, float64, float_status *status);
 float64 float64_sub(float64, float64, float_status *status);
 float64 float64_mul(float64, float64, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 59ca356d0e..9405f12a03 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1409,13 +1409,6 @@ float64 float64_round_to_int(float64 a, float_status *s)
     return float64_round_pack_canonical(pr, s);
 }
 
-float64 float64_trunc_to_int(float64 a, float_status *s)
-{
-    FloatParts pa = float64_unpack_canonical(a, s);
-    FloatParts pr = round_to_int(pa, float_round_to_zero, 0, s);
-    return float64_round_pack_canonical(pr, s);
-}
-
 /*
  * Returns the result of converting the floating-point value `a' to
  * the two's complement integer format. The conversion is performed
-- 
2.17.1
