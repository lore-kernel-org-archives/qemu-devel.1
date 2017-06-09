Received: from eggs.gnu.org ([2001:4830:134:3::10]:53158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dJPS7-0007As-MU
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dJPS4-0002hn-FZ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:20:11 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:36725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dJPS4-0002fP-6K
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:20:08 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Fri,  9 Jun 2017 21:19:47 +0200
Message-Id: <cover.e0862272629975a2a7296103cf5d5f8de70abc01.1497035841.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH 0/2] Unit test+fix for problem with QEMU
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

Thanks,
Knut

Knut Omang (2):
  Add test-listen - a stress test for QEMU socket listen
  socket: Handle race condition between binds to the same port

 tests/Makefile.include |   2 +-
 tests/test-listen.c    | 135 ++++++++++++++++++++++++++++++++++++++++++-
 util/qemu-sockets.c    | 106 +++++++++++++++++++++++----------
 3 files changed, 212 insertions(+), 31 deletions(-)
 create mode 100644 tests/test-listen.c

base-commit: 64175afc695c0672876fbbfc31b299c86d562cb4
-- 
git-series 0.9.1
