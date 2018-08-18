Received: from eggs.gnu.org ([2001:4830:134:3::10]:48163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRF-0008TK-LK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRE-00005L-Kg
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:54:01 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932]:40272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRE-000054-GF
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:54:00 -0400
Received: by mail-ua1-x932.google.com with SMTP id m13-v6so6800401uaq.7
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 18:54:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 17 Aug 2018 22:53:43 -0300
Message-Id: <20180818015344.797-4-f4bug@amsat.org>
In-Reply-To: <20180818015344.797-1-f4bug@amsat.org>
References: <20180818015344.797-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] docker: Sort Ubuntu packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

As recommended in https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#sort-multi-line-arguments

  "This helps to avoid duplication of packages and make the
  list much easier to update. This also makes PRs a lot easier
  to read and review."

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/ubuntu.docker | 61 ++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 7d724e7f53..36e2b17de5 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -2,16 +2,59 @@ FROM ubuntu:16.04
 RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
     /etc/apt/sources.list
 ENV PACKAGES flex bison \
-    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
-    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
-    libspice-protocol-dev libnss3-dev libfdt-dev \
-    libgtk-3-dev libvte-2.91-dev libsdl2-dev libpng12-dev libpixman-1-dev \
-    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev libibverbs-dev \
-    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-dev libcurl4-gnutls-dev \
-    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
-    libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
+    ccache \
+    clang \
+    gcc \
+    gettext \
+    git \
+    glusterfs-common \
+    libaio-dev \
+    libattr1-dev \
+    libbluetooth-dev \
+    libbrlapi-dev \
+    libbz2-dev \
+    libcacard-dev \
+    libcap-dev \
+    libcap-ng-dev \
+    libcurl4-gnutls-dev \
+    libdrm-dev \
+    libepoxy-dev \
+    libfdt-dev \
+    libgbm-dev \
+    libgnutls-dev \
+    libgtk-3-dev \
+    libibverbs-dev \
+    libiscsi-dev \
+    libjemalloc-dev \
+    libjpeg-turbo8-dev \
+    liblzo2-dev \
+    libncurses5-dev \
+    libncursesw5-dev \
+    libnfs-dev \
+    libnss3-dev \
+    libnuma-dev \
+    libpixman-1-dev \
+    libpng12-dev \
+    librados-dev \
+    librbd-dev \
+    librdmacm-dev \
+    libsasl2-dev \
+    libsdl2-dev \
+    libseccomp-dev \
+    libsnappy-dev \
+    libspice-protocol-dev \
+    libspice-server-dev \
+    libssh2-1-dev \
+    libusb-1.0-0-dev \
+    libusbredirhost-dev \
+    libvdeplug-dev \
+    libvte-2.91-dev \
+    libxen-dev \
+    make \
+    python-yaml \
+    sparse \
     texinfo \
-    gettext git make ccache python-yaml gcc clang sparse
+    xfslibs-dev
 RUN apt-get update && \
     apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
-- 
2.18.0
