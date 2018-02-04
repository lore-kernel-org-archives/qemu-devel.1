Received: from eggs.gnu.org ([2001:4830:134:3::10]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBeg-0004Wb-LE
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBef-0004rI-SZ
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:50 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBef-0004qv-NH
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:49 -0500
Received: by mail-pl0-x244.google.com with SMTP id q17so7155990pll.1
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:11:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:18 -0800
Message-Id: <20180204041136.17525-7-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/24] include/fpu/softfloat: implement
 float16_chs helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 1d34f2c3eb..f75aa59100 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -272,6 +272,15 @@ static inline float16 float16_abs(float16 a)
      */
     return make_float16(float16_val(a) & 0x7fff);
 }
+
+static inline float16 float16_chs(float16 a)
+{
+    /* Note that chs does *not* handle NaN specially, nor does
+     * it flush denormal inputs to zero.
+     */
+    return make_float16(float16_val(a) ^ 0x8000);
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.14.3
