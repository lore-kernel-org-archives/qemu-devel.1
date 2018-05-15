Received: from eggs.gnu.org ([2001:4830:134:3::10]:39726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOe-0003fV-Vk
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOc-0007VA-SK
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:16 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIiOc-0007Lc-Hn
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:14 -0400
Received: by mail-pl0-x244.google.com with SMTP id bi12-v6so854212plb.12
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:26:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 May 2018 15:25:33 -0700
Message-Id: <20180515222540.9988-22-richard.henderson@linaro.org>
In-Reply-To: <20180515222540.9988-1-richard.henderson@linaro.org>
References: <20180515222540.9988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 21/28] fpu/softfloat: Remove
 floatX_maybe_silence_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

These functions are now unused.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 63 --------------------------------------
 include/fpu/softfloat.h    |  5 ---
 2 files changed, 68 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 4fa068a5dc..d7033b7757 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -364,19 +364,6 @@ float16 float16_silence_nan(float16 a, float_status *status)
 #endif
 }
 
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN if the half-precision floating point value `a' is a
-| signaling NaN; otherwise returns `a'.
-*----------------------------------------------------------------------------*/
-
-float16 float16_maybe_silence_nan(float16 a, float_status *status)
-{
-    if (float16_is_signaling_nan(a, status)) {
-        return float16_silence_nan(a, status);
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the single-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -438,18 +425,6 @@ float32 float32_silence_nan(float32 a, float_status *status)
     }
 #endif
 }
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN if the single-precision floating point value `a' is a
-| signaling NaN; otherwise returns `a'.
-*----------------------------------------------------------------------------*/
-
-float32 float32_maybe_silence_nan(float32 a, float_status *status)
-{
-    if (float32_is_signaling_nan(a, status)) {
-        return float32_silence_nan(a, status);
-    }
-    return a;
-}
 
 /*----------------------------------------------------------------------------
 | Returns the result of converting the single-precision floating-point NaN
@@ -864,18 +839,6 @@ float64 float64_silence_nan(float64 a, float_status *status)
 #endif
 }
 
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN if the double-precision floating point value `a' is a
-| signaling NaN; otherwise returns `a'.
-*----------------------------------------------------------------------------*/
-
-float64 float64_maybe_silence_nan(float64 a, float_status *status)
-{
-    if (float64_is_signaling_nan(a, status)) {
-        return float64_silence_nan(a, status);
-    }
-    return a;
-}
 
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point NaN
@@ -1037,19 +1000,6 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 #endif
 }
 
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN if the extended double-precision floating point value
-| `a' is a signaling NaN; otherwise returns `a'.
-*----------------------------------------------------------------------------*/
-
-floatx80 floatx80_maybe_silence_nan(floatx80 a, float_status *status)
-{
-    if (floatx80_is_signaling_nan(a, status)) {
-        return floatx80_silence_nan(a, status);
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the extended double-precision floating-
 | point NaN `a' to the canonical NaN format.  If `a' is a signaling NaN, the
@@ -1204,19 +1154,6 @@ float128 float128_silence_nan(float128 a, float_status *status)
 #endif
 }
 
-/*----------------------------------------------------------------------------
-| Returns a quiet NaN if the quadruple-precision floating point value `a' is
-| a signaling NaN; otherwise returns `a'.
-*----------------------------------------------------------------------------*/
-
-float128 float128_maybe_silence_nan(float128 a, float_status *status)
-{
-    if (float128_is_signaling_nan(a, status)) {
-        return float128_silence_nan(a, status);
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point NaN
 | `a' to the canonical NaN format.  If `a' is a signaling NaN, the invalid
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index a6860e858d..69f4dbc4db 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -258,7 +258,6 @@ int float16_compare_quiet(float16, float16, float_status *status);
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
 float16 float16_silence_nan(float16, float_status *status);
-float16 float16_maybe_silence_nan(float16, float_status *status);
 
 static inline int float16_is_any_nan(float16 a)
 {
@@ -370,7 +369,6 @@ float32 float32_maxnummag(float32, float32, float_status *status);
 int float32_is_quiet_nan(float32, float_status *status);
 int float32_is_signaling_nan(float32, float_status *status);
 float32 float32_silence_nan(float32, float_status *status);
-float32 float32_maybe_silence_nan(float32, float_status *status);
 float32 float32_scalbn(float32, int, float_status *status);
 
 static inline float32 float32_abs(float32 a)
@@ -500,7 +498,6 @@ float64 float64_maxnummag(float64, float64, float_status *status);
 int float64_is_quiet_nan(float64 a, float_status *status);
 int float64_is_signaling_nan(float64, float_status *status);
 float64 float64_silence_nan(float64, float_status *status);
-float64 float64_maybe_silence_nan(float64, float_status *status);
 float64 float64_scalbn(float64, int, float_status *status);
 
 static inline float64 float64_abs(float64 a)
@@ -604,7 +601,6 @@ int floatx80_compare_quiet(floatx80, floatx80, float_status *status);
 int floatx80_is_quiet_nan(floatx80, float_status *status);
 int floatx80_is_signaling_nan(floatx80, float_status *status);
 floatx80 floatx80_silence_nan(floatx80, float_status *status);
-floatx80 floatx80_maybe_silence_nan(floatx80, float_status *status);
 floatx80 floatx80_scalbn(floatx80, int, float_status *status);
 
 static inline floatx80 floatx80_abs(floatx80 a)
@@ -816,7 +812,6 @@ int float128_compare_quiet(float128, float128, float_status *status);
 int float128_is_quiet_nan(float128, float_status *status);
 int float128_is_signaling_nan(float128, float_status *status);
 float128 float128_silence_nan(float128, float_status *status);
-float128 float128_maybe_silence_nan(float128, float_status *status);
 float128 float128_scalbn(float128, int, float_status *status);
 
 static inline float128 float128_abs(float128 a)
-- 
2.17.0
