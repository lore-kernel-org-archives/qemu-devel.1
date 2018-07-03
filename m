Received: from eggs.gnu.org ([2001:4830:134:3::10]:44866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISr-0004bk-CF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISq-0004ZN-ET
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:17 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:44656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faISq-0004Z4-7b
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:16 -0400
Received: by mail-wr0-x232.google.com with SMTP id p12-v6so1381304wrn.11
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:23:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:37 +0100
Message-Id: <20180703101444.23778-14-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/20] docker: ubuntu: Use SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Do not test the deprecated API versions (see cabd35840749d).
Debian MXE MinGW cross images are already using SDL2.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
2.17.1
