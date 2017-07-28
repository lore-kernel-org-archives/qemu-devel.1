Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElD-0007dA-7v
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElC-0006Vx-9i
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:35 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:38660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElC-0006Vb-5Y
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:34 -0400
Received: by mail-ua0-x243.google.com with SMTP id x24so20935601uah.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:33:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 20:33:13 -0300
Message-Id: <20170728233316.13352-2-f4bug@amsat.org>
In-Reply-To: <20170728233316.13352-1-f4bug@amsat.org>
References: <20170728233316.13352-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] docker: use one package per line in CentOS
 config
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

This ease rebase/cherry-pick, also it is faster to visually find if a package
is here.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/centos6.docker | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/dockerfiles/centos6.docker
index 17a4d24d54..9b91e832c2 100644
--- a/tests/docker/dockerfiles/centos6.docker
+++ b/tests/docker/dockerfiles/centos6.docker
@@ -1,8 +1,18 @@
 FROM centos:6
 RUN yum install -y epel-release
-ENV PACKAGES libfdt-devel ccache \
-    tar git make gcc g++ flex bison \
-    zlib-devel glib2-devel SDL-devel pixman-devel \
-    epel-release
+ENV PACKAGES \
+    bison \
+    ccache \
+    flex \
+    g++ \
+    gcc \
+    git \
+    glib2-devel \
+    libfdt-devel \
+    make \
+    pixman-devel \
+    SDL-devel \
+    tar \
+    zlib-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.13.3
