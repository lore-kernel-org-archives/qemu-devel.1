Received: from eggs.gnu.org ([2001:4830:134:3::10]:36991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXO-0007r3-2g
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXN-0002Lj-Ah
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhZXN-0002LB-4p
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:29 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 18:57:18 +0800
Message-Id: <20170815105721.31893-3-famz@redhat.com>
In-Reply-To: <20170815105721.31893-1-famz@redhat.com>
References: <20170815105721.31893-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] docker: use one package per line in CentOS
 config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This ease rebase/cherry-pick, also it is faster to visually find if a pac=
kage
is here.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170728233316.13352-2-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos6.docker | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/docke=
rfiles/centos6.docker
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
--=20
2.13.4
