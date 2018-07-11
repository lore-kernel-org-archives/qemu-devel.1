Received: from eggs.gnu.org ([2001:4830:134:3::10]:39420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd951-0008GE-D8
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fd94y-0004Uw-Bq
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:58:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fd94y-0004UU-7g
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 02:58:24 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 11 Jul 2018 14:58:13 +0800
Message-Id: <20180711065813.14894-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: Install more packages in centos7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This makes test-block work.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 575de29a0a..83462b7205 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -3,6 +3,7 @@ RUN yum install -y epel-release centos-release-xen
 RUN yum -y update
 ENV PACKAGES \
     bison \
+    bzip2 \
     bzip2-devel \
     ccache \
     csnappy-devel \
@@ -12,10 +13,12 @@ ENV PACKAGES \
     gettext \
     git \
     glib2-devel \
+    libaio-devel \
     libepoxy-devel \
     libfdt-devel \
     librdmacm-devel \
     lzo-devel \
+    nettle-devel \
     make \
     mesa-libEGL-devel \
     mesa-libgbm-devel \
-- 
2.17.1
