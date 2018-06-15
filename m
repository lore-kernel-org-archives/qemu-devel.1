Received: from eggs.gnu.org ([2001:4830:134:3::10]:53924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoX-0000Wy-6p
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoV-0006Wj-UG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:17 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuoV-0006VJ-NO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:15 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l10-v6so11007752wrn.2
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:55:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:47:05 +0100
Message-Id: <20180615194705.28019-55-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 54/54] .travis.yml: add check-tcg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v7
  - explicit build-tcg-prereqs
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

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
