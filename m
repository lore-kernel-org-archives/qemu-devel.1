Received: from eggs.gnu.org ([2001:4830:134:3::10]:38470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQU-0000Jj-Da
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8UQT-0003ix-CD
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:10 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8UQT-0003ex-2a
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:02:09 -0400
Received: by mail-ot1-x32d.google.com with SMTP id e21-v6so13542196otk.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 11:02:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Oct 2018 13:01:54 -0500
Message-Id: <20181005180201.11387-2-richard.henderson@linaro.org>
In-Reply-To: <20181005180201.11387-1-richard.henderson@linaro.org>
References: <20181005180201.11387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/8] softfloat: remove float64_trunc_to_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

It has not had users since f83311e476 ("target-m68k: use floatx80
internally", 2017-06-21).

Note that no other bit-width has floatX_trunc_to_int.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
