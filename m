Received: from eggs.gnu.org ([2001:4830:134:3::10]:45162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkJ-0002S3-Vc
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkI-00009Q-KL
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:47 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffFkI-00009B-EW
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:29:46 -0400
Received: by mail-ua0-x243.google.com with SMTP id g18-v6so13408376uam.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:29:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:29:24 -0300
Message-Id: <20180717022924.25428-5-f4bug@amsat.org>
In-Reply-To: <20180717022924.25428-1-f4bug@amsat.org>
References: <20180717022924.25428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/4] docker: Add many libraries to the
 'host-cross' image
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
To avoid some problem with Docker permissions on NUMA systems,
the libnuma-dev package is deliberately not installed (yet).
---
 .../dockerfiles/debian-host-cross.docker      | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-host-cross.docker b/tests/docker/dockerfiles/debian-host-cross.docker
index 17d937efc9..89ca0a4daf 100644
--- a/tests/docker/dockerfiles/debian-host-cross.docker
+++ b/tests/docker/dockerfiles/debian-host-cross.docker
@@ -15,11 +15,46 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
+        libaio-dev \
+        libasound2-dev \
+        libattr1-dev \
+        libbluetooth-dev \
+        libbrlapi-dev \
         libbz2-dev \
+        libcacard-dev \
+        libcap-dev \
+        libcap-ng-dev \
+        libcapstone-dev \
+        libcurl4-gnutls-dev \
+        libepoxy-dev \
+        libfdt-dev \
+        libibverbs-dev \
+        libiscsi-dev \
+        libjemalloc-dev \
+        libjpeg-dev \
+        liblttng-ust-dev \
         liblzo2-dev \
+        libncursesw5-dev \
+        libnfs-dev \
+        libnss3-dev \
+        libpixman-1-dev \
+        libpulse-dev \
+        librados-dev \
+        librbd-dev \
         librdmacm-dev \
+        libseccomp-dev \
         libsnappy-dev \
-        libvte-dev
+        libspice-protocol-dev \
+        libssh2-1-dev \
+        liburcu-dev \
+        libusb-1.0-0-dev \
+        libusbredirhost-dev \
+        libusbredirparser-dev \
+        libvdeplug-dev \
+        libvte-dev \
+        libxen-dev \
+        uuid-dev \
+        xfslibs-dev
 
 # virgl
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.18.0
