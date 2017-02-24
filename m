Received: from eggs.gnu.org ([2001:4830:134:3::10]:44324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QU-0008Kc-3k
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ch9QT-0000GE-61
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ch9QT-0000G6-0t
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:32:21 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 24 Feb 2017 14:32:05 +0800
Message-Id: <20170224063205.2537-6-famz@redhat.com>
In-Reply-To: <20170224063205.2537-1-famz@redhat.com>
References: <20170224063205.2537-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] docker: Install python2 explicitly in
 docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Python is no longer installed implicitly, but the QEMU build system
requires it. List it in PACKAGES.

Reported-by: Auger Eric <eric.auger@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170222021801.28658-1-famz@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 478163b..c4f80ad 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,6 +1,6 @@
 FROM fedora:latest
 ENV PACKAGES \
-    ccache git tar PyYAML sparse flex bison \
+    ccache git tar PyYAML sparse flex bison python2 \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
-- 
2.9.3
