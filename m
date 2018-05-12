Received: from eggs.gnu.org ([2001:4830:134:3::10]:33194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHId3-0003uU-FI
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHId2-0002nm-Rk
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:17 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHId2-0002nZ-Lo
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:16 -0400
Received: by mail-pl0-x244.google.com with SMTP id ay10-v6so4144203plb.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:45 -0700
Message-Id: <20180512004311.9299-2-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/27] fpu/softfloat: int_to_float ensure r
 fully initialised
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

From: Alex Bennée <alex.bennee@linaro.org>

Reported by Coverity (CID1390635). We ensure this for uint_to_float
later on so we might as well mirror that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8401b37bd4..b39c0c6fbb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1525,7 +1525,7 @@ FLOAT_TO_UINT(64, 64)
 
 static FloatParts int_to_float(int64_t a, float_status *status)
 {
-    FloatParts r;
+    FloatParts r = {};
     if (a == 0) {
         r.cls = float_class_zero;
         r.sign = false;
-- 
2.17.0
