Received: from eggs.gnu.org ([2001:4830:134:3::10]:51470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdy-0002Kj-JQ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdx-0007d7-PL
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:14 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONdx-0007c4-K4
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:13 -0500
Received: by mail-wr0-x241.google.com with SMTP id h1so17430996wre.12
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:51 +0000
Message-Id: <20171211125705.16120-6-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 05/19] include/fpu/softfloat: add some
 float16 contants
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

This defines the same set of common constants for float 16 as defined
for 32 and 64 bit floats. These are often used by target helper
functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 17dfe60dbd..5a9258c57c 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -395,6 +395,13 @@ static inline float16 float16_set_sign(float16 a, int sign)
     return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
 }
 
+#define float16_zero make_float16(0)
+#define float16_one make_float16(0x3a00)
+#define float16_ln2 make_float16(0x34d1)
+#define float16_pi make_float16(0x4448)
+#define float16_half make_float16(0x3800)
+#define float16_infinity make_float16(0x7a00)
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.15.1
