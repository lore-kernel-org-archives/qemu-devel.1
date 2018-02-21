Received: from eggs.gnu.org ([2001:4830:134:3::10]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDW-0003wK-9p
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDV-0006gk-HF
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:42 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDV-0006gK-AL
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:41 -0500
Received: by mail-wr0-x244.google.com with SMTP id z12so3287370wrg.4
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:08 +0000
Message-Id: <20180221110523.859-9-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/22] include/fpu/softfloat: add some float16
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This defines the same set of common constants for float 16 as defined
for 32 and 64 bit floats. These are often used by target helper
functions. I've also removed constants that are not used by anybody.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 59c06ef192..23824a3000 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -286,6 +286,11 @@ static inline float16 float16_set_sign(float16 a, int sign)
     return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
 }
 
+#define float16_zero make_float16(0)
+#define float16_one make_float16(0x3c00)
+#define float16_half make_float16(0x3800)
+#define float16_infinity make_float16(0x7c00)
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
@@ -392,8 +397,6 @@ static inline float32 float32_set_sign(float32 a, int sign)
 
 #define float32_zero make_float32(0)
 #define float32_one make_float32(0x3f800000)
-#define float32_ln2 make_float32(0x3f317218)
-#define float32_pi make_float32(0x40490fdb)
 #define float32_half make_float32(0x3f000000)
 #define float32_infinity make_float32(0x7f800000)
 
@@ -506,7 +509,6 @@ static inline float64 float64_set_sign(float64 a, int sign)
 #define float64_zero make_float64(0)
 #define float64_one make_float64(0x3ff0000000000000LL)
 #define float64_ln2 make_float64(0x3fe62e42fefa39efLL)
-#define float64_pi make_float64(0x400921fb54442d18LL)
 #define float64_half make_float64(0x3fe0000000000000LL)
 #define float64_infinity make_float64(0x7ff0000000000000LL)
 
-- 
2.15.1
