Received: from eggs.gnu.org ([209.51.188.92]:37481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tJ-0007fP-Dc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tI-0001Fu-Ng
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:05 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3tF-0001Bd-Tv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:03 -0500
Received: by mail-wr1-x429.google.com with SMTP id q18so23235376wrx.9
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:11:00 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:22 +0000
Message-Id: <20190114150129.1013-15-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/21] travis: run tests in verbose mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

Travis sometimes fails a build because it produces no console output for
over 10 minutes. If this is due to a genuine hang, it would be useful to
have used verbose test output to see where it failed. If this is just
due to tests being very slow, having verbose output might allow the
build to succeed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 744dc050d6..39dbda7a0b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -61,7 +61,7 @@ env:
   global:
     - SRC_DIR="."
     - BUILD_DIR="."
-    - TEST_CMD="make check -j3"
+    - TEST_CMD="make check -j3 V=1"
 
 
 git:
@@ -250,6 +250,6 @@ matrix:
 
     - env:
         - CONFIG="--disable-system --disable-docs"
-        - TEST_CMD="make -j3 check-tcg"
+        - TEST_CMD="make -j3 check-tcg V=1"
       dist: trusty
       compiler: gcc
-- 
2.17.1
