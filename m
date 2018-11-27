Received: from eggs.gnu.org ([2001:4830:134:3::10]:55649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRe1F-0008Eh-TA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRe1A-0007H2-2z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:07:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 27 Nov 2018 15:06:37 +0100
Message-Id: <20181127140640.24830-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Block layer patches
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

The following changes since commit d5d31c9a8ab5e87db4230602a6fd5da8eb1313=
5c:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-for-3.1-pull-re=
quest' into staging (2018-11-27 09:55:05 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 6da021815e752b3ca3a547eed53f3e92a8a35452:

  nvme: Fix spurious interrupts (2018-11-27 12:59:00 +0100)

----------------------------------------------------------------
Block layer patches:

- block: Fix crash on migration with explicit child nodes
- nvme: Fix spurious interrupts

----------------------------------------------------------------
Keith Busch (1):
      nvme: Fix spurious interrupts

Kevin Wolf (2):
      block: Don't inactivate children before parents
      iotests: Test migration with -blockdev

 block.c                    |  84 +++++++++++++++++++------------
 hw/block/nvme.c            |   4 +-
 tests/qemu-iotests/234     | 121 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/234.out |  30 +++++++++++
 tests/qemu-iotests/group   |   1 +
 5 files changed, 208 insertions(+), 32 deletions(-)
 create mode 100755 tests/qemu-iotests/234
 create mode 100644 tests/qemu-iotests/234.out
