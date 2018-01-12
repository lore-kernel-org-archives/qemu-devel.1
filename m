Received: from eggs.gnu.org ([2001:4830:134:3::10]:44048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZymm-0005IO-GI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZyml-0007Ke-DB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:16 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:46304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZyml-0007KP-86
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:50:15 -0500
Received: by mail-qt0-x242.google.com with SMTP id r39so5849543qtr.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 04:50:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Jan 2018 09:49:56 -0300
Message-Id: <20180112125000.27256-4-f4bug@amsat.org>
In-Reply-To: <20180112125000.27256-1-f4bug@amsat.org>
References: <20180112125000.27256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/7] docker: add the Ubuntu Trusty base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

based on QEMU v2.10 ubuntu.docker (ca853f0c76e3 and 2346b12fc52d)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/ubuntu14.04.docker | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 tests/docker/dockerfiles/ubuntu14.04.docker

diff --git a/tests/docker/dockerfiles/ubuntu14.04.docker b/tests/docker/dockerfiles/ubuntu14.04.docker
new file mode 100644
index 0000000000..cd24e759a7
--- /dev/null
+++ b/tests/docker/dockerfiles/ubuntu14.04.docker
@@ -0,0 +1,17 @@
+FROM ubuntu:14.04
+RUN apt-get update
+ENV PACKAGES flex bison \
+    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
+    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
+    libspice-protocol-dev libnss3-dev libfdt-dev \
+    libgtk-3-dev libvte-2.90-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
+    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev libibverbs-dev \
+    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-dev libcurl4-gnutls-dev \
+    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
+    libjemalloc-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
+    texinfo dpkg-dev \
+    gettext git make ccache python-yaml gcc clang sparse
+RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install $PACKAGES
+RUN dpkg -l $PACKAGES | sort > /packages.txt
+ENV FEATURES clang pyyaml
+ENV QEMU_CONFIGURE_OPTS --disable-opengl
-- 
2.15.1
