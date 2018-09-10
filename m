Received: from eggs.gnu.org ([2001:4830:134:3::10]:55448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKO-0002y6-7C
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKM-0004fI-3Z
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzDKL-0004eq-UU
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 11:57:15 +0800
Message-Id: <20180910035719.18056-2-famz@redhat.com>
In-Reply-To: <20180910035719.18056-1-famz@redhat.com>
References: <20180910035719.18056-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] docker: Sort Fedora packages
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
Message-Id: <20180818015344.797-2-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 102 ++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
index 7d1d008002..0c4eb9e49c 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,24 +1,90 @@
 FROM fedora:28
 ENV PACKAGES \
-    ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostna=
me \
-    gcc gcc-c++ llvm clang make perl which bc findutils glib2-devel \
-    libaio-devel pixman-devel zlib-devel libfdt-devel libasan libubsan \
-    bluez-libs-devel brlapi-devel bzip2-devel \
-    device-mapper-multipath-devel glusterfs-api-devel gnutls-devel \
-    gtk3-devel libattr-devel libcap-devel libcap-ng-devel libcurl-devel =
\
-    libjpeg-devel libpng-devel librbd-devel libssh2-devel libusbx-devel =
\
-    libxml2-devel lzo-devel ncurses-devel nettle-devel nss-devel \
-    numactl-devel SDL2-devel snappy-devel spice-server-devel \
-    systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-devel \
-    xen-devel \
-    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL2 mingw32-pkg-co=
nfig \
-    mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
-    mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
+    bc \
+    bison \
+    bluez-libs-devel \
+    brlapi-devel \
+    bzip2 \
+    bzip2-devel \
+    ccache \
+    clang \
+    device-mapper-multipath-devel \
+    findutils \
+    flex \
+    gcc \
+    gcc-c++ \
+    gettext \
+    git \
+    glib2-devel \
+    glusterfs-api-devel \
+    gnutls-devel \
+    gtk3-devel \
+    hostname \
+    libaio-devel \
+    libasan \
+    libattr-devel \
+    libcap-devel \
+    libcap-ng-devel \
+    libcurl-devel \
+    libfdt-devel \
+    libjpeg-devel \
+    libpng-devel \
+    librbd-devel \
+    libssh2-devel \
+    libubsan \
+    libusbx-devel \
+    libxml2-devel \
+    llvm \
+    lzo-devel \
+    make \
     mingw32-bzip2 \
-    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL2 mingw64-pkg-co=
nfig \
-    mingw64-gtk3 mingw64-gnutls mingw64-nettle mingw64-libtasn1 \
-    mingw64-libjpeg-turbo mingw64-libpng mingw64-curl mingw64-libssh2 \
-    mingw64-bzip2
+    mingw32-curl \
+    mingw32-glib2 \
+    mingw32-gmp \
+    mingw32-gnutls \
+    mingw32-gtk3 \
+    mingw32-libjpeg-turbo \
+    mingw32-libpng \
+    mingw32-libssh2 \
+    mingw32-libtasn1 \
+    mingw32-nettle \
+    mingw32-pixman \
+    mingw32-pkg-config \
+    mingw32-SDL2 \
+    mingw64-bzip2 \
+    mingw64-curl \
+    mingw64-glib2 \
+    mingw64-gmp \
+    mingw64-gnutls \
+    mingw64-gtk3 \
+    mingw64-libjpeg-turbo \
+    mingw64-libpng \
+    mingw64-libssh2 \
+    mingw64-libtasn1 \
+    mingw64-nettle \
+    mingw64-pixman \
+    mingw64-pkg-config \
+    mingw64-SDL2 \
+    ncurses-devel \
+    nettle-devel \
+    nss-devel \
+    numactl-devel \
+    perl \
+    pixman-devel \
+    python3 \
+    PyYAML \
+    SDL2-devel \
+    snappy-devel \
+    sparse \
+    spice-server-devel \
+    systemtap-sdt-devel \
+    tar \
+    usbredir-devel \
+    virglrenderer-devel \
+    vte3-devel \
+    which \
+    xen-devel \
+    zlib-devel
 ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
=20
 RUN dnf install -y $PACKAGES
--=20
2.17.1
