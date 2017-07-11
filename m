Received: from eggs.gnu.org ([2001:4830:134:3::10]:53730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZ9-0000xh-5Q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZ8-00047C-AU
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:23 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZ8-000473-5o
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:22 -0400
Received: by mail-qt0-x241.google.com with SMTP id c20so15134376qte.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:10:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:46 -0300
Message-Id: <20170711031000.24844-5-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 04/18] docker: remove packages now dependent
 of qemu in Stretch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.13.2
