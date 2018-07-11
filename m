Received: from eggs.gnu.org ([2001:4830:134:3::10]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFx5-0001HP-UY
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFx2-0003gk-Ja
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fdFx2-0003ga-EH
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 11 Jul 2018 22:18:25 +0800
Message-Id: <20180711141829.17406-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Add a CentOS test image to run docker
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

v2: Drop archive-source.sh changes.
    The new test depends on the iotests nbd fix I posted today to pass.

Docker testing on patchew has long suffered from 'make check' hangings. The
cleanness of VM testing is the cure. Now let's add a CentOS 7 image to run the
tests.  It's purely ad-hoc, but hopefully still easy to understand and use for
everyone.

The first patch makes passing source code from host to the container in VM
working, and is a nice clean up.

The second patch makes caches work, to speed up repetitive runs like on
patchew.

The last patch adds the new image that does the job. Two out of three docker
tests running on patchew.org are added to the image. I'll wait for Peter to fix
the 'docker-test-quick@centos6' hanging (oob test) before adding it too.

Fam

Fam Zheng (4):
  tests: Add an option for snapshot (default: off)
  tests/vm: Pass verbose flag into VM make commands
  tests: Allow overriding archive path with SRC_ARCHIVE
  tests: Add centos VM testing

 tests/docker/Makefile.include |  7 ++-
 tests/vm/Makefile.include     |  2 +-
 tests/vm/basevm.py            | 10 ++++-
 tests/vm/centos               | 84 +++++++++++++++++++++++++++++++++++
 tests/vm/freebsd              |  4 +-
 tests/vm/netbsd               |  4 +-
 tests/vm/openbsd              |  4 +-
 tests/vm/ubuntu.i386          |  4 +-
 8 files changed, 106 insertions(+), 13 deletions(-)
 create mode 100755 tests/vm/centos

-- 
2.17.1
