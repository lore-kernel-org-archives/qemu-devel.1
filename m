Received: from eggs.gnu.org ([2001:4830:134:3::10]:56475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwP-00074o-6b
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwO-0007kO-5w
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:09 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1foAwO-0007jL-0f
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:08 -0400
Received: by mail-wm0-x243.google.com with SMTP id c14-v6so2634992wmb.4
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:11:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Aug 2018 18:11:01 +0100
Message-Id: <20180810171102.16451-4-alex.bennee@linaro.org>
In-Reply-To: <20180810171102.16451-1-alex.bennee@linaro.org>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/3] .travis.yml: ensure we support C99 on
 old compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The default Travis gcc is so old it default to -std=gnu89 which will
fall over on some c99ism you are allowed to use in the QEMU source
tree. As we also use some GNU extensions make it -std=gnu99 instead of
-std=c99.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 95be6ec59f..9c61750be0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -72,7 +72,7 @@ before_install:
   - git submodule update --init --recursive capstone dtc ui/keycodemapdb
 before_script:
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
-  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
+  - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=-std=gnu99 || { cat config.log && exit 1; }
 script:
   - make ${MAKEFLAGS} && ${TEST_CMD}
 matrix:
-- 
2.17.1
