Received: from eggs.gnu.org ([2001:4830:134:3::10]:45404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMG7-0000pc-Qc
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMG6-0006Lc-SN
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:03 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:39 +0200
Message-Id: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/15] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 42a48128417b3bfade93d1a4721348cc480e9e50:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-29-v3' into queue-block (2017-05-29 16:34:27 +0200)

----------------------------------------------------------------

Block layer patches

----------------------------------------------------------------
Alberto Garcia (2):
      stream: fix crash in stream_start() when block_job_create() fails
      qcow2: remove extra local_error variable

Daniel P. Berrange (4):
      qemu-img: add support for --object with 'dd' command
      qemu-img: fix --image-opts usage with dd command
      qemu-img: introduce --target-image-opts for 'convert' command
      qemu-img: copy *key-secret opts when opening newly created files

Eric Blake (1):
      block: Tweak error message related to qemu-img amend

Fam Zheng (3):
      iotests: 147: Don't test inet6 if not available
      qemu-img: Fix documentation of convert
      qemu-img: Fix leakage of options on error

Kevin Wolf (3):
      qemu-iotests: Test streaming with missing job ID
      mirror: Drop permissions on s->target on completion
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-29-v3' into queue-block

Max Reitz (2):
      block: Fix backing paths for filenames with colons
      block/file-*: *_parse_filename() and colons

Stephen Bates (1):
      nvme: Add support for Controller Memory Buffers

 block.c                    |  50 +++++++++++++--
 block/file-posix.c         |  17 +-----
 block/file-win32.c         |  12 +---
 block/mirror.c             |   7 ++-
 block/qcow2-cluster.c      |   3 +-
 block/qcow2.c              |   5 +-
 block/stream.c             |   2 +-
 hw/block/nvme.c            |  75 +++++++++++++++++++++--
 hw/block/nvme.h            |  73 ++++++++++++++++++++++
 include/block/block_int.h  |   3 +
 qemu-img-cmds.hx           |   4 +-
 qemu-img.c                 | 148 +++++++++++++++++++++++++++++++++++----------
 qemu-img.texi              |  12 +++-
 tests/qemu-iotests/030     |   4 ++
 tests/qemu-iotests/030.out |   4 +-
 tests/qemu-iotests/060.out |   2 +-
 tests/qemu-iotests/147     |   7 +++
 17 files changed, 351 insertions(+), 77 deletions(-)
