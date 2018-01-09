Received: from eggs.gnu.org ([2001:4830:134:3::10]:51398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvm-0006bI-0y
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvl-0006Uo-5L
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:02 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvk-0006ST-Um
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:01 -0500
Received: by mail-wr0-x242.google.com with SMTP id p6so13914189wrd.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:23:00 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:36 +0000
Message-Id: <20180109122252.17670-5-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/20] include/fpu/softfloat: implement
 float16_chs helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cfc615008d..dc71b01dba 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -354,6 +354,15 @@ static inline float16 float16_abs(float16 a)
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
2.15.1
