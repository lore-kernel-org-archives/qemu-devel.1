Received: from eggs.gnu.org ([2001:4830:134:3::10]:54505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rZd-0004Nw-EM
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rZZ-00044u-W9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:12:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f3rZZ-00044m-Ry
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:12:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  4 Apr 2018 19:11:08 -0400
Message-Id: <1522883475-27858-9-git-send-email-cota@braap.org>
In-Reply-To: <1522883475-27858-1-git-send-email-cota@braap.org>
References: <1522883475-27858-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 08/15] softfloat: add float{32,
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These will gain some users very soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/softfloat.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index a8512fb..66985e1 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -422,6 +422,11 @@ static inline bool float32_is_denormal(float32 a)
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
@@ -561,6 +566,11 @@ static inline bool float64_is_denormal(float64 a)
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
2.7.4
