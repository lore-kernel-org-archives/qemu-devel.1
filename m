Received: from eggs.gnu.org ([2001:4830:134:3::10]:52018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gNhdj-0004kz-Vf
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <raistlin.df@gmail.com>) id 1gNhdb-0006fl-9F
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:10:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <raistlin.df@gmail.com>)
	id 1gNhda-0006bx-PD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:10:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so8091094wrs.10
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:10:32 -0800 (PST)
From: Dario Faggioli <dfaggioli@suse.com>
Date: Fri, 16 Nov 2018 18:10:46 +0100
Message-ID: <154238824601.3534.13597728205342770469.stgit@wayrath>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: dockerfile for openSUSE Leap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Dockerfile for building an openSUSE Leap container.

Tracks the latest release (at the time of writing this
patch, it is Leap 15).

Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
---
Cc: "Alex Bennée" <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>
Cc: "Philippe Mathieu-Daudé" <f4bug@amsat.org>
---
 tests/docker/dockerfiles/opensuse-leap.docker |   62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 tests/docker/dockerfiles/opensuse-leap.docker

diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
new file mode 100644
index 0000000000..9d00861e66
--- /dev/null
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -0,0 +1,62 @@
+FROM opensuse/leap
+ENV PACKAGES \
+    bc \
+    bison \
+    bluez-devel \
+    brlapi-devel \
+    bzip2 \
+    flex \
+    gcc \
+    gcc-c++ \
+    gettext-tools \
+    git \
+    glib2-devel \
+    glusterfs-devel \
+    gtk3-devel \
+    gtkglext-devel \
+    gzip \
+    hostname \
+    libSDL2-devel \
+    libaio-devel \
+    libasan4 \
+    libcap-devel \
+    libcap-ng-devel \
+    libcurl-devel \
+    libfdt-devel \
+    libgcrypt-devel \
+    libgnutls-devel \
+    libjpeg62-devel \
+    libnettle-devel \
+    libnuma-devel \
+    libpixman-1-0-devel \
+    libpng16-devel \
+    librbd-devel \
+    libspice-server-devel \
+    libssh2-devel \
+    libtasn1-devel \
+    libxml2-devel \
+    lzo-devel \
+    make \
+    ncurses-devel \
+    perl \
+    pkg-config \
+    python3 \
+    python3-PyYAML \
+    snappy-devel \
+    sparse \
+    tar \
+    usbredir-devel \
+    virglrenderer-devel \
+    vte-devel \
+    which \
+    xen-devel
+    zlib-devel \
+ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
+
+ENV LANG en_US.UTF-8
+ENV LANGUAGE en_US:en
+ENV LC_ALL en_US.UTF-8
+
+RUN zypper ref && zypper up -y
+RUN zypper install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
