Received: from eggs.gnu.org ([209.51.188.92]:37441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0ht-0007pq-0g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0hs-0007Z8-1w
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:59:52 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:32 +0100
Message-Id: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

The following changes since commit b4fbe1f65a4769c09e6bf2d79fc84360f840f4=
0e:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90129' into staging (2019-01-29 12:00:19 +0000)

are available in the Git repository at:

  https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2019-01-31

for you to fetch changes up to 908b30164bbffad7430d551b2a03a8fbcaa631ef:

  iotests: Allow 147 to be run concurrently (2019-01-31 00:44:55 +0100)

----------------------------------------------------------------
Block patches:
- New debugging QMP command to explore block graphs
- Converted DPRINTF()s to trace events
- Fixed qemu-io's use of getopt() for systems with optreset
- Minor NVMe emulation fixes
- An iotest fix

----------------------------------------------------------------
Laurent Vivier (4):
  block/ssh: Convert from DPRINTF() macro to trace events
  block/curl: Convert from DPRINTF() macro to trace events
  block/file-posix: Convert from DPRINTF() macro to trace events
  block/sheepdog: Convert from DPRINTF() macro to trace events

Li Qiang (3):
  nvme: use TYPE_NVME instead of constant string
  nvme: ensure the num_queues is not zero
  nvme: use pci_dev directly in nvme_realize

Max Reitz (3):
  iotests.py: Add qemu_nbd_pipe()
  iotests: Bind qemu-nbd to localhost in 147
  iotests: Allow 147 to be run concurrently

Richard W.M. Jones (1):
  qemu-io: Add generic function for reinitializing optind.

Vladimir Sementsov-Ogievskiy (2):
  qapi: add x-debug-query-block-graph
  scripts: add render_block_graph function for QEMUMachine

 configure                      |  14 ++++
 qapi/block-core.json           | 108 ++++++++++++++++++++++++
 include/block/block.h          |   1 +
 include/qemu/osdep.h           |  16 ++++
 include/sysemu/block-backend.h |   2 +
 block.c                        | 148 +++++++++++++++++++++++++++++++++
 block/block-backend.c          |   5 ++
 block/curl.c                   |  29 ++-----
 block/file-posix.c             |  25 ++----
 block/sheepdog.c               |  47 ++++-------
 block/ssh.c                    |  46 ++++------
 blockdev.c                     |   5 ++
 hw/block/nvme.c                |  15 ++--
 qemu-img.c                     |   2 +-
 qemu-io-cmds.c                 |   2 +-
 block/trace-events             |  47 +++++++++++
 scripts/render_block_graph.py  | 120 ++++++++++++++++++++++++++
 tests/qemu-iotests/147         |  98 +++++++++++++++-------
 tests/qemu-iotests/iotests.py  |  14 ++++
 19 files changed, 608 insertions(+), 136 deletions(-)
 create mode 100755 scripts/render_block_graph.py

--=20
2.20.1
