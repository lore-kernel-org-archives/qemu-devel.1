Received: from eggs.gnu.org ([2001:4830:134:3::10]:36081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0T-0004uI-6h
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVh0O-0006Od-Gc
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVh0O-0006OZ-Ah
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:58:04 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 15:57:29 +0000
Message-Id: <20170123155737.3793-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 0/8] Merge io/ 2017-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit 598cf1c805271564686f2d732b36f50c3c40dcdd:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-20 16:42:07 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-01-23-2

for you to fetch changes up to c1b412f1d94ba717896f876dbf59fffa91e596fc:

  io: introduce a DNS resolver API (2017-01-23 15:32:46 +0000)

----------------------------------------------------------------
Merge io/ 2017-01-23

----------------------------------------------------------------

Daniel P. Berrange (8):
  sockets: add ability to disable DNS resolution for InetSocketAddress
  io: stop incrementing reference in qio_task_get_source
  io: fix typo in docs for QIOTask
  io: add ability to associate an opaque "result" with with a task
  io: add ability to associate an error with a task
  io: change the QIOTask callback signature
  io: remove Error parameter from QIOTask thread worker
  io: introduce a DNS resolver API

 include/io/dns-resolver.h      | 228 ++++++++++++++++++++++++++++++++++
 include/io/task.h              | 154 ++++++++++++++++-------
 include/qemu/sockets.h         |   2 +
 io/Makefile.objs               |   1 +
 io/channel-socket.c            |  44 +++----
 io/channel-tls.c               |  16 +--
 io/channel-websock.c           |   8 +-
 io/dns-resolver.c              | 276 +++++++++++++++++++++++++++++++++++++++++
 io/task.c                      |  62 ++++++---
 io/trace-events                |   1 -
 migration/socket.c             |  11 +-
 migration/tls.c                |  19 +--
 nbd/common.c                   |   8 +-
 nbd/nbd-internal.h             |   3 +-
 qapi-schema.json               |   5 +
 qemu-char.c                    |  18 +--
 tests/test-io-channel-socket.c |   5 +-
 tests/test-io-channel-tls.c    |   5 +-
 tests/test-io-task.c           |  31 ++---
 ui/vnc-auth-vencrypt.c         |   7 +-
 ui/vnc-ws.c                    |  14 ++-
 util/qemu-sockets.c            |  11 +-
 22 files changed, 760 insertions(+), 169 deletions(-)
 create mode 100644 include/io/dns-resolver.h
 create mode 100644 io/dns-resolver.c

-- 
2.9.3
