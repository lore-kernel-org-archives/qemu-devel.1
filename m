Received: from eggs.gnu.org ([2001:4830:134:3::10]:39605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabm-0003py-Hz
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabg-0002oW-Ok
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabg-0002nB-HO
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabd-0001N9-EX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:09 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:06:52 +0100
Message-Id: <20180515140707.15957-2-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/16] fpu/softfloat: int_to_float ensure r
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

From: Alex Bennée <alex.bennee@linaro.org>

Reported by Coverity (CID1390635). We ensure this for uint_to_float
later on so we might as well mirror that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
