Received: from eggs.gnu.org ([2001:4830:134:3::10]:55487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKT-0003EC-DY
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKS-0004oe-HO
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzDKS-0004nh-CF
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:36 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 11:57:18 +0800
Message-Id: <20180910035719.18056-5-famz@redhat.com>
In-Reply-To: <20180910035719.18056-1-famz@redhat.com>
References: <20180910035719.18056-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] docker: Sort CentOS packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

As recommended in https://docs.docker.com/develop/develop-images/dockerfi=
le_best-practices/#sort-multi-line-arguments

  "This helps to avoid duplication of packages and make the
  list much easier to update."

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180818015344.797-5-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/docke=
rfiles/centos7.docker
index 83462b7205..0a04bfbed8 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -18,10 +18,10 @@ ENV PACKAGES \
     libfdt-devel \
     librdmacm-devel \
     lzo-devel \
-    nettle-devel \
     make \
     mesa-libEGL-devel \
     mesa-libgbm-devel \
+    nettle-devel \
     pixman-devel \
     SDL-devel \
     spice-glib-devel \
--=20
2.17.1
