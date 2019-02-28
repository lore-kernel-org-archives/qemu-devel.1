Received: from eggs.gnu.org ([209.51.188.92]:44140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSKl-0004oo-1D
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSKj-0002Kc-WC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:31:10 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSKh-0002An-20
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:31:08 -0500
Received: by mail-wm1-x334.google.com with SMTP id m1so10555419wml.2
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:31:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:37 +0000
Message-Id: <20190228202537.4638-17-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/16] .travis.yml: add softmmu check-tcg
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 71b3c4a7a3..90c5908ae1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -255,6 +255,12 @@ matrix:
         - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
 
 
+    # Run check-tcg against linux-user
     - env:
         - CONFIG="--disable-system"
         - TEST_CMD="make -j3 check-tcg V=1"
+
+    # Run check-tcg against softmmu targets
+    - env:
+        - CONFIG="--target-list=xtensa-softmmu,arm-softmmu"
+        - TEST_CMD="make -j3 check-tcg V=1"
-- 
2.20.1
