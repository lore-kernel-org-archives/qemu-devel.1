Received: from eggs.gnu.org ([2001:4830:134:3::10]:51412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdv-0002JU-Uk
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdu-0007ZG-9G
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:12 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONdu-0007YG-32
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:10 -0500
Received: by mail-wm0-x243.google.com with SMTP id 9so14236012wme.4
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:09 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:48 +0000
Message-Id: <20171211125705.16120-3-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 02/19] include/fpu/softfloat: implement
 float16_abs helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This will be required when expanding the MINMAX() macro for 16
bit/half-precision operations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.15.1
