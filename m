Received: from eggs.gnu.org ([2001:4830:134:3::10]:51571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe4-0002QK-Bb
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe1-0007hy-Uz
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:20 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONe1-0007gp-PO
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:17 -0500
Received: by mail-wr0-x244.google.com with SMTP id g53so17479029wra.2
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:17 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:53 +0000
Message-Id: <20171211125705.16120-8-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 07/19] fpu/softfloat: improve comments on
 ARM NaN propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Mention the pseudo-code fragment from which this is based and correct
the spelling of signalling.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
