Received: from eggs.gnu.org ([2001:4830:134:3::10]:51969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGpY-00061Z-0D
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGpU-0006mY-NY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:49:24 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:54307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRGpU-0006lq-Gt
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:49:20 -0400
Received: by mail-wm0-x231.google.com with SMTP id o13-v6so3130821wmf.4
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:49:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 13:33:07 +0100
Message-Id: <20180608123307.24773-50-alex.bennee@linaro.org>
In-Reply-To: <20180608123307.24773-1-alex.bennee@linaro.org>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 49/49] .travis.yml: add check-tcg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 814be151f4..f1d2d9edec 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -152,3 +152,9 @@ matrix:
         - TEST_CMD=""
       before_script:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
+    - env:
+        - CONFIG="--disable-system --disable-docs"
+        - TEST_CMD="make check-tcg"
+      sudo: required
+      dist: trusty
+      compiler: gcc
-- 
2.17.1
