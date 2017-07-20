Received: from eggs.gnu.org ([2001:4830:134:3::10]:55653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD88-0003FV-Dq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD87-0004MX-Bx
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:44 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD87-0004M5-5l
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:43 -0400
Received: by mail-wm0-x231.google.com with SMTP id g127so29907870wmd.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:22 +0100
Message-Id: <20170720150426.12393-20-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 19/23] fpu/softfloat2a: implement
 float16_abs helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This will be required when expanding the MINMAX() macro for 16
bit/half-precision operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat2a/softfloat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/fpu/softfloat2a/softfloat.h b/include/fpu/softfloat2a/softfloat.h
index a274dc7419..3cb41977d8 100644
--- a/include/fpu/softfloat2a/softfloat.h
+++ b/include/fpu/softfloat2a/softfloat.h
@@ -379,6 +379,13 @@ static inline int float16_is_zero_or_denormal(float16 a)
     return (float16_val(a) & 0x7c00) == 0;
 }
 
+static inline float16 float16_abs(float16 a)
+{
+    /* Note that abs does *not* handle NaN specially, nor does
+     * it flush denormal inputs to zero.
+     */
+    return make_float16(float16_val(a) & 0x7fff);
+}
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.13.0
