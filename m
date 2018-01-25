Received: from eggs.gnu.org ([2001:4830:134:3::10]:59276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNK-0006hg-4F
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eeaNF-00072M-R6
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:47:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eeaNF-000717-Lh
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 00:46:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 25 Jan 2018 13:46:35 +0800
Message-Id: <20180125054648.18747-2-famz@redhat.com>
In-Reply-To: <20180125054648.18747-1-famz@redhat.com>
References: <20180125054648.18747-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/14] docker: change Fedora base image to
 fedora:27
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

From: Paolo Bonzini <pbonzini@redhat.com>

Using "fedora:latest" makes behavior different depending on when you
actually pulled the image from the docker repository.  In my case,
the supposedly "latest" image was a Fedora 25 download from 8 months
ago, and the new "test-debug" test was failing.

Use "27" to improve reproducibility and make it clear when the image
is obsolete.

Cc: Fam Zheng <famz@redhat.com>
Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
index 32de731675..714adadbfb 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:latest
+FROM fedora:27
 ENV PACKAGES \
     ccache gettext git tar PyYAML sparse flex bison python2 bzip2 hostna=
me \
     glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
--=20
2.14.3
