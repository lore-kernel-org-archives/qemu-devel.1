Received: from eggs.gnu.org ([2001:4830:134:3::10]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvh-0008Lw-Od
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvg-0001wQ-QI
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:55473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXnvg-0001ve-DU
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id y139so5727230wmc.5
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:55:00 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 13:54:44 +0000
Message-Id: <20181214135452.25936-8-alex.bennee@linaro.org>
In-Reply-To: <20181214135452.25936-1-alex.bennee@linaro.org>
References: <20181214135452.25936-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/15] softfloat: add float{32,
 64}_is_zero_or_normal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

These will gain some users very soon.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 9eeccd88a5..38a5e99cf3 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -474,6 +474,11 @@ static inline bool float32_is_denormal(float32 a)
     return float32_is_zero_or_denormal(a) && !float32_is_zero(a);
 }
 
+static inline bool float32_is_zero_or_normal(float32 a)
+{
+    return float32_is_normal(a) || float32_is_zero(a);
+}
+
 static inline float32 float32_set_sign(float32 a, int sign)
 {
     return make_float32((float32_val(a) & 0x7fffffff) | (sign << 31));
@@ -625,6 +630,11 @@ static inline bool float64_is_denormal(float64 a)
     return float64_is_zero_or_denormal(a) && !float64_is_zero(a);
 }
 
+static inline bool float64_is_zero_or_normal(float64 a)
+{
+    return float64_is_normal(a) || float64_is_zero(a);
+}
+
 static inline float64 float64_set_sign(float64 a, int sign)
 {
     return make_float64((float64_val(a) & 0x7fffffffffffffffULL)
-- 
2.17.1
