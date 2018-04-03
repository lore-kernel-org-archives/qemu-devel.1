Received: from eggs.gnu.org ([2001:4830:134:3::10]:55332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot1-0006q3-Ht
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Osx-0006Xn-Lt
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:51 +0200
Message-Id: <20180403163400.6307-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] Block layer patches for 2.12.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit f184de7553272223d6af731d7d623a7cebf710=
b5:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critic=
al-fixes' into staging (2018-03-31 09:42:33 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 9c1386d3ff76c5983529884e3d8420df958c5a29:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2018-04-03' into q=
ueue-block (2018-04-03 17:48:45 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Alberto Garcia (3):
      iotests: Update 051 and 186 after commit 1454509726719e0933c
      iotests: Update 186 after commit ac64273c66ab136c44043259162
      iotests: Test abnormally large size in compressed cluster descripto=
r

Jeff Cody (1):
      block: handle invalid lseek returns gracefully

Kevin Wolf (2):
      gluster: Fix blockdev-add with server.N.type=3Dunix
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-04-03' in=
to queue-block

Luk=C3=A1=C5=A1 Doktor (1):
      qemu-iotests: Use ppc64 qemu_arch on ppc64le host

Max Reitz (2):
      block/file-posix: Fix fully preallocated truncate
      iotests: Test preallocated truncate of 2G image

Vladimir Sementsov-Ogievskiy (1):
      iotests: fix 208 for luks format

 block/file-posix.c               | 19 +++++++--
 block/gluster.c                  | 21 ++++++++--
 tests/qemu-iotests/051.pc.out    | 20 ----------
 tests/qemu-iotests/106           | 24 ++++++++++++
 tests/qemu-iotests/106.out       | 10 +++++
 tests/qemu-iotests/122           | 47 ++++++++++++++++++++++
 tests/qemu-iotests/122.out       | 33 ++++++++++++++++
 tests/qemu-iotests/186           |  6 +--
 tests/qemu-iotests/186.out       | 84 ++++++++++++++--------------------=
------
 tests/qemu-iotests/208           |  2 +-
 tests/qemu-iotests/check         |  4 +-
 tests/qemu-iotests/common.config |  1 +
 tests/qemu-iotests/common.filter |  5 +++
 13 files changed, 184 insertions(+), 92 deletions(-)
