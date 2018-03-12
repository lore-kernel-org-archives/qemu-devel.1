Received: from eggs.gnu.org ([208.118.235.92]:51452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPtO-0005oy-I6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPtN-0002Bn-Pl
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:01:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 16:01:24 +0000
Message-Id: <20180312160125.7596-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca76:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-03-09 17:28:16 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 7376eda7c2e0451e819e81bd05fabc56a9deb946:

  block: make BDRV_POLL_WHILE() re-entrancy safe (2018-03-12 11:07:37 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (1):
  block: make BDRV_POLL_WHILE() re-entrancy safe

 include/block/aio-wait.h | 61 ++++++++++++++++++++++++------------------------
 util/aio-wait.c          |  2 +-
 2 files changed, 31 insertions(+), 32 deletions(-)

-- 
2.14.3
