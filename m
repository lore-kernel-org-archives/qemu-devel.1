Received: from eggs.gnu.org ([2001:4830:134:3::10]:49349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpxYD-0007O1-M8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpxY8-00027M-LP
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:13:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpxY8-00026W-Fp
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:12:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 22:12:44 +0800
Message-Id: <20170907141245.31946-2-famz@redhat.com>
In-Reply-To: <20170907141245.31946-1-famz@redhat.com>
References: <20170907141245.31946-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] docker: Update ubuntu image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Base on the newer ubuntu-lts (16.06) and include more packages for
better build coverage.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/ubuntu.docker | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index a360a050a2..d73ce02246 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -1,12 +1,17 @@
-FROM ubuntu:14.04
+FROM ubuntu:16.04
 RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiverse" >> \
     /etc/apt/sources.list
 RUN apt-get update
 ENV PACKAGES flex bison \
-    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev \
+    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
     libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
     libspice-protocol-dev libnss3-dev libfdt-dev \
-    libgtk-3-dev libvte-2.90-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
+    libgtk-3-dev libvte-2.91-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
+    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev libibverbs-dev \
+    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-dev libcurl4-gnutls-dev \
+    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
+    libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
+    texinfo \
     git make ccache python-yaml gcc clang sparse
 RUN apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
-- 
2.13.5
