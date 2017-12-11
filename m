Received: from eggs.gnu.org ([2001:4830:134:3::10]:51504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe0-0002Mv-N4
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdw-0007bL-9Y
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:16 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONdw-0007aN-3N
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:12 -0500
Received: by mail-wr0-x242.google.com with SMTP id z34so17439355wrz.10
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:50 +0000
Message-Id: <20171211125705.16120-5-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 04/19] include/fpu/softfloat: implement
 float16_set_sign helper
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
 include/fpu/softfloat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 32036382c6..17dfe60dbd 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -390,6 +390,11 @@ static inline float16 float16_chs(float16 a)
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
2.15.1
