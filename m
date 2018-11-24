Received: from eggs.gnu.org ([2001:4830:134:3::10]:57454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmV-0003G0-SP
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmS-0005NP-4w
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:11 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQhmQ-0004j3-O9
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:08 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 24 Nov 2018 18:55:45 -0500
Message-Id: <20181124235553.17371-6-cota@braap.org>
In-Reply-To: <20181124235553.17371-1-cota@braap.org>
References: <20181124235553.17371-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 05/13] softfloat: add float{32,
 64}_is_zero_or_normal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

These will gain some users very soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/softfloat.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

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
