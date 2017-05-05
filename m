Received: from eggs.gnu.org ([2001:4830:134:3::10]:59689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6TqW-0007Nh-KG
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6TqV-0007qf-Q2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6TqV-0007qD-Kl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:23:55 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  5 May 2017 11:23:37 +0800
Message-Id: <20170505032340.26467-3-famz@redhat.com>
In-Reply-To: <20170505032340.26467-1-famz@redhat.com>
References: <20170505032340.26467-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] docker: Add bzip2 and hostname to fedora
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
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

It is used by qemu-iotests.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index c4f80ad..39f6b58 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,6 +1,6 @@
 FROM fedora:latest
 ENV PACKAGES \
-    ccache git tar PyYAML sparse flex bison python2 \
+    ccache git tar PyYAML sparse flex bison python2 bzip2 hostname \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
-- 
2.9.3
