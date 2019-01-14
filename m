Received: from eggs.gnu.org ([209.51.188.92]:60911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj5CT-0002Ah-8S
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj5CP-000247-Dc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 14 Jan 2019 16:34:14 +0000
Message-Id: <20190114163416.1094-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b=
16:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part2' into staging (2019-01-14 11:41:43 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to fef1660132b0f25bf2d275d7f986ddcfe19a4426:

  aio-posix: Fix concurrent aio_poll/set_fd_handler. (2019-01-14 14:09:41=
 +0000)

----------------------------------------------------------------
Pull request

No user-visible changes.

----------------------------------------------------------------

Remy Noel (2):
  aio-posix: Unregister fd from ctx epoll when removing fd_handler.
  aio-posix: Fix concurrent aio_poll/set_fd_handler.

 util/aio-posix.c | 90 +++++++++++++++++++++++++++++-------------------
 util/aio-win32.c | 67 ++++++++++++++++-------------------
 2 files changed, 84 insertions(+), 73 deletions(-)

--=20
2.20.1
