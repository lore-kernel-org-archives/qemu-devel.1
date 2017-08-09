Received: from eggs.gnu.org ([2001:4830:134:3::10]:48612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa2-0006Fu-Od
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa1-0002SI-OC
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:50 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:38861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXa1-0002S1-Jw
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:49 -0400
Received: by mail-qt0-x241.google.com with SMTP id p3so6881933qtg.5
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:10 -0300
Message-Id: <20170809202712.6951-15-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for-2.11 v3 14/16] travis: allow_failures
 for gprof/gcov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 1da542f99f..7c93a10c5f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -87,6 +87,7 @@ before_script:
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
+  fast_finish: true
   include:
     # We manually include builds which we disable "make check" for, they also
     # are the faster jobs (no testing).
@@ -233,3 +234,8 @@ matrix:
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || (cat config.log; exit 1)
+  allow_failures:
+    - env: CONFIG="--enable-gprof --disable-pie"
+      compiler: gcc
+    - env: CONFIG="--enable-gcov --disable-pie"
+      compiler: gcc
-- 
2.13.3
