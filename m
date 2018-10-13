Received: from eggs.gnu.org ([2001:4830:134:3::10]:57879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCf-0002TJ-LN
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCc-0007x1-Rq
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gBTCc-0007wG-It
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 13 Oct 2018 19:19:25 -0400
Message-Id: <20181013231933.28789-6-cota@braap.org>
In-Reply-To: <20181013231933.28789-1-cota@braap.org>
References: <20181013231933.28789-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 05/13] softfloat: add float{32,
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
