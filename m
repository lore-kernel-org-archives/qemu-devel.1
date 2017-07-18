Received: from eggs.gnu.org ([2001:4830:134:3::10]:46597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0R-0007aM-5N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0O-0003BN-8x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:31 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0O-0003Am-2i
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:28 -0400
Received: by mail-wr0-x22a.google.com with SMTP id a10so23437105wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:49 +0100
Message-Id: <20170718104513.23947-9-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/32] docker: remove packages now dependent of
 qemu in Stretch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index f1bfa64160..6ed12a3f6e 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -19,11 +19,8 @@ ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
 
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        glusterfs-common:arm64 \
         libbz2-dev:arm64 \
         liblzo2-dev:arm64 \
-        libncursesw5-dev:arm64 \
-        libnfs-dev:arm64 \
         librdmacm-dev:arm64 \
         libsnappy-dev:arm64 \
         libxen-dev:arm64
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 2beacef49b..5100b0afc0 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -19,11 +19,8 @@ ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
 
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        glusterfs-common:armhf \
         libbz2-dev:armhf \
         liblzo2-dev:armhf \
-        libncursesw5-dev:armhf \
-        libnfs-dev:armhf \
         librdmacm-dev:armhf \
         libsnappy-dev:armhf \
         libxen-dev:armhf
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 9ee997aa54..eb279c5044 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -20,10 +20,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get build-dep -yy -a mipsel qemu
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        glusterfs-common:mipsel \
         libbz2-dev:mipsel \
         liblzo2-dev:mipsel \
-        libncursesw5-dev:mipsel \
-        libnfs-dev:mipsel \
         librdmacm-dev:mipsel \
         libsnappy-dev:mipsel
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 667e428a4c..e188bfeda4 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -23,10 +23,7 @@ ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 # Install extra libraries to increase code coverage
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        glusterfs-common:s390x \
         libbz2-dev:s390x \
         liblzo2-dev:s390x \
-        libncursesw5-dev:s390x \
-        libnfs-dev:s390x \
         librdmacm-dev:s390x \
         libsnappy-dev:s390x
-- 
2.13.0
