Received: from eggs.gnu.org ([2001:4830:134:3::10]:46039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4z-0004eN-LN
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4u-0007dE-1F
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:02:01 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:52206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVJ4t-0007co-RH
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:55 -0400
Received: by mail-wm0-x236.google.com with SMTP id r15-v6so1270175wmc.1
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:01:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:35 +0100
Message-Id: <20180619154435.18898-57-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 56/56] .travis.yml: add check-tcg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v7
  - explicit build-tcg-prereqs

diff --git a/.travis.yml b/.travis.yml
index fabfe9ec34..ad352c5784 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -153,3 +153,11 @@ matrix:
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
+    - env:
+        - CONFIG="--disable-system --disable-docs"
+        - TEST_CMD="make check-tcg"
+      script:
+        - make ${MAKEFLAGS} build-tcg-prereqs && ${TEST_CMD}
+      sudo: required
+      dist: trusty
+      compiler: gcc
-- 
2.17.1
