Received: from eggs.gnu.org ([2001:4830:134:3::10]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dKgcn-0006YW-29
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dKgcj-000756-6q
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:52:29 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:30074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dKgci-00074t-T9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:52:25 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Tue, 13 Jun 2017 09:52:08 +0200
Message-Id: <cover.af39bf23ea744fd4a1461a0fec7ded29e5f43611.1497339083.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Unit test+fix for problem with QEMU
 handling of multiple bind()s to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Knut Omang <knut.omang@oracle.com>

This series contains:
* a unit test that exposes a race condition which causes QEMU to fail
  to find a port even when there is plenty of available ports.
* a refactor of the qemu-sockets inet_listen_saddr() function
  to better handle this situation.

Changes from v1:
* Fix potential uninitialized variable only detected by optimize.
* Improve unexpected error detection in test-listen to give more
  details about why the test fails unexpectedly.
* Fix some line length style issues.

Thanks,
Knut

Knut Omang (2):
  Add test-listen - a stress test for QEMU socket listen
  socket: Handle race condition between binds to the same port

 tests/Makefile.include |   2 +-
 tests/test-listen.c    | 141 ++++++++++++++++++++++++++++++++++++++++++-
 util/qemu-sockets.c    | 109 ++++++++++++++++++++++----------
 3 files changed, 220 insertions(+), 32 deletions(-)
 create mode 100644 tests/test-listen.c

base-commit: 64175afc695c0672876fbbfc31b299c86d562cb4
-- 
git-series 0.9.1
