Received: from eggs.gnu.org ([2001:4830:134:3::10]:48130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRA-0008ON-65
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqR9-0008UD-5r
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:56 -0400
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:41394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqR9-0008Tx-22
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:55 -0400
Received: by mail-vk0-x235.google.com with SMTP id j14-v6so65676vke.8
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 18:53:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 17 Aug 2018 22:53:41 -0300
Message-Id: <20180818015344.797-2-f4bug@amsat.org>
In-Reply-To: <20180818015344.797-1-f4bug@amsat.org>
References: <20180818015344.797-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] docker: Sort Fedora packages
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
 tests/docker/dockerfiles/fedora.docker | 102 ++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 7d1d008002..0c4eb9e49c 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,24 +1,90 @@
 FROM fedora:28
 ENV PACKAGES \
-    ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
-    gcc gcc-c++ llvm clang make perl which bc findutils glib2-devel \
-    libaio-devel pixman-devel zlib-devel libfdt-devel libasan libubsan \
-    bluez-libs-devel brlapi-devel bzip2-devel \
-    device-mapper-multipath-devel glusterfs-api-devel gnutls-devel \
-    gtk3-devel libattr-devel libcap-devel libcap-ng-devel libcurl-devel \
-    libjpeg-devel libpng-devel librbd-devel libssh2-devel libusbx-devel \
-    libxml2-devel lzo-devel ncurses-devel nettle-devel nss-devel \
-    numactl-devel SDL2-devel snappy-devel spice-server-devel \
-    systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-devel \
-    xen-devel \
-    mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL2 mingw32-pkg-config \
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
-    mingw64-pixman mingw64-glib2 mingw64-gmp mingw64-SDL2 mingw64-pkg-config \
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
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
 RUN dnf install -y $PACKAGES
-- 
2.18.0
