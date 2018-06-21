Received: from eggs.gnu.org ([2001:4830:134:3::10]:54333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8P-0005eb-0M
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8M-0003i2-KO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:57 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt8M-0003hV-DL
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:54 -0400
Received: by mail-wm0-x22a.google.com with SMTP id v131-v6so3650302wma.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:31:54 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:26:05 +0100
Message-Id: <20180621062605.941-58-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 57/57] .travis.yml: add check-tcg test
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

diff --git a/.travis.yml b/.travis.yml
index fabfe9ec34..bd66c18fed 100644
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
+        - make ${MAKEFLAGS} && ${TEST_CMD} ${MAKEFLAGS}
+      sudo: required
+      dist: trusty
+      compiler: gcc
-- 
2.17.1
