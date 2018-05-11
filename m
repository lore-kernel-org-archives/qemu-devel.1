Received: from eggs.gnu.org ([2001:4830:134:3::10]:51944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA6-00079L-Rv
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGwA6-0004oX-6d
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:54 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:44250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGwA6-0004o8-1n
	for qemu-devel@nongnu.org; Thu, 10 May 2018 20:43:54 -0400
Received: by mail-pg0-x241.google.com with SMTP id x145-v6so1673335pgx.11
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:43:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 17:43:29 -0700
Message-Id: <20180511004345.26708-4-richard.henderson@linaro.org>
In-Reply-To: <20180511004345.26708-1-richard.henderson@linaro.org>
References: <20180511004345.26708-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/19] fpu/softfloat: Move
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e7c8213a5e..5e4982b035 100644
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
@@ -241,6 +231,16 @@ typedef struct {
     bool arm_althp;
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
