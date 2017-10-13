Received: from eggs.gnu.org ([2001:4830:134:3::10]:41704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lV-0002S2-2Q
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lT-0006XS-Pn
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:49 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:46124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lT-0006WV-Jl
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:47 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l1so1432509wrc.3
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:15 +0100
Message-Id: <20171013162438.32458-8-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 07/30] fpu/softfloat: implement float16_abs
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This will be required when expanding the MINMAX() macro for 16
bit/half-precision operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index d5e99667b6..edf402d422 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -374,6 +374,13 @@ static inline int float16_is_zero_or_denormal(float16 a)
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
2.14.1
