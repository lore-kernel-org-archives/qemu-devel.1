Received: from eggs.gnu.org ([2001:4830:134:3::10]:55421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsh-00047e-6F
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsg-0002fm-AG
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:55 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsg-0002fg-6Z
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:54 -0400
Received: by mail-qt0-x244.google.com with SMTP id w1so11250132qtg.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:13:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:24 -0300
Message-Id: <20170616161334.7492-2-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/11] travis: build using all available cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

no improvement as of today, but if Travis release their limit on the opensource
plan or upgrade their hardware the builds will get some benefit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9cfb3..d21a2a3602 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -45,6 +45,7 @@ notifications:
     on_failure: always
 env:
   global:
+    - PARALLEL_JOBS="$(($(getconf _NPROCESSORS_ONLN) + 1))"
     - TEST_CMD="make check"
   matrix:
     - CONFIG=""
@@ -64,7 +65,7 @@ before_install:
 before_script:
   - ./configure ${CONFIG}
 script:
-  - make -j3 && ${TEST_CMD}
+  - make -j${PARALLEL_JOBS} && ${TEST_CMD}
 matrix:
   include:
     # Test with CLang for compile portability
-- 
2.11.0
