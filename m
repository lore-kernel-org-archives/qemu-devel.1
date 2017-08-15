Received: from eggs.gnu.org ([2001:4830:134:3::10]:37020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXR-0007uE-ML
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXQ-0002NU-R7
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhZXQ-0002NC-L2
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 18:57:20 +0800
Message-Id: <20170815105721.31893-5-famz@redhat.com>
In-Reply-To: <20170815105721.31893-1-famz@redhat.com>
References: <20170815105721.31893-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] docker: install more packages on CentOS to
 extend code coverage
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
Message-Id: <20170728233316.13352-4-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos6.docker | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/docke=
rfiles/centos6.docker
index 8588a12eab..f6aae13f29 100644
--- a/tests/docker/dockerfiles/centos6.docker
+++ b/tests/docker/dockerfiles/centos6.docker
@@ -2,17 +2,27 @@ FROM centos:6
 RUN yum install -y epel-release centos-release-xen
 ENV PACKAGES \
     bison \
+    bzip2-devel \
     ccache \
+    csnappy-devel \
     flex \
     g++ \
     gcc \
     git \
     glib2-devel \
+    libepoxy-devel \
     libfdt-devel \
+    librdmacm-devel \
+    lzo-devel \
     make \
+    mesa-libEGL-devel \
+    mesa-libgbm-devel \
     pixman-devel \
     SDL-devel \
+    spice-glib-devel \
+    spice-server-devel \
     tar \
+    vte-devel \
     xen-devel \
     zlib-devel
 RUN yum install -y $PACKAGES
--=20
2.13.4
