Received: from eggs.gnu.org ([2001:4830:134:3::10]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgv5-0006sl-UC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgv1-00058r-UQ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:47 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgv1-00058O-Nz
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:47:43 -0400
Received: by mail-wr0-x229.google.com with SMTP id 77so138152279wrb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:47:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:48:03 +0100
Message-Id: <20170621144814.15324-11-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/21] docker: add extra libs to armhf target to
 extend codebase coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index ba8d5a5167..e67dfdccc5 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -16,3 +16,14 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        glusterfs-common:armhf \
+        libbz2-dev:armhf \
+        liblzo2-dev:armhf \
+        libncursesw5-dev:armhf \
+        libnfs-dev:armhf \
+        librdmacm-dev:armhf \
+        libsnappy-dev:armhf \
+        libxen-dev:armhf
-- 
2.13.0
