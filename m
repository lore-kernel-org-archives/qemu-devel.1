Received: from eggs.gnu.org ([2001:4830:134:3::10]:35270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDQ-0003tA-0M
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSDP-0006e1-7M
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:35 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSDP-0006da-0u
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:05:35 -0500
Received: by mail-wr0-x244.google.com with SMTP id u49so3259133wrc.10
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:05:34 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:05 +0000
Message-Id: <20180221110523.859-6-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/22] include/fpu/softfloat: implement
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This will be required when expanding the MINMAX() macro for 16
bit/half-precision operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index f3b9008f78..1d34f2c3eb 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -265,6 +265,13 @@ static inline int float16_is_zero_or_denormal(float16 a)
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
2.15.1
