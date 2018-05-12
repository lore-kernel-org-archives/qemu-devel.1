Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHIdB-0004E3-1d
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHId9-0002pw-7N
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:25 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHId9-0002pb-2R
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:23 -0400
Received: by mail-pg0-x244.google.com with SMTP id n1-v6so3086407pgs.2
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:49 -0700
Message-Id: <20180512004311.9299-6-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/27] fpu/softfloat: Move
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bc0f52fa54..353893aaea 100644
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
@@ -247,6 +237,16 @@ typedef struct {
     uint64_t roundeven_mask;
 } FloatFmt;
 
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
 /* Expand fields based on the size of exponent and fraction */
 #define FLOAT_PARAMS(E, F)                                           \
     .exp_size       = E,                                             \
-- 
2.17.0
