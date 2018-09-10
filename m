Received: from eggs.gnu.org ([2001:4830:134:3::10]:55476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKR-00038u-SC
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKQ-0004lS-NL
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzDKQ-0004kl-Hs
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:34 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 11:57:17 +0800
Message-Id: <20180910035719.18056-4-famz@redhat.com>
In-Reply-To: <20180910035719.18056-1-famz@redhat.com>
References: <20180910035719.18056-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] docker: Sort Ubuntu packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

As recommended in https://docs.docker.com/develop/develop-images/dockerfi=
le_best-practices/#sort-multi-line-arguments

  "This helps to avoid duplication of packages and make the
  list much easier to update. This also makes PRs a lot easier
  to read and review."

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180818015344.797-4-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/ubuntu.docker | 61 ++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
index 7d724e7f53..36e2b17de5 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -2,16 +2,59 @@ FROM ubuntu:16.04
 RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiver=
se" >> \
     /etc/apt/sources.list
 ENV PACKAGES flex bison \
-    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncurse=
sw5-dev \
-    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
-    libspice-protocol-dev libnss3-dev libfdt-dev \
-    libgtk-3-dev libvte-2.91-dev libsdl2-dev libpng12-dev libpixman-1-de=
v \
-    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librd=
macm-dev libibverbs-dev \
-    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-=
dev libcurl4-gnutls-dev \
-    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev =
libepoxy-dev libdrm-dev libgbm-dev \
-    libjemalloc-dev libcacard-dev libusbredirhost-dev libnfs-dev libcap-=
dev libattr1-dev \
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
--=20
2.17.1
