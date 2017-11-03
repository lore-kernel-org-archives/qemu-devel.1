Received: from eggs.gnu.org ([2001:4830:134:3::10]:49176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYD-0001Xd-Vs
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYD-0000cK-5q
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:50 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 Nov 2017 21:26:24 +0100
Message-Id: <20171103202624.5956-5-laurent@vivier.eu>
In-Reply-To: <20171103202624.5956-1-laurent@vivier.eu>
References: <20171103202624.5956-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 4/4] softfloat: use floatXX_val() in XX_minmax()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 fpu/softfloat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 433c5dad2d..331d78e848 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7700,11 +7700,9 @@ static inline float ## s float ## s ## _minmax(float ## s a, float ## s b,     \
     }                                                                   \
     aSign = extractFloat ## s ## Sign(a);                               \
     bSign = extractFloat ## s ## Sign(b);                               \
-    av = float ## s ## _val(a);                                         \
-    bv = float ## s ## _val(b);                                         \
     if (ismag) {                                                        \
-        aav = float ## s ## _abs(av);                                   \
-        abv = float ## s ## _abs(bv);                                   \
+        aav = float ## s ## _val(float ## s ## _abs(a));                \
+        abv = float ## s ## _val(float ## s ## _abs(b));                \
         if (aav != abv) {                                               \
             if (ismin) {                                                \
                 return (aav < abv) ? a : b;                             \
@@ -7713,6 +7711,8 @@ static inline float ## s float ## s ## _minmax(float ## s a, float ## s b,     \
             }                                                           \
         }                                                               \
     }                                                                   \
+    av = float ## s ## _val(a);                                         \
+    bv = float ## s ## _val(b);                                         \
     if (aSign != bSign) {                                               \
         if (ismin) {                                                    \
             return aSign ? a : b;                                       \
-- 
2.13.6
