Received: from eggs.gnu.org ([2001:4830:134:3::10]:46498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0I-0007Q8-NK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0G-00035g-N9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0G-00034O-GO
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:20 -0400
Received: by mail-wr0-x230.google.com with SMTP id w4so22822475wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:43 +0100
Message-Id: <20170718104513.23947-3-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/32] travis: move make -j flag out of script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Because global environment variables can be overridden when .travis.yml
is processed by the docker-travis target, the effect of this patch is
that docker-travis now obeys the "J=n" option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 3c7a5cbe25..f583839755 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,7 @@ notifications:
 env:
   global:
     - TEST_CMD="make check"
+    - MAKEFLAGS="-j3"
   matrix:
     - CONFIG=""
     - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
@@ -64,7 +65,7 @@ before_install:
 before_script:
   - ./configure ${CONFIG}
 script:
-  - make -j3 && ${TEST_CMD}
+  - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
   include:
     # Test with CLang for compile portability
-- 
2.13.0
