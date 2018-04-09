Received: from eggs.gnu.org ([2001:4830:134:3::10]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5p-0007m0-D0
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5o-0002lf-Ec
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f5R5o-0002ks-AF
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  9 Apr 2018 15:19:34 +0800
Message-Id: <20180409071934.20845-5-famz@redhat.com>
In-Reply-To: <20180409071934.20845-1-famz@redhat.com>
References: <20180409071934.20845-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] docker: fedora: test more components
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Install optional dependencies of QEMU to get better coverage.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a00004319e..b706f42405 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,9 +1,16 @@
 FROM fedora:27
 ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
-    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
-    gcc gcc-c++ llvm clang make perl which bc findutils libaio-devel \
-    nettle-devel libasan libubsan \
+    gcc gcc-c++ llvm clang make perl which bc findutils glib2-devel \
+    libaio-devel pixman-devel zlib-devel libfdt-devel libasan libubsan \
+    bluez-libs-devel brlapi-devel bzip2-devel \
+    device-mapper-multipath-devel glusterfs-api-devel gnutls-devel \
+    gtk3-devel libattr-devel libcap-devel libcap-ng-devel libcurl-devel \
+    libjpeg-devel libpng-devel librbd-devel libssh2-devel libusbx-devel \
+    libxml2-devel lzo-devel ncurses-devel nettle-devel nss-devel \
+    numactl-devel SDL2-devel snappy-devel spice-server-devel \
+    systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-devel \
+    xen-devel \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
     mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
     mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
-- 
2.14.3
