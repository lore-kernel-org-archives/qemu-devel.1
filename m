Received: from eggs.gnu.org ([2001:4830:134:3::10]:37982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCg-0002Hz-GJ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCf-0000OW-E0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:50 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  7 Mar 2018 11:25:26 +0000
Message-Id: <20180307112532.24248-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit f2bb2d14c2958f3f5aef456bd2cdb1ff99f4a5=
62:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-05 16:41:20 +0000)

are available in the Git repository at:

  https://github.com/berrange/qemu tags/qio-next-pull-request

for you to fetch changes up to 1939ccdaa61ce6a1f57d83277b3d41d3a9ad3c58:

  qio: non-default context for TLS handshake (2018-03-06 10:19:07 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Peter Xu (6):
  qio: rename qio_task_thread_result
  qio: introduce qio_channel_add_watch_{full|source}
  qio: store gsources for net listeners
  qio: non-default context for threaded qtask
  qio: non-default context for async conn
  qio: non-default context for TLS handshake

 chardev/char-socket.c          |  5 ++--
 include/io/channel-socket.h    | 15 ++++++++---
 include/io/channel-tls.h       |  5 +++-
 include/io/channel.h           | 44 ++++++++++++++++++++++++++++++++
 include/io/net-listener.h      | 22 ++++++++++++++--
 include/io/task.h              |  7 +++--
 io/channel-socket.c            | 18 ++++++++-----
 io/channel-tls.c               | 45 ++++++++++++++++++++++++--------
 io/channel.c                   | 40 ++++++++++++++++++++++++-----
 io/dns-resolver.c              |  3 ++-
 io/net-listener.c              | 58 ++++++++++++++++++++++++++----------=
------
 io/task.c                      | 22 +++++++++++++---
 migration/socket.c             |  3 ++-
 migration/tls.c                |  2 ++
 nbd/client.c                   |  1 +
 nbd/server.c                   |  1 +
 tests/test-io-channel-socket.c |  4 +--
 tests/test-io-channel-tls.c    |  2 ++
 tests/test-io-task.c           |  2 ++
 ui/vnc-auth-vencrypt.c         |  1 +
 ui/vnc-ws.c                    |  1 +
 21 files changed, 239 insertions(+), 62 deletions(-)

--=20
2.14.3
