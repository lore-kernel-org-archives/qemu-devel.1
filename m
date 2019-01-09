Received: from eggs.gnu.org ([209.51.188.92]:45615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlS-00022D-PT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlR-000185-81
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlQ-00015N-Va
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:33 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:05 +0000
Message-Id: <20190109163114.17010-5-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/13] tests: update Fedora i386 cross image to
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

Using the "latest" tag is not a good idea because this changes what
release it points to every 6 months. Together with caching of docker
builds this can cause confusion where CI has cached & built with Fedora
N, while a developer tries to reproduce a CI problem with Fedora N + 1,
or vica-verca.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/docker/dockerfiles/fedora-i386-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora-i386-cross.docker b/tests/do=
cker/dockerfiles/fedora-i386-cross.docker
index a4fd895b07..eb8108d118 100644
--- a/tests/docker/dockerfiles/fedora-i386-cross.docker
+++ b/tests/docker/dockerfiles/fedora-i386-cross.docker
@@ -1,4 +1,4 @@
-FROM fedora:latest
+FROM fedora:29
 ENV PACKAGES \
     gcc \
     glib2-devel.i686 \
--=20
2.19.2
