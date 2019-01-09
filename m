Received: from eggs.gnu.org ([209.51.188.92]:45671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlV-00024B-DC
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlT-0001An-Gw
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlT-00014K-63
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:35 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:04 +0000
Message-Id: <20190109163114.17010-4-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/13] tests: update Fedora dockerfile to use
 Fedora 29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Fedora 29 is the current newest release, so switch to using that
from the current Fedora 28.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
index 0c4eb9e49c..58474a5322 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:28
+FROM fedora:29
 ENV PACKAGES \
     bc \
     bison \
@@ -81,7 +81,7 @@ ENV PACKAGES \
     tar \
     usbredir-devel \
     virglrenderer-devel \
-    vte3-devel \
+    vte291-devel \
     which \
     xen-devel \
     zlib-devel
--=20
2.19.2
