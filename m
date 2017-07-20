Received: from eggs.gnu.org ([2001:4830:134:3::10]:53348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0H-0004Fk-0g
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0G-0007ks-3A
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:37 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0F-0007jv-Sy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:36 -0400
Received: by mail-wm0-x22b.google.com with SMTP id k69so26968571wmc.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:10 +0100
Message-Id: <20170720150426.12393-8-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 07/23] softfloat3c: f16_to_f128M
 remove unused variable
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

It causes some compilers to complain.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat3c/f16_to_f128M.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fpu/softfloat3c/f16_to_f128M.c b/fpu/softfloat3c/f16_to_f128M.c
index b947ffc08d..12c75d5990 100644
--- a/fpu/softfloat3c/f16_to_f128M.c
+++ b/fpu/softfloat3c/f16_to_f128M.c
@@ -63,7 +63,6 @@ void f16_to_f128M( float16_t a, float128_t *zPtr )
     struct commonNaN commonNaN;
     uint32_t uiZ96;
     struct exp8_sig16 normExpSig;
-    uint64_t frac64;
 
     /*------------------------------------------------------------------------
     *------------------------------------------------------------------------*/
-- 
2.13.0
