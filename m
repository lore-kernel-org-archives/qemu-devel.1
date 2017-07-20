Received: from eggs.gnu.org ([2001:4830:134:3::10]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0I-0004G4-5W
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0H-0007ms-5q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:38 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0G-0007ky-WD
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:37 -0400
Received: by mail-wr0-x231.google.com with SMTP id 12so72092107wrb.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:09 +0100
Message-Id: <20170720150426.12393-7-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 06/23] softfloat3c: silence
 compiler warning
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

While you could pass a 0 size_words to the function it would be a bug.
At least by ensuring the leg is followed it stops the compiler
complaining about a potential uninitialised access.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat3c/s_shiftRightJamM.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat3c/s_shiftRightJamM.c b/fpu/softfloat3c/s_shiftRightJamM.c
index 47ba5ddaf9..035d5d3c1f 100644
--- a/fpu/softfloat3c/s_shiftRightJamM.c
+++ b/fpu/softfloat3c/s_shiftRightJamM.c
@@ -66,7 +66,7 @@ void
         } while ( i );
         ptr = zPtr;
     }
-    if ( wordDist < size_words ) {
+    if ( wordDist <= size_words ) {
         aPtr += indexMultiwordHiBut( size_words, wordDist );
         innerDist = dist & 31;
         if ( innerDist ) {
-- 
2.13.0
