Received: from eggs.gnu.org ([2001:4830:134:3::10]:33657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGR9-0000WR-Uj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGR9-0004on-4d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:27 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:36497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGR9-0004oa-0V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:27 -0400
Received: by mail-qt0-x22d.google.com with SMTP id 21so4321866qtx.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:32:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:30 -0300
Message-Id: <20170718003159.10200-3-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
Subject: [Qemu-devel] [PATCH v2 02/31] travis: move make -j flag out of
 script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Because global environment variables can be overridden when .travis.yml
is processed by the docker-travis target, the effect of this patch is
that docker-travis now obeys the "J=n" option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.13.2
