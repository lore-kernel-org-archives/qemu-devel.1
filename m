Received: from eggs.gnu.org ([2001:4830:134:3::10]:55465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKP-000311-DX
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzDKO-0004im-IK
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fzDKO-0004i2-Dv
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 23:57:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 11:57:16 +0800
Message-Id: <20180910035719.18056-3-famz@redhat.com>
In-Reply-To: <20180910035719.18056-1-famz@redhat.com>
References: <20180910035719.18056-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] docker: Sort Fedora packages (i386-cross)
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
  list much easier to update. This also makes PRs a lot easier
  to read and review."

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180818015344.797-3-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora-i386-cross.docker | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/do=
cker/dockerfiles/fedora-i386-cross.docker
index 8fbef2fa53..a4fd895b07 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -1,14 +1,13 @@
 FROM fedora:latest
 ENV PACKAGES \
     gcc \
-    glibc-static.i686 \
+    glib2-devel.i686 \
     glibc-devel.i686 \
-    glib2-devel.i686 \
-    zlib-devel.i686 \
-    glib2-devel.i686 \
+    glibc-static.i686 \
+    gnutls-devel.i686 \
     nettle-devel.i686 \
     pixman-devel.i686 \
-    gnutls-devel.i686
+    zlib-devel.i686
=20
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
--=20
2.17.1
