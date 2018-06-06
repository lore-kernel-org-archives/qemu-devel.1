Received: from eggs.gnu.org ([2001:4830:134:3::10]:46463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQcId-0003zk-3E
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQcIY-0000j1-Mk
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQcIY-0000iM-HG
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:32:38 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  6 Jun 2018 18:32:30 +0100
Message-Id: <20180606173233.28080-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] glib: update the min required version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

The previous patch to bump glib to 2.42 hit problems with Peter's build
environment for testing merge:

  https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg02557.html

This posting drops back to 2.40, which allows Ubuntu 14.04 from GLibC
compile farm to be supported.

It does NOT try to go back to 2.34, because it is hoped that the mxe.cc
Debian packages will be suitable for Peter to test Windows
cross-compile. Alternatively the docker environments provided in tree
can be used for mingw build testing on any host able to run docker.

I also dropped some more GLIB_CHECK_VERSION checks that are redundant
given the new min version.

Daniel P. Berrang=C3=A9 (3):
  glib: bump min required glib library version to 2.40
  glib: enforce the minimum required version and warn about old APIs
  util: remove redundant include of glib.h

 configure                                |   6 +-
 crypto/hash-glib.c                       |   4 -
 crypto/hmac-glib.c                       |  36 ---
 include/glib-compat.h                    | 372 ++++-------------------
 qga/commands.c                           |  11 +-
 tests/docker/dockerfiles/centos6.docker  |  30 --
 tests/docker/dockerfiles/min-glib.docker |   8 -
 tests/ivshmem-test.c                     |   6 -
 tests/test-qga.c                         |   2 -
 tests/test-qmp-event.c                   |   8 +-
 tests/tpm-emu.h                          |   4 +-
 tests/vhost-user-test.c                  |  26 +-
 trace/simple.c                           |   6 +-
 util/iova-tree.c                         |   1 -
 util/osdep.c                             |  14 -
 15 files changed, 71 insertions(+), 463 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/centos6.docker
 delete mode 100644 tests/docker/dockerfiles/min-glib.docker

--=20
2.17.0
