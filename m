Received: from eggs.gnu.org ([2001:4830:134:3::10]:36805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KS-0005ra-Os
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KR-000248-C1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:56 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KR-00023Y-5L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:55 -0400
Received: by mail-wm0-x232.google.com with SMTP id f67so86524293wmh.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:48:54 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:27 +0100
Message-Id: <20170717144848.11793-3-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 02/23] travis: move make -j flag out of
 script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Because global environment variables can be overridden when .travis.yml
is processed by the docker-travis target, the effect of this patch is
that docker-travis now obeys the "J=n" option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
