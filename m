Received: from eggs.gnu.org ([2001:4830:134:3::10]:49186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evihK-0002m7-P8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evihG-0002D9-Qe
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:06:30 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evihG-0002Cs-Ig
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:06:26 -0400
Received: by mail-wr0-x242.google.com with SMTP id m12so21893527wrm.13
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:06:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:05:52 +0100
Message-Id: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: fedora: test more components
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Install optional dependencies of QEMU to get better coverage.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 994a35a..0d9da45 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,9 +1,16 @@
 FROM fedora:27
 ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
-    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
-    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
-    nettle-devel libasan libubsan \
+    gcc gcc-c++ clang make perl which bc findutils glib2-devel \
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
1.8.3.1
