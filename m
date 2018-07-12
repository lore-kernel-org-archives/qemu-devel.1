Received: from eggs.gnu.org ([2001:4830:134:3::10]:44448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdQPU-000294-GT
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 21:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdQPQ-0002i8-F7
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 21:28:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fdQPQ-0002hV-Av
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 21:28:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 12 Jul 2018 09:28:25 +0800
Message-Id: <20180712012829.20231-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/4] Add a CentOS test image to run docker
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

v3: Add 'make vm-test' document. [Phil]

v2: Drop archive-source.sh changes.
    The new test depends on the iotests nbd fix I posted today to pass.

Docker testing on patchew has long suffered from 'make check' hangings. T=
he
cleanness of VM testing is the cure. Now let's add a CentOS 7 image to ru=
n the
tests.  It's purely ad-hoc, but hopefully still easy to understand and us=
e for
everyone.

The first patch makes passing source code from host to the container in V=
M
working, and is a nice clean up.

The second patch makes caches work, to speed up repetitive runs like on
patchew.

The last patch adds the new image that does the job. Two out of three doc=
ker
tests running on patchew.org are added to the image. I'll wait for Peter =
to fix
the 'docker-test-quick@centos6' hanging (oob test) before adding it too.

Fam

Fam Zheng (4):
  tests: Add an option for snapshot (default: off)
  tests/vm: Pass verbose flag into VM make commands
  tests: Allow overriding archive path with SRC_ARCHIVE
  tests: Add centos VM testing

 tests/docker/Makefile.include |  7 ++-
 tests/vm/Makefile.include     |  3 +-
 tests/vm/basevm.py            | 10 ++++-
 tests/vm/centos               | 84 +++++++++++++++++++++++++++++++++++
 tests/vm/freebsd              |  4 +-
 tests/vm/netbsd               |  4 +-
 tests/vm/openbsd              |  4 +-
 tests/vm/ubuntu.i386          |  4 +-
 8 files changed, 107 insertions(+), 13 deletions(-)
 create mode 100755 tests/vm/centos

--=20
2.17.1
