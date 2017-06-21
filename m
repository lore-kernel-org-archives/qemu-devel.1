Received: from eggs.gnu.org ([2001:4830:134:3::10]:39175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgzy-0003rO-0i
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgzw-0007nL-Tf
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:50 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgzw-0007mx-N0
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:48 -0400
Received: by mail-wr0-x232.google.com with SMTP id y25so99076920wrd.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:52:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:48:05 +0100
Message-Id: <20170621144814.15324-13-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/21] docker: add extra libs to s390x target to
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

diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 3a687feda0..cfc354ce5d 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -20,3 +20,13 @@ RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive \
+    apt-get install -y --no-install-recommends \
+        glusterfs-common:s390x \
+        libbz2-dev:s390x \
+        liblzo2-dev:s390x \
+        libncursesw5-dev:s390x \
+        libnfs-dev:s390x \
+        librdmacm-dev:s390x \
+        libsnappy-dev:s390x
-- 
2.13.0
