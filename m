Received: from eggs.gnu.org ([2001:4830:134:3::10]:48152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRC-0008PH-Px
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRB-0008Ve-UJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:58 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930]:40270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRB-0008VF-QD
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:53:57 -0400
Received: by mail-ua1-x930.google.com with SMTP id m13-v6so6800375uaq.7
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 18:53:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 17 Aug 2018 22:53:42 -0300
Message-Id: <20180818015344.797-3-f4bug@amsat.org>
In-Reply-To: <20180818015344.797-1-f4bug@amsat.org>
References: <20180818015344.797-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] docker: Sort Fedora packages (i386-cross)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

As recommended in https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#sort-multi-line-arguments

  "This helps to avoid duplication of packages and make the
  list much easier to update. This also makes PRs a lot easier
  to read and review."

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/fedora-i386-cross.docker | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/docker/dockerfiles/fedora-i386-cross.docker
index 8fbef2fa53..a4fd895b07 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -1,14 +1,13 @@
 FROM fedora:latest
 ENV PACKAGES \
     gcc \
-    glibc-static.i686 \
-    glibc-devel.i686 \
-    glib2-devel.i686 \
-    zlib-devel.i686 \
     glib2-devel.i686 \
+    glibc-devel.i686 \
+    glibc-static.i686 \
+    gnutls-devel.i686 \
     nettle-devel.i686 \
     pixman-devel.i686 \
-    gnutls-devel.i686
+    zlib-devel.i686
 
 RUN dnf install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
-- 
2.18.0
