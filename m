Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlhq-0007WU-Qg
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlhq-0000gz-49
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOlhp-0000gi-US
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:00 +0000
Message-Id: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 00/14] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 5e5db49953e31689c1c70060870f0a7a6de26fcb:

  iothread: add poll-grow and poll-shrink parameters (2017-01-03 16:38:50 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (14):
  HACKING: document #include order
  aio: add flag to skip fds to aio_dispatch()
  aio: add AioPollFn and io_poll() interface
  aio: add polling mode to AioContext
  virtio: poll virtqueues for new buffers
  linux-aio: poll ring for completions
  iothread: add polling parameters
  virtio-blk: suppress virtqueue kick during processing
  virtio-scsi: suppress virtqueue kick during processing
  virtio: turn vq->notification into a nested counter
  aio: add .io_poll_begin/end() callbacks
  virtio: disable virtqueue notifications during polling
  aio: self-tune polling time
  iothread: add poll-grow and poll-shrink parameters

 include/block/aio.h         |  53 +++++++-
 include/sysemu/iothread.h   |   5 +
 aio-posix.c                 | 308 +++++++++++++++++++++++++++++++++++++++-----
 aio-win32.c                 |  32 ++++-
 async.c                     |  21 ++-
 block/curl.c                |   8 +-
 block/iscsi.c               |   3 +-
 block/linux-aio.c           |  19 ++-
 block/nbd-client.c          |   8 +-
 block/nfs.c                 |   7 +-
 block/sheepdog.c            |  26 ++--
 block/ssh.c                 |   4 +-
 block/win32-aio.c           |   4 +-
 hw/block/virtio-blk.c       |  18 ++-
 hw/scsi/virtio-scsi.c       |  36 +++---
 hw/virtio/virtio.c          |  54 ++++++--
 iohandler.c                 |   2 +-
 iothread.c                  |  84 ++++++++++++
 nbd/server.c                |   9 +-
 stubs/set-fd-handler.c      |   1 +
 tests/test-aio.c            |   4 +-
 util/event_notifier-posix.c |   2 +-
 HACKING                     |  18 +++
 trace-events                |   6 +
 24 files changed, 622 insertions(+), 110 deletions(-)

-- 
2.9.3
