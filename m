Received: from eggs.gnu.org ([2001:4830:134:3::10]:55622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVay2-00051P-3J
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVay0-0004Wq-U3
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:30 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVay0-0004WU-P8
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:03:28 -0400
Received: by mail-qt0-x244.google.com with SMTP id v31so5380767qtb.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:03:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 13 Jul 2017 07:03:11 -0300
Message-Id: <20170713100311.20037-3-f4bug@amsat.org>
In-Reply-To: <20170713100311.20037-1-f4bug@amsat.org>
References: <20170713100311.20037-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH RESEND 2/2] travis: use console aliveness
 script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Travis CI has specific time limits for each job, and will stop the build and
add an error message to the build log in the following situation[s]:
- A job produces no log output for 10 minutes

See: https://docs.travis-ci.com/user/customizing-the-build#build-timeouts

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9cfb3..032d111bb4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -45,7 +45,7 @@ notifications:
     on_failure: always
 env:
   global:
-    - TEST_CMD="make check"
+    - TEST_CMD="scripts/aliveness.sh 69 make check"
   matrix:
     - CONFIG=""
     - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
-- 
2.13.2
