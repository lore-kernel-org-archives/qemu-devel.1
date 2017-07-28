Received: from eggs.gnu.org ([2001:4830:134:3::10]:56967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElM-0007qZ-9P
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElL-0006cV-AO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:44 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:35545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElL-0006c8-5g
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:43 -0400
Received: by mail-ua0-x243.google.com with SMTP id d29so19820857uai.2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:33:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 20:33:16 -0300
Message-Id: <20170728233316.13352-5-f4bug@amsat.org>
In-Reply-To: <20170728233316.13352-1-f4bug@amsat.org>
References: <20170728233316.13352-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] docker: add centos7 image
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
 tests/docker/dockerfiles/centos7.docker | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tests/docker/dockerfiles/centos7.docker

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
new file mode 100644
index 0000000000..0b59aa2f26
--- /dev/null
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -0,0 +1,31 @@
+FROM centos:7
+RUN yum install -y epel-release centos-release-xen
+RUN yum -y update
+ENV PACKAGES \
+    bison \
+    bzip2-devel \
+    ccache \
+    csnappy-devel \
+    flex \
+    g++ \
+    gcc \
+    git \
+    glib2-devel \
+    libepoxy-devel \
+    libfdt-devel \
+    librdmacm-devel \
+    lzo-devel \
+    make \
+    mesa-libEGL-devel \
+    mesa-libgbm-devel \
+    pixman-devel \
+    SDL-devel \
+    spice-glib-devel \
+    spice-server-devel \
+    tar \
+    vte-devel \
+    xen-devel \
+    zlib-devel
+RUN yum install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+
-- 
2.13.3
