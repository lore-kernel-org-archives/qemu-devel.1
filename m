Received: from eggs.gnu.org ([2001:4830:134:3::10]:37552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIg5-0007sa-N5
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIg4-0000rr-Qo
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIg4-0000rd-Kj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:27 +0800
Message-Id: <20170922074659.30097-5-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/36] docker: reduce noise when building
 travis.docker
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

Set the DEBIAN_FRONTEND and locale env vars to stop apt complaining so
much as we build the image.

Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20170725133425.436-7-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/dockerfiles/travis.docker | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/docker=
files/travis.docker
index 57ac8e1419..605b6e429b 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,4 +1,7 @@
 FROM quay.io/travisci/travis-ruby
+ENV DEBIAN_FRONTEND noninteractive
+ENV LANG en_US.UTF-8
+ENV LC_ALL en_US.UTF-8
 RUN apt-get update
 RUN apt-get -y build-dep qemu
 RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-aut=
oreconf gdb strace lsof net-tools
--=20
2.13.5
