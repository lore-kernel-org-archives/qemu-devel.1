Received: from eggs.gnu.org ([2001:4830:134:3::10]:51495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvu-0006jA-B1
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvp-0006li-Sg
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:10 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:41544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsvp-0006hg-MJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:05 -0500
Received: by mail-wm0-x241.google.com with SMTP id g75so20186467wme.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:23:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:40 +0000
Message-Id: <20180109122252.17670-9-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/20] fpu/softfloat: improve comments on
 ARM NaN propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Mention the pseudo-code fragment from which this is based and correct
the spelling of signalling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index de2c5d5702..3d507d8c77 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -445,14 +445,15 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 
 #if defined(TARGET_ARM)
 static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                    flag aIsLargerSignificand)
+                   flag aIsLargerSignificand)
 {
-    /* ARM mandated NaN propagation rules: take the first of:
-     *  1. A if it is signaling
-     *  2. B if it is signaling
+    /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
+     * the first of:
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
2.15.1
