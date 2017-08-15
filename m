Received: from eggs.gnu.org ([2001:4830:134:3::10]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXV-0007y4-Rn
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXS-0002Od-Qv
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhZXS-0002OA-KR
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:34 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 18:57:21 +0800
Message-Id: <20170815105721.31893-6-famz@redhat.com>
In-Reply-To: <20170815105721.31893-1-famz@redhat.com>
References: <20170815105721.31893-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] docker: add centos7 image
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170728233316.13352-5-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 31 +++++++++++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)
 create mode 100644 tests/docker/dockerfiles/centos7.docker

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/docke=
rfiles/centos7.docker
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
--=20
2.13.4
