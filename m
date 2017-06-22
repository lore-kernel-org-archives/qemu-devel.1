Received: from eggs.gnu.org ([2001:4830:134:3::10]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss9-00067m-Vj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss6-0005DR-SG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:33 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:34669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNss6-0005DD-OB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:30 -0400
Received: by mail-qt0-x232.google.com with SMTP id v20so2965015qtg.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:24 -0300
Message-Id: <20170622033231.19344-15-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 14/21] travis: dump config.log if
 ./configure script fails
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 96ddc16cfd..bac5bea744 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -93,7 +93,7 @@ before_script:
   - if [ -x "$(command -v ccache 2>/dev/null)" ]; then export CC="ccache ${CC}"; ccache -s -M 0 -z; fi
   - echo "Using ${PARALLEL_JOBS} parallel jobs"
   - export HOST_CC="${CC}"
-  - ./configure ${CONFIG}
+  - ./configure ${CONFIG} || cat config.log
 script:
   - make -j${PARALLEL_JOBS} && ccache -s
   - ${TEST_CMD}
-- 
2.11.0
