Received: from eggs.gnu.org ([2001:4830:134:3::10]:54628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYG-0004kY-2w
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYF-0006Oz-7x
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnNYF-0006On-1W
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 31 Aug 2017 19:22:09 +0800
Message-Id: <20170831112210.19921-3-famz@redhat.com>
In-Reply-To: <20170831112210.19921-1-famz@redhat.com>
References: <20170831112210.19921-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] docker: Add nettle-devel to fedora image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The LUKS cases in qemu-iotests requires this.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 4eaa8ed2a5..27e8201c54 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -3,6 +3,7 @@ ENV PACKAGES \
     ccache git tar PyYAML sparse flex bison python2 bzip2 hostname \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
     gcc gcc-c++ clang make perl which bc findutils libaio-devel \
+    nettle-devel \
     mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
     mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
     mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
-- 
2.13.5
