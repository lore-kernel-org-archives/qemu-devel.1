Received: from eggs.gnu.org ([2001:4830:134:3::10]:52393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhl-0007oW-Vn
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhl-0007Qj-0K
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:29 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILhk-0007Om-RG
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:28 -0400
Received: by mail-pg0-x244.google.com with SMTP id v7-v6so3276339pgs.0
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:11:55 -0700
Message-Id: <20180514221219.7091-5-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 04/28] fpu/softfloat: Move
 softfloat-specialize.h below FloatParts definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

We want to be able to specialize on the canonical representation.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index d07419324a..0d17027379 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -95,16 +95,6 @@ this code that are retained.
 *----------------------------------------------------------------------------*/
 #include "fpu/softfloat-macros.h"
 
-/*----------------------------------------------------------------------------
-| Functions and definitions to determine:  (1) whether tininess for underflow
-| is detected before or after rounding by default, (2) what (if anything)
-| happens when exceptions are raised, (3) how signaling NaNs are distinguished
-| from quiet NaNs, (4) the default generated quiet NaNs, and (5) how NaNs
-| are propagated from function inputs to output.  These details are target-
-| specific.
-*----------------------------------------------------------------------------*/
-#include "softfloat-specialize.h"
-
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the half-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
@@ -322,6 +312,16 @@ static inline float64 float64_pack_raw(FloatParts p)
     return make_float64(pack_raw(float64_params, p));
 }
 
+/*----------------------------------------------------------------------------
+| Functions and definitions to determine:  (1) whether tininess for underflow
+| is detected before or after rounding by default, (2) what (if anything)
+| happens when exceptions are raised, (3) how signaling NaNs are distinguished
+| from quiet NaNs, (4) the default generated quiet NaNs, and (5) how NaNs
+| are propagated from function inputs to output.  These details are target-
+| specific.
+*----------------------------------------------------------------------------*/
+#include "softfloat-specialize.h"
+
 /* Canonicalize EXP and FRAC, setting CLS.  */
 static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
                                float_status *status)
-- 
2.17.0
