Received: from eggs.gnu.org ([2001:4830:134:3::10]:55552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD81-00036p-KV
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD80-0004J4-QW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:37 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD80-0004H7-LA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:12:36 -0400
Received: by mail-wm0-x22c.google.com with SMTP id k69so27176765wmc.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:12:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:25 +0100
Message-Id: <20170720150426.12393-23-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 22/23] fpu/softfloat2a: improve
 comments on ARM NaN propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Mention the pseudo-code fragment from which this is based and correct
the spelling of signalling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat2a/softfloat-specialize.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat2a/softfloat-specialize.h b/fpu/softfloat2a/softfloat-specialize.h
index c8282b8bf7..2ccd4abe11 100644
--- a/fpu/softfloat2a/softfloat-specialize.h
+++ b/fpu/softfloat2a/softfloat-specialize.h
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
2.13.0
