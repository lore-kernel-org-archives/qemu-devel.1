Received: from eggs.gnu.org ([2001:4830:134:3::10]:33275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cmErE-0008TK-Q0
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cmErD-0005Yj-HB
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:21:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cmErD-0005YY-Ai
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 02:20:59 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 10 Mar 2017 15:20:51 +0800
Message-Id: <20170310072051.15704-3-famz@redhat.com>
In-Reply-To: <20170310072051.15704-1-famz@redhat.com>
References: <20170310072051.15704-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] docker/dockerfiles/debian-s390-cross:
 include clang
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

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

It's a silly little limitation on Shippable that is looks for clang
in the container even though we won't use it. The arm/aarch64 cross
builds inherit this from debian.docker but as we needed to use
debian-testing for this we add it here. We also collapse the update
step into one RUN line to remove and intermediate layer of the docker
build.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20170306112848.659-1-alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/d=
ocker/dockerfiles/debian-s390x-cross.docker
index bbb21ed..3a687fe 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -13,8 +13,8 @@ RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >>=
 /etc/apt/sources.list
 RUN dpkg --add-architecture s390x
=20
 # Grab the updated list of packages
-RUN apt update
-RUN apt dist-upgrade -yy
+RUN apt update && apt dist-upgrade -yy
+RUN apt install -yy build-essential clang
 RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
 RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
=20
--=20
2.9.3
