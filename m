Received: from eggs.gnu.org ([2001:4830:134:3::10]:41841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32ld-0002d1-Qk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lb-0006da-M6
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:57 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:45927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lb-0006cy-Fk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:55 -0400
Received: by mail-wr0-x236.google.com with SMTP id k7so1417671wre.2
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:18 +0100
Message-Id: <20171013162438.32458-11-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 10/30] softfloat: improve comments on ARM
 NaN propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Mention the pseudo-code fragment from which this is based and correct
the spelling of signalling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat-specialize.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index c8282b8bf7..2ccd4abe11 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -445,14 +445,14 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 
 #if defined(TARGET_ARM)
 static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                    flag aIsLargerSignificand)
+                   flag aIsLargerSignificand)
 {
-    /* ARM mandated NaN propagation rules: take the first of:
-     *  1. A if it is signaling
-     *  2. B if it is signaling
+    /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take the first of:
+     *  1. A if it is signalling
+     *  2. B if it is signalling
      *  3. A (quiet)
      *  4. B (quiet)
-     * A signaling NaN is always quietened before returning it.
+     * A signalling NaN is always quietened before returning it.
      */
     if (aIsSNaN) {
         return 0;
-- 
2.14.1
