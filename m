Received: from eggs.gnu.org ([2001:4830:134:3::10]:51422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdw-0002JY-6y
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdv-0007aZ-Hr
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:12 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONdv-0007Zs-BF
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:11 -0500
Received: by mail-wr0-x244.google.com with SMTP id v22so17487449wrb.0
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:49 +0000
Message-Id: <20171211125705.16120-4-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 03/19] include/fpu/softfloat: implement
 float16_chs helper
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index edf402d422..32036382c6 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -381,6 +381,15 @@ static inline float16 float16_abs(float16 a)
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
