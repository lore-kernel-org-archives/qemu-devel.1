Received: from eggs.gnu.org ([2001:4830:134:3::10]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsn-00048g-BP
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsj-0002gB-3S
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:01 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsi-0002g5-Vw
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:13:57 -0400
Received: by mail-qt0-x242.google.com with SMTP id s33so11302299qtg.3
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:13:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:25 -0300
Message-Id: <20170616161334.7492-3-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/11] travis: split building/testing to have
 finer elapsed time
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

to check each step elapsed time on the travis output report.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index d21a2a3602..b2c69fdd59 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -65,7 +65,8 @@ before_install:
 before_script:
   - ./configure ${CONFIG}
 script:
-  - make -j${PARALLEL_JOBS} && ${TEST_CMD}
+  - make -j${PARALLEL_JOBS}
+  - test -z "${TEST_CMD}" || ${TEST_CMD}
 matrix:
   include:
     # Test with CLang for compile portability
-- 
2.11.0
