Received: from eggs.gnu.org ([2001:4830:134:3::10]:37007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXP-0007ru-Lu
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhZXO-0002MV-Vm
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhZXO-0002M8-Pn
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:57:30 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 Aug 2017 18:57:19 +0800
Message-Id: <20170815105721.31893-4-famz@redhat.com>
In-Reply-To: <20170815105721.31893-1-famz@redhat.com>
References: <20170815105721.31893-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] docker: add Xen libs to centos6 image
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
Message-Id: <20170728233316.13352-3-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos6.docker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/docke=
rfiles/centos6.docker
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
--=20
2.13.4
