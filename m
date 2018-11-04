Received: from eggs.gnu.org ([2001:4830:134:3::10]:41962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGiA-0007jl-9A
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGi8-0002uL-8j
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gJGi8-0002su-1i
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:56 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun,  4 Nov 2018 11:24:24 +0000
Message-Id: <20181104112424.18663-9-stefanha@redhat.com>
In-Reply-To: <20181104112424.18663-1-stefanha@redhat.com>
References: <20181104112424.18663-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 8/8] docker: use HTTPS git URL for
 virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Daniel Berrange <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
index eb13f06ed1..24b113b76f 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -24,7 +24,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virgl=
renderer
+RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr=
/src/virglrenderer
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx =
--disable-tests && make install
=20
 # netmap
--=20
2.17.2
