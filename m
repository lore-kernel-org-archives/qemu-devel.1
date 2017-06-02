Received: from eggs.gnu.org ([2001:4830:134:3::10]:54340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgJ-0001O6-W5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgH-00025Y-4j
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGhgG-00024h-Ur
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Jun 2017 16:11:02 +0800
Message-Id: <20170602081120.3497-5-famz@redhat.com>
In-Reply-To: <20170602081120.3497-1-famz@redhat.com>
References: <20170602081120.3497-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 04/22] docker: Add flex and bison to centos6
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

Currently there are warnings about flex and bison being missing when
building in the centos6 image:

    make[1]: flex: Command not found
             BISON dtc-parser.tab.c
    make[1]: bison: Command not found

Add them.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170524005206.31916-1-famz@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos6.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/centos6.docker b/tests/docker/docke=
rfiles/centos6.docker
index 34e0d3b..17a4d24 100644
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
--=20
2.9.4
