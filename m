Received: from eggs.gnu.org ([2001:4830:134:3::10]:45438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3za-000612-TG
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3za-00079C-0L
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:40 +0200
Message-Id: <20170403153355.19722-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] Block patches for rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 102a3d847891f48c0b13cace19d189217b05a7=
25:

  usb-host: switch to LIBUSB_API_VERSION (2017-04-03 14:41:23 +0100)

are available in the git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2017-04-03

for you to fetch changes up to 86d1bd70987cd11d85d01f52aa5824c63d910471:

  block/parallels: Avoid overflows (2017-04-03 17:11:40 +0200)

----------------------------------------------------------------
Block patches for 2.9-rc3

----------------------------------------------------------------
Daniel P. Berrange (1):
      iotests: fix 097 when run with qcow

Denis V. Lunev (1):
      block: add missed aio_context_acquire into release_drive

Eric Blake (2):
      qcow2: Discard unaligned tail when wiping image
      iotests: Improve image-clear tests on non-aligned image

Markus Armbruster (9):
      nbd sockets vnc: Mark problematic address family tests TODO
      char: Fix socket with "type": "vsock" address
      io vnc sockets: Clean up SocketAddressKind switches
      block: Document -drive problematic code and bugs
      gluster: Prepare for SocketAddressFlat extension
      qapi-schema: SocketAddressFlat variants 'vsock' and 'fd'
      sockets: New helper socket_address_crumple()
      nbd: Tidy up blockdev-add interface
      sheepdog: Fix blockdev-add

Max Reitz (1):
      block/parallels: Avoid overflows

Peter Maydell (1):
      qemu-io-cmds: Assert that global and nofile commands don't use ct->=
perms

 qapi-schema.json                 |  19 ++---
 qapi/block-core.json             |   6 +-
 include/qemu/sockets.h           |  11 +++
 block.c                          |  48 ++++++++++-
 block/file-posix.c               |   6 ++
 block/gluster.c                  |  28 +++---
 block/nbd.c                      |  62 ++++++++------
 block/nfs.c                      |   7 ++
 block/parallels.c                |  19 +++--
 block/qcow2-cluster.c            |  10 +--
 block/rbd.c                      |   6 ++
 block/sheepdog.c                 |  90 +++++++++++++-------
 block/ssh.c                      |   8 ++
 blockdev-nbd.c                   |   1 +
 chardev/char-socket.c            |   9 +-
 hw/core/qdev-properties-system.c |   4 +
 io/dns-resolver.c                |   7 +-
 qemu-io-cmds.c                   |   7 ++
 ui/vnc.c                         |  19 +++--
 util/qemu-sockets.c              |  40 ++++++++-
 tests/qemu-iotests/097           |  27 +++---
 tests/qemu-iotests/097.out       | 180 ++++++++++-----------------------=
------
 tests/qemu-iotests/147           |  25 ++++--
 tests/qemu-iotests/176           | 131 ++++++++++++++++++++++++++++
 tests/qemu-iotests/176.out       | 150 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group         |   1 +
 26 files changed, 655 insertions(+), 266 deletions(-)
 create mode 100755 tests/qemu-iotests/176
 create mode 100644 tests/qemu-iotests/176.out

--=20
2.12.1
