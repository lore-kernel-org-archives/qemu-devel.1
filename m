Received: from eggs.gnu.org ([2001:4830:134:3::10]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZe-00017t-SB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZc-0002W2-6E
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 11 Aug 2017 16:05:29 +0200
Message-Id: <20170811140536.2792-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Block/Multiboot patches for 2.10.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 95766c2cd04395e5712b4d5967b3251f35d537=
df:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-08-10 18:53:39 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 8565c3ab537e78f3e69977ec2c609dc9417a806e:

  qemu-iotests: fix 185 (2017-08-11 14:44:39 +0200)

----------------------------------------------------------------
Block layer patches for 2.10.0-rc3

----------------------------------------------------------------
Eric Blake (4):
      tests/multiboot: Fix whitespace failure
      vpc: Check failure of bdrv_getlength()
      qcow2: Drop debugging dump_refcounts()
      qcow2: Check failure of bdrv_getlength()

Fam Zheng (2):
      osdep: Add runtime OFD lock detection
      file-posix: Do runtime check for ofd lock API

Vladimir Sementsov-Ogievskiy (1):
      qemu-iotests: fix 185

 include/qemu/osdep.h        |  1 +
 block/file-posix.c          | 19 ++++++-------
 block/qcow2.c               | 26 +++---------------
 block/vpc.c                 |  9 ++++++-
 util/osdep.c                | 66 ++++++++++++++++++++++++++++++++++++++-=
------
 tests/multiboot/run_test.sh |  2 +-
 tests/qemu-iotests/185      |  4 +++
 7 files changed, 82 insertions(+), 45 deletions(-)
