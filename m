Received: from eggs.gnu.org ([209.51.188.92]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hMbox-0001xO-Px
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hMbow-00058K-UZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:18:03 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  3 May 2019 19:17:42 +0200
Message-Id: <20190503171744.21589-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] blockjob: Fix coroutine thread after
 AioContext change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (2):
  blockjob: Fix coroutine thread after AioContext change
  test-block-iothread: Job coroutine thread after AioContext switch

 job.c                       |   2 +-
 tests/test-block-iothread.c | 107 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)

--=20
2.20.1
