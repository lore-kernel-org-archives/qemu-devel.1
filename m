Received: from eggs.gnu.org ([2001:4830:134:3::10]:55687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeKrq-0003LR-Ag
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eeKrp-0003s9-5d
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:13:30 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eeKro-0003rM-VF
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:13:29 -0500
Received: by mail-wr0-x242.google.com with SMTP id z48so3975381wrz.6
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:13:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 24 Jan 2018 13:13:02 +0000
Message-Id: <20180124131315.30567-10-alex.bennee@linaro.org>
In-Reply-To: <20180124131315.30567-1-alex.bennee@linaro.org>
References: <20180124131315.30567-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/22] fpu/softfloat: improve comments on
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

Mention the pseudo-code fragment from which this is based.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index de2c5d5702..4be0fb21ba 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -445,9 +445,10 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 
 #if defined(TARGET_ARM)
 static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
-                    flag aIsLargerSignificand)
+                   flag aIsLargerSignificand)
 {
-    /* ARM mandated NaN propagation rules: take the first of:
+    /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
+     * the first of:
      *  1. A if it is signaling
      *  2. B if it is signaling
      *  3. A (quiet)
-- 
2.15.1
