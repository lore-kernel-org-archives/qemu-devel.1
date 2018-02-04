Received: from eggs.gnu.org ([2001:4830:134:3::10]:47299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBei-0004Yg-Ai
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBeh-0004rx-HZ
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:52 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBeh-0004rh-B1
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:51 -0500
Received: by mail-pg0-x242.google.com with SMTP id 141so5380855pgd.8
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:11:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:19 -0800
Message-Id: <20180204041136.17525-8-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/24] include/fpu/softfloat: implement
 float16_set_sign helper
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index f75aa59100..59c06ef192 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -281,6 +281,11 @@ static inline float16 float16_chs(float16 a)
     return make_float16(float16_val(a) ^ 0x8000);
 }
 
+static inline float16 float16_set_sign(float16 a, int sign)
+{
+    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.14.3
