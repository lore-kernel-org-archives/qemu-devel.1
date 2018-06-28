Received: from eggs.gnu.org ([2001:4830:134:3::10]:52496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4Z-0007Di-GJ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4W-0003uc-FG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:07 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:40133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4W-0003u3-9s
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:04 -0400
Received: by mail-qt0-x229.google.com with SMTP id s47-v6so5314974qth.7
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:47:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:37 -0300
Message-Id: <20180628164643.9668-3-f4bug@amsat.org>
In-Reply-To: <20180628164643.9668-1-f4bug@amsat.org>
References: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/8] docker: ubuntu: Use SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Do not test the deprecated API versions (see cabd35840749d).
Debian MXE MinGW cross images are already using SDL2.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/ubuntu.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index c03520ce3f..7d724e7f53 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -5,7 +5,7 @@ ENV PACKAGES flex bison \
     libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
     libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
     libspice-protocol-dev libnss3-dev libfdt-dev \
-    libgtk-3-dev libvte-2.91-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
+    libgtk-3-dev libvte-2.91-dev libsdl2-dev libpng12-dev libpixman-1-dev \
     libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev libibverbs-dev \
     libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-dev libcurl4-gnutls-dev \
     libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
@@ -15,4 +15,4 @@ ENV PACKAGES flex bison \
 RUN apt-get update && \
     apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
-ENV FEATURES clang pyyaml
+ENV FEATURES clang pyyaml sdl2
-- 
2.18.0
