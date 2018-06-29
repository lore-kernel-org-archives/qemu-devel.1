Received: from eggs.gnu.org ([2001:4830:134:3::10]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWr-0007Yp-96
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrWm-0000py-Qy
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrWm-0000oy-Mo
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:25:24 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 29 Jun 2018 12:25:17 +0100
Message-Id: <20180629112520.31358-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Min glib patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f=
18:

  Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-reque=
st' into staging (2018-06-28 17:53:31 +0100)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/min-glib-pull-request

for you to fetch changes up to e71e8cc035558eabd6b3e19f6d3254c754c027ef:

  glib: enforce the minimum required version and warn about old APIs (201=
8-06-29 12:22:28 +0100)

----------------------------------------------------------------
glib: update the min required version

This updates the minimum required glib version to 2.40

----------------------------------------------------------------

Daniel P. Berrang=C3=A9 (3):
  util: remove redundant include of glib.h and add osdep.h
  glib: bump min required glib library version to 2.40
  glib: enforce the minimum required version and warn about old APIs

 configure                                |   6 +-
 crypto/hash-glib.c                       |   4 -
 crypto/hmac-glib.c                       |  36 ---
 include/glib-compat.h                    | 373 ++++-------------------
 include/qemu/iova-tree.h                 |   1 -
 qga/commands.c                           |  11 +-
 tests/docker/dockerfiles/centos6.docker  |  30 --
 tests/docker/dockerfiles/min-glib.docker |   8 -
 tests/ivshmem-test.c                     |   6 -
 tests/test-qga.c                         |   2 -
 tests/test-qmp-event.c                   |   8 +-
 tests/tpm-emu.h                          |   4 +-
 tests/vhost-user-test.c                  |  26 +-
 trace/simple.c                           |   6 +-
 util/iova-tree.c                         |   2 +-
 util/osdep.c                             |  14 -
 16 files changed, 73 insertions(+), 464 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/centos6.docker
 delete mode 100644 tests/docker/dockerfiles/min-glib.docker

--=20
2.17.1
