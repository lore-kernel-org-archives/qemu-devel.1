Received: from eggs.gnu.org ([2001:4830:134:3::10]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5V-0002Ek-Ft
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5S-0004SH-5J
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:13 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGi5R-0004Rd-Vc
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:10 -0400
Received: by mail-wr0-x243.google.com with SMTP id v5-v6so1326837wrf.9
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 02:42:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 May 2018 10:42:02 +0100
Message-Id: <20180510094206.15354-2-alex.bennee@linaro.org>
In-Reply-To: <20180510094206.15354-1-alex.bennee@linaro.org>
References: <20180510094206.15354-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/5] fpu/softfloat: int_to_float ensure r
 fully initialised
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Reported by Coverity (CID1390635). We ensure this for uint_to_float
later on so we might as well mirror that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 70e0c40a1c..3adf6a06e4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1517,7 +1517,7 @@ FLOAT_TO_UINT(64, 64)
 
 static FloatParts int_to_float(int64_t a, float_status *status)
 {
-    FloatParts r;
+    FloatParts r = {};
     if (a == 0) {
         r.cls = float_class_zero;
         r.sign = false;
-- 
2.17.0
