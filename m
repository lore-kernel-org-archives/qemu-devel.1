Received: from eggs.gnu.org ([2001:4830:134:3::10]:46409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCPSo-0001L5-FK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCPSk-0006aY-Kf
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:28:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eCPSk-0006Zx-Eb
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:28:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  8 Nov 2017 12:20:11 +0000
Message-Id: <20171108122013.4293-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11-rc1 0/2] Block patches
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

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 161d53bbed2be4c4336c098185de3afb13cc6bd5:

  util/async: use atomic_mb_set in qemu_bh_cancel (2017-11-08 09:24:41 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Sergio Lopez (1):
  util/async: use atomic_mb_set in qemu_bh_cancel

Stefan Hajnoczi (1):
  tests-aio-multithread: fix /aio/multi/schedule race condition

 tests/test-aio-multithread.c | 5 ++---
 util/async.c                 | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.13.6
