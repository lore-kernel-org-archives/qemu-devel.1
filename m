Received: from eggs.gnu.org ([2001:4830:134:3::10]:56853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmF2-0006vE-6w
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmEy-0000cc-QH
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmEy-0000cO-Hy
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:12:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:31 +0800
Message-Id: <20180815031248.14908-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/17] Block and testing patches
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

The following changes since commit 38441756b70eec5807b5f60dad11a93a911998=
66:

  Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/block-and-testing-pull-request

for you to fetch changes up to 37a81812f7b8367422a039eb09d915df543983ee:

  aio-posix: Improve comment around marking node deleted (2018-08-15 10:1=
2:35 +0800)

----------------------------------------------------------------
Block and testing patches for 3.1

- aio fixes by me
- nvme fixes by Paolo and me
- test improvements by Peter, Phil and me

----------------------------------------------------------------

Fam Zheng (10):
  nvme: Fix nvme_init error handling
  aio-posix: Don't count ctx->notifier as progress when polling
  aio: Do aio_notify_accept only during blocking aio_poll
  docker: Install more packages in centos7
  tests: Add an option for snapshot (default: off)
  tests: Allow overriding archive path with SRC_ARCHIVE
  tests: Add centos VM testing
  tests: vm: Add vm-clean-all
  tests/vm: Add vm-build-all/vm-clean-all in help text
  aio-posix: Improve comment around marking node deleted

Paolo Bonzini (1):
  nvme: simplify plug/unplug

Peter Maydell (4):
  tests/vm: Pass the jobs parallelism setting to 'make check'
  tests/vm: Propagate V=3D1 down into the make inside the VM
  tests/vm: Bump guest RAM up from 2G to 4G
  tests/vm: Use make's --output-sync option

Philippe Mathieu-Daud=C3=A9 (2):
  tests/vm: Only use -cpu 'host' if KVM is available
  tests/vm: Add flex and bison to the vm image

 block/nvme.c                            | 57 +++++++----------
 docs/devel/testing.rst                  |  1 +
 tests/docker/Makefile.include           |  7 ++-
 tests/docker/dockerfiles/centos7.docker |  3 +
 tests/vm/Makefile.include               | 12 +++-
 tests/vm/basevm.py                      | 17 +++--
 tests/vm/centos                         | 84 +++++++++++++++++++++++++
 tests/vm/freebsd                        |  4 +-
 tests/vm/netbsd                         |  4 +-
 tests/vm/openbsd                        |  4 +-
 tests/vm/ubuntu.i386                    |  6 +-
 util/aio-posix.c                        |  9 +--
 util/aio-win32.c                        |  3 +-
 13 files changed, 154 insertions(+), 57 deletions(-)
 create mode 100755 tests/vm/centos

--=20
2.17.1
