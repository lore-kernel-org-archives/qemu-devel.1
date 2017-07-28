Received: from eggs.gnu.org ([2001:4830:134:3::10]:56913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElG-0007kJ-Pp
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElG-0006Y9-0b
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:38 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dbElF-0006Xs-Rh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:33:37 -0400
Received: by mail-ua0-x241.google.com with SMTP id d29so19820817uai.2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:33:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 20:33:14 -0300
Message-Id: <20170728233316.13352-3-f4bug@amsat.org>
In-Reply-To: <20170728233316.13352-1-f4bug@amsat.org>
References: <20170728233316.13352-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] docker: add Xen libs to centos6 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Olaf Hering <olaf@aepfle.de>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/centos6.docker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/dockerfiles/centos6.docker
index 9b91e832c2..8588a12eab 100644
--- a/tests/docker/dockerfiles/centos6.docker
+++ b/tests/docker/dockerfiles/centos6.docker
@@ -1,5 +1,5 @@
 FROM centos:6
-RUN yum install -y epel-release
+RUN yum install -y epel-release centos-release-xen
 ENV PACKAGES \
     bison \
     ccache \
@@ -13,6 +13,7 @@ ENV PACKAGES \
     pixman-devel \
     SDL-devel \
     tar \
+    xen-devel \
     zlib-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.13.3
