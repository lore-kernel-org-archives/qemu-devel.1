Received: from eggs.gnu.org ([2001:4830:134:3::10]:36876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KX-0005xT-GU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KW-00029c-Jz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:01 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KW-00029A-DJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:49:00 -0400
Received: by mail-wr0-x22f.google.com with SMTP id y43so2188572wrd.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:49:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:33 +0100
Message-Id: <20170717144848.11793-9-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 08/23] docker: remove packages now dependent
 of qemu in Stretch
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-arm64-cross.docker  | 3 ---
 tests/docker/dockerfiles/debian-armhf-cross.docker  | 3 ---
 tests/docker/dockerfiles/debian-mipsel-cross.docker | 3 ---
 tests/docker/dockerfiles/debian-s390x-cross.docker  | 3 ---
 4 files changed, 12 deletions(-)

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
index 18fe813aa7..a085943290 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -23,10 +23,7 @@ ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 
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
