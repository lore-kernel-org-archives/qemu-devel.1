Received: from eggs.gnu.org ([2001:4830:134:3::10]:44188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqaW-0000m5-Gu
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqaS-0006PJ-IV
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:30:48 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dKqaS-0006P6-Eq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:30:44 -0400
Received: by mail-qt0-x241.google.com with SMTP id o21so36746228qtb.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 11:30:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Jun 2017 15:30:24 -0300
Message-Id: <20170613183025.5145-2-f4bug@amsat.org>
In-Reply-To: <20170613183025.5145-1-f4bug@amsat.org>
References: <20170613183025.5145-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] docker: Add flex and bison to centos6 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Currently there are warnings about flex and bison being missing when
building in the centos6 image:

    make[1]: flex: Command not found
             BISON dtc-parser.tab.c
    make[1]: bison: Command not found

Add them.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos6.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/dockerfiles/centos6.docker
index 34e0d3b91e..17a4d24d54 100644
--- a/tests/docker/dockerfiles/centos6.docker
+++ b/tests/docker/dockerfiles/centos6.docker
@@ -1,7 +1,7 @@
 FROM centos:6
 RUN yum install -y epel-release
 ENV PACKAGES libfdt-devel ccache \
-    tar git make gcc g++ \
+    tar git make gcc g++ flex bison \
     zlib-devel glib2-devel SDL-devel pixman-devel \
     epel-release
 RUN yum install -y $PACKAGES
-- 
2.11.0
